--[[
Name: AceComm-2.0
Revision: $Rev: 36940 $
Developed by: The Ace Development Team (http://www.wowace.com/index.php/The_Ace_Development_Team)
Inspired By: Ace 1.x by Turan (turan@gryphon.com)
Website: http://www.wowace.com/
Documentation: http://www.wowace.com/index.php/AceComm-2.0
SVN: http://svn.wowace.com/wowace/trunk/Ace2/AceComm-2.0
Description: Mixin to allow for inter-player addon communications.
Dependencies: AceLibrary, AceOO-2.0, AceEvent-2.0,
              ChatThrottleLib by Mikk (included)
License: LGPL v2.1
]]

local MAJOR_VERSION = "AceComm-2.0"
local MINOR_VERSION = "$Revision: 36940 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0") end

local _G = getfenv(0)

local AceOO = AceLibrary("AceOO-2.0")
local Mixin = AceOO.Mixin
local AceComm = Mixin {
						"SendCommMessage",
						"SendPrioritizedCommMessage",
						"RegisterComm",
						"UnregisterComm",
						"UnregisterAllComms",
						"IsCommRegistered",
						"SetDefaultCommPriority",
						"SetCommPrefix",
						"RegisterMemoizations",
						"IsUserInChannel",
					  }
AceComm.hooks = {}

local AceEvent = AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0")

local byte_a = ("a"):byte()
local byte_z = ("z"):byte()
local byte_A = ("A"):byte()
local byte_Z = ("Z"):byte()
local byte_fake_s = ("\015"):byte()
local byte_fake_S = ("\020"):byte()
local byte_deg = ("\176"):byte()
local byte_percent = ("%"):byte() -- 37

local byte_b = ("b"):byte()
local byte_B = ("B"):byte()
local byte_nil = ("/"):byte()
local byte_plus = ("+"):byte()
local byte_minus = ("-"):byte()
local byte_d = ("d"):byte()
local byte_D = ("D"):byte()
local byte_e = ("e"):byte()
local byte_E = ("E"):byte()
local byte_m = ("m"):byte()
local byte_s = ("s"):byte()
local byte_S = ("S"):byte()
local byte_o = ("o"):byte()
local byte_O = ("O"):byte()
local byte_t = ("t"):byte()
local byte_T = ("T"):byte()
local byte_u = ("u"):byte()
local byte_U = ("U"):byte()
local byte_i = ("i"):byte()
local byte_I = ("I"):byte()
local byte_inf = ("@"):byte()
local byte_ninf = ("$"):byte()
local byte_nan = ("!"):byte()

local inf = 1/0
local nan = 0/0

local math_floor = math.floor
local string_char = string.char

local type = type
local unpack = unpack
local ipairs = ipairs
local pairs = pairs
local next = next
local select = select

local player = UnitName("player")

local new, del
do
	local list = setmetatable({},{__mode='k'})
	function new(...)
		local t = next(list)
		if t then
			list[t] = nil
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			return t
		else
			return {...}
		end
	end
	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end
		list[t] = true
		return nil
	end
end

local NumericCheckSum, HexCheckSum, BinaryCheckSum
local TailoredNumericCheckSum, TailoredHexCheckSum, TailoredBinaryCheckSum
do
	local SOME_PRIME = 16777213
	function NumericCheckSum(text)
		local counter = 1
		local len = text:len()
		for i = 1, len, 3 do
			counter = (counter*8257 % 16777259) +
				(text:byte(i)) +
				((text:byte(i+1) or 1)*127) +
				((text:byte(i+2) or 2)*16383)
		end
		return counter % 16777213
	end
	
	function HexCheckSum(text)
		return ("%06x"):format(NumericCheckSum(text))
	end
	
	function BinaryCheckSum(text)
		local num = NumericCheckSum(text)
		return string_char(math_floor(num / 256^2), math_floor(num / 256) % 256, num % 256)
	end
	
	function TailoredNumericCheckSum(text)
		local hash = NumericCheckSum(text)
		local a = math_floor(hash / 256^2)
		local b = math_floor(hash / 256) % 256
		local c = hash % 256
		-- \000, \n, |, \176, s, S, \015, \020
		if a == 0 or a == 10 or a == 124 or a == 176 or a == 115 or a == 83 or a == 15 or a == 20 or a == 37 then
			a = a + 1
		-- \t, \255
		elseif a == 9 or a == 255 then
			a = a - 1
		end
		if b == 0 or b == 10 or b == 124 or b == 176 or b == 115 or b == 83 or b == 15 or b == 20 or b == 37 then
			b = b + 1
		elseif b == 9 or b == 255 then
			b = b - 1
		end
		if c == 0 or c == 10 or c == 124 or c == 176 or c == 115 or c == 83 or c == 15 or c == 20 or c == 37 then
			c = c + 1
		elseif c == 9 or c == 255 then
			c = c - 1
		end
		return a * 256^2 + b * 256 + c
	end
	
	function TailoredHexCheckSum(text)
		return ("%06x"):format(TailoredNumericCheckSum(text))
	end
	
	function TailoredBinaryCheckSum(text)
		local num = TailoredNumericCheckSum(text)
		return string_char(math_floor(num / 256^2), math_floor(num / 256) % 256, num % 256)
	end
end

local function GetLatency()
	local _,_,lag = GetNetStats()
	return lag / 1000
end

local function IsInChannel(chan)
	return GetChannelName(chan) ~= 0
end

local function encodeLargeChar(c)
    local num = c:byte()
    num = num - 127
    if num >= 9 then
        num = num + 2
    end
    if num >= 29 then
        num = num + 2
    end
    if num >= 128 then
        return string_char(29, num - 127) -- 1, 2, 3, 4, 5
    end
    return string_char(31, num)
end

local function decodeLargeChar(c)
    local num = c:byte()
    if num >= 29 then
        num = num - 2
    end
    if num >= 9 then
        num = num - 2
    end
    num = num + 127
    return string_char(num)
end

-- Package a message for transmission
local function Encode(text, drunk)
    if drunk then
    	text = text:gsub("\029", "\029\030")
    	
    	text = text:gsub("\031", "\029\032")
	    text = text:gsub("[\128-\255]", encodeLargeChar)
    	
		text = text:gsub("\020", "\029\021")
		text = text:gsub("\015", "\029\016")
		text = text:gsub("S", "\020")
		text = text:gsub("s", "\015")
		-- change S and s to a different set of character bytes.
		
    	text = text:gsub("\127", "\029\126") -- \127 (this is here because \000 is more common)
    	text = text:gsub("%z", "\127") -- \000
    	text = text:gsub("\010", "\029\011") -- \n
    	text = text:gsub("\124", "\029\125") -- |
    	text = text:gsub("%%", "\029\038") -- %
    	-- encode assorted prohibited characters
    else
        text = text:gsub("\176", "\176\177")
        
    	text = text:gsub("\255", "\176\254") -- \255 (this is here because \000 is more common)
    	text = text:gsub("%z", "\255") -- \000
    	text = text:gsub("\010", "\176\011") -- \n
    	text = text:gsub("\124", "\176\125") -- |
    	text = text:gsub("%%", "\176\038") -- %
    	-- encode assorted prohibited characters
    end
	return text
end

local function func(text)
	if text == "\016" then
		return "\015"
	elseif text == "\021" then
		return "\020"
	elseif text == "\177" then
		return "\176"
	elseif text == "\254" then
		return "\255"
	elseif text == "\011" then
		return "\010"
	elseif text == "\125" then
		return "\124"
	elseif text == "\038" then
		return "\037"
	end
end

-- Clean a received message
local function Decode(text, drunk)
	if drunk then
		text = text:gsub("^(.*)\029.-$", "%1")
		-- get rid of " ...hic!"
		
    	text = text:gsub("\029\038", "%%")
    	text = text:gsub("\029\125", "\124")
    	text = text:gsub("\029\011", "\010")
    	text = text:gsub("\127", "\000")
    	text = text:gsub("\029\126", "\127")
    	text = text:gsub("\015", "s")
    	text = text:gsub("\020", "S")
    	text = text:gsub("\029\016", "\015")
    	text = text:gsub("\029\021", "\020")
    	text = text:gsub("\029\001", "\251")
    	text = text:gsub("\029\002", "\252")
    	text = text:gsub("\029\003", "\253")
    	text = text:gsub("\029\004", "\254")
    	text = text:gsub("\029\005", "\255")
    	text = text:gsub("\031(.)", decodeLargeChar)
    	text = text:gsub("\029\032", "\031")
    	text = text:gsub("\029\030", "\029")
	else
	    text = text:gsub("\255", "\000")
	    
    	text = text:gsub("\176([\177\254\011\125\038])", func)
	end
	-- remove the hidden character and refix the prohibited characters.
	return text
end

local lastChannelJoined

function AceComm.hooks:JoinChannelByName(orig, channel, ...)
	lastChannelJoined = channel
	return orig(channel, ...)
end

local function JoinChannel(channel)
	if not IsInChannel(channel) then
		LeaveChannelByName(channel)
		AceComm:ScheduleEvent("AceComm-JoinChannelByName-" .. channel, JoinChannelByName, 0, channel)
	end
end

local function LeaveChannel(channel)
	if IsInChannel(channel) then
		LeaveChannelByName(channel)
	end
end

local switches = {}

local function SwitchChannel(former, latter)
	if IsInChannel(former) then
		LeaveChannelByName(former)
		local t = new()
		t.former = former
		t.latter = latter
		switches[t] = true
		return
	end
	if not IsInChannel(latter) then
		JoinChannelByName(latter)
	end
end

local shutdown = false

local zoneCache
local function GetCurrentZoneChannel()
	if not zoneCache then
		zoneCache = "AceCommZone" .. HexCheckSum(GetRealZoneText())
	end
	return zoneCache
end

local AceComm_registry

local function SupposedToBeInChannel(chan)
	if not chan:find("^AceComm") then
		return true
	elseif shutdown or not AceEvent:IsFullyInitialized() then
		return false
	end
	
	if chan == "AceComm" then
		return AceComm_registry.GLOBAL and next(AceComm_registry.GLOBAL) and true or false
	elseif chan:find("^AceCommZone%x%x%x%x%x%x$") then
		if chan == GetCurrentZoneChannel() then
			return AceComm_registry.ZONE and next(AceComm_registry.ZONE) and true or false
		else
			return false
		end
	else
		return AceComm_registry.CUSTOM and AceComm_registry.CUSTOM[chan] and next(AceComm_registry.CUSTOM[chan]) and true or false
	end
end

local function LeaveAceCommChannels(all)
	if all then
		shutdown = true
	end
	local _,a,_,b,_,c,_,d,_,e,_,f,_,g,_,h,_,i,_,j = GetChannelList()
	local tmp = new()
	tmp[1] = a
	tmp[2] = b
	tmp[3] = c
	tmp[4] = d
	tmp[5] = e
	tmp[6] = f
	tmp[7] = g
	tmp[8] = h
	tmp[9] = i
	tmp[10] = j
	for _,v in ipairs(tmp) do
		if v and v:find("^AceComm") then
			if not SupposedToBeInChannel(v) then
				LeaveChannelByName(v)
			end
		end
	end
	tmp = del(tmp)
end

local lastRefix = 0
local function RefixAceCommChannelsAndEvents()
	if GetTime() - lastRefix <= 5 then
		AceComm:ScheduleEvent("AceComm-RefixAceCommChannelsAndEvents", RefixAceCommChannelsAndEvents, GetTime() - lastRefix)
		return
	end
	lastRefix = GetTime()
	LeaveAceCommChannels(false)
	
	local channel = false
	local whisper = false
	local addon = false
	if SupposedToBeInChannel("AceComm") then
		JoinChannel("AceComm")
		channel = true
	end
	if SupposedToBeInChannel(GetCurrentZoneChannel()) then
		JoinChannel(GetCurrentZoneChannel())
		channel = true
	end
	if AceComm_registry.CUSTOM then
		for k,v in pairs(AceComm_registry.CUSTOM) do
			if next(v) and SupposedToBeInChannel(k) then
				JoinChannel(k)
				channel = true
			end
		end
	end
	if AceComm_registry.WHISPER or AceComm_registry.GROUP or AceComm_registry.PARTY or AceComm_registry.RAID or AceComm_registry.BATTLEGROUND or AceComm_registry.GUILD then
		addon = true
	end
	
	if channel then
		if not AceComm:IsEventRegistered("CHAT_MSG_CHANNEL") then
			AceComm:RegisterEvent("CHAT_MSG_CHANNEL")
		end
		if not AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_LIST") then
			AceComm:RegisterEvent("CHAT_MSG_CHANNEL_LIST")
		end
		if not AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_JOIN") then
			AceComm:RegisterEvent("CHAT_MSG_CHANNEL_JOIN")
		end
		if not AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_LEAVE") then
			AceComm:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE")
		end
	else
		if AceComm:IsEventRegistered("CHAT_MSG_CHANNEL") then
			AceComm:UnregisterEvent("CHAT_MSG_CHANNEL")
		end
		if AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_LIST") then
			AceComm:UnregisterEvent("CHAT_MSG_CHANNEL_LIST")
		end
		if AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_JOIN") then
			AceComm:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN")
		end
		if AceComm:IsEventRegistered("CHAT_MSG_CHANNEL_LEAVE") then
			AceComm:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
		end
	end
	
	if addon then
		if not AceComm:IsEventRegistered("CHAT_MSG_ADDON") then
			AceComm:RegisterEvent("CHAT_MSG_ADDON")
		end
	else
		if AceComm:IsEventRegistered("CHAT_MSG_ADDON") then
			AceComm:UnregisterEvent("CHAT_MSG_ADDON")
		end
	end
end


do
	local myFunc = function(k)
		if not IsInChannel(k.latter) then
			JoinChannelByName(k.latter)
		end
		switches[k] = del(k)
	end
	
	function AceComm:CHAT_MSG_CHANNEL_NOTICE(kind, _, _, deadName, _, _, _, num, channel)
		if kind == "YOU_LEFT" then
			if not channel:find("^AceComm") then
				return
			end
			for k in pairs(switches) do
				if k.former == channel then
					self:ScheduleEvent("AceComm-Join-" .. k.latter, myFunc, 0, k)
				end
			end
			if channel == GetCurrentZoneChannel() then
				self:TriggerEvent("AceComm_LeftChannel", "ZONE")
			elseif channel == "AceComm" then
				self:TriggerEvent("AceComm_LeftChannel", "GLOBAL")
			else
				self:TriggerEvent("AceComm_LeftChannel", "CUSTOM", channel:sub(8))
			end
			if channel:find("^AceComm") and SupposedToBeInChannel(channel) then
				self:ScheduleEvent("AceComm-JoinChannel-" .. channel, JoinChannel, 0, channel)
			end
			if AceComm.userRegistry[channel] then
				AceComm.userRegistry[channel] = del(AceComm.userRegistry[channel])
			end
		elseif kind == "YOU_JOINED" then
			if not (num == 0 and deadName or channel):find("^AceComm") then
				return
			end
			if num == 0 then
				self:ScheduleEvent("AceComm-LeaveChannelByName-" .. deadName, LeaveChannelByName, 0, deadName)
				local t = new()
				t.former = deadName
				t.latter = deadName
				switches[t] = true
			elseif channel == GetCurrentZoneChannel() then
				self:TriggerEvent("AceComm_JoinedChannel", "ZONE")
			elseif channel == "AceComm" then
				self:TriggerEvent("AceComm_JoinedChannel", "GLOBAL")
			else
				self:TriggerEvent("AceComm_JoinedChannel", "CUSTOM", channel:sub(8))
			end
			if num ~= 0 then
				if not SupposedToBeInChannel(channel) then
					LeaveChannel(channel)
				else
					ListChannelByName(channel)
				end
			end
		end
	end
end

local Serialize
do
	local recurse
	local function _Serialize(v, textToHash)
		local kind = type(v)
		if kind == "boolean" then
			if v then
				return "B" -- true
			else
				return "b" -- false
			end
		elseif not v then
			return "/"
		elseif kind == "number" then
			if v == math_floor(v) then
				if v <= 2^7-1 and v >= -2^7 then
					if v < 0 then
						v = v + 256
					end
					return string_char(byte_d, v)
				elseif v <= 2^15-1 and v >= -2^15 then
					if v < 0 then
						v = v + 256^2
					end
					return string_char(byte_D, math_floor(v / 256), v % 256)
				elseif v <= 2^31-1 and v >= -2^31 then
					if v < 0 then
						v = v + 256^4
					end
					return string_char(byte_e, math_floor(v / 256^3), math_floor(v / 256^2) % 256, math_floor(v / 256) % 256, v % 256)
				elseif v <= 2^63-1 and v >= -2^63 then
					if v < 0 then
						v = v + 256^8
					end
					return string_char(byte_E, math_floor(v / 256^7), math_floor(v / 256^6) % 256, math_floor(v / 256^5) % 256, math_floor(v / 256^4) % 256, math_floor(v / 256^3) % 256, math_floor(v / 256^2) % 256, math_floor(v / 256) % 256, v % 256)
				end
			elseif v == inf then
				return string_char(64 --[[byte_inf]])
			elseif v == -inf then
				return string_char(36 --[[byte_ninf]])
			elseif v ~= v then
				return string_char(33 --[[byte_nan]])
			end
--			do
--				local s = tostring(v)
--				local len = s:len()
--				return string_char(byte_plus, len) .. s
--			end
			local sign = v < 0 or v == 0 and tostring(v) == "-0"
			if sign then
				v = -v
			end
			local m, exp = math.frexp(v)
			m = m * 2^53
			local x = exp + 1023
			local b = m % 256
			local c = math_floor(m / 256) % 256
			m = math_floor(m / 256^2)
			m = m + x * 2^37
			return string_char(sign and byte_minus or byte_plus, math_floor(m / 256^5) % 256, math_floor(m / 256^4) % 256, math_floor(m / 256^3) % 256, math_floor(m / 256^2) % 256, math_floor(m / 256) % 256, m % 256, c, b)
		elseif kind == "string" then
			local hash = textToHash and textToHash[v]
			if hash then
				return string_char(byte_m, math_floor(hash / 256^2), math_floor(hash / 256) % 256, hash % 256)
			end
			local r,g,b,A,B,C,D,E,F,G,H,name = v:match("^|cff(%x%x)(%x%x)(%x%x)|Hitem:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%d+)|h%[(.+)%]|h|r$")
			if A then
				-- item link
				
				A = A+0 -- convert to number
				B = B+0
				C = C+0
				D = D+0
				E = E+0
				F = F+0
				G = G+0
				H = H+0
				r = tonumber(r, 16)
				g = tonumber(g, 16)
				b = tonumber(b, 16)
				
				-- (1-35000):(1-3093):(1-3093):(1-3093):(1-3093):(?):(-57 to 2164):(0-4294967295)
				
				F = nil -- don't care
				if G < 0 then
					G = G + 256^2 -- handle negatives
				end
				
				H = H % 256^2 -- only lower 16 bits matter
				
				return string_char(byte_I, r, g, b, math_floor(A / 256) % 256, A % 256, math_floor(B / 256) % 256, B % 256, math_floor(C / 256) % 256, C % 256, math_floor(D / 256) % 256, D % 256, math_floor(E / 256) % 256, E % 256, math_floor(G / 256) % 256, G % 256, math_floor(H / 256) % 256, H % 256, name:len() % 256) .. name:sub(1, 255)
			else
				-- normal string
				local len = v:len()
				if len <= 255 then
					return string_char(byte_s, len) .. v
				else
					return string_char(byte_S, math_floor(len / 256), len % 256) .. v
				end
			end
		elseif kind == "function" then
			AceComm:error("Cannot serialize a function")
		elseif kind == "table" then
			if recurse[v] then
				for k in pairs(recurse) do
					recurse[k] = nil
				end
				AceComm:error("Cannot serialize a recursive table")
				return
			end
			recurse[v] = true
			if AceOO.inherits(v, AceOO.Class) then
				if not v.class then
					AceComm:error("Cannot serialize an AceOO class, can only serialize objects")
				elseif type(v.Serialize) ~= "function" then
					AceComm:error("Cannot serialize an AceOO object without the `Serialize' method.")
				elseif type(v.class.Deserialize) ~= "function" then
					AceComm:error("Cannot serialize an AceOO object without the `Deserialize' static method.")
				elseif type(v.class.GetLibraryVersion) ~= "function" or not AceLibrary:HasInstance(v.class:GetLibraryVersion()) then
					AceComm:error("Cannot serialize an AceOO object if the class is not registered with AceLibrary.")
				end
				local classHash = TailoredBinaryCheckSum(v.class:GetLibraryVersion())
				local t = new(classHash, v:Serialize())
				for i = 2, #t do
					t[i] = _Serialize(t[i], textToHash)
				end
				if not notFirst then
					for k in pairs(recurse) do
						recurse[k] = nil
					end
				end
				local s = table.concat(t)
				t = del(t)
				local len = s:len()
				if len <= 255 then
					return string_char(byte_o, len) .. s
				else
					return string_char(byte_O, math_floor(len / 256), len % 256) .. s
				end
			end
			local t = new()
			local islist = false
			local n = #v
			if n >= 1 then
				islist = true
				for k,u in pairs(v) do
					if type(k) ~= "number" or k < 1 then
						islist = false
						break
					end
				end
			end
			if islist then
				n = n * 4
				while v[n] == nil do
					n = n - 1
				end
				for i = 1, n do
					t[i] = _Serialize(v[i], textToHash)
				end
			else
				local i = 1
				for k,u in pairs(v) do
					t[i] = _Serialize(k, textToHash)
					t[i+1] = _Serialize(u, textToHash)
					i = i + 2
				end
			end
			if not notFirst then
				for k in pairs(recurse) do
					recurse[k] = nil
				end
			end
			local s = table.concat(t)
			t = del(t)
			local len = s:len()
			if islist then
				if len <= 255 then
					return string_char(byte_u, len) .. s
				else
					return "U" .. string_char(math_floor(len / 256), len % 256) .. s
				end
			else
				if len <= 255 then
					return "t" .. string_char(len) .. s
				else
					return "T" .. string_char(math_floor(len / 256), len % 256) .. s
				end
			end
		end
	end
	
	function Serialize(value, textToHash)
		if not recurse then
			recurse = new()
		end
		local chunk = _Serialize(value, textToHash)
		for k in pairs(recurse) do
			recurse[k] = nil
		end
		return chunk
	end
end

local Deserialize
do
	local function _Deserialize(value, position, hashToText)
		if not position then
			position = 1
		end
		local x = value:byte(position)
		if x == byte_b then
			-- false
			return false, position
		elseif x == byte_B then
			-- true
			return true, position
		elseif x == byte_nil then
			-- nil
			return nil, position
		elseif x == byte_i then
			-- 14-byte item link
			local a1 = value:byte(position + 1)
			local a2 = value:byte(position + 2)
			local b1 = value:byte(position + 3)
			local b2 = value:byte(position + 4)
			local c1 = value:byte(position + 5)
			local c2 = value:byte(position + 6)
			local d1 = value:byte(position + 7)
			local d2 = value:byte(position + 8)
			local e1 = value:byte(position + 9)
			local e2 = value:byte(position + 10)
			local g1 = value:byte(position + 11)
			local g2 = value:byte(position + 12)
			local h1 = value:byte(position + 13)
			local h2 = value:byte(position + 14)
			local A = a1 * 256 + a2
			local B = b1 * 256 + b2
			local C = c1 * 256 + c2
			local D = d1 * 256 + d2
			local E = e1 * 256 + e2
			local G = g1 * 256 + g2
			local H = h1 * 256 + h2
			if G >= 2^15 then
				G = G - 256^2
			end
			local s = ("item:%d:%d:%d:%d:%d:%d:%d:%d"):format(A, B, C, D, E, 0, G, H)
			local _, link = GetItemInfo(s)
			return link, position + 14
		elseif x == byte_I then
			-- long item link
			local a1 = value:byte(position + 4)
			local a2 = value:byte(position + 5)
			local b1 = value:byte(position + 6)
			local b2 = value:byte(position + 7)
			local c1 = value:byte(position + 8)
			local c2 = value:byte(position + 9)
			local d1 = value:byte(position + 10)
			local d2 = value:byte(position + 11)
			local e1 = value:byte(position + 12)
			local e2 = value:byte(position + 13)
			local g1 = value:byte(position + 14)
			local g2 = value:byte(position + 15)
			local h1 = value:byte(position + 16)
			local h2 = value:byte(position + 17)
			local A = a1 * 256 + a2
			local B = b1 * 256 + b2
			local C = c1 * 256 + c2
			local D = d1 * 256 + d2
			local E = e1 * 256 + e2
			local G = g1 * 256 + g2
			local H = h1 * 256 + h2
			if G >= 2^15 then
				G = G - 256^2
			end
			local s = ("item:%d:%d:%d:%d:%d:%d:%d:%d"):format(A, B, C, D, E, 0, G, H)
			local _, link = GetItemInfo(s)
			local len = value:byte(position + 18)
			if not link then
				local r = value:byte(position + 1)
				local g = value:byte(position + 2)
				local b = value:byte(position + 3)
				local name = value:sub(position + 19, position + 18 + len)
				
				link = ("|cff%02x%02x%02x|Hitem:%d:%d:%d:%d:%d:%d:%d:%d|h[%s]|h|r"):format(r, g, b, A, B, C, D, E, 0, G, H, name)
			end
			return link, position + 18 + len
		elseif x == byte_m then
			local hash = value:byte(position + 1) * 256^2 + value:byte(position + 2) * 256 + value:byte(position + 3)
			return hashToText[hash], position + 3
		elseif x == byte_s then
			-- 0-255-byte string
			local len = value:byte(position + 1)
			return value:sub(position + 2, position + 1 + len), position + 1 + len
		elseif x == byte_S then
			-- 256-65535-byte string
			local len = value:byte(position + 1) * 256 + value:byte(position + 2)
			return value:sub(position + 3, position + 2 + len), position + 2 + len
		elseif x == 64 --[[byte_inf]] then
			return inf, position
		elseif x == 36 --[[byte_ninf]] then
			return -inf, position
		elseif x == 33 --[[byte_nan]] then
			return nan, position
		elseif x == byte_d then
			-- 1-byte integer
			local a = value:byte(position + 1)
			if a >= 128 then
				a = a - 256
			end
			return a, position + 1
		elseif x == byte_D then
			-- 2-byte integer
			local a = value:byte(position + 1)
			local b = value:byte(position + 2)
			local N = a * 256 + b
			if N >= 2^15 then
				N = N - 256^2
			end
			return N, position + 2
		elseif x == byte_e then
			-- 4-byte integer
			local a = value:byte(position + 1)
			local b = value:byte(position + 2)
			local c = value:byte(position + 3)
			local d = value:byte(position + 4)
			local N = a * 256^3 + b * 256^2 + c * 256 + d
			if N >= 2^31 then
				N = N - 256^4
			end
			return N, position + 4
		elseif x == byte_E then
			-- 8-byte integer
			local a = value:byte(position + 1)
			local b = value:byte(position + 2)
			local c = value:byte(position + 3)
			local d = value:byte(position + 4)
			local e = value:byte(position + 5)
			local f = value:byte(position + 6)
			local g = value:byte(position + 7)
			local h = value:byte(position + 8)
			local N = a * 256^7 + b * 256^6 + c * 256^5 + d * 256^4 + e * 256^3 + f * 256^2 + g * 256 + h
			if N >= 2^63 then
				N = N - 2^64
			end
			return N, position + 8
		elseif x == byte_plus or x == byte_minus then
			local a = value:byte(position + 1)
			local b = value:byte(position + 2)
			local c = value:byte(position + 3)
			local d = value:byte(position + 4)
			local e = value:byte(position + 5)
			local f = value:byte(position + 6)
			local g = value:byte(position + 7)
			local h = value:byte(position + 8)
			local N = a * 256^5 + b * 256^4 + c * 256^3 + d * 256^2 + e * 256 + f
			local sign = x
			local x = math.floor(N / 2^37)
			local m = (N % 2^37) * 256^2 + g * 256 + h
			local mantissa = m / 2^53
			local exp = x - 1023
			local val = math.ldexp(mantissa, exp)
			if sign == byte_minus then
				return -val, position + 8
			end
			return val, position + 8
		elseif x == byte_u or x == byte_U then
			-- numerically-indexed table
			local finish
			local start
			if x == byte_u then
				local len = value:byte(position + 1)
				finish = position + 1 + len
				start = position + 2
			else
				local len = value:byte(position + 1) * 256 + value:byte(position + 2)
				finish = position + 2 + len
				start = position + 3
			end
			local t = new()
			local n = 0
			local curr = start - 1
			while curr < finish do
				local v
				v, curr = _Deserialize(value, curr + 1, hashToText)
				n = n + 1
				t[n] = v
			end
			return t, finish
		elseif x == byte_o or x == byte_O then
			-- numerically-indexed table
			local finish
			local start
			if x == byte_o then
				local len = value:byte(position + 1)
				finish = position + 1 + len
				start = position + 2
			else
				local len = value:byte(position + 1) * 256 + value:byte(position + 2)
				finish = position + 2 + len
				start = position + 3
			end
			local hash = value:byte(start) * 256^2 + value:byte(start + 1) * 256 + value:byte(start + 2)
			local curr = start + 2
			if not AceComm.classes[hash] then
				return nil, finish
			end
			local class = AceComm.classes[hash]
			if type(class.Deserialize) ~= "function" or type(class.prototype.Serialize) ~= "function" then
				return nil, finish
			end
			local n = 0
			local tmp = new()
			while curr < finish do
				local v
				v, curr = _Deserialize(value, curr + 1, hashToText)
				n = n + 1
				tmp[n] = v
			end
			local object = class:Deserialize(unpack(tmp, 1, n))
			tmp = del(tmp)
			return object, finish
		elseif x == byte_t or x == byte_T then
			-- table
			local finish
			local start
			if x == byte_t then
				local len = value:byte(position + 1)
				finish = position + 1 + len
				start = position + 2
			else
				local len = value:byte(position + 1) * 256 + value:byte(position + 2)
				finish = position + 2 + len
				start = position + 3
			end
			local t = new()
			local curr = start - 1
			while curr < finish do
				local key, l = _Deserialize(value, curr + 1, hashToText)
				local value, m = _Deserialize(value, l + 1, hashToText)
				curr = m
				t[key] = value
			end
			if type(t.n) ~= "number" then
				local i = 1
				while t[i] ~= nil do
					i = i + 1
				end
			end
			return t, finish
		else
			error("Improper serialized value provided")
		end
	end
	
	function Deserialize(value, hashToText)
		local ret,msg = pcall(_Deserialize, value, nil, hashToText)
		if ret then
			return msg
		end
	end
end

local function GetCurrentGroupDistribution()
	if MiniMapBattlefieldFrame.status == "active" then
		return "BATTLEGROUND"
	elseif UnitInRaid("player") then
		return "RAID"
	elseif UnitInParty("player") then
		return "PARTY"
	else
		return nil
	end
end

local function IsInDistribution(dist, customChannel)
	if dist == "GROUP" then
		return GetCurrentGroupDistribution() and true or false
	elseif dist == "BATTLEGROUND" then
		return MiniMapBattlefieldFrame.status == "active"
	elseif dist == "RAID" then
		return UnitInRaid("player") and true or false
	elseif dist == "PARTY" then
		return UnitInParty("player") and true or false
	elseif dist == "GUILD" then
		return IsInGuild() and true or nil
	elseif dist == "GLOBAL" then
		return IsInChannel("AceComm")
	elseif dist == "ZONE" then
		return IsInChannel(GetCurrentZoneChannel())
	elseif dist == "WHISPER" then
		return true
	elseif dist == "CUSTOM" then
		return IsInChannel(customChannel)
	end
	error("unknown distribution: " .. dist, 2)
end

function AceComm:RegisterComm(prefix, distribution, method, a4)
	AceComm:argCheck(prefix, 2, "string")
	AceComm:argCheck(distribution, 3, "string")
	if distribution ~= "GLOBAL" and distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" and distribution ~= "ZONE" and distribution ~= "CUSTOM" then
		AceComm:error('Argument #3 to `RegisterComm\' must be either "GLOBAL", "ZONE", "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", "GROUP", or "CUSTOM". %q is not appropriate', distribution)
	end
	local customChannel
	if distribution == "CUSTOM" then
		customChannel, method = method, a4
		AceComm:argCheck(customChannel, 4, "string")
		if customChannel:len() == 0 then
			AceComm:error('Argument #4 to `RegisterComm\' must be a non-zero-length string.')
		elseif customChannel:find("%s") then
			AceComm:error('Argument #4 to `RegisterComm\' must not have spaces.')
		end
	end
	if self == AceComm then
		AceComm:argCheck(method, customChannel and 5 or 4, "function", "table")
		self = method
	else
		AceComm:argCheck(method, customChannel and 5 or 4, "string", "function", "table", "nil")
	end
	if not method then
		method = "OnCommReceive"
	end
	if type(method) == "string" and type(self[method]) ~= "function" and type(self[method]) ~= "table" then
		AceEvent:error("Cannot register comm %q to method %q, it does not exist", prefix, method)
	end
	
	local registry = AceComm_registry
	if not registry[distribution] then
		registry[distribution] = new()
	end
	if customChannel then
		customChannel = "AceComm" .. customChannel
		if not registry[distribution][customChannel] then
			registry[distribution][customChannel] = new()
		end
		if not registry[distribution][customChannel][prefix] then
			registry[distribution][customChannel][prefix] = new()
		end
		registry[distribution][customChannel][prefix][self] = method
	else
		if not registry[distribution][prefix] then
			registry[distribution][prefix] = new()
		end
		registry[distribution][prefix][self] = method
	end
	
	RefixAceCommChannelsAndEvents()
end

function AceComm:UnregisterComm(prefix, distribution, customChannel)
	AceComm:argCheck(prefix, 2, "string")
	AceComm:argCheck(distribution, 3, "string", "nil")
	if distribution and distribution ~= "GLOBAL" and distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" and distribution ~= "ZONE" and distribution ~= "CUSTOM" then
		AceComm:error('Argument #3 to `UnregisterComm\' must be either nil, "GLOBAL", "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", "GROUP", "ZONE", or "CUSTOM". %q is not appropriate', distribution)
	end
	if distribution == "CUSTOM" then
		AceComm:argCheck(customChannel, 3, "string")
		if customChannel:len() == 0 then
			AceComm:error('Argument #3 to `UnregisterComm\' must be a non-zero-length string.')
		end
	else
		AceComm:argCheck(customChannel, 3, "nil")
	end
	
	local registry = AceComm_registry
	if not distribution then
		for k,v in pairs(registry) do
			if k == "CUSTOM" then
				for l,u in pairs(v) do
					if u[prefix] and u[prefix][self] then
						AceComm.UnregisterComm(self, prefix, k, l:sub(8))
						if not registry[k] then
							break
						end
					end
				end
			else
				if v[prefix] and v[prefix][self] then
					AceComm.UnregisterComm(self, prefix, k)
				end
			end
		end
		return
	end
	if self == AceComm then
		if distribution == "CUSTOM" then
			error(("Cannot unregister comm %q::%q. Improperly unregistering from AceComm-2.0."):format(distribution, customChannel), 2)
		else
			error(("Cannot unregister comm %q. Improperly unregistering from AceComm-2.0."):format(distribution), 2)
		end
	end
	if distribution == "CUSTOM" then
		customChannel = "AceComm" .. customChannel
		if not registry[distribution] or not registry[distribution][customChannel] or not registry[distribution][customChannel][prefix] or not registry[distribution][customChannel][prefix][self] then
			AceComm:error("Cannot unregister comm %q. %q is not registered with it.", distribution, self)
		end
		registry[distribution][customChannel][prefix][self] = nil
		
		if not next(registry[distribution][customChannel][prefix]) then
			registry[distribution][customChannel][prefix] = del(registry[distribution][customChannel][prefix])
		end
		
		if not next(registry[distribution][customChannel]) then
			registry[distribution][customChannel] = del(registry[distribution][customChannel])
		end
	else
		if not registry[distribution] or not registry[distribution][prefix] or not registry[distribution][prefix][self] then
			AceComm:error("Cannot unregister comm %q. %q is not registered with it.", distribution, self)
		end
		registry[distribution][prefix][self] = nil
		
		if not next(registry[distribution][prefix]) then
			registry[distribution][prefix] = del(registry[distribution][prefix])
		end
	end
	
	if not next(registry[distribution]) then
		registry[distribution] = del(registry[distribution])
	end
	
	RefixAceCommChannelsAndEvents()
end

function AceComm:UnregisterAllComms()
	local registry = AceComm_registry
	for k, distribution in pairs(registry) do
		if k == "CUSTOM" then
			for l, channel in pairs(distribution) do
				local j = next(channel)
				while j ~= nil do
					local prefix = channel[j]
					if prefix[self] then
						AceComm.UnregisterComm(self, j)
						if distribution[l] and registry[k] then
							j = next(channel)
						else
							l = nil
							k = nil
							break
						end
					else
						j = next(channel, j)
					end
				end
				if k == nil then
					break
				end
			end
		else
			local j = next(distribution)
			while j ~= nil do
				local prefix = distribution[j]
				if prefix[self] then
					AceComm.UnregisterComm(self, j)
					if registry[k] then
						j = next(distribution)
					else
						k = nil
						break
					end
				else
					j = next(distribution, j)
				end
			end
		end
	end
end

function AceComm:IsCommRegistered(prefix, distribution, customChannel)
	AceComm:argCheck(prefix, 2, "string")
	AceComm:argCheck(distribution, 3, "string", "nil")
	if distribution and distribution ~= "GLOBAL" and distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" and distribution ~= "ZONE" and distribution ~= "CUSTOM" then
		AceComm:error('Argument #3 to `IsCommRegistered\' must be either "GLOBAL", "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", "GROUP", "ZONE", or "CUSTOM". %q is not appropriate', distribution)
	end
	if distribution == "CUSTOM" then
		AceComm:argCheck(customChannel, 4, "nil", "string")
		if customChannel == "" then
			AceComm:error('Argument #4 to `IsCommRegistered\' must be a non-zero-length string or nil.')
		end
	else
		AceComm:argCheck(customChannel, 4, "nil")
	end
	local registry = AceComm_registry
	if not distribution then
		for k,v in pairs(registry) do
			if k == "CUSTOM" then
				for l,u in pairs(v) do
					if u[prefix] and u[prefix][self] then
						return true
					end
				end
			else
				if v[prefix] and v[prefix][self] then
					return true
				end
			end
		end
		return false
	elseif distribution == "CUSTOM" and not customChannel then
		if not registry[distribution] then
			return false
		end
		for l,u in pairs(registry[distribution]) do
			if u[prefix] and u[prefix][self] then
				return true
			end
		end
		return false
	elseif distribution == "CUSTOM" then
		customChannel = "AceComm" .. customChannel
		return registry[distribution] and registry[distribution][customChannel] and registry[distribution][customChannel][prefix] and registry[distribution][customChannel][prefix][self] and true or false
	end
	return registry[distribution] and registry[distribution][prefix] and registry[distribution][prefix][self] and true or false
end

function AceComm:OnEmbedDisable(target)
	self.UnregisterAllComms(target)
end

local id = byte_Z

local function encodedChar(x)
	if x == 10 then
		return "\029\011"
	elseif x == 0 then
		return "\127"
	elseif x == 127 then
		return "\029\126"
	elseif x == 124 then
		return "\029\125"
	elseif x == byte_s then
		return "\015"
	elseif x == byte_S then
		return "\020"
	elseif x == 15 then
		return "\029\016"
	elseif x == 20 then
		return "\029\021"
	elseif x == 29 then
		return "\029\030"
	elseif x == 37 then
		return "\029\038"
	end
	return string_char(x)
end

local function soberEncodedChar(x)
	if x == 10 then
		return "\176\011"
	elseif x == 0 then
		return "\255"
	elseif x == 255 then
		return "\176\254"
	elseif x == 124 then
		return "\176\125"
	elseif x == byte_deg then
		return "\176\177"
	elseif x == 37 then
		return "\176\038"
	end
	return string_char(x)
end

local recentGuildMessage = 0
local firstGuildMessage = true
local stopGuildMessages = false


function AceComm:PLAYER_GUILD_UPDATE(arg1)
	if arg1 and arg1 ~= "player" then return end
	
	recentGuildMessage = 0
	firstGuildMessage = true
	stopGuildMessages = false
end

local function SendMessage(prefix, priority, distribution, person, message, textToHash)
	if distribution == "CUSTOM" then
		person = "AceComm" .. person
	end
	if not IsInDistribution(distribution, person) then
		return false
	end
	if distribution == "GROUP" then
		distribution = GetCurrentGroupDistribution()
		if not distribution then
			return false
		end
	end	
	if distribution == "GUILD" and stopGuildMessages then
		return false
	end
	if id == byte_Z then
		id = byte_a
	elseif id == byte_z then
		id = byte_A
	else
		id = id + 1
	end
	if id == byte_s or id == byte_S then
		id = id + 1
	end
	local id = string_char(id)
	local drunk = distribution == "GLOBAL" or distribution == "ZONE" or distribution == "CUSTOM"
	prefix = Encode(prefix, drunk)
	message = Serialize(message, textToHash)
	message = Encode(message, drunk)
	local headerLen = prefix:len() + 6
	local messageLen = message:len()
	local max = math_floor(messageLen / (250 - headerLen) + 1)
	if max > 1 then
		local segment = math_floor(messageLen / max + 0.5)
		local last = 0
		local good = true
		for i = 1, max do
			local bit
			if i == max then
				bit = message:sub(last + 1)
			else
				local next = segment * i
				if message:byte(next) == byte_deg then
					next = next + 1
				end
				bit = message:sub(last + 1, next)
				last = next
			end
			if distribution == "GLOBAL" or distribution == "ZONE" or distribution == "CUSTOM" then
				bit = prefix .. "\t" .. id .. encodedChar(i) .. encodedChar(max) .. "\t" .. bit .. "\029"
				local channel
				if distribution == "GLOBAL" then
					channel = "AceComm"
				elseif distribution == "ZONE" then
					channel = GetCurrentZoneChannel()
				elseif distribution == "CUSTOM" then
					channel = person
				end
				local index = GetChannelName(channel)
				if index and index > 0 then
					ChatThrottleLib:SendChatMessage(priority, prefix, bit, "CHANNEL", nil, index)
				else
					good = false
				end
			else
				bit = id .. soberEncodedChar(i) .. soberEncodedChar(max) .. "\t" .. bit
				ChatThrottleLib:SendAddonMessage(priority, prefix, bit, distribution, person)
			end
		end
		return good
	else
		if distribution == "GLOBAL" or distribution == "ZONE" or distribution == "CUSTOM" then
			message = prefix .. "\t" .. id .. string_char(1) .. string_char(1) .. "\t" .. message .. "\029"
			local channel
			if distribution == "GLOBAL" then
				channel = "AceComm"
			elseif distribution == "ZONE" then
				channel = GetCurrentZoneChannel()
			elseif distribution == "CUSTOM" then
				channel = person
			end
			local index = GetChannelName(channel)
			if index and index > 0 then
				ChatThrottleLib:SendChatMessage(priority, prefix, message, "CHANNEL", nil, index)
				return true
			end
		else
			message = id .. string_char(1) .. string_char(1) .. "\t" .. message
			if distribution == "GUILD" and firstGuildMessage then
				firstGuildMessage = false
				if GetCVar("EnableErrorSpeech") == "1" then
					SetCVar("EnableErrorSpeech", "0")
					AceLibrary("AceEvent-2.0"):ScheduleEvent("AceComm-EnableErrorSpeech", function()
						SetCVar("EnableErrorSpeech", "1")
					end, 10)
				end
				recentGuildMessage = GetTime() + 10
			end
			ChatThrottleLib:SendAddonMessage(priority, prefix, message, distribution, person)
			return true
		end
	end
	return false
end

function AceComm:SendPrioritizedCommMessage(priority, distribution, person, ...)
	AceComm:argCheck(priority, 2, "string")
	if priority ~= "NORMAL" and priority ~= "BULK" and priority ~= "ALERT" then
		AceComm:error('Argument #2 to `SendPrioritizedCommMessage\' must be either "NORMAL", "BULK", or "ALERT"')
	end
	AceComm:argCheck(distribution, 3, "string")
	local includePerson = true
	if distribution == "WHISPER" or distribution == "CUSTOM" then
		includePerson = false
		AceComm:argCheck(person, 4, "string")
		if person:len() == 0 then
			AceComm:error("Argument #4 to `SendPrioritizedCommMessage' must be a non-zero-length string")
		end
	end
	if self == AceComm then
		AceComm:error("Cannot send a comm message from AceComm directly.")
	end
	if distribution and distribution ~= "GLOBAL" and distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" and distribution ~= "ZONE" and distribution ~= "CUSTOM" then
		AceComm:error('Argument #4 to `SendPrioritizedCommMessage\' must be either nil, "GLOBAL", "ZONE", "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", "GROUP", or "CUSTOM". %q is not appropriate', distribution)
	end
	
	local prefix = AceComm.commPrefixes[self]
	if type(prefix) ~= "string" then
		AceComm:error("`SetCommPrefix' must be called before sending a message.")
	end
	
	local message
	
	local tmp
	if includePerson and select('#', ...) == 0 and type(person) ~= "table" then
		message = person
	elseif not includePerson and select('#', ...) == 1 and type((...)) ~= "table" then
		message = ...
	else
		tmp = new()
		message = tmp
		local n = 1
		if includePerson then
			tmp[1] = person
			n = 2
		end
		for i = 1, select('#', ...) do
			tmp[n] = select(i, ...)
			n = n + 1
		end
	end
	
	local ret = SendMessage(AceComm.prefixTextToHash[prefix], priority, distribution, person, message, self.commMemoTextToHash)
	
	if tmp then
		tmp = del(tmp)
	end
	
	return ret
end

function AceComm:SendCommMessage(distribution, person, ...)
	AceComm:argCheck(distribution, 2, "string")
	local includePerson = true
	if distribution == "WHISPER" or distribution == "CUSTOM" then
		includePerson = false
		AceComm:argCheck(person, 3, "string")
		if person:len() == 0 then
			AceComm:error("Argument #3 to `SendCommMessage' must be a non-zero-length string")
		end
	end
	if self == AceComm then
		AceComm:error("Cannot send a comm message from AceComm directly.")
	end
	if distribution and distribution ~= "GLOBAL" and distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" and distribution ~= "ZONE" and distribution ~= "CUSTOM" then
		AceComm:error('Argument #2 to `SendCommMessage\' must be either nil, "GLOBAL", "ZONE", "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", "GROUP", or "CUSTOM". %q is not appropriate', distribution)
	end
	
	local prefix = AceComm.commPrefixes[self]
	if type(prefix) ~= "string" then
		AceComm:error("`SetCommPrefix' must be called before sending a message.")
	end
	
	local message
	local tmp
	if includePerson and select('#', ...) == 0 and type(person) ~= "table" then
		message = person
	elseif not includePerson and select('#', ...) == 1 and type((...)) ~= "table" then
		message = ...
	else
		tmp = new()
		message = tmp
		local n = 1
		if includePerson then
			tmp[1] = person
			n = 2
		end
		for i = 1, select('#', ...) do
			tmp[n] = select(i, ...)
			n = n + 1
		end
	end
	
	local priority = self.commPriority or "NORMAL"
	
	local ret = SendMessage(AceComm.prefixTextToHash[prefix], priority, distribution, person, message, self.commMemoTextToHash)
	
	if tmp then
		tmp = del(tmp)
	end
	
	return ret
end

function AceComm:SetDefaultCommPriority(priority)
	AceComm:argCheck(priority, 2, "string")
	if priority ~= "NORMAL" and priority ~= "BULK" and priority ~= "ALERT" then
		AceComm:error('Argument #2 must be either "NORMAL", "BULK", or "ALERT"')
	end
	
	if self.commPriority then
		AceComm:error("Cannot call `SetDefaultCommPriority' more than once")
	end
	
	self.commPriority = priority
end

function AceComm:SetCommPrefix(prefix)
	AceComm:argCheck(prefix, 2, "string")
	
	if AceComm.commPrefixes[self] then
		AceComm:error("Cannot call `SetCommPrefix' more than once.")
	end
	
	if AceComm.prefixes[prefix] then
		AceComm:error("Cannot set prefix to %q, it is already in use.", prefix)
	end
	
	local hash
	if prefix:len() == 3 then
		hash = prefix
	else
		hash = TailoredBinaryCheckSum(prefix)
	end
	if AceComm.prefixHashToText[hash] then
		AceComm:error("Cannot set prefix to %q, its hash is used by another prefix: %q", prefix, AceComm.prefixHashToText[hash])
	end
	
	AceComm.prefixes[prefix] = true
	self.commPrefix = prefix
	AceComm.commPrefixes[self] = prefix
	AceComm.prefixHashToText[hash] = prefix
	AceComm.prefixTextToHash[prefix] = hash
end

function AceComm:RegisterMemoizations(values)
	AceComm:argCheck(values, 2, "table")
	for k,v in pairs(values) do
		if type(k) ~= "number" then
			AceComm:error("Bad argument #2 to `RegisterMemoizations'. All keys must be numbers")
		elseif type(v) ~= "string" then
			AceComm:error("Bad argument #2 to `RegisterMemoizations'. All values must be strings")
		end
	end
	if self.commMemoHashToText or self.commMemoTextToHash then
		AceComm:error("You can only call `RegisterMemoizations' once.")
	elseif not AceComm.commPrefixes[self] then
		AceComm:error("You can only call `SetCommPrefix' before calling `RegisterMemoizations'.")
	elseif AceComm.prefixMemoizations[AceComm.commPrefixes[self]] then
		AceComm:error("Another addon with prefix %q has already registered memoizations.", AceComm.commPrefixes[self])
	end
	local hashToText = new()
	local textToHash = new()
	for _,text in ipairs(values) do
		local hash = TailoredNumericCheckSum(text)
		if hashToText[hash] then
			AceComm:error("%q and %q have the same checksum. You must remove one of them for memoization to work properly", hashToText[hash], text)
		else
			textToHash[text] = hash
			hashToText[hash] = text
		end
	end
	values = nil
	self.commMemoHashToText = hashToText
	self.commMemoTextToHash = textToHash
	AceComm.prefixMemoizations[AceComm.commPrefixes[self]] = hashToText
end

local lastCheck = GetTime()
local function CheckRefix()
	if GetTime() - lastCheck >= 120 then
		lastCheck = GetTime()
		RefixAceCommChannelsAndEvents()
	end
end

local function HandleMessage(prefix, message, distribution, sender, customChannel)
	local isGroup = GetCurrentGroupDistribution() == distribution
	local isCustom = distribution == "CUSTOM"
	if (not AceComm_registry[distribution] and (not isGroup or not AceComm_registry.GROUP)) or (isCustom and not AceComm_registry.CUSTOM[customChannel]) then
		return CheckRefix()
	end
	local _, id, current, max
	if not message then
		_,_, prefix, id, current, max, message = prefix:find("^(...)\t(.)(.)(.)\t(.*)$")
		prefix = AceComm.prefixHashToText[prefix]
		if not prefix then
			return CheckRefix()
		end
		if isCustom then
			if not AceComm_registry.CUSTOM[customChannel][prefix] then
				return CheckRefix()
			end
		else
			if (not AceComm_registry[distribution] or not AceComm_registry[distribution][prefix]) and (not isGroup or not AceComm_registry.GROUP or not AceComm_registry.GROUP[prefix]) then
				return CheckRefix()
			end
		end
	else
		_,_, id, current, max, message = message:find("^(.)(.)(.)\t(.*)$")
	end
	if not message then
		return
	end
	local smallCustomChannel = customChannel and customChannel:sub(8)
	current = current:byte()
	max = max:byte()
	if max > 1 then
		local queue = AceComm.recvQueue
		local x
		if distribution == "CUSTOM" then
			x = prefix .. ":" .. sender .. distribution .. customChannel .. id
		else
			x = prefix .. ":" .. sender .. distribution .. id
		end
		if not queue[x] then
			if current ~= 1 then
				return
			end
			queue[x] = new()
		end
		local chunk = queue[x]
		chunk.time = GetTime()
		chunk[current] = message
		if chunk[max] then
			local success
			success, message = pcall(table.concat, chunk)
			if not success then
				return
			end
			queue[x] = del(queue[x])
		else
			return
		end
	end
	message = Deserialize(message, AceComm.prefixMemoizations[prefix])
	local isTable = type(message) == "table"
	local n
	if isTable then
		n = #message * 4
		if n < 40 then
			n = 40
		end
		while message[n] == nil do
			n = n - 1
		end
	end
	if AceComm_registry[distribution] then
		if isTable then
			if isCustom then
				if AceComm_registry.CUSTOM[customChannel][prefix] then
					for k,v in pairs(AceComm_registry.CUSTOM[customChannel][prefix]) do
						local type_v = type(v)
						if type_v == "string" then
							local f = k[v]
							if type(f) == "table" then
								local i = 1
								local g = f[message[i]]
								while g do
									if type(g) ~= "table" then -- function
										g(k, prefix, sender, distribution, smallCustomChannel, unpack(message, i+1, n))
										break
									else
										i = i + 1
										g = g[message[i]]
									end
								end
							else -- function
								f(k, prefix, sender, distribution, smallCustomChannel, unpack(message, 1, n))
							end
						elseif type_v == "table" then
							local i = 1
							local g = v[message[i]]
							while g do
								if type(g) ~= "table" then -- function
									g(prefix, sender, distribution, smallCustomChannel, unpack(message, i+1, n))
									break
								else
									i = i + 1
									g = g[message[i]]
								end
							end
						else -- function
							v(prefix, sender, distribution, smallCustomChannel, unpack(message, 1, n))
						end
					end
				end
			else
				if AceComm_registry[distribution][prefix] then
					for k,v in pairs(AceComm_registry[distribution][prefix]) do
						local type_v = type(v)
						if type_v == "string" then
							local f = k[v]
							if type(f) == "table" then
								local i = 1
								local g = f[message[i]]
								while g do
									if type(g) ~= "table" then -- function
										g(k, prefix, sender, distribution, unpack(message, i+1, n))
										break
									else
										i = i + 1
										g = g[message[i]]
									end
								end
							else -- function
								f(k, prefix, sender, distribution, unpack(message, 1, n))
							end
						elseif type_v == "table" then
							local i = 1
							local g = v[message[i]]
							while g do
								if type(g) ~= "table" then -- function
									g(prefix, sender, distribution, unpack(message, i+1, n))
									break
								else
									i = i + 1
									g = g[message[i]]
								end
							end
						else -- function
							v(prefix, sender, distribution, unpack(message, 1, n))
						end
					end
				end
			end
		else
			if isCustom then
				if AceComm_registry.CUSTOM[customChannel][prefix] then
					for k,v in pairs(AceComm_registry.CUSTOM[customChannel][prefix]) do
						local type_v = type(v)
						if type_v == "string" then
							local f = k[v]
							if type(f) == "table" then
								local g = f[message]
								if g and type(g) == "function" then
									g(k, prefix, sender, distribution, smallCustomChannel)
								end
							else -- function
								f(k, prefix, sender, distribution, smallCustomChannel, message)
							end
						elseif type_v == "table" then
							local g = v[message]
							if g and type(g) == "function" then
								g(k, prefix, sender, distribution, smallCustomChannel)
							end
						else -- function
							v(prefix, sender, distribution, smallCustomChannel, message)
						end
					end
				end
			else
				if AceComm_registry[distribution][prefix] then
					for k,v in pairs(AceComm_registry[distribution][prefix]) do
						local type_v = type(v)
						if type_v == "string" then
							local f = k[v]
							if type(f) == "table" then
								local g = f[message]
								if g and type(g) == "function" then
									g(k, prefix, sender, distribution)
								end
							else -- function
								f(k, prefix, sender, distribution, message)
							end
						elseif type_v == "table" then
							local g = v[message]
							if g and type(g) == "function" then
								g(k, prefix, sender, distribution)
							end
						else -- function
							v(prefix, sender, distribution, message)
						end
					end
				end
			end
		end
	end
	if isGroup and AceComm_registry.GROUP and AceComm_registry.GROUP[prefix] then
		if isTable then
			for k,v in pairs(AceComm_registry.GROUP[prefix]) do
				local type_v = type(v)
				if type_v == "string" then
					local f = k[v]
					if type(f) == "table" then
						local i = 1
						local g = f[message[i]]
						while g do
							if type(g) ~= "table" then -- function
								g(k, prefix, sender, "GROUP", unpack(message, i+1, n))
								break
							else
								i = i + 1
								g = g[message[i]]
							end
						end
					else -- function
						f(k, prefix, sender, "GROUP", unpack(message, 1, n))
					end
				elseif type_v == "table" then
					local i = 1
					local g = v[message[i]]
					while g do
						if type(g) ~= "table" then -- function
							g(prefix, sender, "GROUP", unpack(message, i+1, n))
							break
						else
							i = i + 1
							g = g[message[i]]
						end
					end
				else -- function
					v(prefix, sender, "GROUP", unpack(message, 1, n))
				end
			end
		else
			for k,v in pairs(AceComm_registry.GROUP[prefix]) do
				local type_v = type(v)
				if type_v == "string" then
					local f = k[v]
					if type(f) == "table" then
						local g = f[message]
						if g and type(g) == "function" then
							g(k, prefix, sender, "GROUP")
						end
					else -- function
						f(k, prefix, sender, "GROUP", message)
					end
				elseif type_v == "table" then
					local g = v[message]
					if g and type(g) == "function" then
						g(k, prefix, sender, "GROUP")
					end
				else -- function
					v(prefix, sender, "GROUP", message)
				end
			end
		end
	end
end

function AceComm:CHAT_MSG_ADDON(prefix, message, distribution, sender)
	if sender == player and not AceComm.enableLoopback and distribution ~= "WHISPER" then
		return
	end
	prefix = self.prefixHashToText[prefix]
	if not prefix then
		return CheckRefix()
	end
	local isGroup = GetCurrentGroupDistribution() == distribution
	if not AceComm_registry[distribution] and (not isGroup or not AceComm_registry.GROUP) then
		return CheckRefix()
	end
	prefix = Decode(prefix)
	if (not AceComm_registry[distribution] or not AceComm_registry[distribution][prefix]) and (not isGroup or not AceComm_registry.GROUP or not AceComm_registry.GROUP[prefix]) then
		return CheckRefix()
	end
	message = Decode(message)
	return HandleMessage(prefix, message, distribution, sender)
end

function AceComm:CHAT_MSG_CHANNEL(text, sender, _, _, _, _, _, _, channel)
	if sender == player or not channel:find("^AceComm") then
		return
	end
	text = Decode(text, true)
	local distribution
	local customChannel
	if channel == "AceComm" then
		distribution = "GLOBAL"
	elseif channel == GetCurrentZoneChannel() then
		distribution = "ZONE"
	else
		distribution = "CUSTOM"
		customChannel = channel
	end
	return HandleMessage(text, nil, distribution, sender, customChannel)
end

function AceComm:IsUserInChannel(userName, distribution, customChannel)
	AceComm:argCheck(userName, 2, "string", "nil")
	if not userName then
		userName = player
	end
	AceComm:argCheck(distribution, 3, "string")
	local channel
	if distribution == "GLOBAL" then
		channel = "AceComm"
	elseif distribution == "ZONE" then
		channel = GetCurrentZoneChannel()
	elseif distribution == "CUSTOM" then
		AceComm:argCheck(customChannel, 4, "string")
		channel = "AceComm" .. customChannel
	else
		AceComm:error('Argument #3 to `IsUserInChannel\' must be "GLOBAL", "CUSTOM", or "ZONE"')
	end
	
	return AceComm.userRegistry[channel] and AceComm.userRegistry[channel][userName] or false
end

function AceComm:CHAT_MSG_CHANNEL_LIST(text, _, _, _, _, _, _, _, channel)
	if not channel:find("^AceComm") then
		return
	end
	
	if not AceComm.userRegistry[channel] then
		AceComm.userRegistry[channel] = new()
	end
	local t = AceComm.userRegistry[channel]
	for k in text:gmatch("[^, @%*#]+") do
		t[k] = true
	end
end

function AceComm:CHAT_MSG_CHANNEL_JOIN(_, user, _, _, _, _, _, _, channel)
	if not channel:find("^AceComm") then
		return
	end
	
	if not AceComm.userRegistry[channel] then
		AceComm.userRegistry[channel] = new()
	end
	local t = AceComm.userRegistry[channel]
	t[user] = true
end

function AceComm:CHAT_MSG_CHANNEL_LEAVE(_, user, _, _, _, _, _, _, channel)
	if not channel:find("^AceComm") then
		return
	end
	
	if not AceComm.userRegistry[channel] then
		AceComm.userRegistry[channel] = new()
	end
	local t = AceComm.userRegistry[channel]
	if t[user] then
		t[user] = nil
	end
end

function AceComm:AceEvent_FullyInitialized()
	RefixAceCommChannelsAndEvents()
end

function AceComm:PLAYER_LOGOUT()
	LeaveAceCommChannels(true)
end

function AceComm:ZONE_CHANGED_NEW_AREA()
	local lastZone = zoneCache
	zoneCache = nil
	local newZone = GetCurrentZoneChannel()
	if self.registry.ZONE and next(self.registry.ZONE) then
		if lastZone then
			SwitchChannel(lastZone, newZone)
		else
			JoinChannel(newZone)
		end
	end
end

function AceComm:embed(target)
	self.super.embed(self, target)
	if not AceEvent then
		AceComm:error(MAJOR_VERSION .. " requires AceEvent-2.0")
	end
end

local recentNotSeen = {}
local notSeenString = '^' .. ERR_CHAT_PLAYER_NOT_FOUND_S:gsub("%%s", "(.-)"):gsub("%%1%$s", "(.-)") .. '$'
local ambiguousString = '^' .. ERR_CHAT_PLAYER_AMBIGUOUS_S:gsub("%%s", "(.-)"):gsub("%%1%$s", "(.-)") .. '$'
function AceComm.hooks:ChatFrame_MessageEventHandler(orig, event)
	if event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_CHANNEL_LIST" then
		if arg9:find("^AceComm") then
			return
		end
	elseif event == "CHAT_MSG_SYSTEM" then
		local _,_,player = arg1:find(notSeenString)
		if not player then
			_,_,player = arg1:find(ambiguousString)
		end
		if player then
			local t = GetTime()
			if recentNotSeen[player] and recentNotSeen[player] > t then
				recentNotSeen[player] = t + 10
				return
			else
				recentNotSeen[player] = t + 10
			end
		elseif arg1 == ERR_GUILD_PERMISSIONS then
			if recentGuildMessage > GetTime() then
				stopGuildMessages = true
				return
			end
		end
	end
	return orig(event)
end

local loggingOut
function AceComm.hooks:Logout(orig)
	if IsResting() then
		LeaveAceCommChannels(true)
	else
		self:ScheduleEvent("AceComm-LeaveAceCommChannels", LeaveAceCommChannels, 15, true)
	end
	loggingOut = true
	return orig()
end

function AceComm.hooks:CancelLogout(orig)
	shutdown = false
	self:CancelScheduledEvent("AceComm-LeaveAceCommChannels")
	RefixAceCommChannelsAndEvents()
	loggingOut = false
	return orig()
end

function AceComm.hooks:Quit(orig)
	if IsResting() then
		LeaveAceCommChannels(true)
	else
		self:ScheduleEvent("AceComm-LeaveAceCommChannels", LeaveAceCommChannels, 15, true)
	end
	loggingOut = true
	return orig()
end

local function filterAceComm(k, v, ...)
	if not k or not v then
		return
	end
	if v:find("^AceComm") then
		return filterAceComm(...)
	else
		return k, v, filterAceComm(...)
	end
end
function AceComm.hooks:FCFDropDown_LoadChannels(orig, ...)
	return orig(filterAceComm(...))
end

function AceComm:CHAT_MSG_SYSTEM(text)
	if text ~= ERR_TOO_MANY_CHAT_CHANNELS then
		return
	end
	
	local chan = lastChannelJoined
	if not chan then
		return
	end
	if not lastChannelJoined:find("^AceComm") then
		return
	end
	
	local text
	if chan == "AceComm" then
		local addon = self.registry.GLOBAL and next(AceComm_registry.GLOBAL)
		if not addon then
			return
		end
		addon = tostring(addon)
		text = ("%s has tried to join the AceComm global channel, but there are not enough channels available. %s may not work because of this"):format(addon, addon)
	elseif chan == GetCurrentZoneChannel() then
		local addon = AceComm_registry.ZONE and next(AceComm_registry.ZONE)
		if not addon then
			return
		end
		addon = tostring(addon)
		text = ("%s has tried to join the AceComm zone channel, but there are not enough channels available. %s may not work because of this"):format(addon, addon)
	else
		local addon = AceComm_registry.CUSTOM and AceComm_registry.CUSTOM[chan] and next(AceComm_registry.CUSTOM[chan])
		if not addon then
			return
		end
		addon = tostring(addon)
		text = ("%s has tried to join the AceComm custom channel %s, but there are not enough channels available. %s may not work because of this"):format(addon, chan, addon)
	end
	
	StaticPopupDialogs["ACECOMM_TOO_MANY_CHANNELS"] = {
		text = text,
		button1 = CLOSE,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
	}
	StaticPopup_Show("ACECOMM_TOO_MANY_CHANNELS")
end

function AceComm:QueryAddonVersion(addon, distribution, player)
	AceComm:argCheck(addon, 2, "string")
	AceComm:argCheck(distribution, 3, "string")
	if distribution ~= "WHISPER" and distribution ~= "PARTY" and distribution ~= "RAID" and distribution ~= "GUILD" and distribution ~= "BATTLEGROUND" and distribution ~= "GROUP" then
		AceComm:error('Argument #3 to `QueryAddonVersion\' must be either "WHISPER", "PARTY", "RAID", "GUILD", "BATTLEGROUND", or "GROUP". %q is not appropriate', distribution)
	end
	if distribution == "WHISPER" then
		AceComm:argCheck(player, 4, "string")
	elseif distribution == "GROUP" then
		distribution = GetCurrentGroupDistribution()
	end
	if not IsInDistribution(distribution) then
		return
	end
	if distribution == "WHISPER" then
		self.addonVersionPinger:SendCommMessage("WHISPER", player, "PING", addon)
	else
		self.addonVersionPinger:SendCommMessage(distribution, "PING", addon)
	end
end

function AceComm:RegisterAddonVersionReceptor(obj, method)
	self:argCheck(obj, 2, "function", "table")
	if type(obj) == "function" then
		method = true
	else
		self:argCheck(method, 3, "string")
		if type(obj[method]) ~= "function" then
			self:error("Handler provided to `RegisterAddonVersionReceptor', %q, not a function", method)
		end
	end
	self.addonVersionPinger.receptors[obj] = method
end

local function activate(self, oldLib, oldDeactivate)
	AceComm = self
	
	if not oldLib or not oldLib.hooks or not oldLib.hooks.ChatFrame_MessageEventHandler then
		local old_ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler
		function ChatFrame_MessageEventHandler(event)
			if self.hooks.ChatFrame_MessageEventHandler then
				return self.hooks.ChatFrame_MessageEventHandler(self, old_ChatFrame_MessageEventHandler, event)
			else
				return old_ChatFrame_MessageEventHandler(event)
			end
		end
	end
	if not oldLib or not oldLib.hooks or not oldLib.hooks.Logout then
		local old_Logout = Logout
		function Logout()
			if self.hooks.Logout then
				return self.hooks.Logout(self, old_Logout)
			else
				return old_Logout()
			end
		end
	end
	if not oldLib or not oldLib.hooks or not oldLib.hooks.CancelLogout then
		local old_CancelLogout = CancelLogout
		function CancelLogout()
			if self.hooks.CancelLogout then
				return self.hooks.CancelLogout(self, old_CancelLogout)
			else
				return old_CancelLogout()
			end
		end
	end
	if not oldLib or not oldLib.hooks or not oldLib.hooks.Quit then
		local old_Quit = Quit
		function Quit()
			if self.hooks.Quit then
				return self.hooks.Quit(self, old_Quit)
			else
				return old_Quit()
			end
		end
	end
	if not oldLib or not oldLib.hooks or not oldLib.hooks.FCFDropDown_LoadChannels then
		local old_FCFDropDown_LoadChannels = FCFDropDown_LoadChannels
		function FCFDropDown_LoadChannels(...)
			if self.hooks.FCFDropDown_LoadChannels then
				return self.hooks.FCFDropDown_LoadChannels(self, old_FCFDropDown_LoadChannels, ...)
			else
				return old_FCFDropDown_LoadChannels(...)
			end
		end
	end
	if not oldLib or not oldLib.hooks or not oldLib.hooks.JoinChannelByName then
		local old_JoinChannelByName = JoinChannelByName
		function JoinChannelByName(...)
			if self.hooks.JoinChannelByName then
				return self.hooks.JoinChannelByName(self, old_JoinChannelByName, ...)
			else
				return old_JoinChannelByName(...)
			end
		end
	end
	
	self.recvQueue = oldLib and oldLib.recvQueue or {}
	self.registry = oldLib and oldLib.registry or {}
	self.channels = oldLib and oldLib.channels or {}
	self.prefixes = oldLib and oldLib.prefixes or {}
	self.classes = oldLib and oldLib.classes or {}
	self.prefixMemoizations = oldLib and oldLib.prefixMemoizations or {}
	self.prefixHashToText = oldLib and oldLib.prefixHashToText or {}
	self.prefixTextToHash = oldLib and oldLib.prefixTextToHash or {}
	self.userRegistry = oldLib and oldLib.userRegistry or {}
	self.commPrefixes = oldLib and oldLib.commPrefixes or {}
	self.addonVersionPinger = oldLib and oldLib.addonVersionPinger
	AceComm_registry = self.registry
	for k in pairs(self.classes) do
		self.classes[k] = nil
	end
	
	self:activate(oldLib, oldDeactivate)
	
	if oldLib and not oldLib.commPrefixes then
		for t in pairs(self.embedList) do
			if t.commPrefix and not self.commPrefixes[t] then
				self.commPrefixes[t] = t.commPrefix
			end
		end
	end
	
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		AceEvent = instance
		
		AceEvent:embed(AceComm)
		
		self:UnregisterAllEvents()
		self:CancelAllScheduledEvents()
		
		if AceEvent:IsFullyInitialized() then
			self:AceEvent_FullyInitialized()
		else
			self:RegisterEvent("AceEvent_FullyInitialized", "AceEvent_FullyInitialized", true)
		end
		
		self:RegisterEvent("PLAYER_LOGOUT")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
		self:RegisterEvent("CHAT_MSG_SYSTEM")
		self:RegisterEvent("PLAYER_GUILD_UPDATE")
		
		if not self.addonVersionPinger then
			self.addonVersionPinger = {}
			self:embed(self.addonVersionPinger)
			self.addonVersionPinger:SetCommPrefix("Version")
			self.addonVersionPinger.receptors = {}
		else
			self.addonVersionPinger:UnregisterAllComms()
		end
		self.addonVersionPinger.OnCommReceive = {
			PING = function(self, prefix, sender, distribution, addon)
				local version = ""
				if AceLibrary:HasInstance(addon) then
					local revision
					version, revision = AceLibrary(addon):GetLibraryVersion()
					version = version .. "-" .. revision
				else
					local revision
					local _G_addon = _G[addon]
					if not _G_addon then
						_G_addon = _G[addon:match("^[^_]+_(.*)$")]
					end
					if type(_G_addon) == "table" then
						if rawget(_G_addon, "version") then version = _G_addon.version
						elseif rawget(_G_addon, "Version") then version = _G_addon.Version
						elseif rawget(_G_addon, "VERSION") then version = _G_addon.VERSION
						end
						if type(version) == "function" then version = tostring(select(2, pcall(version()))) end
						local revision = nil
						if rawget(_G_addon, "revision") then revision = _G_addon.revision
						elseif rawget(_G_addon, "Revision") then revision = _G_addon.Revision
						elseif rawget(_G_addon, "REVISION") then revision = _G_addon.REVISION
						elseif rawget(_G_addon, "rev") then revision = _G_addon.rev
						elseif rawget(_G_addon, "Rev") then revision = _G_addon.Rev
						elseif rawget(_G_addon, "REV") then revision = _G_addon.REV
						end
						if type(revision) == "function" then revision = tostring(select(2, pcall(revision()))) end

						if version then version = tostring(version) end
						if revision then revision = tostring(revision) end
						if type(revision) == "string" and type(version) == "string" and version:len() > 0 and not version:find(revision) then
							version = version .. "." .. revision
						end

						if not version and revision then version = revision end
					end

					if _G[addon:upper().."_VERSION"] then
						version = _G[addon:upper() .. "_VERSION"]
					end
					if _G[addon:upper().."_REVISION"] or _G[addon:upper().."_REV"] then
						local revision = _G[addon:upper() .. "_REVISION"] or _G[addon:upper().."_REV"]
						if type(revision) == "string" and type(version) == "string" and version:len() > 0 and not version:find(revision) then
							version = version .. "." .. revision
						end
						if (not version or version == "") and revision then version = revision end
					end

					if not version or version == "" then
						version = GetAddOnMetadata(addon, "Version")
					end
					if not version or version == "" then
						version = IsAddOnLoaded(addon) and true or false
					end
				end
				self:SendCommMessage("WHISPER", sender, "PONG", addon, version)
			end,
			PONG = function(self, prefix, sender, distribution, addon, version)
				for obj, method in pairs(self.receptors) do
					if type(obj) == "function" then
						local success, err = pcall(obj, sender, addon, version)
						if not success then
							geterrorhandler()(err)
						end
					else
						local obj_method = obj[method]
						local success, err = pcall(obj_method, obj, sender, addon, version)
						if not success then
							geterrorhandler()(err)
						end
					end
				end
			end
		}
		self.addonVersionPinger:RegisterComm("Version", "WHISPER")
		self.addonVersionPinger:RegisterComm("Version", "GUILD")
		self.addonVersionPinger:RegisterComm("Version", "RAID")
		self.addonVersionPinger:RegisterComm("Version", "PARTY")
		self.addonVersionPinger:RegisterComm("Version", "BATTLEGROUND")
	else
		if AceOO.inherits(instance, AceOO.Class) and not instance.class then
			self.classes[TailoredNumericCheckSum(major)] = instance
		end
	end
end

AceLibrary:Register(AceComm, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)





--
-- ChatThrottleLib by Mikk
--
-- Manages AddOn chat output to keep player from getting kicked off.
--
-- ChatThrottleLib.SendChatMessage/.SendAddonMessage functions that accept 
-- a Priority ("BULK", "NORMAL", "ALERT") as well as prefix for SendChatMessage.
--
-- Priorities get an equal share of available bandwidth when fully loaded.
-- Communication channels are separated on extension+chattype+destination and
-- get round-robinned. (Destination only matters for whispers and channels,
-- obviously)
--
-- Will install hooks for SendChatMessage and SendAdd[Oo]nMessage to measure
-- bandwidth bypassing the library and use less bandwidth itself.
--
--
-- Fully embeddable library. Just copy this file into your addon directory,
-- add it to the .toc, and it's done.
--
-- Can run as a standalone addon also, but, really, just embed it! :-)
--

local CTL_VERSION = 16

if ChatThrottleLib and ChatThrottleLib.version >= CTL_VERSION then
	-- There's already a newer (or same) version loaded. Buh-bye.
	return
end

if not ChatThrottleLib then
	ChatThrottleLib = {}
end

ChatThrottleLib.MAX_CPS = 800			  -- 2000 seems to be safe if NOTHING ELSE is happening. let's call it 800.
ChatThrottleLib.MSG_OVERHEAD = 40		-- Guesstimate overhead for sending a message; source+dest+chattype+protocolstuff

ChatThrottleLib.BURST = 4000				-- WoW's server buffer seems to be about 32KB. 8KB should be safe, but seen disconnects on _some_ servers. Using 4KB now.

ChatThrottleLib.MIN_FPS = 20				-- Reduce output CPS to half (and don't burst) if FPS drops below this value


local ChatThrottleLib = ChatThrottleLib
local setmetatable = setmetatable
local table_remove = table.remove
local tostring = tostring
local GetTime = GetTime
local math_min = math.min
local math_max = math.max

ChatThrottleLib.version = CTL_VERSION


-----------------------------------------------------------------------
-- Double-linked ring implementation

local Ring = {}
local RingMeta = { __index = Ring }

function Ring:New()
	local ret = {}
	setmetatable(ret, RingMeta)
	return ret
end

function Ring:Add(obj)	-- Append at the "far end" of the ring (aka just before the current position)
	if self.pos then
		obj.prev = self.pos.prev
		obj.prev.next = obj
		obj.next = self.pos
		obj.next.prev = obj
	else
		obj.next = obj
		obj.prev = obj
		self.pos = obj
	end
end

function Ring:Remove(obj)
	obj.next.prev = obj.prev
	obj.prev.next = obj.next
	if self.pos == obj then
		self.pos = obj.next
		if self.pos == obj then
			self.pos = nil
		end
	end
end



-----------------------------------------------------------------------
-- Recycling bin for pipes (kept in a linked list because that's 
-- how they're worked with in the rotating rings; just reusing members)

ChatThrottleLib.PipeBin = { count = 0 }

function ChatThrottleLib.PipeBin:Put(pipe)
	for i = #pipe, 1, -1 do
		pipe[i] = nil
	end
	pipe.prev = nil
	pipe.next = self.list
	self.list = pipe
	self.count = self.count + 1
end

function ChatThrottleLib.PipeBin:Get()
	if self.list then
		local ret = self.list
		self.list = ret.next
		ret.next = nil
		self.count = self.count - 1
		return ret
	end
	return {}
end

function ChatThrottleLib.PipeBin:Tidy()
	if self.count < 25 then
		return
	end
	
	local n
	if self.count > 100 then
		n = self.count-90
	else
		n = 10
	end
	for i = 2, n do
		self.list = self.list.next
	end
	local delme = self.list
	self.list = self.list.next
	delme.next = nil
end




-----------------------------------------------------------------------
-- Recycling bin for messages

ChatThrottleLib.MsgBin = {}

function ChatThrottleLib.MsgBin:Put(msg)
	msg.text = nil
	self[#self + 1] = msg
end

function ChatThrottleLib.MsgBin:Get()
	return table_remove(self) or {}
end

function ChatThrottleLib.MsgBin:Tidy()
	if #self < 50 then
		return
	end
	if #self > 150 then	 -- "can't happen" but ...
		for n = #self, 120, -1 do
			self[n] = nil
		end
	else
		for n = #self, #self - 20, -1 do
			self[n] = nil
		end
	end
end


-----------------------------------------------------------------------
-- ChatThrottleLib:Init
-- Initialize queues, set up frame for OnUpdate, etc


function ChatThrottleLib:Init()	
	
	-- Set up queues
	if not self.Prio then
		self.Prio = {}
		self.Prio["ALERT"] = { ByName = {}, Ring = Ring:New(), avail = 0 }
		self.Prio["NORMAL"] = { ByName = {}, Ring = Ring:New(), avail = 0 }
		self.Prio["BULK"] = { ByName = {}, Ring = Ring:New(), avail = 0 }
	end
	
	-- v4: total send counters per priority
	for _, Prio in pairs(self.Prio) do
		Prio.nTotalSent = Prio.nTotalSent or 0
	end
	
	if not self.avail then
		self.avail = 0 -- v5
	end
	if not self.nTotalSent then
		self.nTotalSent = 0 -- v5
	end

	
	-- Set up a frame to get OnUpdate events
	if not self.Frame then
		self.Frame = CreateFrame("Frame")
		self.Frame:Hide()
	end
	self.Frame:SetScript("OnUpdate", self.OnUpdate)
	self.Frame:SetScript("OnEvent", self.OnEvent)	-- v11: Monitor P_E_W so we can throttle hard for a few seconds
	self.Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.OnUpdateDelay = 0
	self.LastAvailUpdate = GetTime()
	self.HardThrottlingBeginTime = GetTime()	-- v11: Throttle hard for a few seconds after startup
	
	-- Hook SendChatMessage and SendAddonMessage so we can measure unpiped traffic and avoid overloads (v7)
	if not self.ORIG_SendChatMessage then
		-- use secure hooks instead of insecure hooks (v16)
		self.securelyHooked = true
		--SendChatMessage
		self.ORIG_SendChatMessage = SendChatMessage
		hooksecurefunc("SendChatMessage", function(...)
			return ChatThrottleLib.Hook_SendChatMessage(...)
		end)
		self.ORIG_SendAddonMessage = SendAddonMessage
		--SendAddonMessage
		hooksecurefunc("SendAddonMessage", function(...)
			return ChatThrottleLib.Hook_SendAddonMessage(...)
		end)
	end
	self.nBypass = 0
end


-----------------------------------------------------------------------
-- ChatThrottleLib.Hook_SendChatMessage / .Hook_SendAddonMessage
function ChatThrottleLib.Hook_SendChatMessage(text, chattype, language, destination, ...)
	local self = ChatThrottleLib
	local size = tostring(text or ""):len() + tostring(chattype or ""):len() + tostring(destination or ""):len() + 40
	self.avail = self.avail - size
	self.nBypass = self.nBypass + size
	if not self.securelyHooked then
		self.ORIG_SendChatMessage(text, chattype, language, destination, ...)
	end
end
function ChatThrottleLib.Hook_SendAddonMessage(prefix, text, chattype, destination, ...)
	local self = ChatThrottleLib
	local size = tostring(text or ""):len() + tostring(chattype or ""):len() + tostring(prefix or ""):len() + tostring(destination or ""):len() + 40
	self.avail = self.avail - size
	self.nBypass = self.nBypass + size
	if not self.securelyHooked then
		self.ORIG_SendAddonMessage(prefix, text, chattype, destination, ...)
	end
end



-----------------------------------------------------------------------
-- ChatThrottleLib:UpdateAvail
-- Update self.avail with how much bandwidth is currently available

function ChatThrottleLib:UpdateAvail()
	local now = GetTime()
	local MAX_CPS = self.MAX_CPS;
	local newavail = MAX_CPS * (now - self.LastAvailUpdate)

	if now - self.HardThrottlingBeginTime < 5 then
		-- First 5 seconds after startup/zoning: VERY hard clamping to avoid irritating the server rate limiter, it seems very cranky then
		self.avail = math_min(self.avail + (newavail*0.1), MAX_CPS*0.5)
	elseif GetFramerate() < self.MIN_FPS then		-- GetFrameRate call takes ~0.002 secs
		newavail = newavail * 0.5
		self.avail = math_min(MAX_CPS, self.avail + newavail)
		self.bChoking = true		-- just for stats
	else
		self.avail = math_min(self.BURST, self.avail + newavail)
		self.bChoking = false
	end
	
	self.avail = math_max(self.avail, 0-(MAX_CPS*2))	-- Can go negative when someone is eating bandwidth past the lib. but we refuse to stay silent for more than 2 seconds; if they can do it, we can.
	self.LastAvailUpdate = now
	
	return self.avail
end


-----------------------------------------------------------------------
-- Despooling logic

function ChatThrottleLib:Despool(Prio)
	local ring = Prio.Ring
	while ring.pos and Prio.avail > ring.pos[1].nSize do
		local msg = table_remove(Prio.Ring.pos, 1)
		if not Prio.Ring.pos[1] then
			local pipe = Prio.Ring.pos
			Prio.Ring:Remove(pipe)
			Prio.ByName[pipe.name] = nil
			self.PipeBin:Put(pipe)
		else
			Prio.Ring.pos = Prio.Ring.pos.next
		end
		Prio.avail = Prio.avail - msg.nSize
		msg.f(unpack(msg, 1, msg.n))
		Prio.nTotalSent = Prio.nTotalSent + msg.nSize
		self.MsgBin:Put(msg)
	end
end


function ChatThrottleLib.OnEvent()
	-- v11: We know that the rate limiter is touchy after login. Assume that it's touch after zoning, too.
	local self = ChatThrottleLib
	if event == "PLAYER_ENTERING_WORLD" then
		self.HardThrottlingBeginTime = GetTime()	-- Throttle hard for a few seconds after zoning
		self.avail = 0
	end
end


function ChatThrottleLib.OnUpdate()
	local self = ChatThrottleLib
	
	self.OnUpdateDelay = self.OnUpdateDelay + arg1
	if self.OnUpdateDelay < 0.08 then
		return
	end
	self.OnUpdateDelay = 0
	
	self:UpdateAvail()
	
	if self.avail < 0  then
		return -- argh. some bastard is spewing stuff past the lib. just bail early to save cpu.
	end

	-- See how many of or priorities have queued messages
	local n = 0
	for prioname,Prio in pairs(self.Prio) do
		if Prio.Ring.pos or Prio.avail < 0 then 
			n = n + 1 
		end
	end
	
	-- Anything queued still?
	if n<1 then
		-- Nope. Move spillover bandwidth to global availability gauge and clear self.bQueueing
		for prioname, Prio in pairs(self.Prio) do
			self.avail = self.avail + Prio.avail
			Prio.avail = 0
		end
		self.bQueueing = false
		self.Frame:Hide()
		return
	end
	
	-- There's stuff queued. Hand out available bandwidth to priorities as needed and despool their queues
	local avail = self.avail/n
	self.avail = 0
	
	for prioname, Prio in pairs(self.Prio) do
		if Prio.Ring.pos or Prio.avail < 0 then
			Prio.avail = Prio.avail + avail
			if Prio.Ring.pos and Prio.avail > Prio.Ring.pos[1].nSize then
				self:Despool(Prio)
			end
		end
	end

	-- Expire recycled tables if needed	
	self.MsgBin:Tidy()
	self.PipeBin:Tidy()
end




-----------------------------------------------------------------------
-- Spooling logic


function ChatThrottleLib:Enqueue(prioname, pipename, msg)
	local Prio = self.Prio[prioname]
	local pipe = Prio.ByName[pipename]
	if not pipe then
		self.Frame:Show()
		pipe = self.PipeBin:Get()
		pipe.name = pipename
		Prio.ByName[pipename] = pipe
		Prio.Ring:Add(pipe)
	end
	
	pipe[#pipe + 1] = msg
	
	self.bQueueing = true
end



function ChatThrottleLib:SendChatMessage(prio, prefix,   text, chattype, language, destination)
	if not self or not prio or not text or not self.Prio[prio] then
		error('Usage: ChatThrottleLib:SendChatMessage("{BULK||NORMAL||ALERT}", "prefix" or nil, "text"[, "chattype"[, "language"[, "destination"]]]', 2)
	end
	
	prefix = prefix or tostring(this)		-- each frame gets its own queue if prefix is not given
	
	local nSize = text:len() + self.MSG_OVERHEAD
	
	-- Check if there's room in the global available bandwidth gauge to send directly
	if not self.bQueueing and nSize < self:UpdateAvail() then
		self.avail = self.avail - nSize
		self.ORIG_SendChatMessage(text, chattype, language, destination)
		self.Prio[prio].nTotalSent = self.Prio[prio].nTotalSent + nSize
		return
	end
	
	-- Message needs to be queued
	local msg = self.MsgBin:Get()
	msg.f = self.ORIG_SendChatMessage
	msg[1] = text
	msg[2] = chattype or "SAY"
	msg[3] = language
	msg[4] = destination
	msg.n = 4
	msg.nSize = nSize

	self:Enqueue(prio, ("%s/%s/%s"):format(prefix, chattype, destination or ""), msg)
end


function ChatThrottleLib:SendAddonMessage(prio, prefix, text, chattype, target)
	if not self or not prio or not prefix or not text or not chattype or not self.Prio[prio] then
		error('Usage: ChatThrottleLib:SendAddonMessage("{BULK||NORMAL||ALERT}", "prefix", "text", "chattype"[, "target"])', 0)
	end
	
	local nSize = prefix:len() + 1 + text:len() + self.MSG_OVERHEAD
	
	-- Check if there's room in the global available bandwidth gauge to send directly
	if not self.bQueueing and nSize < self:UpdateAvail() then
		self.avail = self.avail - nSize
		self.ORIG_SendAddonMessage(prefix, text, chattype, target)
		self.Prio[prio].nTotalSent = self.Prio[prio].nTotalSent + nSize
		return
	end
	
	-- Message needs to be queued
	local msg = self.MsgBin:Get()
	msg.f = self.ORIG_SendAddonMessage
	msg[1] = prefix
	msg[2] = text
	msg[3] = chattype
	msg[4] = target
	msg.n = (target~=nil) and 4 or 3;
	msg.nSize = nSize
	
	self:Enqueue(prio, ("%s/%s/%s"):format(prefix, chattype, target or ""), msg)
end




-----------------------------------------------------------------------
-- Get the ball rolling!

ChatThrottleLib:Init()

--[[ WoWBench debugging snippet
if(WOWB_VER) then
	local function SayTimer()
		print("SAY: "..GetTime().." "..arg1)
	end
	ChatThrottleLib.Frame:SetScript("OnEvent", SayTimer)
	ChatThrottleLib.Frame:RegisterEvent("CHAT_MSG_SAY")
end
]]
