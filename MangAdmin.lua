-------------------------------------------------------------------------------------------------------------
--
-- MangAdmin Version 1.0
--
-- Copyright (C) 2007 Free Software Foundation, Inc.
-- License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
-- This is free software: you are free to change and redistribute it.
-- There is NO WARRANTY, to the extent permitted by law.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--   Official Website    : http://mangadmin.all-mag.de
-- GoogleCode Website    : http://code.google.com/p/mangadmin/
-- Subversion Repository : http://mangadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

local MAJOR_VERSION = "MangAdmin-1.0"
local MINOR_VERSION = "$Revision: 1 $"
local ROOT_PATH     = "Interface\\AddOns\\MangAdmin\\"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local MangAdmin  = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0", "AceDebug-2.0")
local Locale     = AceLibrary("AceLocale-2.2"):new("MangAdmin")
local FrameLib   = AceLibrary("FrameLib-1.0")
local Graph      = AceLibrary("Graph-1.0")

MangAdmin:RegisterDB("MangAdminDb", "MangAdminDbPerChar")
MangAdmin:RegisterDefaults("char", 
  {
    getValueCallHandler = {
      functionOrder = {},
      callingFunctions = {"ToggleGMMode", "ToggleFlyMode", "Testfunction1", "Testfunction2"},
      calledGetGuid = false,
      realGuid = nil
    },
    language = nil
  }
)

-- Register Translations
Locale:EnableDynamicLocales(true)
--Locale:EnableDebugging()
Locale:RegisterTranslations("enUS", function() return Return_enUS() end)
Locale:RegisterTranslations("deDE", function() return Return_deDE() end)
Locale:RegisterTranslations("frFR", function() return Return_frFR() end)
Locale:RegisterTranslations("itIT", function() return Return_itIT() end)
Locale:RegisterTranslations("fiFI", function() return Return_fiFI() end)
Locale:RegisterTranslations("plPL", function() return Return_plPL() end)
Locale:RegisterTranslations("svSV", function() return Return_svSV() end)
Locale:RegisterTranslations("liLI", function() return Return_liLI() end)
Locale:RegisterTranslations("liLI", function() return Return_roRO() end)
--Locale:Debug()
--Locale:SetLocale("enUS")

--===============================================================================================================--
--== Initializing Frames
--== This lua script is like the xml files to create the frames
--===============================================================================================================--

function MangAdmin:CreateFrames()
  -- [[ Main Elements ]]
  FrameLib:BuildFrame({
  	name = "ma_bgframe",
  	group = "bg",
  	parent = UIParent,
  	texture = {
  		color = {0,0,0,0.5}
  	},
  	draggable = true,
  	size = {
  		width = 680,
  		height = 440
  	},
  	setpoint = {
  		pos = "CENTER"
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_menubgframe",
  	group = "bg",
  	parent = ma_bgframe,
  	texture = {
  		color = {0,0,0,0.5}
  	},
  	size = {
  		width = 570,
  		height = 22
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offY = 22,
  		offX = 10
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_topframe",
  	group = "bg",
  	parent = ma_bgframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 675,
  		height = 80
  	},
  	setpoint = {
  		pos = "TOP",
  		offY = -2
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_midframe",
  	group = "bg",
  	parent = ma_bgframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 675,
  		height = 254
  	},
  	setpoint = {
  		pos = "TOP",
  		offY = -83
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_leftframe",
  	group = "bg",
  	parent = ma_bgframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 374,
  		height = 100
  	},
  	setpoint = {
  		pos = "TOP",
  		offX = -150.5,
  		offY = -338
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_rightframe",
  	group = "bg",
  	parent = ma_bgframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 300,
  		height = 100
  	},
  	setpoint = {
  		pos = "TOP",
  		offX = 187.5,
  		offY = -338
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_logoframe",
  	group = "bg",
  	parent = ma_topframe,
  	texture = {
  		file = ROOT_PATH.."Textures\\logo.tga"
  	},
  	size = {
  		width = 512,
  		height = 64
  	},
  	setpoint = {
  		pos = "LEFT",
  		offX = 10
  	},
  	inherits = nil
  })

  FrameLib:BuildFontString({
  	name = "ma_loggedtext",
  	group = "bg",
  	parent = ma_topframe,
  	text = Locale["logged"],
  	setpoint = {
  		pos = "BOTTOMRIGHT",
  		offX = -10,
  		offY = 10
  	}
  })

  FrameLib:BuildFontString({
  	name = "ma_tooltiptext",
  	group = "bg",
  	parent = ma_rightframe,
  	text = Locale["tt_Default"],
  	color = {
  		r = 0,
  		g = 255,
  		b = 0,
  		a = 1.0
  	}
  })

  FrameLib:BuildFrame({
  	name = "ma_languagedropdown",
  	group = "bg",
  	parent = ma_topframe,
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -130,
      offY = -10
  	},
  	inherits = "UIDropDownMenuTemplate"
  })

  FrameLib:BuildButton({
  	name = "ma_languagebutton",
  	group = "bg",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_languagebutton_texture",
  		color = {33,164,210,1.0}
  	},
  	size = {
  		width = 120,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -10,
  		offY = -14
  	},
  	text = Locale["ma_LanguageButton"]
  })
  
  FrameLib:BuildButton({
  	name = "ma_itembutton",
  	group = "bg",
  	parent = ma_leftframe,
  	texture = {
  		name = "ma_itembutton_texture",
  		color = {33,164,210,1.0}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 10,
  		offY = -4
  	},
  	text = Locale["ma_ItemButton"]
  })
  
  FrameLib:BuildButton({
  	name = "ma_spellbutton",
  	group = "bg",
  	parent = ma_leftframe,
  	texture = {
  		name = "ma_spellbutton_texture",
  		color = {33,164,210,1.0}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 94,
  		offY = -4
  	},
  	text = Locale["ma_SpellButton"]
  })

  -- [[Popup Frame]]
  FrameLib:BuildFrame({
  	name = "ma_popupframe",
  	group = "popup",
  	parent = UIParent,
  	texture = {
  		color = {0,0,0,0.5}
  	},
  	draggable = true,
  	size = {
  		width = 440,
  		height = 380
  	},
  	setpoint = {
  		pos = "CENTER"
  	},
    frameStrata = "HIGH",
  	inherits = nil
  })
  
  FrameLib:BuildFrame({
  	name = "ma_popuptopframe",
  	group = "popup",
  	parent = ma_popupframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 435,
  		height = 80
  	},
  	setpoint = {
  		pos = "TOP",
  		offY = -2
  	},
  	inherits = nil
  })

  FrameLib:BuildFrame({
  	name = "ma_popupmidframe",
  	group = "popup",
  	parent = ma_popupframe,
  	texture = {
  		color = {102,102,102,0.7}
  	},
  	size = {
  		width = 435,
  		height = 294
  	},
  	setpoint = {
  		pos = "TOP",
  		offY = -83
  	},
  	inherits = nil
  })
  
  -- [[ Tab Buttons ]]
  FrameLib:BuildButton({
  	name = "ma_mainbutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_mainbutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,1},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 12,
  		offY = 20
  	},
  	text = Locale["tabmenu_Main"]
  })

  FrameLib:BuildButton({
  	name = "ma_charbutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_charbutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,0},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 94,
  		offY = 20
  	},
  	text = Locale["tabmenu_Char"]
  })

  FrameLib:BuildButton({
  	name = "ma_telebutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_telebutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,0},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 100,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 176,
  		offY = 20
  	},
  	text = Locale["tabmenu_Tele"]
  })

  FrameLib:BuildButton({
  	name = "ma_ticketbutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_ticketbutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,0},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 130,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 278,
  		offY = 20
  	},
  	text = Locale["tabmenu_Ticket"]
  })

  FrameLib:BuildButton({
  	name = "ma_serverbutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_serverbutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,0},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 410,
  		offY = 20
  	},
  	text = Locale["tabmenu_Server"]
  })

  FrameLib:BuildButton({
  	name = "ma_logbutton",
  	group = "tabbuttons",
  	parent = ma_topframe,
  	texture = {
  		name = "ma_logbutton_texture",
  		color = {102,102,102,0.7},
  		gradient = {
  			orientation = "vertical",
  			min = {102,102,102,0},
  			max = {102,102,102,0.7}
  		}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 492,
  		offY = 20
  	},
  	text = Locale["tabmenu_Log"]
  })

  -- [[ Group Elements ]]
  -- MAIN
  FrameLib:BuildButton({
  	name = "ma_togglegmbutton",
  	group = "main",
  	parent = ma_midframe,
  	texture = {
  		name = "ma_togglegmbutton_texture",
  		color = {33,164,210,1.0}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -10,
  		offY = -4
  	},
  	text = Locale["ma_ToggleGMButton"]
  })

  FrameLib:BuildButton({
  	name = "ma_toggleflybutton",
  	group = "main",
  	parent = ma_midframe,
  	texture = {
  		name = "ma_toggleflybutton_texture",
  		color = {33,164,210,1.0}
  	},
  	size = {
  		width = 80,
  		height = 20
  	},
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -10,
  		offY = -28
  	},
  	text = Locale["ma_ToggleFlyButton"]
  })
    
  FrameLib:BuildFrame({
    type = "Slider",
    name = "ma_speedslider",
  	group = "main",
  	parent = ma_midframe,
    size = {
      width = 80
    },
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -10,
      offY = -62
  	},
  	inherits = "OptionsSliderTemplate"
  })
    
  -- LOG
  FrameLib:BuildFrame({
  	type = "ScrollingMessageFrame",
  	name = "ma_logframe",
  	group = "log",
  	parent = ma_midframe,
  	texture = {
  		color = {10,10,10,0.7},
  		gradient = {
  			orientation = "horizontal",
  			min = {10,10,10,0.7},
  			max = {10,10,10,0}
  		}
  	},
  	size = {
  		width = 400,
  		height = 234
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 10,
  		offY = -10
  	},
  	justify = {
  		h = "LEFT",
  		v = "TOP"
  	},
  	fading = false,
  	scrollMouseWheel = true
  })

  FrameLib:BuildButton({
  	name = "ma_logscrollupbutton",
  	group = "log",
  	parent = ma_midframe,
  	setpoint = {
  		pos = "TOPRIGHT",
  		offX = -10,
  		offY = -10
  	},
  	inherits = "UIPanelScrollUpButtonTemplate",
  	script = function() ma_logframe:ScrollUp() end
  })

  FrameLib:BuildButton({
  	name = "ma_logscrolldownbutton",
  	group = "log",
  	parent = ma_midframe,
  	setpoint = {
  		pos = "BOTTOMRIGHT",
  		offX = -10,
  		offY = 10
  	},
  	inherits = "UIPanelScrollDownButtonTemplate",
  	script = function() ma_logframe:ScrollDown() end
  })

  --SERVER
  FrameLib:BuildFrame({
  	name = "ma_graphframe",
  	group = "server",
  	parent = ma_midframe,
  	texture = {
  		color = {0,0,0,0.7}
  	},
  	size = {
  		width = 152,
  		height = 152
  	},
  	setpoint = {
  		pos = "TOPLEFT",
  		offX = 10,
  		offY = -10
  	},
  	inherits = nil
  })

  local down, up, lag = GetNetStats();
  g=Graph:CreateGraphRealtime("ma_netstatframe",ma_graphframe,"CENTER","CENTER",0,0,150,150)
  f = CreateFrame("Frame",name,ma_netstatframe)
  f:SetScript("OnUpdate",function() g:AddTimeData(1) end)
  f:Show()

  --FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  --FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  
end

--===============================================================================================================--
--== MangAdmin Frame Generation End
--== MangAdmin Official Start
--===============================================================================================================--



function MangAdmin:OnInitialize()
  -- initializing MangAdmin
  self:SetLanguage()
  self:CreateFrames()
  self:RegisterChatCommand(Locale["slashcmds"], opts) -- this registers the chat commands
	self:PrepareButtons() -- this prepares the actions and tooltips of nearly all MangAdmin buttons  
  -- FuBar plugin config
	self.hasNoColor = true
	self.hasNoText = false
	self.clickableTooltip = true
	self.hasIcon = true
	self.hideWithoutStandby = true
	self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  -- make MangAdmin frames closable with escape key
  tinsert(UISpecialFrames,"ma_bgframe")
  tinsert(UISpecialFrames,"ma_popupframe")
	-- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to MangAdmin:AddMessage(...)
	for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
  -- initializing Frames, like DropDowns, Sliders, aso
  self:LangDropDownInit()
  self:SpeedSliderInit()
end

function MangAdmin:OnEnable()
  self:SetDebugging(true) -- to have debugging through the whole app.    
  -- init guid for callhandler, not implemented yet, comes in next revision
  self.GetGuid()
end

function MangAdmin:OnDisable()
  -- called when the addon is disabled
  -- so far nothing to do here
end

function MangAdmin:OnClick()
  -- this toggles the MangAdmin frame when clicking on the mini icon
	if ma_bgframe:IsVisible() or ma_popupframe:IsVisible() then 
		FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
    FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
	else
		FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
	end
end

function MangAdmin:PrepareButtons()
  --here the function of all buttons are defined
	local function preScript(object, text, script)
    if text then
  		object:SetScript("OnEnter", function() ma_tooltiptext:SetText(text) end)
  		object:SetScript("OnLeave", function() ma_tooltiptext:SetText(Locale["tt_Default"]) end)
    end
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
  --Language changing
  preScript(ma_languagebutton, Locale["tt_LanguageButton"], function() MangAdmin:ChangeLanguage(UIDropDownMenu_GetSelectedValue(ma_languagedropdown)) end)
  --Speed Slider
  preScript(ma_speedslider, Locale["tt_SpeedSlider"], {{"OnMouseUp", function() MangAdmin:SetSpeed() end},{"OnValueChanged", function() ma_speedsliderText:SetText(string.format("%.1f", ma_speedslider:GetValue())) end}})
  --buttons
  preScript(ma_itembutton, Locale["tt_ItemButton"], function() MangAdmin:TogglePopup() end)
  preScript(ma_spellbutton, Locale["tt_SpellButton"], function() MangAdmin:TogglePopup() end)
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

function MangAdmin:TogglePopup()
  -- this toggles the MangAdmin Popup frame
	if ma_popupframe:IsVisible() then 
		FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
	else
		FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
	end
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
    else
      -- not a registered field case, so put normal values out
      return true
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
    --check for function with more high priority before key
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
  local called = MangAdmin.db.char.getValueCallHandler.calledGetGuid
  local realGuid = MangAdmin.db.char.getValueCallHandler.realGuid
  if not called then
    if MangAdmin:Selection("self") or MangAdmin:Selection("none") then
      MangAdmin:ChatMsg(".getvalue 0")
    end
  else
    ma_loggedtext:SetText(Locale["logged"]..Locale["charguid"]..realGuid)
  end
end

function MangAdmin:Selection(selection)
  if selection == "player" then
    if UnitIsPlayer("target") then
      return true
    end
  elseif selection == "self" then
    if UnitIsUnit("target", "player") then
      return true
    end
  elseif selection == "none" then
    if not UnitName("target") then
      return true
    end
  else
    error("Argument 'selection' can be 'player',''self', or 'none'!")
    return false
  end
end

function MangAdmin:AndBit(value, test) 
	return mod(value, test*2) >= test 
end

--[[USABILITY FUNCTIONS - MANGADMIN MAIN PART]]
function MangAdmin:SetLanguage()
  if self.db.char.language then
    Locale:SetLocale(self.db.char.language)
  else
    self.db.char.language = Locale:GetLocale()
  end
end

function MangAdmin:ChangeLanguage(locale)
  self.db.char.language = locale
  ReloadUI()
end

function MangAdmin:ToggleGMMode(value)
  if not value then
    if MangAdmin:Selection("self") or MangAdmin:Selection("none") then
      MangAdmin:InsertFunctionOrder("ToggleGMMode")
      MangAdmin:ChatMsg(".getvalue 228") -- 228 = PLAYER_FLAGS (8 = GMMODE)
      return true
    else
      self:Print("Please select nothing or yourself!")
    end
  else
    local status
    if MangAdmin:AndBit(value, 8) then status = "off" else status = "on" end
    MangAdmin:ChatMsg(".gm"..status)
    MangAdmin:LogAction("Turned GM-mode to "..status..".")
    return false
  end
end

function MangAdmin:ToggleFlyMode(value)
  -- function DEFECT, have to find getvalue of PLAYER_MOVEMENT_FLAGS
  self:Print("Sorry, this function is defect and not available yet!")
  return true
  -- function DEFECT stop
  --[[if not value then
    if MangAdmin:SelectionCheck() then
      MangAdmin:InsertFunctionOrder("ToggleFlyMode")
      MangAdmin:ChatMsg(".getvalue ??") -- ??? = PLAYER_MOVEMENT_FLAGS (? = MOVEMENTFLAG_CAN_FLY)
      return true
    end
  else
    local status
    if MangAdmin:AndBit(value, 8388608) then status = "off" else status = "on" end
    MangAdmin:ChatMsg(".flymode "..status)
    MangAdmin:LogAction("Turned Fly-mode to "..status..".")
    return false
  end]]
end

function MangAdmin:SetSpeed()
  local value = string.format("%.1f", ma_speedslider:GetValue())
  local player = "todo"
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    self:ChatMsg(".modify speed "..value)
    self:LogAction("Set speed of "..player.." to "..value..".")
  else
    self:Print("Please select nothing, yourself or another player!")
  end
end

--[[FRAME INIT FUNCTIONS]]
function MangAdmin:LangDropDownInit()
  local function LangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {{"English","enUS"},{"German","deDE"},{"French","frFR"},{"Italian","itIT"},{"Finnish","fiFI"},{"Polish","plPL"},{"Swedish","svSV"},{"Lithuania","liLI"},{"Romania","roRO"}}  
    for k,v in ipairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_languagedropdown, this.value) end
      if v[2] == Locale:GetLocale() then
        info.checked = true
      else
        info.checked = nil
      end
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
  end  
  UIDropDownMenu_Initialize(ma_languagedropdown, LangDropDownInitialize)
	UIDropDownMenu_SetWidth(100, ma_languagedropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_languagedropdown)
end

function MangAdmin:SpeedSliderInit()
  ma_speedslider:SetOrientation("HORIZONTAL")
  ma_speedslider:SetMinMaxValues(1, 10)
  ma_speedslider:SetValueStep(0.1)
  ma_speedslider:SetValue(1)
	ma_speedsliderText:SetText("1.0")
end




