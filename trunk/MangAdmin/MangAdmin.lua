--[[
Name: MangAdmin-1.0
Revision: $Rev: 1 $
Author(s): josh (josh@all-mag.de)
Dependencies: AceLibrary
License: LGPL v2.1
]]

local MAJOR_VERSION = "MangAdmin-1.0"
local MINOR_VERSION = "$Revision: 1 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local Locale     = AceLibrary("AceLocale-2.2"):new("MangAdmin")
local MangAdmin  = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0")
local FrameLib   = AceLibrary("FrameLib-1.0")

MangAdmin:RegisterChatCommand(Locale["slashcmds"], opts)
MangAdmin:RegisterDB("MangAdminDatabase", "MangAdminDatabasePerChar")

function MangAdmin:OnInitialize()
	-- prepare buttons and tooltips
	self:PrepareButtons()
	-- setIcon(path) and Tooltip
	self.hasNoColor = true
	self.hasNoText = false
	self.clickableTooltip = true
	self.hasIcon = true
	self.hideWithoutStandby = true
	self:SetIcon("Interface\\AddOns\\MangAdmin\\Textures\\icon.tga")
	-- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to MangAdmin:AddMessage(...)
	for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
end

function MangAdmin:OnEnable()
	self:UpdateText()
end

function MangAdmin:OnTextUpdate()
  self:SetText("You have 1223 new ticket requests!")
end

function MangAdmin:OnClick()
	if ma_bgframe:IsVisible() then 
		-- StopMusic()
		FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
	else
		-- PlayMusic("Interface\\AddOns\\MangAdmin\\Sounds\\about.mp3")
		FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
	end
end

function MangAdmin:OnDisable()
  -- Called when the addon is disabled
end

function MangAdmin:AddMessage(frame, text, r, g, b, id)
	-- frame is the object that was hooked (one of the ChatFrames)
	-- text, r, g, b, id are the other arguments provided to it.
	-- local h,m = GetGameTime()
	-- self.hooks[frame].AddMessage(frame, string.format("[%02d:%02d] %s", h, m, text), r, g, b, id)
	-- self.hooks[object][method] holds the original method.
	-- This should be called every time you deal with hooking, unless you use a secure hook.
	-- be sure to provide all the arguments provided to you as well.
	-- In this case, we pass back the method with modified arguments (adding a timestamp).
	-- Note that if the original AddMessage would be required to return a value you need to do:
	-- return self.hooks[frame].AddMessage(frame, string.format("[%02d:%02d] %s", h, m, text), r, g, b, id)
	self.hooks[frame].AddMessage(frame, text, r, g, b, id)
end

function MangAdmin:PrepareButtons()
	local function preScript(object, text, onclick)
		object:SetScript("OnEnter", function() ma_tooltiptext:SetText(text) end)
		object:SetScript("OnLeave", function() ma_tooltiptext:SetText(Locale["tt_Default"]) end)
		if onclick then
			object:SetScript("OnClick", onclick)
		end
	end
	preScript(ma_mainbutton, Locale["tt_MainButton"], function() MangAdmin:ToggleTabButton("ma_mainbutton"); MangAdmin:ToggleContentGroup("main") end)
	preScript(ma_charbutton, Locale["tt_CharButton"], function() MangAdmin:ToggleTabButton("ma_charbutton"); MangAdmin:ToggleContentGroup("char") end)
	preScript(ma_telebutton, Locale["tt_TeleButton"], function() MangAdmin:ToggleTabButton("ma_telebutton"); MangAdmin:ToggleContentGroup("tele") end)
	preScript(ma_ticketbutton, Locale["tt_TicketButton"], function() MangAdmin:ToggleTabButton("ma_ticketbutton"); MangAdmin:ToggleContentGroup("ticket") end)
	preScript(ma_serverbutton, Locale["tt_ServerButton"], function() MangAdmin:ToggleTabButton("ma_serverbutton"); MangAdmin:ToggleContentGroup("server") end)
	preScript(ma_logbutton, Locale["tt_LogButton"], function() MangAdmin:ToggleTabButton("ma_logbutton"); MangAdmin:ToggleContentGroup("log") end)
end

function MangAdmin:ToggleTabButton(btn)
	FrameLib:HandleGroup("tabbuttons", 
	function(button) 
		if button:GetName() == btn then
			getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
		else
			getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
		end
	end)
end

function MangAdmin:ToggleContentGroup(group)
	self:LogAction("Toggled navigation point '"..group.."'")
	--FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
	FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
	FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
	FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function MangAdmin:LogAction(msg)
	local down, up, lag = GetNetStats();
	ma_logframe:AddMessage("|cFF00FF00["..date("%H:%M:%S").."]|r "..msg, 1.0, 1.0, 0.0)
end


