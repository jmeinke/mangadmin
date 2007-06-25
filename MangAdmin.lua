--[[
Name: MangAdmin-1.0
Revision: $Rev: 1 $
Author(s): josh (josh@all-mag.de)
Dependencies: AceLibrary
License: GNU 2.0
]]

local MAJOR_VERSION = "MangAdmin-1.0"
local MINOR_VERSION = "$Revision: 1 $"
local ROOT_PATH     = "Interface\\AddOns\\MangAdmin\\"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local MangAdmin  = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0")
local Locale     = AceLibrary("AceLocale-2.2"):new("MangAdmin")      
local FrameLib   = AceLibrary("FrameLib-1.0")

Locale:EnableDynamicLocales(true)

MangAdmin:RegisterChatCommand(Locale["slashcmds"], opts)
MangAdmin:RegisterDB("MangAdminDb", "MangAdminDbPerChar")

MangAdmin:RegisterDefaults("char", 
  {
    getValueCallHandler = {
      functionOrder = {},
      callingFunctions = {"ToggleGMMode", "Testmode1", "Testmode2"},
      calledGetGuid = false,
      realGuid = nil
    }  
  }
)

function MangAdmin:OnInitialize()
	-- initializing MangAdmin
	self:PrepareButtons() -- this prepares the actions and tooltips of nearly all MangAdmin buttons  
  -- FuBar plugin config
	self.hasNoColor = true
	self.hasNoText = false
	self.clickableTooltip = true
	self.hasIcon = true
	self.hideWithoutStandby = true
	self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  -- make MangAdmin closable with escape key
  tinsert(UISpecialFrames,"ma_bgframe")
	-- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to MangAdmin:AddMessage(...)
	for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
end

function MangAdmin:OnEnable()
  -- init guid for callhandler
  self.GetGuid()
end

function MangAdmin:OnDisable()
  -- called when the addon is disabled
  -- so far nothing to do here
end

function MangAdmin:OnClick()
  -- this toggles the MangAdmin frame when clicking on the mini icon
	if ma_bgframe:IsVisible() then 
		FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
	else
		FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
	end
end

function MangAdmin:PrepareButtons()
  --here the function of all buttons are defined
	local function preScript(object, text, script)
		object:SetScript("OnEnter", function() ma_tooltiptext:SetText(text) end)
		object:SetScript("OnLeave", function() ma_tooltiptext:SetText(Locale["tt_Default"]) end)
		if type(script) == "function" then
  		object:SetScript("OnClick", script)
  	elseif type(script) == "table" then
  		for k,v in pairs(script) do
  			object:SetScript(unpack(v))
  		end
    end
	end
  --[[tab buttons]]
	preScript(ma_mainbutton, Locale["tt_MainButton"], function() MangAdmin:ToggleTabButton("ma_mainbutton"); MangAdmin:ToggleContentGroup("main") end)
	--preScript(ma_charbutton, Locale["tt_CharButton"], function() MangAdmin:ToggleTabButton("ma_charbutton"); MangAdmin:ToggleContentGroup("char") end)
	--preScript(ma_telebutton, Locale["tt_TeleButton"], function() MangAdmin:ToggleTabButton("ma_telebutton"); MangAdmin:ToggleContentGroup("tele") end)
	--preScript(ma_ticketbutton, Locale["tt_TicketButton"], function() MangAdmin:ToggleTabButton("ma_ticketbutton"); MangAdmin:ToggleContentGroup("ticket") end)
	preScript(ma_serverbutton, Locale["tt_ServerButton"], function() MangAdmin:ToggleTabButton("ma_serverbutton"); MangAdmin:ToggleContentGroup("server") end)
	preScript(ma_logbutton, Locale["tt_LogButton"], function() MangAdmin:ToggleTabButton("ma_logbutton"); MangAdmin:ToggleContentGroup("log") end)
  --[[Language dropdown]]
  --preScript(ma_logbutton, Locale["tt_LanguageDropdown"], {{"OnLoad", MangAdmin:LangDropDownOnLoad()},{"OnClick", MangAdmin:LangDropDownOnClick()}})
  --[[other buttons]]
  preScript(ma_togglegmbutton, Locale["tt_ToggleGMButton"], function() MangAdmin:ToggleGMMode() end)
  preScript(ma_toggleflybutton, Locale["tt_ToggleFlyButton"], function() MangAdmin:ToggleFlyMode() end)  
end

function MangAdmin:ToggleTabButton(btn)
  --this modifies the look of tab buttons when clocked on them 
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
	MangAdmin:LogAction("Toggled navigation point '"..group.."'.")
  MangAdmin:HideAllGroups()
	FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function MangAdmin:HideAllGroups()
  FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
	--FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
	FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
	FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
end

function MangAdmin:AddMessage(frame, text, r, g, b, id)
	-- frame is the object that was hooked (one of the ChatFrames)  
  local catchedSth = false
  
  -- hooking all uint32 .getvalue requests
  for guid, field, value in string.gmatch(text, "The uint32 value of (%w+) in (%w+) is: (%w+)") do
    catchedSth = true
    output = MangAdmin:GetValueCallHandler(guid, field, value)
  end
  
  if not catchedSth then
    -- output
    self.hooks[frame].AddMessage(frame, text, r, g, b, id)
  else
    if output == false then
      -- so far nothing to do here
      -- don't output anything
    elseif output == true then
      self.hooks[frame].AddMessage(frame, text, r, g, b, id)
    else
      -- output
      self.hooks[frame].AddMessage(frame, output, r, g, b, id)
    end
  end
end

function MangAdmin:GetValueCallHandler(guid, field, value)
  -- checks for specific actions and calls functions by checking the function-order
  local called = self.db.char.getValueCallHandler.calledGetGuid
  local realGuid = self.db.char.getValueCallHandler.realGuid
  -- case checking
  if guid == value and field == "0" and not called then
    -- getting GUID and setting db variables and logged text
    self.db.char.getValueCallHandler.calledGetGuid = true
    self.db.char.getValueCallHandler.realGuid = value
    ma_loggedtext:SetText(Locale["logged"]..Locale["charguid"]..guid)
    return false    
  elseif guid == realGuid then
    if field == "228" then
      -- 228 = PLAYER_FLAGS
      if MangAdmin:ProcessFunctionOrder("ToggleGMMode") then
        -- Toggling Gamemaster mode
        return MangAdmin:ToggleGMMode(value)
      else
        -- not found in function order list, so put normal values out
        return true
      end
    end
  else
    MangAdmin:LogAction("DEBUG: Getvalues are: GUID = "..guid.."; field = "..field.."; value = "..value..";")
    return true
  end
end

function MangAdmin:InsertFunctionOrder(fname)
  -- insert the getvalue function ordering
  table.insert(self.db.char.getValueCallHandler.functionOrder, fname)
end

function MangAdmin:ProcessFunctionOrder(fname)
  -- check the order of the getvalue using functions by parsing the table twice
  local key = nil
  for k,v in pairs(self.db.char.getValueCallHandler.functionOrder) do
    if v == fname then
      key = k
      break
    end
  end
  
  if not key then    
    return false
  else
    --check for function with more high proirity before key
    --[[for k,v in pairs(self.db.char.getValueCallHandler.functionOrder) do
      if k = key then break end
    end]]
    table.remove(self.db.char.getValueCallHandler.functionOrder, key)
    return true
  end
end

function MangAdmin:LogAction(msg)
	ma_logframe:AddMessage("|cFF00FF00["..date("%H:%M:%S").."]|r "..msg, 1.0, 1.0, 0.0)
end

function MangAdmin:ChatMsg(msg)
  if not type then local type = "say" end
  SendChatMessage(msg, type, nil, nil)
end

function MangAdmin:GetGuid()
  MangAdmin:ChatMsg(".getvalue 0")
end

function MangAdmin:SelectionCheck()
  if UnitIsUnit("target", "player") then
    return true
  elseif not UnitName("target") then 
      return true
  else
      self:Print("You have to select yourself or nothing first!")
      return false
  end
end

--[[USABILITY FUNCTIONS - MANGADMIN MAIN PART]]
function MangAdmin:ToggleGMMode(value)
  if not value then
    if MangAdmin:SelectionCheck() then
      MangAdmin:InsertFunctionOrder("ToggleGMMode")
      MangAdmin:ChatMsg(".getvalue 228") -- 228 = PLAYER_FLAGS (8 = GMMODE)
      return true
    end
  else
    local status
    if value == "8" or value == "40" then status = "off" else status = "on" end
    MangAdmin:ChatMsg(".gm"..status)
    MangAdmin:LogAction("Turned GM-mode to "..status..".")
    return false
  end
end

function MangAdmin:ToggleFlyMode()
  local status = "on"
  if IsFlying() then
    status = "off"
  end
  MangAdmin:ChatMsg(".flymode "..status)
  MangAdmin:LogAction("Turned Fly-mode to "..status..".")
end

--[[DROPDOWN FUNCTIONS]]
--[[function MangAdmin:LangDropDownOnLoad()
  UIDropDownMenu_Initialize(this, LangDropDownInitialize)
	UIDropDownMenu_SetSelectedID(this, 1)
	UIDropDownMenu_SetWidth(90, ma_languagedropdown)
end

function LangDropDownInitialize()
  --local selectedValue = UIDropDownMenu_GetSelectedValue(ma_languagedropdown)
	local option
  
  for optval in Locale:IterateAvailableLocales() do
    --MangAdmin:LogAction("DEBUG: "..optval)
    option = {}
  	option.text = optval
  	option.func = MangAdmin:LangDropDownOnClick()
  	option.value = optval
  	if ( option.value == selectedValue ) then
  		option.checked = optval
  	end
  	UIDropDownMenu_AddButton(option)
  end	
  local selectedValue = UIDropDownMenu_GetSelectedValue(ma_languagedropdown);
	local info;

	info = {};
	info.text = "Hello Button";
	info.func = HelloDropDownMenu_OnClick;
	info.value = 1;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end

function MangAdmin:LangDropDownOnClick()
  UIDropDownMenu_SetSelectedValue(ma_languagedropdown, this.value)
  --MangAdmin:ChatMsg(this.value)
end
]]



