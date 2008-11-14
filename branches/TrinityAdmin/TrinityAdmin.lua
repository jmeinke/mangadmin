-------------------------------------------------------------------------------------------------------------
--
-- TrinityAdmin Version 1.0
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
-- Official Forums: http://www.Trinityround.org/forum/
-- GoogleCode Website: http://code.google.com/p/Trinityadmin/
-- Subversion Repository: http://Trinityadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

local MAJOR_VERSION = "TrinityAdmin-1.0"
local MINOR_VERSION = "$Revision: 114 $"
ROOT_PATH     = "Interface\\AddOns\\TrinityAdmin\\"
local cont = ""
if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

TrinityAdmin    = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0", "AceDebug-2.0", "AceEvent-2.0")
Locale       = AceLibrary("AceLocale-2.2"):new("TrinityAdmin")
Strings      = AceLibrary("AceLocale-2.2"):new("TEST")
FrameLib     = AceLibrary("FrameLib-1.0")
Graph        = AceLibrary("Graph-1.0")
local Tablet = AceLibrary("Tablet-2.0")

TrinityAdmin:RegisterDB("TrinityAdminDb", "TrinityAdminDbPerChar")
TrinityAdmin:RegisterDefaults("char", 
  {
    --[[getValueCallHandler = {
      calledGetGuid = false,
      realGuid = nil
    },]]
    functionQueue = {},
    requests = {
      tpinfo = false,
      ticket = false,
      ticketbody = 0,
      item = false,
      favitem = false,
      itemset = false,
      spell = false,
      skill = false,
      quest = false,
      creature = false,
      object = false,
      tele = false,
      toggle = false
    },
    nextGridWay = "ahead",
    selectedZone = nil,
    newTicketQueue = {},
    instantKillMode = false,
    msgDeltaTime = time(),
    
  }
)
TrinityAdmin:RegisterDefaults("account", 
  {
    language = nil,
    localesearchstring = true,
    favorites = {
      items = {},
      itemsets = {},
      spells = {},
      skills = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {}
    },
    buffer = {
      tickets = {},
      items = {},
      itemsets = {},
      spells = {},
      skills = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {},
      counter = 0
    },
    tickets = {
      selected = 0,
      count = 0,
      requested = 0,
      playerinfo = {},
      loading = false
    },
    style = {
      showtooltips = true,
      showminimenu = true,
      transparency = {
        buttons = 1.0,
        frames = 0.7,
        backgrounds = 0.5
      },
      color = {
        buffer = {},
        buttons = {
          r = 33, 
          g = 164, 
          b = 210
        },
        frames = {
          r = 102,
          g = 102,
          b = 102
        },
        backgrounds = {
          r = 0,
          g = 0,
          b = 0
        },
        linkifier = {
          r = 0.8705882352941177,
          g = 0.3725490196078432,
          b = 0.1411764705882353
        }
      }
    }
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
Locale:RegisterTranslations("roRO", function() return Return_roRO() end)
Locale:RegisterTranslations("csCZ", function() return Return_csCZ() end)
Locale:RegisterTranslations("huHU", function() return Return_huHU() end)
Locale:RegisterTranslations("esES", function() return Return_esES() end)
Locale:RegisterTranslations("zhCN", function() return Return_zhCN() end)
Locale:RegisterTranslations("ptPT", function() return Return_ptPT() end)
Locale:RegisterTranslations("ruRU", function() return Return_ruRU() end)
Locale:RegisterTranslations("nlNL", function() return Return_nlNL() end)
-- Register String Traslations
Strings:EnableDynamicLocales(true)
Strings:RegisterTranslations("enUS", function() return ReturnStrings_enUS() end)
Strings:RegisterTranslations("deDE", function() return ReturnStrings_deDE() end)
Strings:RegisterTranslations("frFR", function() return ReturnStrings_frFR() end)
Strings:RegisterTranslations("itIT", function() return ReturnStrings_itIT() end)
Strings:RegisterTranslations("fiFI", function() return ReturnStrings_fiFI() end)
Strings:RegisterTranslations("plPL", function() return ReturnStrings_plPL() end)
Strings:RegisterTranslations("svSV", function() return ReturnStrings_svSV() end)
Strings:RegisterTranslations("liLI", function() return ReturnStrings_liLI() end)
Strings:RegisterTranslations("roRO", function() return ReturnStrings_roRO() end)
Strings:RegisterTranslations("csCZ", function() return ReturnStrings_csCZ() end)
Strings:RegisterTranslations("huHU", function() return ReturnStrings_huHU() end)
Strings:RegisterTranslations("esES", function() return ReturnStrings_esES() end)
Strings:RegisterTranslations("zhCN", function() return ReturnStrings_zhCN() end)
Strings:RegisterTranslations("ptPT", function() return ReturnStrings_ptPT() end)
Strings:RegisterTranslations("ruRU", function() return ReturnStrings_ruRU() end)
Strings:RegisterTranslations("nlNL", function() return ReturnStrings_nlNL() end)
--Locale:Debug()
--Locale:SetLocale("enUS")

TrinityAdmin.consoleOpts = {
  type = 'group',
  args = {
    toggle = {
      name = "toggle",
      desc = Locale["cmd_toggle"],
      type = 'execute',
      func = function() TrinityAdmin:OnClick() end
    },
    transparency = {
      name = "transparency",
      desc = Locale["cmd_transparency"],
      type = 'execute',
      func = function() TrinityAdmin:ToggleTransparency() end
    },
    tooltips = {
      name = "tooltips",
      desc = Locale["cmd_tooltip"],
      type = 'execute',
      func = function() TrinityAdmin:ToggleTooltips() end
    },
    minimenu = {
      name = "tooltips",
      desc = "Toogle the toolbar/minimenu",
      type = 'execute',
      func = function() TrinityAdmin:ToggleMinimenu() end
    }
  }
}

function TrinityAdmin:OnInitialize()
  -- initializing TrinityAdmin
  self:SetLanguage()
  self:CreateFrames()
  self:RegisterChatCommand(Locale["slashcmds"], self.consoleOpts) -- this registers the chat commands
  self:InitButtons() -- this prepares the actions and tooltips of nearly all TrinityAdmin buttons  
  self:SearchReset()
  -- FuBar plugin config
  TrinityAdmin.hasNoColor = true
  TrinityAdmin.hasNoText = false
  TrinityAdmin.clickableTooltip = true
  TrinityAdmin.hasIcon = true
  TrinityAdmin.hideWithoutStandby = true
  TrinityAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  -- make TrinityAdmin frames closable with escape key
  tinsert(UISpecialFrames,"ma_bgframe")
  tinsert(UISpecialFrames,"ma_popupframe")
  -- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to TrinityAdmin:AddMessage(...)
  for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
  -- initializing Frames, like DropDowns, Sliders, aso
  self:InitDropDowns()
  self:InitSliders()
  self:InitScrollFrames()
  self:InitCheckButtons()
  self:InitModelFrame()
  --clear color buffer
  self.db.account.style.color.buffer = {}
  --altering the function setitemref, to make it possible to click links
  TrinityLinkifier_SetItemRef_Original = SetItemRef
  SetItemRef = TrinityLinkifier_SetItemRef
  self.db.char.msgDeltaTime = time()
  -- hide minimenu if not enabled
  if not self.db.account.style.showminimenu then
    FrameLib:HandleGroup("minimenu", function(frame) frame:Hide() end)
  end
end

function TrinityAdmin:OnEnable()
  self:SetDebugging(true) -- to have debugging through the whole app
  ma_toptext:SetText(Locale["char"].." "..Locale["guid"]..tonumber(UnitGUID("player"),16))
  ma_top2text:SetText(Locale["realm"].." "..Locale["tickets"].."0")
  self:SearchReset()
  -- refresh server information
  self:ChatMsg(".server info")
  -- register events
  --self:RegisterEvent("ZONE_CHANGED") -- for teleport list update
  self:RegisterEvent("PLAYER_TARGET_CHANGED")
  self:RegisterEvent("UNIT_MODEL_CHANGED")
  self:RegisterEvent("PLAYER_DEAD")
  self:RegisterEvent("PLAYER_ALIVE")
  self:PLAYER_TARGET_CHANGED() --init
end

--events
function TrinityAdmin:PLAYER_DEAD()
  ma_mm_revivebutton:Show()
end

function TrinityAdmin:PLAYER_ALIVE()
  ma_mm_revivebutton:Hide()
end

function TrinityAdmin:ZONE_CHANGED()
  --[[if hastranslationlocale then
    if not TrinityAdmin.db.char.selectedZone or TrinityAdmin.db.char.selectedZone ~= translate(GetZoneText()) then
      if translationfor(GetZoneText()) then
        TrinityAdmin.db.char.selectedZone = translate(GetZoneText())
        InlineScrollUpdate()
      end
    end
  end]]
end

function TrinityAdmin:UNIT_MODEL_CHANGED()
  self:ModelChanged()
end

function TrinityAdmin:PLAYER_TARGET_CHANGED()
  self:ModelChanged()
  self:NpcModelChanged()
  if UnitIsPlayer("target") then
    ma_savebutton:Enable()
    if UnitIsDead("target") then
      ma_revivebutton:Enable()
      ma_killbutton:Disable()
    else
      ma_revivebutton:Disable()
      ma_killbutton:Enable()
    end
    if not UnitIsUnit("target", "player") then
      ma_kickbutton:Enable()
    else
      ma_kickbutton:Disable()
    end
    ma_respawnbutton:Disable()
  elseif not UnitName("target") then
    ma_savebutton:Enable()
    ma_revivebutton:Disable()
    ma_killbutton:Disable()
    ma_kickbutton:Disable()
    ma_respawnbutton:Disable()
  else
    ma_savebutton:Disable()
    ma_revivebutton:Disable()
    ma_kickbutton:Disable()
    if UnitIsDead("target") then
      ma_respawnbutton:Enable()
      ma_killbutton:Disable()
    else
      if self.db.char.instantKillMode then
        if not UnitIsFriend("player", "target") then
          self:KillSomething()
        end
      end
      ma_respawnbutton:Disable()
      ma_killbutton:Enable()
    end
  end
end

function TrinityAdmin:OnDisable()
  -- called when the addon is disabled
  self:SearchReset()
end

function TrinityAdmin:OnClick()
  -- this toggles the TrinityAdmin frame when clicking on the mini icon
  if IsShiftKeyDown() then
    ReloadUI()
  elseif IsAltKeyDown() then
    self.db.char.newTicketQueue = 0
    TrinityAdmin:UpdateTooltip()
  elseif ma_bgframe:IsVisible() and not ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  elseif ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
    FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  elseif not ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  else
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  end
end

function TrinityAdmin:OnTooltipUpdate()
  local tickets = self.db.char.newTicketQueue
  local ticketCount = 0
  table.foreachi(tickets, function() ticketCount = ticketCount + 1 end)
  if ticketCount == 0 then
    local cat = Tablet:AddCategory("columns", 1)
    cat:AddLine("text", Locale["ma_TicketsNoNew"])
    TrinityAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  else
    local cat = Tablet:AddCategory(
      "columns", 1,
      "justify", "LEFT",
      "hideBlankLine", true,
      "showWithoutChildren", false,
      "child_textR", 1,
      "child_textG", 1,
      "child_textB", 1
    )
    cat:AddLine(
      "text", string.format(Locale["ma_TicketsNewNumber"], ticketCount),
      "func", function() TrinityAdmin:ShowTicketTab() end)
    local counter = 0
    local name
    for i, name in pairs(tickets) do
      counter = counter + 1
      if counter == ticketCount then
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGoLast"], name),
          "func", function(name) TrinityAdmin:TelePlayer("gochar", name) end,
          "arg1", name
        )
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGetLast"], name),
          "func", function(name) TrinityAdmin:TelePlayer("getchar", name) end,
          "arg1", name
        )
      end
    end
    TrinityAdmin:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
  end
  Tablet:SetHint(Locale["ma_IconHint"])
end

function TrinityAdmin:ToggleTabButton(group)
  --this modifies the look of tab buttons when clicked on them 
  FrameLib:HandleGroup("tabbuttons", 
  function(button) 
    if button:GetName() == "ma_tabbutton_"..group then
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    else
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    end
  end)
end

function TrinityAdmin:ToggleContentGroup(group)
  --TrinityAdmin:LogAction("Toggled navigation point '"..group.."'.")
  self:HideAllGroups()
  FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function TrinityAdmin:InstantGroupToggle(group)
  if group ~= "ticket" then
    self.db.char.requests.ticket = false
  end
  FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  TrinityAdmin:ToggleTabButton(group)
  TrinityAdmin:ToggleContentGroup(group)
end

function TrinityAdmin:TogglePopup(value, param)
  -- this toggles the TrinityAdmin Search Popup frame, toggling deactivated, popup will be overwritten
  --[[if ma_popupframe:IsVisible() then 
    FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end)
  else]]
  if value == "search" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    ma_mailscrollframe:Hide()
    ma_maileditbox:Hide()
    ma_var1editbox:Hide()
    ma_var2editbox:Hide()
    ma_var1text:Hide()
    ma_var2text:Hide()
    ma_searchbutton:SetScript("OnClick", function() self:SearchStart(param.type, ma_searcheditbox:GetText()) end)
    ma_searchbutton:SetText(Locale["ma_SearchButton"])
    ma_resetsearchbutton:SetScript("OnClick", function() TrinityAdmin:SearchReset() end)
    ma_resetsearchbutton:SetText(Locale["ma_ResetButton"])
    ma_resetsearchbutton:Enable()
    ma_ptabbutton_1:SetScript("OnClick", function() TrinityAdmin:TogglePopup("search", {type = param.type}) end)
    ma_ptabbutton_2:SetScript("OnClick", function() TrinityAdmin:TogglePopup("favorites", {type = param.type}) end)
    ma_ptabbutton_2:Show()
    ma_selectallbutton:SetScript("OnClick", function() self:Favorites("select", param.type) end)
    ma_deselectallbutton:SetScript("OnClick", function() self:Favorites("deselect", param.type) end)
    ma_modfavsbutton:SetScript("OnClick", function() self:Favorites("add", param.type) end)
    ma_modfavsbutton:SetText(Locale["ma_FavAdd"])
    ma_modfavsbutton:Enable()
    self:SearchReset()
    self.db.char.requests.toggle = true
    if param.type == "item" then
      ma_ptabbutton_1:SetText(Locale["ma_ItemButton"])
      ma_var1editbox:Show()
      ma_var1text:Show()
      ma_var1text:SetText(Locale["ma_ItemVar1Button"])
    elseif param.type == "itemset" then
      ma_ptabbutton_1:SetText(Locale["ma_ItemSetButton"])
    elseif param.type == "spell" then
      ma_ptabbutton_1:SetText(Locale["ma_SpellButton"])
    elseif param.type == "skill" then
      ma_ptabbutton_1:SetText(Locale["ma_SkillButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_SkillVar1Button"])
      ma_var2text:SetText(Locale["ma_SkillVar2Button"])
    elseif param.type == "quest" then
      ma_ptabbutton_1:SetText(Locale["ma_QuestButton"])
    elseif param.type == "creature" then
      ma_ptabbutton_1:SetText(Locale["ma_CreatureButton"])
    elseif param.type == "object" then
      ma_ptabbutton_1:SetText(Locale["ma_ObjectButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_ObjectVar1Button"])
      ma_var2text:SetText(Locale["ma_ObjectVar2Button"])
    elseif param.type == "tele" then
      ma_ptabbutton_1:SetText(Locale["ma_TeleSearchButton"])
    elseif param.type == "ticket" then
      --[[ma_modfavsbutton:Hide()
      ma_selectallbutton:Hide()
      ma_deselectallbutton:Hide()
      ma_ptabbutton_2:Hide()
      ma_lookupresulttext:SetText(Locale["ma_TicketCount"].."0")
      ma_ptabbutton_1:SetText(Locale["ma_LoadTicketsButton"])
      ma_searchbutton:SetText(Locale["ma_Reload"])
      ma_searchbutton:SetScript("OnClick", function() self:LoadTickets() end)
      ma_resetsearchbutton:SetText(Locale["ma_LoadMore"])
      ma_resetsearchbutton:SetScript("OnClick", function() TrinityAdmin.db.account.tickets.loading = true; self:LoadTickets(TrinityAdmin.db.account.tickets.count) end)]]--
    end
  elseif value == "favorites" then
    self:SearchReset()
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    ma_modfavsbutton:SetScript("OnClick", function() self:Favorites("remove", param.type) end)
    ma_modfavsbutton:SetText(Locale["ma_FavRemove"])
    ma_modfavsbutton:Enable()
    self:Favorites("show", param.type)
  elseif value == "mail" then
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    for n = 1,7 do
      getglobal("ma_PopupScrollBarEntry"..n):Hide()
    end
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."246")
    ma_lookupresulttext:Show()
    ma_resetsearchbutton:Hide()
    ma_PopupScrollBar:Hide()
    ma_searcheditbox:SetScript("OnTextChanged", function() TrinityAdmin:UpdateMailBytesLeft() end)
    ma_var1editbox:SetScript("OnTextChanged", function() TrinityAdmin:UpdateMailBytesLeft() end)
    ma_modfavsbutton:Hide()
    ma_selectallbutton:Hide()
    ma_deselectallbutton:Hide()
    if param.recipient then
      ma_searcheditbox:SetText(param.recipient)
    else
      ma_searcheditbox:SetText(Locale["ma_MailRecipient"])
    end
    ma_ptabbutton_1:SetText(Locale["ma_Mail"])
    ma_ptabbutton_2:Hide()
    ma_searchbutton:SetText(Locale["ma_Send"])
    ma_searchbutton:SetScript("OnClick", function() self:SendMail(ma_searcheditbox:GetText(), ma_var1editbox:GetText(), ma_maileditbox:GetText()) end)
    ma_var2editbox:Hide()
    ma_var2text:Hide()
    if param.subject then
      ma_var1editbox:SetText(param.subject)
    else
      ma_var1editbox:SetText(Locale["ma_MailSubject"])
    end
    ma_var1editbox:Show()
    ma_var1text:SetText(Locale["ma_MailSubject"])
    ma_var1text:Show()
    ma_maileditbox:SetText(Locale["ma_MailYourMsg"])
  end
end

function TrinityAdmin:HideAllGroups()
  FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("npc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("go", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
end

--[[function WaitLoop(seconds)
    local stime = time() + seconds
    local deltatime = time()
    while deltatime < stime do
      deltatime = time()
   end
end

function TrinityAdmin:TicketHackTimer()
  if self.db.char.requests.ticket then
    if (time() - self.db.char.msgDeltaTime) > 0 then
      self.db.char.requests.ticketbody = 0
      self:RequestTickets()
    else
      self.db.char.msgDeltaTime = time()
      self:LogAction("TicketHackTimer: Please be patient...")
      WaitLoop(1)
      self:TicketHackTimer()
    end
  end
end]]

function TrinityAdmin:AddMessage(frame, text, r, g, b, id)
  -- frame is the object that was hooked (one of the ChatFrames)  
  local catchedSth = false
  local output = true
  if id == 1 then --make sure that the message comes from the server, message id = 1
    --[[ hook all uint32 .getvalue requests
    for guid, field, value in string.gmatch(text, "The uint32 value of (%w+) in (%w+) is: (%w+)") do
      catchedSth = true
      output = self:GetValueCallHandler(guid, field, value)
    end]]
    
    --[[if self.db.char.requests.ticket then
      if (time() - self.db.char.msgDeltaTime) > 0 then
          self.db.char.requests.ticketbody = 0
          self:RequestTickets()
      else
        self:ChatMsg("ads")
      end
      self.db.char.msgDeltaTime = time()
    end]]
    --Catches if Toggle is still on for some reason, but search frame is not up, and disables it so messages arent caught
    if self.db.char.requests.toggle and not ma_popupframe:IsVisible() then
      self.db.char.requests.toggle = false
    end
    -- hook .gps for gridnavigation
    for x, y in string.gmatch(text, Strings["ma_GmatchGPS"]) do
      for k,v in pairs(self.db.char.functionQueue) do
        if v == "GridNavigate" then
          self:GridNavigate(string.format("%.1f", x), string.format("%.1f", y), nil)
          table.remove(self.db.char.functionQueue, k)
          break
        end
      end
    end
    if self.db.char.requests.toggle then
      if self.db.char.requests.item then
        -- hook all item lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchItem"]) do
            table.insert(self.db.account.buffer.items, {itId = id, itName = name, checked = false})
            -- for item info in cache
            local itemName, itemLink, itemQuality, _, _, _, _, _, _ = GetItemInfo(id);
            if not itemName then
              GameTooltip:SetOwner(ma_popupframe, "ANCHOR_RIGHT")
              GameTooltip:SetHyperlink("item:"..id..":0:0:0:0:0:0:0")
              GameTooltip:Hide()
            end
            PopupScrollUpdate()
            catchedSth = true
            output = false  
        end
      elseif self.db.char.requests.itemset then
        -- hook all itemset lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchItemSet"]) do
            table.insert(self.db.account.buffer.itemsets, {isId = id, isName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.spell then
        -- hook all spell lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchSpell"]) do
            table.insert(self.db.account.buffer.spells, {spId = id, spName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.skill then
        -- hook all skill lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchSkill"]) do
            table.insert(self.db.account.buffer.skills, {skId = id, skName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.creature then
        -- hook all creature lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchCreature"]) do
            table.insert(self.db.account.buffer.creatures, {crId = id, crName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.object then
        -- hook all object lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchGameObject"]) do
            table.insert(self.db.account.buffer.objects, {objId = id, objName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.quest then
        -- hook all quest lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchQuest"]) do
            table.insert(self.db.account.buffer.quests, {qsId = id, qsName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
      elseif self.db.char.requests.tele then
        -- hook all tele lookups
        for name in string.gmatch(text, Strings["ma_GmatchTele"]) do
            table.insert(self.db.account.buffer.teles, {tName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = false
        end
        --this is to hide the message shown before the teles
        if string.gmatch(text, Strings["ma_GmatchTeleFound"]) then
          catchedSth = true
          output = false
        end
      end
    end
    -- hook all new tickets
    for name in string.gmatch(text, Strings["ma_GmatchNewTicket"]) do
      -- now need function for: Got new ticket
      table.insert(self.db.char.newTicketQueue, name)
      self:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
      PlaySoundFile(ROOT_PATH.."Sound\\mail.wav")
      self:LogAction("Got new ticket from: "..name)
    end
    
    -- hook ticket count
    for count, status in string.gmatch(text, Strings["ma_GmatchTicketCount"]) do
      if self.db.char.requests.ticket then
        catchedSth = true
        output = false
        self:LoadTickets(count)
      end
    end
    
    -- hook player account info
    for status, char, guid, account, id, level, ip, login, latency in string.gmatch(text, Strings["ma_GmatchAccountInfo"]) do
      if self.db.char.requests.tpinfo then
        if status == "" then
          status = Locale["ma_Online"]
        else
          status = Locale["ma_Offline"]
        end
        --table.insert(self.db.account.buffer.tpinfo, {char = {pStatus = status, pGuid = guid, pAcc = account, pId = id, pLevel = level, pIp = ip}})
        ma_tpinfo_text:SetText(ma_tpinfo_text:GetText()..Locale["ma_TicketsInfoPlayer"]..char.." ("..guid..")\n"..Locale["ma_TicketsInfoStatus"]..status.."\n"..Locale["ma_TicketsInfoAccount"]..account.." ("..id..")\n"..Locale["ma_TicketsInfoAccLevel"]..level.."\n"..Locale["ma_TicketsInfoLastIP"]..ip.."\n"..Locale["ma_TicketsInfoLatency"]..latency)
        catchedSth = true
        output = false
      end
    end
    
    -- hook player account info
    for played, level, money in string.gmatch(text, Strings["ma_GmatchAccountInfo2"]) do
      if self.db.char.requests.tpinfo then
        ma_tpinfo_text:SetText(ma_tpinfo_text:GetText().."\n"..Locale["ma_TicketsInfoPlayedTime"]..played.."\n"..Locale["ma_TicketsInfoLevel"]..level.."\n"..Locale["ma_TicketsInfoMoney"]..money)
        catchedSth = true
        output = false
        self.db.char.requests.tpinfo = false
      end
    end
    
    --check for info command to update informations in right bottom
    for revision, platform in string.gmatch(text, Strings["ma_GmatchRevision"]) do
      ma_inforevisiontext:SetText(Locale["info_revision"]..revision)
      ma_infoplatformtext:SetText(Locale["info_platform"]..platform)
    end
    for users, maxusers in string.gmatch(text, Strings["ma_GmatchOnlinePlayers"]) do
      ma_infoonlinetext:SetText(Locale["info_online"]..users)
      ma_infomaxonlinetext:SetText(Locale["info_maxonline"]..maxusers)
    end
    for uptime in string.gmatch(text, Strings["ma_GmatchUptime"]) do
      ma_infouptimetext:SetText(Locale["info_uptime"]..uptime)
    end
    
    -- get tickets
    for char, update, category, message in string.gmatch(text, Strings["ma_GmatchTickets"]) do
      if self.db.char.requests.ticket then
        local ticketCount = 0
        table.foreachi(self.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
        local number = self.db.account.tickets.count - ticketCount
        --self:LogAction(number)
        table.insert(self.db.account.buffer.tickets, {tNumber = number, tChar = char, tLUpdate = update, tCat = category, tMsg = ""})
        --self:RequestTickets()
        InlineScrollUpdate()
        catchedSth = false
        output = false
        self.db.char.requests.ticketbody = number
        self.db.char.msgDeltaTime = time()
        --TrinityAdmin:ChatMsg("DEBUG YEAH")
        --self:ChatMsg(".ticket")
        self:LoadTickets(number)
      end
    end
    
    -- get ticket content
    if self.db.char.requests.ticket then
      local delta = time() - self.db.char.msgDeltaTime
      --self:LogAction("Delta: "..delta)
      if self.db.char.requests.ticketbody > 0 then
        if delta <= 300 then
          if not catchedSth then
            --self:LogAction(text)
            local ticketCount = 0
            table.foreachi(TrinityAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
            --self:LogAction("Prepare to add text to DB ticket: "..ticketCount)
            for k,v in ipairs(self.db.account.buffer.tickets) do
              if k == ticketCount then
                local oldmsg = v.tMsg
                self.db.account.buffer.tickets[k].tMsg = oldmsg..text.."\n"
                --self:LogAction("Added text to ticket in DB: "..k.." Ticket id:"..self.db.account.buffer.tickets[k].tNumber)
              end
            end
            catchedSth = true
            output = false
          end
        else
          --self:LogAction("Time passed. Getting next ticket...")
          --self:RequestTickets()
        end
      end
    end
    
    -- Check for possible UrlModification
    if catchedSth then
      if output == false then
        -- don't output anything
      elseif output == true then
        text = TrinityLinkifier_Decompose(text)
        self.hooks[frame].AddMessage(frame, text, r, g, b, id)
      end
    else
      text = TrinityLinkifier_Decompose(text)
      self.hooks[frame].AddMessage(frame, text, r, g, b, id)
    end
  else
    -- message is not from server
    --Linkifier should be used on non server messages as well to catch links suc as items in chat
    text = TrinityLinkifier_Decompose(text)
    -- Returns the message to the client, or else the chat frame never shows it
    self.hooks[frame].AddMessage(frame, text, r, g, b, id)
  end
end

--[[ function TrinityAdmin:GetValueCallHandler(guid, field, value)
  -- checks for specific actions and calls functions by checking the function-order
  local called = self.db.char.getValueCallHandler.calledGetGuid
  local realGuid = self.db.char.getValueCallHandler.realGuid
  -- case checking
  if guid == value and field == "0" and not called then
    -- getting GUID and setting db variables and logged text
    self.db.char.getValueCallHandler.calledGetGuid = true
    self.db.char.getValueCallHandler.realGuid = value
    ma_toptext:SetText(Locale["char"]..Locale["guid"]..UnitGUID())
    return false    
  elseif guid == realGuid then
    return true
  else
    TrinityAdmin:LogAction("DEBUG: Getvalues are: GUID = "..guid.."; field = "..field.."; value = "..value..";")
    return true
  end
end ]]

function TrinityAdmin:LogAction(msg)
  ma_logframe:AddMessage("|cFF00FF00["..date("%H:%M:%S").."]|r "..msg, 1.0, 1.0, 0.0)
end

function TrinityAdmin:ChatMsg(msg, msgt, recipient)
  if not msgt then local msgt = "say" end
  if msgt == "addon" then
    if recipient then
      SendAddonMessage("", msg, "WHISPER", recipient)
    else
      SendAddonMessage("", msg, "GUILD")
    end
  else
    if recipient then 
      SendChatMessage(msg, "WHISPER", nil, recipient)
    else
      SendChatMessage(msg, msgt, nil, nil)
    end
  end
end

function TrinityAdmin:Selection(selection)
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
    error("Argument 'selection' can be 'player','self', or 'none'!")
    return false
  end
end

function TrinityAdmin:AndBit(value, test) 
  return mod(value, test*2) >= test 
end


--=================================--
--TrinityAdmin Commands functions--
--=================================--
function TrinityAdmin:SetLanguage()
  if self.db.account.language then
    Locale:SetLocale(self.db.account.language)
    if self.db.account.localesearchstring then
      Strings:SetLocale(self.db.account.language)
    else
      Strings:SetLocale("enUS")
    end
  else
    self.db.account.language = Locale:GetLocale()
  end
end

function TrinityAdmin:ChangeLanguage(locale)
  self.db.account.localesearchstring = ma_checklocalsearchstringsbutton:GetChecked()
  self.db.account.language = locale
  ReloadUI()
end

function TrinityAdmin:ToggleGMMode(value)
  TrinityAdmin:ChatMsg(".gm "..value)
  TrinityAdmin:LogAction("Turned GM-mode to "..value..".")
end

function TrinityAdmin:ToggleFlyMode(value)
  --if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    TrinityAdmin:ChatMsg(".gm fly "..value)
    TrinityAdmin:LogAction("Turned Fly-mode "..value.." for "..player..".")
  --[[else
    self:Print(Locale["selectionerror1"])
  end]]
end

function TrinityAdmin:ToggleHoverMode(value)
  TrinityAdmin:ChatMsg(".hover "..value)
  local status
  if value == 1 then
    status = "on"
  else
    status = "off"
  end
  TrinityAdmin:LogAction("Turned Hover-mode "..status..".")
end

function TrinityAdmin:ToggleWhisper(value)
  TrinityAdmin:ChatMsg(".whispers "..value)
  TrinityAdmin:LogAction("Turned accepting whispers to "..value..".")
end

function TrinityAdmin:ToggleVisible(value)
  TrinityAdmin:ChatMsg(".gm visible "..value)
  if value == "on" then
    TrinityAdmin:LogAction("Turned you visible.")
  else
    TrinityAdmin:LogAction("Turned you invisible.")
  end  
end

function TrinityAdmin:ToggleTaxicheat(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    TrinityAdmin:ChatMsg(".taxicheat "..value)
    if value == 1 then
      TrinityAdmin:LogAction("Activated taxicheat to "..player..".")
    else
      TrinityAdmin:LogAction("Disabled taxicheat to "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:SetSpeed()
  local value = string.format("%.1f", ma_speedslider:GetValue())
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    --self:ChatMsg(".modify speed "..value)
    --self:ChatMsg(".modify fly "..value)
    --self:ChatMsg(".modify swim "..value)
    self:ChatMsg(".modify aspeed "..value)
    self:LogAction("Set speed of "..player.." to "..value..".")
  else
    self:Print(Locale["selectionerror1"])
    ma_speedslider:SetValue(1)
  end
end

function TrinityAdmin:SetScale()
  local value = string.format("%.1f", ma_scaleslider:GetValue())
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".modify scale "..value)
    self:LogAction("Set scale of "..player.." to "..value..".")
  else
    self:Print(Locale["selectionerror1"])
    ma_scaleslider:SetValue(1)
  end
end

function TrinityAdmin:LearnSpell(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".learn"
    local logcmd = "Learned"
    if state == "RightButton" then
      command = ".unlearn"
      logcmd = "Unlearned"
    end
    if type(value) == "string" then
      if value == "all" then
        self:ChatMsg(command.." all")
        self:LogAction(logcmd.." all spells to "..player..".")
      elseif value == "all_crafts" then
        self:ChatMsg(command.." all_crafts")
        self:LogAction(logcmd.." all professions and recipes to "..player..".")
      elseif value == "all_gm" then
        self:ChatMsg(command.." all_gm")
        self:LogAction(logcmd.." all default spells for Game Masters to "..player..".")
      elseif value == "all_lang" then
        self:ChatMsg(command.." all_lang")
        self:LogAction(logcmd.." all languages to "..player..".")
      elseif value == "all_myclass" then
        self:ChatMsg(command.." all_myclass")
        self:LogAction(logcmd.." all spells available to the "..class.."-class to "..player..".")
      else
        self:ChatMsg(command.." "..value)
        self:LogAction(logcmd.." spell "..value.." to "..player..".")
      end
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." spell "..v.." to "..player..".")
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:SetSkill(value, skill, maxskill)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    if not skill then
      skill = ma_var1editbox:GetText()
      if ma_var1editbox:GetText() == "" then
        skill = 375
      end
    end
    if not maxskill then
      maxskill = ma_var2editbox:GetText()
      if ma_var2editbox:GetText() == "" then
        maxskill = 375
      end
    end
    if type(value) == "string" then
      self:ChatMsg(".setskill "..value.." "..skill.." "..maxskill)
      self:LogAction("Set skill "..value.." of "..player.." to "..skill.." with a maximum of "..maxskill..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(".setskill "..v.." "..skill.." "..maxskill)
        self:LogAction("Set skill "..v.." of "..player.." to "..skill.." with a maximum of "..maxskill..".")
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Quest(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".quest add"
    local logcmd = "Added"
    local logcmd2 = "to"
    if state == "RightButton" then
      command = ".quest remove"
      logcmd = "Removed"
      logcmd2 = "from"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Creature(value, state)
    local command = ".npc add"
    local logcmd = "Spawned"
    if state == "RightButton" then
      command = ".list creature"
      logcmd = "Listed"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." creature with id "..value..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    end

end

function TrinityAdmin:AddItem(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local amount = ma_var1editbox:GetText()
    if state == "RightButton" then
      self:ChatMsg(".list item "..value)
      self:LogAction("Listed item with id "..value..".")
    else
      if amount == "" then
        self:ChatMsg(".additem "..value)
        self:LogAction("Added item with id "..value.." to "..player..".")
      else
        self:ChatMsg(".additem "..value.." "..amount)
        self:LogAction("Added "..amount.." items with id "..value.." to "..player..".")
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:AddItemSet(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".additemset "..value)
    self:LogAction("Added itemset with id "..value.." to "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:AddObject(value, state)
  local loot = ma_var1editbox:GetText()
  local _time = ma_var2editbox:GetText()
  if state == "RightButton" then
    self:ChatMsg(".gobject add "..value.." "..value)
    self:LogAction("Added object id "..value.." with loot template.")
  else
    if loot ~= "" and _time == "" then
      self:ChatMsg(".gobject add "..value.. " "..loot)
      self:LogAction("Added object id "..value.." with loot "..loot..".")
    elseif loot ~= "" and _time ~= "" then
      self:ChatMsg(".gobject add "..value.. " "..loot.." ".._time)
      self:LogAction("Added object id "..value.." with loot "..loot.." and spawntime ".._time..".")
    else
      self:ChatMsg(".gobject add "..value)
      self:LogAction("Added object id "..value..".")
    end
  end
end

function TrinityAdmin:TelePlayer(value, player)
  if value == "gochar" then
    self:ChatMsg(".goname "..player)
    self:LogAction("Teleported to player "..player..".")
  elseif value == "getchar" then
    self:ChatMsg(".namego "..player)
    self:LogAction("Summoned player "..player..".")
  end
end

function TrinityAdmin:KickPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".kick")
    self:LogAction("Kicked player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Cooldown()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".cooldown")
    self:LogAction("Cooled player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Demorph()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".demorph")
    self:LogAction("Demorphed player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:GPS()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".gps")
    self:LogAction("Got GPS coordinates for player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:ShowGUID()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".guid")
    self:LogAction("Got GUID for player "..player..".")
end

function TrinityAdmin:ShowMove()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".movegens")
    self:LogAction("Got Movement Stack for player "..player..".")
end

function TrinityAdmin:NPCFreeze()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".npc setmovetype stay NODEL")
    self:LogAction("Set NPC movement to STAY for player "..player..".")
end

function TrinityAdmin:NPCUnFreeze_Random()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".npc setmovetype random NODEL")
    self:LogAction("Set NPC movement type to RANDOM for player "..player..".")
end

function TrinityAdmin:NPCUnFreeze_Way()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".npc setmovetype way NODEL")
    self:LogAction("Set NPC movement type to WAYPOINT for player "..player..".")
end

function TrinityAdmin:NPCInfo()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".npc info")
    self:LogAction("Got NPC info for player "..player..".")
end

function TrinityAdmin:Pinfo()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".pinfo")
    self:LogAction("Got Player Info for player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Distance()
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".distance")
    self:LogAction("Got distance to player "..player..".")
end

function TrinityAdmin:SetJail_A()
    self:ChatMsg(".tele del ma_AllianceJail")
    i=1
    while i<100 do
        i=i+1
        self:ChatMsg(".")
    end
    self:ChatMsg(".tele add ma_AllianceJail")
    self:LogAction("Set location of Alliance Jail")
end

function TrinityAdmin:SetJail_H()
    self:ChatMsg(".tele del ma_HordeJail")
    i=1
    while i<100 do
        i=i+1
        self:ChatMsg(".")
    end
    self:ChatMsg(".tele add ma_HordeJail")
    self:LogAction("Set location of Horde Jail")
end

function TrinityAdmin:JailA()
    cname=ma_charactertarget:GetText()
    self:ChatMsg(".tele name "..cname.." ma_AllianceJail")
    self:LogAction("Jailed player "..player..".")
    self:ChatMsg(".notify "..cname.." has been found guilty and jailed.")
end

function TrinityAdmin:JailH()
    cname=ma_charactertarget:GetText()
    --self:ChatMsg("Selected "..cname)
    self:ChatMsg(".tele name "..cname.." ma_HordeJail")
    self:LogAction("Jailed player "..player..".")
    self:ChatMsg(".notify "..cname.." has been found guilty and jailed.")
end

function TrinityAdmin:UnJail()
    cname=ma_charactertarget:GetText()
    self:ChatMsg(".recall "..cname)
    self:LogAction("UnJailed player "..player..".")
    self:ChatMsg(".notify "..cname.." has been pardoned and released from jail.")
end

function TrinityAdmin:Recall()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".recall")
    self:LogAction("Recalled player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:RevivePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".revive")
    self:LogAction("Revived player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:DismountPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".dismount")
    self:LogAction("Dismounted player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:SavePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".save")
    self:LogAction("Saved player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:KillSomething()
  local target = UnitName("target") or UnitName("player")
  self:ChatMsg(".die")
  self:LogAction("Killed "..target..".")
end

function TrinityAdmin:Respawn()
  self:ChatMsg(".respawn")
  self:LogAction("Respawned creatures near you.")
end

function TrinityAdmin:Modify(case, value) 
  -- to dxers: I think it's better to do switch case with names (so other devs can see quicker what it is for) 
  -- and level down is possible: pass negative amount with .levelup
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    if case == "money" then
      self:ChatMsg(".modify money "..value)
      self:LogAction("Give player "..player.." "..value.." copper).")
    elseif case == "levelup" then
      self:ChatMsg(".levelup "..value)
      self:LogAction("Leveled up player "..player.." by "..value.." levels.")
    elseif case == "leveldown" then
      self:ChatMsg(".levelup "..value*(-1))
      self:LogAction("Leveled down player "..player.." by "..value.." levels.")
    elseif case == "enery" then
      self:ChatMsg(".modify energy "..value)
      self:LogAction("Modified energy for "..player.." to "..value.." energy.")
    elseif case == "rage" then
      self:ChatMsg(".modify rage "..value)
      self:LogAction("Modified rage for "..player.." to "..value.." rage.")
    elseif case == "health" then
      self:ChatMsg(".modify hp "..value)
      self:LogAction("Modified hp for "..player.." to "..value.." healthpoints")
    elseif case == "mana" then
      self:ChatMsg(".modify mana "..value)
      self:LogAction("Modified mana for "..player.." to "..value.." mana")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:Reset(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".reset "..value)
    self:LogAction("Reset "..value.."' for player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function TrinityAdmin:GridNavigate(x, y)
  local way = self.db.char.nextGridWay
  if not x and not y then
    table.insert(self.db.char.functionQueue, "GridNavigate")
    self:ChatMsg(".gps")
  else
    if pcall(function() return ma_gridnavieditbox:GetText() + 10 end) then
      local step = ma_gridnavieditbox:GetText()
      local newy
      local newx
      if way == "back" then
        newy = y - step
        newx = x
      elseif way == "right" then
        newy = y
        newx = x + step
      elseif way == "left" then
        newy = y
        newx = x - step
      else
        newy = y + step
        newx = x
      end
      self:ChatMsg(".go xy "..newx.." "..newy)
      self:LogAction("Teleported to grid position: X: "..newx.." Y: "..newy)
    else
      self:Print("Value must be a number!")
    end
  end
end

function TrinityAdmin:CreateGuild(leader, name)
  self:ChatMsg(".guild create "..leader.." "..name)
  self:LogAction("Created guild '"..name.."' with leader "..leader..".")
end

function TrinityAdmin:Screenshot()
  UIParent:Hide()
  Screenshot()
  UIParent:Show()
end

function TrinityAdmin:Announce(value)
  self:ChatMsg(".announce "..value)
  self:LogAction("Announced message: "..value)
end

function TrinityAdmin:Shutdown(value)
  if value == "" then
    self:ChatMsg(".server shutdown 0")
    self:LogAction("Shut down server instantly.")
  else
    self:ChatMsg(".server shutdown "..value)
    self:LogAction("Shut down server in "..value.." seconds.")
  end
end

function TrinityAdmin:SendMail(recipient, subject, body)
  recipient = string.gsub(recipient, " ", "")
  subject = string.gsub(subject, " ", "")
  body = string.gsub(body, "\n", " ")
  self:ChatMsg(".sendm "..recipient.." "..subject.." "..body)
  self:LogAction("Sent a mail to "..recipient..". Subject was: "..subject)
end

function TrinityAdmin:ReloadTable(tablename)
  if not (tablename == "") then
    self:ChatMsg(".reload "..tablename)
    if tablename == "all" then
      self:LogAction("Reloaded all reloadable Trinity database tables.")
    else
      self:LogAction("Reloaded the table "..tablename..".")
    end
  end
end

function TrinityAdmin:QuickCommand(v)
  local cname = ma_charactertarget:GetText()
  if(v == 1) then --.ban
    self:ChatMsg(".ban "..cname)
    self:LogAction("Banned player: "..cname..".")
  elseif(v == 2) then --.goname
    self:ChatMsg(".goname "..cname)
    self:LogAction("Teleported TO player: "..cname..".")
  elseif(v == 3) then --.guild create
    self:ChatMsg(".guild create "..cname)
    self:LogAction("Created Guild: "..cname..".")
  elseif(v == 4) then --.tele add
    self:ChatMsg(".tele add "..cname)
    self:LogAction("Added .tele location: "..cname..".")
  elseif(v == 5) then --.baninfo
    self:ChatMsg(".baninfo "..cname)
    self:LogAction("Listed .baninfo: "..cname..".")
  elseif(v == 6) then --.groupgo
    self:ChatMsg(".groupgo "..cname)
    self:LogAction("Teleported "..cname.." and his/her group TO me.")
  elseif(v == 7) then --.guild invite 
    self:ChatMsg(".guild invite "..cname)
    self:LogAction("Guild invitation: "..cname..".")
  elseif(v == 8) then --.tele del
    self:ChatMsg(".tele del "..cname)
    self:LogAction("Deleted .tele location: "..cname..".")
  elseif(v == 9) then --.banlist
    self:ChatMsg(".banlist "..cname)
    self:LogAction("Listed bans matching: "..cname..".")
  elseif(v == 10) then --.namego
    self:ChatMsg(".namego "..cname)
    self:LogAction("Teleported "..cname.." TO me.")
  elseif(v == 11) then --.guild rank
    self:ChatMsg(".guild rank "..cname)
    self:LogAction("Guild rank change: "..cname..".")
  elseif(v == 12) then --.tele group
    self:ChatMsg(".tele group "..cname)
    self:LogAction("Group teleported: "..cname..".")
  elseif(v == 13) then --.unban
    self:ChatMsg(".unban "..cname)
    self:LogAction("Unbanned "..cname..".")
  elseif(v == 14) then --.guild delete
    self:ChatMsg(".guild delete "..cname)
    self:LogAction("Deleted guild: "..cname..".")
  elseif(v == 15) then --.guild uninvite
    self:ChatMsg(".guild uninvite "..cname)
    self:LogAction("Removed from guild: "..cname..".")
  elseif(v == 16) then --.tele name
    self:ChatMsg(".tele name "..cname)
    self:LogAction("Teleported: "..cname..".")
  elseif(v == 17) then --.mute
    self:ChatMsg(".mute "..cname)
    self:LogAction("Muted "..cname..".")
  end
end

function TrinityAdmin:ReloadScripts()
  self:ChatMsg(".loadscripts")
  self:LogAction("(Re-)Loaded scripts.")
end

function TrinityAdmin:ChangeWeather(status)
  if not (status == "") then
    self:ChatMsg(".wchange "..status)
    self:LogAction("Changed weather ("..status..").")
  end
end

function TrinityAdmin:UpdateMailBytesLeft()
  local bleft = 246 - strlen(ma_searcheditbox:GetText()) - strlen(ma_var1editbox:GetText()) - strlen(ma_maileditbox:GetText())
  if bleft >= 0 then
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."|cff00ff00"..bleft.."|r")
  else
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."|cffff0000"..bleft.."|r")
  end
end

function TrinityAdmin:Ticket(value)
  local ticket = self.db.account.tickets.selected
  if value == "delete" then
    self:ChatMsg(".delticket "..ticket["tNumber"])
    self:LogAction("Deleted ticket with number: "..ticket["tNumber"])
    self:ShowTicketTab()
    --InlineScrollUpdate()
  elseif value == "gochar" then
    self:ChatMsg(".goname "..ticket["tChar"])
  elseif value == "getchar" then
    self:ChatMsg(".namego "..ticket["tChar"])
  elseif value == "answer" then
    self:TogglePopup("mail", {recipient = ticket["tChar"], subject = "Ticket("..ticket["tCat"]..")", body = ticket["tMsg"]})
  elseif value == "whisper" then
    ChatFrameEditBox:Show()
    ChatFrameEditBox:Insert("/w "..ticket["tChar"].." ");
  end
end

function TrinityAdmin:ToggleTickets(value)
  TrinityAdmin:ChatMsg(".ticket "..value)
  TrinityAdmin:LogAction("Turned receiving new tickets "..value..".")
end

function TrinityAdmin:ToggleMaps(value)
  TrinityAdmin:ChatMsg(".explorecheat "..value)
  if value == 1 then
    TrinityAdmin:LogAction("Revealed all maps for selected player.")
  else
    TrinityAdmin:LogAction("Hide all unexplored maps for selected player.")
  end
end

function TrinityAdmin:ShowTicketTab()
  ma_tpinfo_text:SetText(Locale["ma_TicketsNoInfo"])
  ma_ticketeditbox:SetText(Locale["ma_TicketsNotLoaded"])
  ma_deleteticketbutton:Disable()
  ma_answerticketbutton:Disable()
  ma_getcharticketbutton:Disable()
  ma_gocharticketbutton:Disable()
  ma_whisperticketbutton:Disable()
  TrinityAdmin:InstantGroupToggle("ticket")
  self:LoadTickets(nil)
end

function TrinityAdmin:LoadTickets(number)
  self.db.char.newTicketQueue = {}
  --self.db.account.tickets.requested = 0
  if number then
    if tonumber(number) > 0 then
      self.db.account.tickets.count = tonumber(number)
      if self.db.char.requests.ticket then
        self:LogAction("Load of tickets requested. Found "..number.." tickets!")
        self:RequestTickets()
        self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
        --ma_resetsearchbutton:Enable()
      end
    else
      --ma_resetsearchbutton:Disable()
      self:NoResults("ticket")
    end
  else
    self.db.char.requests.ticket = true
    self.db.account.tickets.count = 0
    self.db.account.buffer.tickets = {}
    self:ChatMsg(".ticket")
    self:LogAction("Requesting ticket number!")
  end
  --InlineScrollUpdate()
end

function TrinityAdmin:RequestTickets()
  self.db.char.requests.ticket = true
  local ticketCount = 0
  table.foreachi(self.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
  --ma_lookupresulttext:SetText(Locale["ma_TicketCount"]..count)
  ma_top2text:SetText(Locale["realm"].." "..Locale["tickets"]..self.db.account.tickets.count)
  local tnumber = self.db.account.tickets.count - ticketCount
  --self:LogAction("tNumber = "..tnumber..", Tc = "..ticketCount)
  if tnumber > 0 then
    self:ChatMsg(".ticket "..tnumber)
    --self:LogAction(".ticket "..tnumber)
    self:LogAction("Loading ticket "..tnumber.."...")
  else
    self:LogAction("Loaded all available tickets! No more to load...")
    ma_resetsearchbutton:Disable()
  end
end

function TrinityAdmin:Favorites(value, searchtype)
  if value == "add" then
    if searchtype == "item" then
      table.foreachi(self.db.account.buffer.items, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.items, {itId = v["itId"], itName = v["itName"], checked = false}) end end)
    elseif searchtype == "itemset" then
      table.foreachi(self.db.account.buffer.itemsets, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.itemsets, {isId = v["isId"], isName = v["isName"], checked = false}) end end)
    elseif searchtype == "spell" then
      table.foreachi(self.db.account.buffer.spells, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.spells, {spId = v["spId"], spName = v["spName"], checked = false}) end end)
    elseif searchtype == "skill" then
      table.foreachi(self.db.account.buffer.skills, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.skills, {skId = v["skId"], skName = v["skName"], checked = false}) end end)
    elseif searchtype == "quest" then
      table.foreachi(self.db.account.buffer.quests, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.quests, {qsId = v["qsId"], qsName = v["qsName"], checked = false}) end end)
    elseif searchtype == "creature" then
      table.foreachi(self.db.account.buffer.creatures, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.creatures, {crId = v["crId"], crName = v["crName"], checked = false}) end end)
    elseif searchtype == "object" then
      table.foreachi(self.db.account.buffer.objects, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.objects, {objId = v["objId"], objName = v["objName"], checked = false}) end end)
    elseif searchtype == "tele" then
      table.foreachi(self.db.account.buffer.teles, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.teles, {tName = v["tName"], checked = false}) end end)
    end
    self:LogAction("Added some "..searchtype.."s to the favorites.")
  elseif value == "remove" then
    if searchtype == "item" then
      for k,v in pairs(self.db.account.favorites.items) do
        if v["checked"] then table.remove(self.db.account.favorites.items, k) end 
      end
    elseif searchtype == "itemset" then
      for k,v in pairs(self.db.account.favorites.itemsets) do
        if v["checked"] then table.remove(self.db.account.favorites.itemsets, k) end 
      end
    elseif searchtype == "spell" then
      for k,v in pairs(self.db.account.favorites.spells) do
        if v["checked"] then table.remove(self.db.account.favorites.spells, k) end 
      end
    elseif searchtype == "skill" then
      for k,v in pairs(self.db.account.favorites.skills) do
        if v["checked"] then table.remove(self.db.account.favorites.skills, k) end 
      end
    elseif searchtype == "quest" then
      for k,v in pairs(self.db.account.favorites.quests) do
        if v["checked"] then table.remove(self.db.account.favorites.quests, k) end 
      end
    elseif searchtype == "creature" then
      for k,v in pairs(self.db.account.favorites.creatures) do
        if v["checked"] then table.remove(self.db.account.favorites.creatures, k) end 
      end
    elseif searchtype == "object" then
      for k,v in pairs(self.db.account.favorites.objects) do
        if v["checked"] then table.remove(self.db.account.favorites.objects, k) end 
      end
    elseif searchtype == "tele" then
      for k,v in pairs(self.db.account.favorites.teles) do
        if v["checked"] then table.remove(self.db.account.favorites.teles, k) end 
      end
    end
    self:LogAction("Removed some favorited "..searchtype.."s from the list.")
    PopupScrollUpdate()
  elseif value == "show" then
    if searchtype == "item" then
      self.db.char.requests.favitem = true
    elseif searchtype == "itemset" then
      self.db.char.requests.favitemset = true
    elseif searchtype == "spell" then
      self.db.char.requests.favspell = true
    elseif searchtype == "skill" then
      self.db.char.requests.favskill = true
    elseif searchtype == "quest" then
      self.db.char.requests.favquest = true
    elseif searchtype == "creature" then
      self.db.char.requests.favcreature = true
    elseif searchtype == "object" then
      self.db.char.requests.favobject = true
    elseif searchtype == "tele" then
      self.db.char.requests.favtele = true
    end
    PopupScrollUpdate()
  elseif value == "select" or value == "deselect" then
    local selected = true
    if value == "deselect" then
      selected = false
    end
    if searchtype == "item" then
      if TrinityAdmin.db.char.requests.item then
        table.foreachi(self.db.account.buffer.items, function(k,v) self.db.account.buffer.items[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favitem then
        table.foreachi(self.db.account.favorites.items, function(k,v) self.db.account.favorites.items[k].checked = selected end)
      end
    elseif searchtype == "itemset" then
      if TrinityAdmin.db.char.requests.itemset then
        table.foreachi(self.db.account.buffer.itemsets, function(k,v) self.db.account.buffer.itemsets[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favitemset then
        table.foreachi(self.db.account.favorites.itemsets, function(k,v) self.db.account.favorites.itemsets[k].checked = selected end)
      end
    elseif searchtype == "spell" then
      if TrinityAdmin.db.char.requests.spell then
        table.foreachi(self.db.account.buffer.spells, function(k,v) self.db.account.buffer.spells[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favspell then
        table.foreachi(self.db.account.favorites.spells, function(k,v) self.db.account.favorites.spells[k].checked = selected end)
      end
    elseif searchtype == "skill" then
      if TrinityAdmin.db.char.requests.skill then
        table.foreachi(self.db.account.buffer.skills, function(k,v) self.db.account.buffer.skills[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favskill then
        table.foreachi(self.db.account.favorites.skills, function(k,v) self.db.account.favorites.skills[k].checked = selected end)
      end
    elseif searchtype == "quest" then
      if TrinityAdmin.db.char.requests.quest then
        table.foreachi(self.db.account.buffer.quests, function(k,v) self.db.account.buffer.quests[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favquest then
        table.foreachi(self.db.account.favorites.quests, function(k,v) self.db.account.favorites.quests[k].checked = selected end)
      end
    elseif searchtype == "creature" then
      if TrinityAdmin.db.char.requests.creature then
        table.foreachi(self.db.account.buffer.creatures, function(k,v) self.db.account.buffer.creatures[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favcreature then
        table.foreachi(self.db.account.favorites.creatures, function(k,v) self.db.account.favorites.creatures[k].checked = selected end)
      end
    elseif searchtype == "object" then
      if TrinityAdmin.db.char.requests.object then
        table.foreachi(self.db.account.buffer.objects, function(k,v) self.db.account.buffer.objects[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favobject then
        table.foreachi(self.db.account.favorites.objects, function(k,v) self.db.account.favorites.objects[k].checked = selected end)
      end
    elseif searchtype == "tele" then
      if TrinityAdmin.db.char.requests.tele then
        table.foreachi(self.db.account.buffer.teles, function(k,v) self.db.account.buffer.teles[k].checked = selected end)
      elseif TrinityAdmin.db.char.requests.favtele then
        table.foreachi(self.db.account.favorites.teles, function(k,v) self.db.account.favorites.teles[k].checked = selected end)
      end
    end
    PopupScrollUpdate()
  end
end

function TrinityAdmin:SearchStart(var, value)
  self.db.char.requests.toggle = true
  if var == "item" then
    self.db.char.requests.item = true
    self.db.account.buffer.items = {}
    self:ChatMsg(".lookup item "..value)
  elseif var == "itemset" then
    self.db.char.requests.itemset = true
    self.db.account.buffer.itemsets = {}
    self:ChatMsg(".lookup itemset "..value)
  elseif var == "spell" then
    self.db.char.requests.spell = true
    self.db.account.buffer.spells = {}
    self:ChatMsg(".lookup spell "..value)
  elseif var == "skill" then
    self.db.char.requests.skill = true
    self.db.account.buffer.skills = {}
    self:ChatMsg(".lookup skill "..value)
  elseif var == "quest" then
    self.db.char.requests.quest = true
    self.db.account.buffer.quests = {}
    self:ChatMsg(".lookup quest "..value)
  elseif var == "creature" then
    self.db.char.requests.creature = true
    self.db.account.buffer.creatures = {}
    self:ChatMsg(".lookup creature "..value)
  elseif var == "object" then
    self.db.char.requests.object = true
    self.db.account.buffer.objects = {}
    self:ChatMsg(".lookup object "..value)
  elseif var == "tele" then
    self.db.char.requests.tele = true
    self.db.account.buffer.teles = {}
    self:ChatMsg(".lookup tele "..value)
  end
  self.db.account.buffer.counter = 0
  self:LogAction("Searching for "..var.."s with the keyword '"..value.."'.")
end

function TrinityAdmin:SearchReset()
  ma_searcheditbox:SetScript("OnTextChanged", function() end)
  ma_var1editbox:SetScript("OnTextChanged", function() end)
  ma_searcheditbox:SetText("")
  ma_var1editbox:SetText("")
  ma_var2editbox:SetText("")
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  self.db.char.requests.item = false
  self.db.char.requests.favitem = false
  self.db.char.requests.itemset = false
  self.db.char.requests.favitemset = false
  self.db.char.requests.spell = false
  self.db.char.requests.favspell = false
  self.db.char.requests.skill = false
  self.db.char.requests.favskill = false
  self.db.char.requests.quest = false
  self.db.char.requests.favquest = false
  self.db.char.requests.creature = false
  self.db.char.requests.favcreature = false
  self.db.char.requests.object = false
  self.db.char.requests.favobject = false
  self.db.char.requests.tele = false
  self.db.char.requests.favtele = false
  self.db.char.requests.toggle = false
  self.db.account.buffer.items = {}
  self.db.account.buffer.itemsets = {}
  self.db.account.buffer.spells = {}
  self.db.account.buffer.skills = {}
  self.db.account.buffer.quests = {}
  self.db.account.buffer.creatures = {}
  self.db.account.buffer.objects = {}
  self.db.account.buffer.teles = {}
  self.db.account.buffer.counter = 0
  PopupScrollUpdate()
end

function TrinityAdmin:PrepareScript(object, text, script)
  --if object then
    if text then
      if self.db.account.style.showtooltips then
        object:SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetText(text); GameTooltip:Show() end)
        object:SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
      end
    end
    if type(script) == "function" then
      object:SetScript("OnClick", script)
    elseif type(script) == "table" then
      for k,v in pairs(script) do
        object:SetScript(unpack(v))
      end
    end
  --end
end

--[[INITIALIZION FUNCTIONS]]
function TrinityAdmin:InitButtons()
  -- start tab buttons
  self:PrepareScript(ma_tabbutton_main       , Locale["tt_MainButton"]         , function() TrinityAdmin:InstantGroupToggle("main") end)
  self:PrepareScript(ma_tabbutton_char       , Locale["tt_CharButton"]         , function() TrinityAdmin:InstantGroupToggle("char") end)
  self:PrepareScript(ma_tabbutton_npc        , Locale["tt_NpcButton"]          , function() TrinityAdmin:InstantGroupToggle("npc"); end)
  self:PrepareScript(ma_tabbutton_go         , Locale["tt_GOButton"]           , function() TrinityAdmin:InstantGroupToggle("go"); end)
  self:PrepareScript(ma_tabbutton_tele       , Locale["tt_TeleButton"]         , function() TrinityAdmin:InstantGroupToggle("tele"); end)
  self:PrepareScript(ma_tabbutton_ticket     , Locale["tt_TicketButton"]       , function() TrinityAdmin:ShowTicketTab() end)
  self:PrepareScript(ma_tabbutton_misc       , Locale["tt_MiscButton"]         , function() TrinityAdmin:InstantGroupToggle("misc") end)
  self:PrepareScript(ma_tabbutton_server     , Locale["tt_ServerButton"]       , function() TrinityAdmin:InstantGroupToggle("server") end)
  self:PrepareScript(ma_tabbutton_log        , Locale["tt_LogButton"]          , function() TrinityAdmin:InstantGroupToggle("log") end)
  --end tab buttons
  -- start mini buttons
  self:PrepareScript(ma_mm_logoframe         , nil                             , function() TrinityAdmin:OnClick() end)
  self:PrepareScript(ma_mm_mainbutton        , Locale["tt_MainButton"]         , function() TrinityAdmin:InstantGroupToggle("main") end)
  self:PrepareScript(ma_mm_charbutton        , Locale["tt_CharButton"]         , function() TrinityAdmin:InstantGroupToggle("char") end)
  self:PrepareScript(ma_mm_npcbutton         , Locale["tt_NpcButton"]          , function() TrinityAdmin:InstantGroupToggle("npc") end)
  self:PrepareScript(ma_mm_gobutton          , Locale["tt_GOButton"]           , function() TrinityAdmin:InstantGroupToggle("go") end)
  self:PrepareScript(ma_mm_telebutton        , Locale["tt_TeleButton"]         , function() TrinityAdmin:InstantGroupToggle("tele") end)
  self:PrepareScript(ma_mm_ticketbutton      , Locale["tt_TicketButton"]       , function() TrinityAdmin:ShowTicketTab() end)
  self:PrepareScript(ma_mm_miscbutton        , Locale["tt_MiscButton"]         , function() TrinityAdmin:InstantGroupToggle("misc") end)
  self:PrepareScript(ma_mm_serverbutton      , Locale["tt_ServerButton"]       , function() TrinityAdmin:InstantGroupToggle("server") end)
  self:PrepareScript(ma_mm_logbutton         , Locale["tt_LogButton"]          , function() TrinityAdmin:InstantGroupToggle("log") end)
  --end mini buttons
  self:PrepareScript(ma_languagebutton       , Locale["tt_LanguageButton"]     , function() TrinityAdmin:ChangeLanguage(UIDropDownMenu_GetSelectedValue(ma_languagedropdown)) end)
  self:PrepareScript(ma_speedslider          , Locale["tt_SpeedSlider"]        , {{"OnMouseUp", function() TrinityAdmin:SetSpeed() end},{"OnValueChanged", function() ma_speedsliderText:SetText(string.format("%.1f", ma_speedslider:GetValue())) end}})
  self:PrepareScript(ma_scaleslider          , Locale["tt_ScaleSlider"]        , {{"OnMouseUp", function() TrinityAdmin:SetScale() end},{"OnValueChanged", function() ma_scalesliderText:SetText(string.format("%.1f", ma_scaleslider:GetValue())) end}})  
  self:PrepareScript(ma_itembutton           , Locale["tt_ItemButton"]         , function() TrinityAdmin:TogglePopup("search", {type = "item"}) end)
  self:PrepareScript(ma_itemsetbutton        , Locale["tt_ItemSetButton"]      , function() TrinityAdmin:TogglePopup("search", {type = "itemset"}) end)
  self:PrepareScript(ma_spellbutton          , Locale["tt_SpellButton"]        , function() TrinityAdmin:TogglePopup("search", {type = "spell"}) end)
  self:PrepareScript(ma_skillbutton          , Locale["tt_SkillButton"]        , function() TrinityAdmin:TogglePopup("search", {type = "skill"}) end)
  self:PrepareScript(ma_questbutton          , Locale["tt_QuestButton"]        , function() TrinityAdmin:TogglePopup("search", {type = "quest"}) end)
  self:PrepareScript(ma_creaturebutton       , Locale["tt_CreatureButton"]     , function() TrinityAdmin:TogglePopup("search", {type = "creature"}) end)
  self:PrepareScript(ma_objectbutton         , Locale["tt_ObjectButton"]       , function() TrinityAdmin:TogglePopup("search", {type = "object"}) end)
  self:PrepareScript(ma_telesearchbutton     , Locale["ma_TeleSearchButton"]   , function() TrinityAdmin:TogglePopup("search", {type = "tele"}) end)
  self:PrepareScript(ma_sendmailbutton       , Locale["ma_Mail"]               , function() TrinityAdmin:TogglePopup("mail", {}) end)
  self:PrepareScript(ma_screenshotbutton     , Locale["tt_ScreenButton"]       , function() TrinityAdmin:Screenshot() end)
  self:PrepareScript(ma_displaylevelbutton   , Locale["tt_DisplayAccountLvl"]  , function() TrinityAdmin:ChatMsg(".acct") end)
  self:PrepareScript(ma_gmonbutton           , Locale["tt_GMOnButton"]         , function() TrinityAdmin:ToggleGMMode("on") end)
  self:PrepareScript(ma_gmoffbutton          , Locale["tt_GMOffButton"]        , function() TrinityAdmin:ToggleGMMode("off") end)
  self:PrepareScript(ma_flyonbutton          , Locale["tt_FlyOnButton"]        , function() TrinityAdmin:ToggleFlyMode("on") end)
  self:PrepareScript(ma_flyoffbutton         , Locale["tt_FlyOffButton"]       , function() TrinityAdmin:ToggleFlyMode("off") end)
  self:PrepareScript(ma_hoveronbutton        , Locale["tt_HoverOnButton"]      , function() TrinityAdmin:ToggleHoverMode(1) end)
  self:PrepareScript(ma_hoveroffbutton       , Locale["tt_HoverOffButton"]     , function() TrinityAdmin:ToggleHoverMode(0) end)
  self:PrepareScript(ma_whisperonbutton      , Locale["tt_WhispOnButton"]      , function() TrinityAdmin:ToggleWhisper("on") end)
  self:PrepareScript(ma_whisperoffbutton     , Locale["tt_WhispOffButton"]     , function() TrinityAdmin:ToggleWhisper("off") end)
  self:PrepareScript(ma_invisibleonbutton    , Locale["tt_InvisOnButton"]      , function() TrinityAdmin:ToggleVisible("off") end)
  self:PrepareScript(ma_invisibleoffbutton   , Locale["tt_InvisOffButton"]     , function() TrinityAdmin:ToggleVisible("on") end)
  self:PrepareScript(ma_taxicheatonbutton    , Locale["tt_TaxiOnButton"]       , function() TrinityAdmin:ToggleTaxicheat("on") end)
  self:PrepareScript(ma_taxicheatoffbutton   , Locale["tt_TaxiOffButton"]      , function() TrinityAdmin:ToggleTaxicheat("off") end)
  self:PrepareScript(ma_ticketonbutton       , Locale["tt_TicketOn"]           , function() TrinityAdmin:ToggleTickets("on") end)
  self:PrepareScript(ma_ticketoffbutton      , Locale["tt_TicketOff"]          , function() TrinityAdmin:ToggleTickets("off") end)
  self:PrepareScript(ma_mapsonbutton         , Locale["tt_ShowMapsButton"]     , function() TrinityAdmin:ToggleMaps(1) end)
  self:PrepareScript(ma_mapsoffbutton        , Locale["tt_HideMapsButton"]     , function() TrinityAdmin:ToggleMaps(0) end)
  self:PrepareScript(ma_bankbutton           , Locale["tt_BankButton"]         , function() TrinityAdmin:ChatMsg(".bank") end)
  self:PrepareScript(ma_r1c1button           , Locale["tt_r1c1Button"]         , function() TrinityAdmin:QuickCommand(1) end)
  self:PrepareScript(ma_r1c2button           , Locale["tt_r1c2Button"]         , function() TrinityAdmin:QuickCommand(2) end)
  self:PrepareScript(ma_r1c3button           , Locale["tt_r1c3Button"]         , function() TrinityAdmin:QuickCommand(3) end)
  self:PrepareScript(ma_r1c4button           , Locale["tt_r1c4Button"]         , function() TrinityAdmin:QuickCommand(4) end)
  self:PrepareScript(ma_r2c1button           , Locale["tt_r2c1Button"]         , function() TrinityAdmin:QuickCommand(5) end)
  self:PrepareScript(ma_r2c2button           , Locale["tt_r2c2Button"]         , function() TrinityAdmin:QuickCommand(6) end)
  self:PrepareScript(ma_r2c3button           , Locale["tt_r2c3Button"]         , function() TrinityAdmin:QuickCommand(7) end)
  self:PrepareScript(ma_r2c4button           , Locale["tt_r2c4Button"]         , function() TrinityAdmin:QuickCommand(8) end)
  self:PrepareScript(ma_r3c1button           , Locale["tt_r3c1Button"]         , function() TrinityAdmin:QuickCommand(9) end)
  self:PrepareScript(ma_r3c2button           , Locale["tt_r3c2Button"]         , function() TrinityAdmin:QuickCommand(10) end)
  self:PrepareScript(ma_r3c3button           , Locale["tt_r3c3Button"]         , function() TrinityAdmin:QuickCommand(11) end)
  self:PrepareScript(ma_r3c4button           , Locale["tt_r3c4Button"]         , function() TrinityAdmin:QuickCommand(12) end)
  self:PrepareScript(ma_r4c1button           , Locale["tt_r4c1Button"]         , function() TrinityAdmin:QuickCommand(13) end)
  self:PrepareScript(ma_r4c2button           , Locale["tt_r4c2Button"]         , function() TrinityAdmin:QuickCommand(14) end)
  self:PrepareScript(ma_r4c3button           , Locale["tt_r4c3Button"]         , function() TrinityAdmin:QuickCommand(15) end)
  self:PrepareScript(ma_r4c4button           , Locale["tt_r4c4Button"]         , function() TrinityAdmin:QuickCommand(16) end)
  self:PrepareScript(ma_r4c5button           , Locale["tt_r4c5Button"]         , function() TrinityAdmin:QuickCommand(17) end)
  self:PrepareScript(ma_setjail_a_button     , Locale["tt_SetJail_A_Button"]   , function() TrinityAdmin:SetJail_A() end)
  self:PrepareScript(ma_setjail_h_button     , Locale["tt_SetJail_H_Button"]   , function() TrinityAdmin:SetJail_H() end)
  self:PrepareScript(ma_jailabutton          , Locale["tt_JailAButton"]        , function() TrinityAdmin:JailA() end)
  self:PrepareScript(ma_jailhbutton          , Locale["tt_JailHButton"]        , function() TrinityAdmin:JailH() end)
  self:PrepareScript(ma_unjailbutton         , Locale["tt_UnJailButton"]       , function() TrinityAdmin:UnJail() end)
  --self:PrepareScript(ma_learnallbutton       , nil                             , function() TrinityAdmin:LearnSpell("all") end)
  --self:PrepareScript(ma_learncraftsbutton    , nil                             , function() TrinityAdmin:LearnSpell("all_crafts") end)
  --self:PrepareScript(ma_learngmbutton        , nil                             , function() TrinityAdmin:LearnSpell("all_gm") end)
  --self:PrepareScript(ma_learnlangbutton      , nil                             , function() TrinityAdmin:LearnSpell("all_lang") end)
  --self:PrepareScript(ma_learnclassbutton     , nil                             , function() TrinityAdmin:LearnSpell("all_myclass") end)
  self:PrepareScript(ma_modifybutton         , nil                             , function() TrinityAdmin:Modify(UIDropDownMenu_GetSelectedValue(ma_modifydropdown),ma_modifyeditbox:GetText()) end)
  self:PrepareScript(ma_searchbutton         , nil                             , function() TrinityAdmin:SearchStart("item", ma_searcheditbox:GetText()) end)
  self:PrepareScript(ma_resetsearchbutton    , nil                             , function() TrinityAdmin:SearchReset() end)
  self:PrepareScript(ma_revivebutton         , nil                             , function() TrinityAdmin:RevivePlayer() end)
  self:PrepareScript(ma_killbutton           , nil                             , function() TrinityAdmin:KillSomething() end)
  self:PrepareScript(ma_npckillbutton        , nil                             , function() TrinityAdmin:KillSomething() end)
  self:PrepareScript(ma_savebutton           , nil                             , function() TrinityAdmin:SavePlayer() end)
  self:PrepareScript(ma_dismountbutton       , nil                             , function() TrinityAdmin:DismountPlayer() end)
  self:PrepareScript(ma_kickbutton           , Locale["tt_KickButton"]         , function() TrinityAdmin:KickPlayer() end)
  self:PrepareScript(ma_cooldownbutton       , Locale["tt_CooldownButton"]     , function() TrinityAdmin:Cooldown() end)
  self:PrepareScript(ma_demorphbutton        , Locale["tt_DemorphButton"]      , function() TrinityAdmin:Demorph() end)
  self:PrepareScript(ma_showmapsbutton       , Locale["tt_ShowMapsButton"]     , function() TrinityAdmin:ToggleMaps(1) end)
  self:PrepareScript(ma_hidemapsbutton       , Locale["tt_HideMapsButton"]     , function() TrinityAdmin:ToggleMaps(0) end)
  self:PrepareScript(ma_gpsbutton            , Locale["tt_GPSButton"]          , function() TrinityAdmin:GPS() end)
  self:PrepareScript(ma_guidbutton           , Locale["tt_GUIDButton"]         , function() TrinityAdmin:ShowGUID() end)
  self:PrepareScript(ma_npcguidbutton        , Locale["tt_GUIDButton"]         , function() TrinityAdmin:ShowGUID() end)
  self:PrepareScript(ma_movestackbutton      , Locale["tt_MoveStackButton"]    , function() TrinityAdmin:ShowMove() end)
  self:PrepareScript(ma_npcfreezebutton      , Locale["tt_NPCFreezeButton"]    , function() TrinityAdmin:NPCFreeze() end)
  self:PrepareScript(ma_npcunfreeze_randombutton , Locale["tt_NPCUnFreeze_RandomButton"]  , function() TrinityAdmin:NPCUnFreeze_Random() end)
  self:PrepareScript(ma_npcunfreeze_waybutton , Locale["tt_NPCUnFreeze_WayButton"]  , function() TrinityAdmin:NPCUnFreeze_Way() end)
  self:PrepareScript(ma_npcinfobutton        , Locale["tt_NPCInfoButton"]      , function() TrinityAdmin:NPCInfo() end)
  self:PrepareScript(ma_pinfobutton          , Locale["tt_PinfoButton"]        , function() TrinityAdmin:Pinfo() end)
  self:PrepareScript(ma_npcdistancebutton    , Locale["tt_DistanceButton"]     , function() TrinityAdmin:Distance() end)
  self:PrepareScript(ma_distancebutton       , Locale["tt_DistanceButton"]     , function() TrinityAdmin:Distance() end)
  self:PrepareScript(ma_recallbutton         , Locale["tt_RecallButton"]       , function() TrinityAdmin:Recall() end)
  self:PrepareScript(ma_respawnbutton        , nil                             , function() TrinityAdmin:Respawn() end)
  self:PrepareScript(ma_gridnaviaheadbutton  , nil                             , function() TrinityAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "ahead" end)
  self:PrepareScript(ma_gridnavibackbutton   , nil                             , function() TrinityAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "back" end)
  self:PrepareScript(ma_gridnavirightbutton  , nil                             , function() TrinityAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "right" end)
  self:PrepareScript(ma_gridnavileftbutton   , nil                             , function() TrinityAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "left" end)
  self:PrepareScript(ma_announcebutton       , Locale["tt_AnnounceButton"]     , function() TrinityAdmin:Announce(ma_announceeditbox:GetText()) end)
  self:PrepareScript(ma_resetannouncebutton  , nil                             , function() ma_announceeditbox:SetText("") end)
  self:PrepareScript(ma_shutdownbutton       , Locale["tt_ShutdownButton"]     , function() TrinityAdmin:Shutdown(ma_shutdowneditbox:GetText()) end)
  self:PrepareScript(ma_closebutton          , nil                             , function() TrinityAdmin:CloseButton("bg") end)
  self:PrepareScript(ma_popupclosebutton     , nil                             , function() TrinityAdmin:CloseButton("popup") end)
  self:PrepareScript(ma_popup2closebutton    , nil                             , function() TrinityAdmin:CloseButton("popup2") end)
  --self:PrepareScript(ma_showticketsbutton    , nil                             , function() TrinityAdmin:TogglePopup("search", {type = "ticket"}); TrinityAdmin:LoadTickets() end)
  self:PrepareScript(ma_showticketsbutton    , nil                             , function() TrinityAdmin:LoadTickets() end)
  self:PrepareScript(ma_deleteticketbutton   , nil                             , function() TrinityAdmin:Ticket("delete") end)
  self:PrepareScript(ma_answerticketbutton   , nil                             , function() TrinityAdmin:Ticket("answer") end)
  self:PrepareScript(ma_getcharticketbutton  , nil                             , function() TrinityAdmin:Ticket("getchar") end)
  self:PrepareScript(ma_gocharticketbutton   , nil                             , function() TrinityAdmin:Ticket("gochar") end)
  self:PrepareScript(ma_whisperticketbutton  , nil                             , function() TrinityAdmin:Ticket("whisper") end)
  self:PrepareScript(ma_bgcolorshowbutton    , nil                             , function() TrinityAdmin:ShowColorPicker("bg") end)
  self:PrepareScript(ma_frmcolorshowbutton   , nil                             , function() TrinityAdmin:ShowColorPicker("frm") end)
  self:PrepareScript(ma_btncolorshowbutton   , nil                             , function() TrinityAdmin:ShowColorPicker("btn") end)
  self:PrepareScript(ma_linkifiercolorbutton , nil                             , function() TrinityAdmin:ShowColorPicker("linkifier") end)
  self:PrepareScript(ma_applystylebutton     , nil                             , function() TrinityAdmin:ApplyStyleChanges() end)
  self:PrepareScript(ma_loadtablebutton      , nil                             , function() TrinityAdmin:ReloadTable(UIDropDownMenu_GetSelectedValue(ma_reloadtabledropdown)) end)
  self:PrepareScript(ma_loadscriptsbutton    , nil                             , function() TrinityAdmin:ReloadScripts() end)
  self:PrepareScript(ma_changeweatherbutton  , nil                             , function() TrinityAdmin:ChangeWeather(UIDropDownMenu_GetSelectedValue(ma_weatherdropdown)) end)
  self:PrepareScript(ma_resetbutton          , nil                             , function() TrinityAdmin:Reset(UIDropDownMenu_GetSelectedValue(ma_resetdropdown)) end)
  self:PrepareScript(ma_learnlangbutton      , nil                             , function() TrinityAdmin:LearnSpell(UIDropDownMenu_GetSelectedValue(ma_learnlangdropdown)) end)
  self:PrepareScript(ma_inforefreshbutton    , nil                             , function() TrinityAdmin:ChatMsg(".server info") end)
  self:PrepareScript(ma_modelrotatelbutton   , Locale["tt_RotateLeft"]         , function() TrinityAdmin:ModelRotateLeft() end)
  self:PrepareScript(ma_modelrotaterbutton   , Locale["tt_RotateRight"]        , function() TrinityAdmin:ModelRotateRight() end)
  self:PrepareScript(ma_npcmodelrotatelbutton   , Locale["tt_RotateLeft"]      , function() TrinityAdmin:NpcModelRotateLeft() end)
  self:PrepareScript(ma_npcmodelrotaterbutton   , Locale["tt_RotateRight"]     , function() TrinityAdmin:NpcModelRotateRight() end)
  self:PrepareScript(ma_frmtrslider          , Locale["tt_FrmTrSlider"]        , {{"OnMouseUp", function() TrinityAdmin:ChangeTransparency("frames") end},{"OnValueChanged", function() ma_frmtrsliderText:SetText(string.format("%.2f", ma_frmtrslider:GetValue())) end}})  
  self:PrepareScript(ma_btntrslider          , Locale["tt_BtnTrSlider"]        , {{"OnMouseUp", function() TrinityAdmin:ChangeTransparency("buttons") end},{"OnValueChanged", function() ma_btntrsliderText:SetText(string.format("%.2f", ma_btntrslider:GetValue())) end}})  
  self:PrepareScript(ma_instantkillbutton    , nil                             , function() self.db.char.instantKillMode = ma_instantkillbutton:GetChecked() end)
  self:PrepareScript(ma_mm_revivebutton      , nil                             , function() SendChatMessage(".revive", "GUILD", nil, nil) end)
  self:PrepareScript(ma_ContScrollBarEntry1      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "EK_N"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry2      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "EK_S"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry3      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "K"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry4      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "Ou"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry5      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "BG"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry6      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "I_EK"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry7      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "I_K"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry8      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "I_O"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry9      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "Ot"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
  self:PrepareScript(ma_ContScrollBarEntry10      , nil                      , function() 
    TrinityAdmin.db.char.selectedCont = "J"
    cont=TrinityAdmin.db.char.selectedCont
    TrinityAdmin:TeleScrollUpdate() 
    end)
end

function TrinityAdmin:InitDropDowns()
  local function LangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {"Czech","csCZ"},
      {"German","deDE"},
      {"Dutch","nlNL"},
      {"English","enUS"},
      {"Spanish","esES"},
      {"Finnish","fiFI"},
      {"French","frFR"},
      {"Hungarian","huHU"},
      {"Italian","itIT"},
      {"Lithuanian","liLI"},
      {"Polish","plPL"},
      {"Portuguese","ptPT"},
      {"Romanian","roRO"},
      {"Russian","ruRU"},
      {"Swedish","svSV"},
      {"Chinese","zhCN"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_languagedropdown, this.value) end
      info.checked = nil
      --info.notCheckable = true
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_languagedropdown, Locale:GetLocale())
  end
  UIDropDownMenu_Initialize(ma_languagedropdown, LangDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_languagedropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_languagedropdown)
  -- WEATHER
  local function WeatherDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_WeatherFine"],"0 0"},
      {Locale["ma_WeatherFog"],"0 1"},
      {Locale["ma_WeatherRain"],"1 1"},
      {Locale["ma_WeatherSnow"],"2 1"},
      {Locale["ma_WeatherSand"],"3 1"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_weatherdropdown, this.value) end
      info.checked = nil
      --info.notCheckable = true
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_weatherdropdown, "0 0")
  end  
  UIDropDownMenu_Initialize(ma_weatherdropdown, WeatherDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_weatherdropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_weatherdropdown)
  -- RELOAD TABLES
  local function ReloadTableDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = { -- data taken from source code
      {"all","all"},
      {"all_area","all_area"},
      {"all_loot","all_loot"},
      {"all_quest","all_quest"},
      {"all_spell","all_spell"},
      {"areatrigger_tavern","areatrigger_tavern"},
      {"areatrigger_teleport","areatrigger_teleport"},
      {"command","command"},
      {"creature_questrelation","creature_questrelation"},
      {"creature_involvedrelation","creature_involvedrelation"},
      {"gameobject_questrelation","gameobject_questrelation"},
      {"gameobject_involvedrelation","gameobject_involvedrelation"},
      {"areatrigger_involvedrelation","areatrigger_involvedrelation"},
      {"quest_template","quest_template"},
      {"creature_loot_template","creature_loot_template"},
      {"disenchant_loot_template","disenchant_loot_template"},
      {"fishing_loot_template","fishing_loot_template"},
      {"gameobject_loot_template","gameobject_loot_template"},
      {"item_loot_template","item_loot_template"},
      {"pickpocketing_loot_template","pickpocketing_loot_template"},
      {"prospecting_loot_template","prospecting_loot_template"},
      {"skinning_loot_template","skinning_loot_template"},
      {"reserved_name","reserved_name"},
      {"skill_discovery_template","skill_discovery_template"},
      {"skill_extra_item_template","skill_extra_item_template"},
      {"spell_affect","spell_affect"},
      {"spell_chain","spell_chain"},
      {"spell_learn_skill","spell_learn_skill"},
      {"spell_learn_spell","spell_learn_spell"},
      {"spell_proc_event","spell_proc_event"},
      {"spell_script_target","spell_script_target"},
      {"spell_target_position","spell_target_position"},
      {"button_scripts","button_scripts"},
      {"quest_end_scripts","quest_end_scripts"},
      {"quest_start_scripts","quest_start_scripts"},
      {"spell_scripts","spell_scripts"},
      {"game_graveyard_zone","game_graveyard_zone"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.checked = nil
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_reloadtabledropdown, this.value) end
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_reloadtabledropdown, "all")
  end  
  UIDropDownMenu_Initialize(ma_reloadtabledropdown, ReloadTableDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_reloadtabledropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_reloadtabledropdown)
  -- MODIFY
  local function ModifyDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_LevelUp"],"levelup"},
      {Locale["ma_LevelDown"],"leveldown"},
      {Locale["ma_Money"],"money"},
      {Locale["ma_Energy"],"energy"},
      {Locale["ma_Rage"],"rage"},
      {Locale["ma_Mana"],"mana"},
      {Locale["ma_Healthpoints"],"health"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_modifydropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_modifydropdown, "levelup")
  end  
  UIDropDownMenu_Initialize(ma_modifydropdown, ModifyDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_modifydropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_modifydropdown)
  -- RESET
  local function ResetDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_Talents"],"talents"},
      {Locale["ma_Stats"],"stats"},
      {Locale["ma_Spells"],"spells"},
      {Locale["ma_Honor"],"honor"},
      {Locale["ma_Level"],"level"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_resetdropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_resetdropdown, "talents")
  end  
  UIDropDownMenu_Initialize(ma_resetdropdown, ResetDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_resetdropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_resetdropdown)
  -- LEARN LANG
  local function LearnLangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_AllLang"],"all_lang"},
      {Locale["Common"],"668"},
      {Locale["Orcish"],"669"},
      {Locale["Taurahe"],"670"},
      {Locale["Darnassian"],"671"},
      {Locale["Dwarvish"],"672"},
      {Locale["Thalassian"],"813"},
      {Locale["Demonic"],"815"},
      {Locale["Draconic"],"814"},
      {Locale["Titan"],"816"},
      {Locale["Kalimag"],"817"},
      {Locale["Gnomish"],"7340"},
      {Locale["Troll"],"7341"},
      {Locale["Gutterspeak"],"17737"},
      {Locale["Draenei"],"29932"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_learnlangdropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_learnlangdropdown, "all_lang")
  end  
  UIDropDownMenu_Initialize(ma_learnlangdropdown, LearnLangDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_learnlangdropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_learnlangdropdown)
end

function TrinityAdmin:InitSliders()
  -- Speed Slider
  ma_speedslider:SetOrientation("HORIZONTAL")
  ma_speedslider:SetMinMaxValues(1, 10)
  ma_speedslider:SetValueStep(0.1)
  ma_speedslider:SetValue(1)
  ma_speedsliderText:SetText("1.0")
  -- Scale Slider
  ma_scaleslider:SetOrientation("HORIZONTAL")
  ma_scaleslider:SetMinMaxValues(0.1, 3)
  ma_scaleslider:SetValueStep(0.1)
  ma_scaleslider:SetValue(1)
  ma_scalesliderText:SetText("1.0")
  -- Frame Transparency Slider
  ma_frmtrslider:SetOrientation("HORIZONTAL")
  ma_frmtrslider:SetMinMaxValues(0.1, 1.0)
  ma_frmtrslider:SetValueStep(0.05)
  ma_frmtrslider:SetValue(TrinityAdmin.db.account.style.transparency.frames)
  ma_frmtrsliderText:SetText(string.format("%.2f", TrinityAdmin.db.account.style.transparency.frames))
  -- Button Transparency Slider
  ma_btntrslider:SetOrientation("HORIZONTAL")
  ma_btntrslider:SetMinMaxValues(0.1, 1.0)
  ma_btntrslider:SetValueStep(0.05)
  ma_btntrslider:SetValue(TrinityAdmin.db.account.style.transparency.buttons)
  ma_btntrsliderText:SetText(string.format("%.2f", TrinityAdmin.db.account.style.transparency.buttons))
end

function TrinityAdmin:InitScrollFrames()
  cont = TrinityAdmin.db.char.selectedCont
  ma_PopupScrollBar:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(30, PopupScrollUpdate) end)
  ma_PopupScrollBar:SetScript("OnShow", function() PopupScrollUpdate() end)
  ma_ZoneScrollBar:SetScript("OnVerticalScroll", function() 
    --cont = TrinityAdmin.db.char.selectedCont 
    FauxScrollFrame_OnVerticalScroll(16, self:TeleScrollUpdate()) 
    end)
  ma_ZoneScrollBar:SetScript("OnShow", function() self:TeleScrollUpdate() end)
  ma_SubzoneScrollBar:SetScript("OnVerticalScroll", function() 
    --cont = TrinityAdmin.db.char.selectedCont
    --self:ChatMsg("Loaded cont:" ..cont)
    FauxScrollFrame_OnVerticalScroll(16, self:SubzoneScrollUpdate()) 
    end)
  ma_SubzoneScrollBar:SetScript("OnShow", function() self:SubzoneScrollUpdate() end)
  ma_ticketscrollframe:SetScrollChild(ma_ticketeditbox)
  self:PrepareScript(ma_ticketeditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
  ma_mailscrollframe:SetScrollChild(ma_maileditbox)
  self:PrepareScript(ma_maileditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged(); TrinityAdmin:UpdateMailBytesLeft() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
  ma_logframe:SetScript("OnUpdate", function() TrinityAdminLogOnUpdate(arg1) end)
end

function TrinityAdmin:InitModelFrame()
  ma_modelframe:SetScript("OnUpdate", function() TrinityAdminModelOnUpdate(arg1) end)
  ma_modelframe.rotation = 0.61;
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  ma_modelframe:SetUnit("player")
  ma_npcmodelframe:SetScript("OnUpdate", function() TrinityAdminNpcModelOnUpdate(arg1) end)
  ma_npcmodelframe.rotation = 0.61;
  ma_npcmodelframe:SetRotation(ma_npcmodelframe.rotation)
  ma_npcmodelframe:SetUnit("player")

end

function TrinityAdmin:NpcModelChanged()
  if not self:Selection("none") then
    ma_npcmodelframe:SetUnit("target")
  else
    ma_npcmodelframe:SetUnit("player")
  end
  ma_npcmodelframe:RefreshUnit()
end

function TrinityAdmin:ModelChanged()
  if not self:Selection("none") then
    ma_modelframe:SetUnit("target")
  else
    ma_modelframe:SetUnit("player")
  end
  ma_modelframe:RefreshUnit()
end

function TrinityAdminNpcModelOnUpdate(elapsedTime)
  if ( ma_npcmodelrotatelbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation + (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation < 0 ) then
      this.rotation = this.rotation + (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
  if ( ma_npcmodelrotaterbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation - (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation > (2 * PI) ) then
      this.rotation = this.rotation - (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
end

function TrinityAdminModelOnUpdate(elapsedTime)
  if ( ma_modelrotatelbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation + (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation < 0 ) then
      this.rotation = this.rotation + (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
  if ( ma_modelrotaterbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation - (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation > (2 * PI) ) then
      this.rotation = this.rotation - (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
end

function TrinityAdminLogOnUpdate(elapsedTime)
  if ( ma_logscrollupbutton:GetButtonState() == "PUSHED" ) then
    ma_logframe:ScrollUp()
  end
  if ( ma_logscrolldownbutton:GetButtonState() == "PUSHED" ) then
    ma_logframe:ScrollDown()
  end
end

function TrinityAdmin:NpcModelRotateLeft()
  ma_npcmodelframe.rotation = ma_npcmodelframe.rotation - 0.03
  ma_npcmodelframe:SetRotation(ma_npcmodelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function TrinityAdmin:ModelRotateLeft()
  ma_modelframe.rotation = ma_modelframe.rotation - 0.03
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function TrinityAdmin:NpcModelRotateRight()
  ma_npcmodelframe.rotation = ma_npcmodelframe.rotation + 0.03
  ma_npcmodelframe:SetRotation(ma_npcmodelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function TrinityAdmin:ModelRotateRight()
  ma_modelframe.rotation = ma_modelframe.rotation + 0.03
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function TrinityAdmin:NoResults(var)
  if var == "ticket" then
    -- Reset list and make an entry "No Tickets"
    self:LogAction(Locale["ma_TicketsNoTickets"])
    ma_ticketeditbox:SetText(Locale["ma_TicketsNoTickets"])
    FauxScrollFrame_Update(ma_ZoneScrollBar,12,12,30)
    for line = 1,12 do
      getglobal("ma_ZoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_ZoneScrollBarEntry"..line):SetText(Locale["ma_TicketsNoTickets"])
        getglobal("ma_ZoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_ZoneScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "search" then
    ma_lookupresulttext:SetText(Locale["searchResults"].."0")
    FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30)
    for line = 1,7 do
      getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
      getglobal("ma_PopupScrollBarEntry"..line):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
      if line == 1 then
        getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["tt_SearchDefault"])
        getglobal("ma_PopupScrollBarEntry"..line):Show()
      else
        getglobal("ma_PopupScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "favorites" then
    ma_lookupresulttext:SetText(Locale["favoriteResults"].."0")
    FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30)
    for line = 1,7 do
      getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
      getglobal("ma_PopupScrollBarEntry"..line):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
      if line == 1 then
        getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["ma_NoFavorites"])
        getglobal("ma_PopupScrollBarEntry"..line):Show()
      else
        getglobal("ma_PopupScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "zones" then
    FauxScrollFrame_Update(ma_ZoneScrollBar,12,12,16)
    for line = 1,12 do
      getglobal("ma_ZoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_ZoneScrollBarEntry"..line):SetText(Locale["ma_NoZones"])
        getglobal("ma_ZoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_ZoneScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "subzones" then
    FauxScrollFrame_Update(ma_SubzoneScrollBar,12,12,16)
    for line = 1,12 do
      getglobal("ma_SubzoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_SubzoneScrollBarEntry"..line):SetText(Locale["ma_NoSubZones"])
        getglobal("ma_SubzoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_SubzoneScrollBarEntry"..line):Hide()
      end
    end
  end
end

function PopupScrollUpdate()
  local line -- 1 through 7 of our window to scroll
  local lineplusoffset -- an index into our data calculated from the scroll offset
  
  if TrinityAdmin.db.char.requests.item or TrinityAdmin.db.char.requests.favitem then --get items
    local count = 0
    if TrinityAdmin.db.char.requests.item then
      table.foreachi(TrinityAdmin.db.account.buffer.items, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favitem then
      table.foreachi(TrinityAdmin.db.account.favorites.items, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local item
          if TrinityAdmin.db.char.requests.item then
            item = TrinityAdmin.db.account.buffer.items[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favitem then
            item = TrinityAdmin.db.account.favorites.items[lineplusoffset]
          end
          local key = lineplusoffset
          --item icons
          getglobal("ma_PopupScrollBarEntryIcon"..line.."IconTexture"):SetTexture(GetItemIcon(item["itId"]))
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnClick", function() TrinityAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):Show()
          --item description
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..item["itId"].."|r Name: |cffffffff"..item["itName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.item then
            if item["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.items[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.items[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favitem then
            if item["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.items[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.items[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(item["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.item then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favitem then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.itemset or TrinityAdmin.db.char.requests.favitemset then --get itemsets
    local count = 0
    if TrinityAdmin.db.char.requests.itemset then
      table.foreachi(TrinityAdmin.db.account.buffer.itemsets, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favitemset then
      table.foreachi(TrinityAdmin.db.account.favorites.itemsets, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local itemset
          if TrinityAdmin.db.char.requests.itemset then
            itemset = TrinityAdmin.db.account.buffer.itemsets[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favitemset then
            itemset = TrinityAdmin.db.account.favorites.itemsets[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..itemset["isId"].."|r Name: |cffffffff"..itemset["isName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:AddItemSet(itemset["isId"]) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.itemset then
            if itemset["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.itemsets[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.itemsets[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favitemset then
            if itemset["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.itemsets[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.itemsets[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(itemset["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.itemset then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favitemset then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.quest or TrinityAdmin.db.char.requests.favquest then --get quests
    local count = 0
    if TrinityAdmin.db.char.requests.quest then
      table.foreachi(TrinityAdmin.db.account.buffer.quests, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favquest then
      table.foreachi(TrinityAdmin.db.account.favorites.quests, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local quest
          if TrinityAdmin.db.char.requests.quest then
            quest = TrinityAdmin.db.account.buffer.quests[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favquest then
            quest = TrinityAdmin.db.account.favorites.quests[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..quest["qsId"].."|r Name: |cffffffff"..quest["qsName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:Quest(quest["qsId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.quest then
            if quest["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.quests[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.quests[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favquest then
            if quest["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.quests[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.quests[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(quest["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.quest then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favquest then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.creature or TrinityAdmin.db.char.requests.favcreature then --get creatures
    local count = 0
    if TrinityAdmin.db.char.requests.creature then
      table.foreachi(TrinityAdmin.db.account.buffer.creatures, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favcreature then
      table.foreachi(TrinityAdmin.db.account.favorites.creatures, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local creature
          if TrinityAdmin.db.char.requests.creature then
            creature = TrinityAdmin.db.account.buffer.creatures[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favcreature then
            creature = TrinityAdmin.db.account.favorites.creatures[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..creature["crId"].."|r Name: |cffffffff"..creature["crName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:Creature(creature["crId"], arg1) end) 
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.creature then
            if creature["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.creatures[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.creatures[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favcreature then
            if creature["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.creatures[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.creatures[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(creature["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.creature then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favcreature then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.spell or TrinityAdmin.db.char.requests.favspell then --get spells
    local count = 0
    if TrinityAdmin.db.char.requests.spell then
      table.foreachi(TrinityAdmin.db.account.buffer.spells, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favspell then
      table.foreachi(TrinityAdmin.db.account.favorites.spells, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local spell
          if TrinityAdmin.db.char.requests.spell then
            spell = TrinityAdmin.db.account.buffer.spells[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favspell then
            spell = TrinityAdmin.db.account.favorites.spells[lineplusoffset]
          end
          local key = lineplusoffset
          --spell icon
          --getglobal("ma_PopupScrollBarEntryIcon"..line.."IconTexture"):SetTexture(GetSpellTexture(spell["spId"],BOOKTYPE_SPELL))
          --spell info
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..spell["spId"].."|r Name: |cffffffff"..spell["spName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:LearnSpell(spell["spId"], arg1) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.spell then
            if spell["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.spells[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.spells[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favspell then
            if spell["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.spells[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.spells[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(spell["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.spell then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favspell then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.skill or TrinityAdmin.db.char.requests.favskill then --get skills
    local count = 0
    if TrinityAdmin.db.char.requests.skill then
      table.foreachi(TrinityAdmin.db.account.buffer.skills, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favskill then
      table.foreachi(TrinityAdmin.db.account.favorites.skills, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local skill
          if TrinityAdmin.db.char.requests.skill then
            skill = TrinityAdmin.db.account.buffer.skills[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favskill then
            skill = TrinityAdmin.db.account.favorites.skills[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..skill["skId"].."|r Name: |cffffffff"..skill["skName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:SetSkill(skill["skId"], nil, nil) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.skill then
            if skill["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.skills[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.skills[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favskill then
            if skill["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.skills[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.skills[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(skill["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.skill then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favskill then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.object or TrinityAdmin.db.char.requests.favobject then --get objects
    local count = 0
    if TrinityAdmin.db.char.requests.object then
      table.foreachi(TrinityAdmin.db.account.buffer.objects, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favobject then
      table.foreachi(TrinityAdmin.db.account.favorites.objects, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local object
          if TrinityAdmin.db.char.requests.object then
            object = TrinityAdmin.db.account.buffer.objects[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favobject then
            object = TrinityAdmin.db.account.favorites.objects[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..object["objId"].."|r Name: |cffffffff"..object["objName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:AddObject(object["objId"], arg1) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.object then
            if object["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.objects[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.objects[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favobject then
            if object["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.objects[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.objects[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(object["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.object then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favobject then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  elseif TrinityAdmin.db.char.requests.tele or TrinityAdmin.db.char.requests.favtele then --get teles
    local count = 0
    if TrinityAdmin.db.char.requests.tele then
      table.foreachi(TrinityAdmin.db.account.buffer.teles, function() count = count + 1 end)
    elseif TrinityAdmin.db.char.requests.favtele then
      table.foreachi(TrinityAdmin.db.account.favorites.teles, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30)
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local tele
          if TrinityAdmin.db.char.requests.tele then
            tele = TrinityAdmin.db.account.buffer.teles[lineplusoffset]
          elseif TrinityAdmin.db.char.requests.favtele then
            tele = TrinityAdmin.db.account.favorites.teles[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Name: |cffffffff"..tele["tName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:ChatMsg(".tele "..tele["tName"]) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if TrinityAdmin.db.char.requests.tele then
            if tele["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.teles[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.buffer.teles[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif TrinityAdmin.db.char.requests.favtele then
            if tele["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.teles[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() TrinityAdmin.db.account.favorites.teles[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(tele["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if TrinityAdmin.db.char.requests.tele then
        TrinityAdmin:NoResults("search")
      elseif TrinityAdmin.db.char.requests.favtele then
        TrinityAdmin:NoResults("favorites")
      end
    end
    
  else
    TrinityAdmin:NoResults("search")
  end
end

function InlineScrollUpdate()
  if TrinityAdmin.db.char.requests.ticket then --get tickets
    local ticketCount = 0
    table.foreachi(TrinityAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
    if ticketCount > 0 then
      --FauxScrollFrame_Update(ma_PopupScrollBar,4,7,30) --for paged mode, only load 4 at a time
      FauxScrollFrame_Update(ma_ZoneScrollBar,ticketCount,12,16)
      for line = 1,12 do
        --lineplusoffset = line + ((TrinityAdmin.db.account.tickets.page - 1) * 4)  --for paged mode
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_ZoneScrollBar)
        if lineplusoffset <= ticketCount then
          local object = TrinityAdmin.db.account.buffer.tickets[lineplusoffset]
          getglobal("ma_ZoneScrollBarEntry"..line):SetText("Id: |cffffffff"..object["tNumber"].."|r Cat: |cffffffff"..object["tCat"].."|r Player: |cffffffff"..object["tChar"].."|r")
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnClick", function() 
            ma_ticketeditbox:SetText(object["tMsg"])
            ma_tpinfo_text:SetText(string.format(Locale["ma_TicketTicketLoaded"], object["tNumber"]))
            --TrinityAdmin.db.char.requests.tpinfo = true
            --TrinityAdmin:ChatMsg(".pinfo "..object["tChar"])
            TrinityAdmin:LogAction("Displaying ticket number "..object["tNumber"].." from player "..object["tChar"])
            --TrinityAdmin:LogAction("Loading player info of ticket creator ("..object["tChar"]..")")
            --FrameLib:HandleGroup("popup2", function(frame) frame:Show() end)
            TrinityAdmin.db.account.tickets.selected = object
            ma_deleteticketbutton:Enable()
            ma_answerticketbutton:Enable()
            ma_getcharticketbutton:Enable()
            ma_gocharticketbutton:Enable()
            ma_whisperticketbutton:Enable()
          end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_ZoneScrollBarEntry"..line):Enable()
          getglobal("ma_ZoneScrollBarEntry"..line):Show()
        else
          getglobal("ma_ZoneScrollBarEntry"..line):Hide()
        end
      end
    else
      --TrinityAdmin:NoResults("ticket")
    end
  else
    --[[local TeleTable = {}
    local zoneCount = 0
    for index, value in pairsByKeys(ReturnTeleportLocations(cont)) do
      zoneCount = zoneCount + 1
      if not TrinityAdmin.db.char.selectedZone and zoneCount == 0 then
        SubzoneScrollUpdate(cont)
      end
      --TrinityAdmin:LogAction("added index: "..index)
      table.insert(TeleTable, {name = index, subzones = value})
    end
    if zoneCount > 0 then
      FauxScrollFrame_Update(ma_ZoneScrollBar,zoneCount,12,16)
      for line = 1,12 do
        --lineplusoffset = line + ((TrinityAdmin.db.account.tickets.page - 1) * 4)  --for paged mode
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_ZoneScrollBar)
        if lineplusoffset <= zoneCount then
          local teleobj = TeleTable[lineplusoffset]
          if TrinityAdmin.db.char.selectedZone == teleobj.name then
            getglobal("ma_ZoneScrollBarEntry"..line):SetText("|cffff0000"..teleobj.name.."|r")
          else
            getglobal("ma_ZoneScrollBarEntry"..line):SetText(teleobj.name)
          end
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnClick", function()
            TrinityAdmin.db.char.selectedZone = teleobj.name
            InlineScrollUpdate(cont)
            SubzoneScrollUpdate(cont)
          end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnEnter", function()  end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnLeave", function()  end)
          getglobal("ma_ZoneScrollBarEntry"..line):Enable()
          getglobal("ma_ZoneScrollBarEntry"..line):Show()
        else
          getglobal("ma_ZoneScrollBarEntry"..line):Hide()
        end
      end
    else
      TrinityAdmin:NoResults("zones")
    end]]
  end
end

function TrinityAdmin:TeleScrollUpdate()
    cont = TrinityAdmin.db.char.selectedCont
    --TrinityAdmin.db.char.selectedCont = cont
    --self:ChatMsg("Wrote cont:" ..cont)
    local TeleTable = {}
    local zoneCount = 0
    for index, value in pairsByKeys(ReturnTeleportLocations(cont)) do
      zoneCount = zoneCount + 1
      if not TrinityAdmin.db.char.selectedZone and zoneCount == 0 then
        TrinityAdmin:SubzoneScrollUpdate()
      end
      --TrinityAdmin:LogAction("added index: "..index)
      table.insert(TeleTable, {name = index, subzones = value})
    end
    
    if zoneCount > -1 then
      FauxScrollFrame_Update(ma_ZoneScrollBar,zoneCount,12,16)
      for line = 1,12 do
        --lineplusoffset = line + ((TrinityAdmin.db.account.tickets.page - 1) * 4)  --for paged mode
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_ZoneScrollBar)
        --self:ChatMsg("L+O:" ..lineplusoffset)
        if lineplusoffset <= zoneCount then
          local teleobj = TeleTable[lineplusoffset]
          if TrinityAdmin.db.char.selectedZone == teleobj.name then
            getglobal("ma_ZoneScrollBarEntry"..line):SetText("|cffff0000"..teleobj.name.."|r")
          else
            getglobal("ma_ZoneScrollBarEntry"..line):SetText(teleobj.name)
          end
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnClick", function()
            TrinityAdmin.db.char.selectedZone = teleobj.name
            --TrinityAdmin.db.char.selectedCont = cont
            TrinityAdmin:TeleScrollUpdate()
            --InlineScrollUpdate(cont)
            TrinityAdmin:SubzoneScrollUpdate()
          end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnEnter", function() cont = TrinityAdmin.db.char.selectedCont end)
          getglobal("ma_ZoneScrollBarEntry"..line):SetScript("OnLeave", function() cont = TrinityAdmin.db.char.selectedCont end)
          getglobal("ma_ZoneScrollBarEntry"..line):Enable()
          getglobal("ma_ZoneScrollBarEntry"..line):Show()
        else
          getglobal("ma_ZoneScrollBarEntry"..line):Hide()
        end
      end
    else
      TrinityAdmin:NoResults("zones")
    end
end

function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

function TrinityAdmin:SubzoneScrollUpdate()
  cont = TrinityAdmin.db.char.selectedCont
  local TeleTable = {}
  local subzoneCount = 0
  --local shownZone = "Alterac Mountains"
  if TrinityAdmin.db.char.selectedZone then
    shownZone = TrinityAdmin.db.char.selectedZone
  end
  ma_telesubzonetext:SetText(Locale["Zone"]..shownZone)
  for index, value in pairsByKeys(ReturnTeleportLocations(cont)) do
    if index == shownZone then
      for i, v in pairsByKeys(value) do
        table.insert(TeleTable, {name = i, command = v})
        subzoneCount = subzoneCount + 1
      end
    end
  end
  --TrinityAdmin:ChatMsg("subs:" ..subzoneCount)
  --TrinityAdmin:ChatMsg("Cont:" ..cont)
  if subzoneCount > 0 then
    FauxScrollFrame_Update(ma_SubzoneScrollBar,subzoneCount,12,16)
    for line = 1,12 do
      --lineplusoffset = line + ((TrinityAdmin.db.account.tickets.page - 1) * 4)  --for paged mode
      lineplusoffset = line + FauxScrollFrame_GetOffset(ma_SubzoneScrollBar)
      if lineplusoffset <= subzoneCount then
        local teleobj = TeleTable[lineplusoffset]
        getglobal("ma_SubzoneScrollBarEntry"..line):SetText(teleobj.name)
        getglobal("ma_SubzoneScrollBarEntry"..line):SetScript("OnClick", function() TrinityAdmin:ChatMsg(teleobj.command) end)
        getglobal("ma_SubzoneScrollBarEntry"..line):SetScript("OnEnter", function() cont = TrinityAdmin.db.char.selectedCont end)
        getglobal("ma_SubzoneScrollBarEntry"..line):SetScript("OnLeave", function() cont = TrinityAdmin.db.char.selectedCont end)
        getglobal("ma_SubzoneScrollBarEntry"..line):Enable()
        getglobal("ma_SubzoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_SubzoneScrollBarEntry"..line):Hide()
      end
    end
  else
    TrinityAdmin:NoResults("subzones")
  end
end

-- STYLE FUNCTIONS
function TrinityAdmin:ToggleTransparency()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    self.db.account.style.transparency.backgrounds = 1.0
  else
    self.db.account.style.transparency.backgrounds = 0.5
  end
  ReloadUI()
end

function TrinityAdmin:ChangeTransparency(element)
  if element == "frames" then
    TrinityAdmin.db.account.style.transparency.frames = string.format("%.2f", ma_frmtrslider:GetValue())
  elseif element == "buttons" then
    TrinityAdmin.db.account.style.transparency.buttons = string.format("%.2f", ma_btntrslider:GetValue())
  end
end

function TrinityAdmin:ToggleTooltips()
  if self.db.account.style.showtooltips then
    self.db.account.style.showtooltips = false
  else
    self.db.account.style.showtooltips = true
  end
  ReloadUI()
end

function TrinityAdmin:ToggleMinimenu()
  if self.db.account.style.showminimenu then
    self.db.account.style.showminimenu = false
  else
    self.db.account.style.showminimenu = true
  end
  ReloadUI()
end

function TrinityAdmin:InitCheckButtons()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    ma_checktransparencybutton:SetChecked(true)
  else
    ma_checktransparencybutton:SetChecked(false)
  end
  ma_instantkillbutton:SetChecked(self.db.char.instantKillMode)
  ma_checklocalsearchstringsbutton:SetChecked(self.db.account.localesearchstring)
  ma_showminimenubutton:SetChecked(self.db.account.style.showminimenu)
  ma_showtooltipsbutton:SetChecked(self.db.account.style.showtooltips)
end

function TrinityAdmin:ShowColorPicker(t)
  if t == "bg" then
    local r,g,b
    if TrinityAdmin.db.account.style.color.buffer.backgrounds then
      r = TrinityAdmin.db.account.style.color.buffer.backgrounds.r
      g = TrinityAdmin.db.account.style.color.buffer.backgrounds.g
      b = TrinityAdmin.db.account.style.color.buffer.backgrounds.b
    else
      r = TrinityAdmin.db.account.style.color.backgrounds.r
      g = TrinityAdmin.db.account.style.color.backgrounds.g
      b = TrinityAdmin.db.account.style.color.backgrounds.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_bgcolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB()
      ma_bgcolorshowbutton_texture:SetTexture(r,g,b)
      TrinityAdmin.db.account.style.color.buffer.backgrounds = {}
      TrinityAdmin.db.account.style.color.buffer.backgrounds.r = r
      TrinityAdmin.db.account.style.color.buffer.backgrounds.g = g
      TrinityAdmin.db.account.style.color.buffer.backgrounds.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  elseif t == "frm" then
    local r,g,b
    if TrinityAdmin.db.account.style.color.buffer.frames then
      r = TrinityAdmin.db.account.style.color.buffer.frames.r
      g = TrinityAdmin.db.account.style.color.buffer.frames.g
      b = TrinityAdmin.db.account.style.color.buffer.frames.b
    else
      r = TrinityAdmin.db.account.style.color.frames.r
      g = TrinityAdmin.db.account.style.color.frames.g
      b = TrinityAdmin.db.account.style.color.frames.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_frmcolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB()
      ma_frmcolorshowbutton_texture:SetTexture(r,g,b)
      TrinityAdmin.db.account.style.color.buffer.frames = {}
      TrinityAdmin.db.account.style.color.buffer.frames.r = r
      TrinityAdmin.db.account.style.color.buffer.frames.g = g
      TrinityAdmin.db.account.style.color.buffer.frames.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  elseif t == "btn" then
    local r,g,b
    if TrinityAdmin.db.account.style.color.buffer.buttons then
      r = TrinityAdmin.db.account.style.color.buffer.buttons.r
      g = TrinityAdmin.db.account.style.color.buffer.buttons.g
      b = TrinityAdmin.db.account.style.color.buffer.buttons.b
    else
      r = TrinityAdmin.db.account.style.color.buttons.r
      g = TrinityAdmin.db.account.style.color.buttons.g
      b = TrinityAdmin.db.account.style.color.buttons.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_btncolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB();
      ma_btncolorshowbutton_texture:SetTexture(r,g,b)
      TrinityAdmin.db.account.style.color.buffer.buttons = {}
      TrinityAdmin.db.account.style.color.buffer.buttons.r = r
      TrinityAdmin.db.account.style.color.buffer.buttons.g = g
      TrinityAdmin.db.account.style.color.buffer.buttons.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  elseif t == "linkifier" then
    local r,g,b
    if TrinityAdmin.db.account.style.color.buffer.linkifier then
      r = TrinityAdmin.db.account.style.color.buffer.linkifier.r
      g = TrinityAdmin.db.account.style.color.buffer.linkifier.g
      b = TrinityAdmin.db.account.style.color.buffer.linkifier.b
    else
      r = TrinityAdmin.db.account.style.color.linkifier.r
      g = TrinityAdmin.db.account.style.color.linkifier.g
      b = TrinityAdmin.db.account.style.color.linkifier.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_linkifiercolorbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB();
      ma_linkifiercolorbutton_texture:SetTexture(r,g,b)
      TrinityAdmin.db.account.style.color.buffer.linkifier = {}
      TrinityAdmin.db.account.style.color.buffer.linkifier.r = r
      TrinityAdmin.db.account.style.color.buffer.linkifier.g = g
      TrinityAdmin.db.account.style.color.buffer.linkifier.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  end
  ColorPickerFrame.hasOpacity = false
  ColorPickerFrame:Show()
end

function TrinityAdmin:ApplyStyleChanges()
  if TrinityAdmin.db.account.style.color.buffer.backgrounds then
    TrinityAdmin.db.account.style.color.backgrounds = TrinityAdmin.db.account.style.color.buffer.backgrounds
  end
  if TrinityAdmin.db.account.style.color.buffer.frames then
    TrinityAdmin.db.account.style.color.frames = TrinityAdmin.db.account.style.color.buffer.frames
  end
  if TrinityAdmin.db.account.style.color.buffer.buttons then
    TrinityAdmin.db.account.style.color.buttons = TrinityAdmin.db.account.style.color.buffer.buttons
  end
  if TrinityAdmin.db.account.style.color.buffer.linkifier then
    TrinityAdmin.db.account.style.color.linkifier = TrinityAdmin.db.account.style.color.buffer.linkifier
  end
  if ma_checktransparencybutton:GetChecked() then
    self.db.account.style.transparency.backgrounds = 0.5
  else
    self.db.account.style.transparency.backgrounds = 1.0
  end
  if ma_checklocalsearchstringsbutton:GetChecked() then
    self.db.account.localesearchstring = true
  else
    self.db.account.localesearchstring = false
  end
  if ma_showtooltipsbutton:GetChecked() then
    self.db.account.style.showtooltips = true
  else
    self.db.account.style.showtooltips = false
  end
  if ma_showminimenubutton:GetChecked() then
    self.db.account.style.showminimenu = true
  else
    self.db.account.style.showminimenu = false
  end
  ReloadUI()
end

function TrinityAdmin:CloseButton(name)
  if name == "bg" then
    TrinityAdmin:SearchReset()
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  elseif name == "popup" then
    TrinityAdmin:SearchReset()
    FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end)
  elseif name == "popup2" then
    FrameLib:HandleGroup("popup2", function(frame) frame:Hide()  end)
  end
end
