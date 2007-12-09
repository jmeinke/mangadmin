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

local MangAdmin  = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0", "AceDebug-2.0", "AceEvent-2.0")
local Locale     = AceLibrary("AceLocale-2.2"):new("MangAdmin")
local FrameLib   = AceLibrary("FrameLib-1.0")
local Graph      = AceLibrary("Graph-1.0")
local Tablet     = AceLibrary("Tablet-2.0")

MangAdmin:RegisterDB("MangAdminDb", "MangAdminDbPerChar")
MangAdmin:RegisterDefaults("char", 
  {
    getValueCallHandler = {
      calledGetGuid = false,
      realGuid = nil
    },
    functionQueue = {},
    workaroundValues = {
      flymode = nil
    },
    requests = {
      tpinfo = false,
      ticket = false,
      item = false,
      itemset = false,
      spell = false,
      quest = false,
      creature = false,
      object = false,
      tele = false
    },
    nextGridWay = "ahead",
    newTicketQueue = {}
  }
)
MangAdmin:RegisterDefaults("account", 
  {
    language = nil,
    favourites = {
      items = {},
      itemsets = {},
      spells = {},
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
--Locale:Debug()
--Locale:SetLocale("enUS")

MangAdmin.consoleOpts = {
  type = 'group',
  args = {
    toggle = {
      name = "toggle",
      desc = "Toggles the main window",
      type = 'execute',
      func = function() MangAdmin:OnClick() end
    },
    transparency = {
      name = "transparency",
      desc = "Toggles the transparency (0.5 or 1.0)",
      type = 'execute',
      func = function() MangAdmin:ToggleTransparency() end
    }
  }
}

function MangAdmin:OnInitialize()
  -- initializing MangAdmin
  self:SetLanguage()
  self:CreateFrames()
  self:RegisterChatCommand(Locale["slashcmds"], self.consoleOpts) -- this registers the chat commands
  self:InitButtons() -- this prepares the actions and tooltips of nearly all MangAdmin buttons  
  self:SearchReset()
   -- FuBar plugin config
  MangAdmin.hasNoColor = true
  MangAdmin.hasNoText = false
  MangAdmin.clickableTooltip = true
  MangAdmin.hasIcon = true
  MangAdmin.hideWithoutStandby = true
  MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
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
  self:InitLangDropDown()
  self:InitSliders()
  self:InitScrollFrames()
  self:InitTransparencyButton()
  --clear color buffer
  self.db.account.style.color.buffer = {}
end

function MangAdmin:OnEnable()
  self:SetDebugging(true) -- to have debugging through the whole app.    
  -- init guid for callhandler, not implemented yet, comes in next revision
  self.GetGuid()
  self:SearchReset()
  -- register events
  --self:RegisterEvent("ZONE_CHANGED") -- for teleport list update
end

function MangAdmin:OnDisable()
  -- called when the addon is disabled
  self:SearchReset()
end

function MangAdmin:OnClick()
  -- this toggles the MangAdmin frame when clicking on the mini icon
  if IsShiftKeyDown() then
    ReloadUI()
  elseif IsAltKeyDown() then
    self.db.char.newTicketQueue = 0
    MangAdmin:UpdateTooltip()
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

function MangAdmin:OnTooltipUpdate()
  local tickets = self.db.char.newTicketQueue
  local ticketCount = 0
  table.foreachi(tickets, function() ticketCount = ticketCount + 1 end)
  if ticketCount == 0 then
    local cat = Tablet:AddCategory("columns", 1)
    cat:AddLine("text", Locale["ma_TicketsNoNew"])
    MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
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
      "func", function() MangAdmin:ShowTicketTab() end)
    local counter = 0
    local name
    for i, name in ipairs(tickets) do
      counter = counter + 1
      if counter == ticketCount then
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGoLast"], name),
          "func", function(name) MangAdmin:TelePlayer("gochar", name) end,
          "arg1", name
        )
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGetLast"], name),
          "func", function(name) MangAdmin:TelePlayer("getchar", name) end,
          "arg1", name
        )
      end
    end
    MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
  end
  Tablet:SetHint(Locale["ma_IconHint"])
end

function MangAdmin:ToggleTabButton(group)
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

function MangAdmin:ToggleContentGroup(group)
  --MangAdmin:LogAction("Toggled navigation point '"..group.."'.")
  self:HideAllGroups()
  FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function MangAdmin:InstantGroupToggle(group)
  FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  MangAdmin:ToggleTabButton(group)
  MangAdmin:ToggleContentGroup(group)
end

function MangAdmin:TogglePopup(value, param)
  -- this toggles the MangAdmin Search Popup frame, toggling deactivated, popup will be overwritten
  --[[if ma_popupframe:IsVisible() then 
    FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end)
  else]]
  if value == "search" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    ma_mailscrollframe:Hide()
    ma_maileditbox:Hide()
    ma_var1editbox:Hide()
    ma_var2editbox:Hide()
    ma_var1text:Hide()
    ma_var2text:Hide()
    ma_searchbutton:SetScript("OnClick", function() self:SearchStart(param.type, ma_searcheditbox:GetText()) end)
    ma_searchbutton:SetText(Locale["ma_SearchButton"])
    ma_resetsearchbutton:SetScript("OnClick", function() MangAdmin:SearchReset() end)
    ma_resetsearchbutton:SetText(Locale["ma_ResetButton"])
    ma_resetsearchbutton:Enable()
    self:SearchReset()
    if param.type == "item" then
      ma_lookuptext:SetText(Locale["ma_ItemButton"])
      ma_var1editbox:Show()
      ma_var1text:Show()
      ma_var1text:SetText(Locale["ma_ItemVar1Button"])
    elseif param.type == "itemset" then
      ma_lookuptext:SetText(Locale["ma_ItemSetButton"])
    elseif param.type == "spell" then
      ma_lookuptext:SetText(Locale["ma_SpellButton"])
    elseif param.type == "quest" then
      ma_lookuptext:SetText(Locale["ma_QuestButton"])
    elseif param.type == "creature" then
      ma_lookuptext:SetText(Locale["ma_CreatureButton"])
    elseif param.type == "object" then
      ma_lookuptext:SetText(Locale["ma_ObjectButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_ObjectVar1Button"])
      ma_var2text:SetText(Locale["ma_ObjectVar2Button"])
    elseif param.type == "tele" then
      ma_lookuptext:SetText(Locale["ma_TeleSearchButton"])
    elseif param.type == "ticket" then
      ma_lookupresulttext:SetText(Locale["ma_TicketCount"].."0")
      ma_lookuptext:SetText(Locale["ma_LoadTicketsButton"])
      ma_searchbutton:SetText(Locale["ma_Reload"])
      ma_searchbutton:SetScript("OnClick", function() self:LoadTickets() end)
      ma_resetsearchbutton:SetText(Locale["ma_LoadMore"])
      ma_resetsearchbutton:SetScript("OnClick", function() MangAdmin.db.account.tickets.loading = true; self:LoadTickets(MangAdmin.db.account.tickets.count) end)
    end
  elseif value == "mail" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    for n = 1,7 do
      getglobal("ma_PopupScrollBarEntry"..n):Hide()
    end
    ma_lookupresulttext:SetText("Bytes left: 246")
    ma_lookupresulttext:Show()
    ma_resetsearchbutton:Hide()
    ma_PopupScrollBar:Hide()
    ma_searcheditbox:SetScript("OnTextChanged", function() MangAdmin:UpdateMailBytesLeft() end)
    ma_var1editbox:SetScript("OnTextChanged", function() MangAdmin:UpdateMailBytesLeft() end)
    if param.recipient then
      ma_searcheditbox:SetText(param.recipient)
    else
      ma_searcheditbox:SetText(Locale["ma_MailRecipient"])
    end
    ma_lookuptext:SetText(Locale["ma_Mail"])
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

function MangAdmin:HideAllGroups()
  FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
end

function MangAdmin:AddMessage(frame, text, r, g, b, id)
  -- frame is the object that was hooked (one of the ChatFrames)  
  local catchedSth = false

  if id == 11 then --make sure that the message comes from the server, message id = 11, I don't know why exactly this id but i think it's right
    -- hook all uint32 .getvalue requests
    for guid, field, value in string.gmatch(text, "The uint32 value of (%w+) in (%w+) is: (%w+)") do
      catchedSth = true
      output = self:GetValueCallHandler(guid, field, value)
    end
    
    -- hook .gps for gridnavigation
    for x, y in string.gmatch(text, "X: (.*) Y: (.*) Z") do
      for k,v in pairs(self.db.char.functionQueue) do
        if v == "GridNavigate" then
          self:GridNavigate(string.format("%.1f", x), string.format("%.1f", y), nil)
          table.remove(self.db.char.functionQueue, k)
          break
        end
      end
    end
    
    -- hook all item lookups
    for id, name in string.gmatch(text, "|cffffffff|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r") do
      if self.db.char.requests.item then
        table.insert(self.db.account.buffer.items, {itId = id, itName = name})
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
    end
    
    -- hook all itemset lookups
    for id, name in string.gmatch(text, "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.itemset then
        table.insert(self.db.account.buffer.itemsets, {isId = id, isName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all spell lookups
    for id, name in string.gmatch(text, "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.spell then
        table.insert(self.db.account.buffer.spells, {spId = id, spName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all creature lookups
    for id, name in string.gmatch(text, "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.creature then
        table.insert(self.db.account.buffer.creatures, {crId = id, crName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all object lookups
    for id, name in string.gmatch(text, "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.object then
        table.insert(self.db.account.buffer.objects, {objId = id, objName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all quest lookups
    for id, name in string.gmatch(text, "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.quest then
        table.insert(self.db.account.buffer.quests, {qsId = id, qsName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
 
    -- hook all tele lookups
    for name in string.gmatch(text, "h%[(.-)%]") do
      if self.db.char.requests.tele then
        table.insert(self.db.account.buffer.teles, {tName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
   
    -- hook all new tickets
    for name in string.gmatch(text, "New ticket from (.*)") do
      -- now need function for: Got new ticket
      table.insert(self.db.char.newTicketQueue, name)
      self:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
      PlaySoundFile(ROOT_PATH.."Sound\\mail.wav")
      self:LogAction("Got new ticket from: "..name)
    end
    
    -- hook ticket count
    for count, status in string.gmatch(text, "Tickets count: (%d+) show new tickets: (%w+)\n") do
      if self.db.char.requests.ticket then
        catchedSth = true
        output = false
        self:LoadTickets(count)
      end
    end
    
    -- get tickets
    for char, category, message in string.gmatch(text, "Ticket of (.*) %(Category: (%d+)%):\n(.*)\n") do
      if self.db.char.requests.ticket then
        local ticketCount = 0
        table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
        local number = self.db.account.tickets.count - ticketCount
        table.insert(self.db.account.buffer.tickets, {tNumber = number, tChar = char, tCat = category, tMsg = message})
        PopupScrollUpdate()
        self:RequestTickets()
        catchedSth = true
        output = false
      end
    end
    
    -- hook player account info
    for status, char, guid, account, id, level, ip in string.gmatch(text, "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*)") do
      if self.db.char.requests.tpinfo then
        if status == "" then
          status = Locale["ma_Online"]
        else
          status = Locale["ma_Offline"]
        end
        --table.insert(self.db.account.buffer.tpinfo, {char = {pStatus = status, pGuid = guid, pAcc = account, pId = id, pLevel = level, pIp = ip}})
        ma_tpinfo_text:SetText(ma_tpinfo_text:GetText()..Locale["ma_TicketsInfoPlayer"]..char.." ("..guid..")\n"..Locale["ma_TicketsInfoStatus"]..status.."\n"..Locale["ma_TicketsInfoAccount"]..account.." ("..id..")\n"..Locale["ma_TicketsInfoAccLevel"]..level.."\n"..Locale["ma_TicketsInfoLastIP"]..ip)
        catchedSth = true
        output = false
      end
    end
    
    -- hook player account info
    for played, level, money in string.gmatch(text, "Played time: (.*) Level: (%d+) Money: (.*)") do
      if self.db.char.requests.tpinfo then
        ma_tpinfo_text:SetText(ma_tpinfo_text:GetText().."\n"..Locale["ma_TicketsInfoPlayedTime"]..played.."\n"..Locale["ma_TicketsInfoLevel"]..level.."\n"..Locale["ma_TicketsInfoMoney"]..money)
        catchedSth = true
        output = false
        self.db.char.requests.tpinfo = false
      end
    end
    
  else
    -- message is not from server
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
    return true
  else
    MangAdmin:LogAction("DEBUG: Getvalues are: GUID = "..guid.."; field = "..field.."; value = "..value..";")
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


--=================================--
--MangAdmin Commands functions--
--=================================--
function MangAdmin:SetLanguage()
  if self.db.account.language then
    Locale:SetLocale(self.db.account.language)
  else
    self.db.account.language = Locale:GetLocale()
  end
end

function MangAdmin:ChangeLanguage(locale)
  self.db.account.language = locale
  ReloadUI()
end

function MangAdmin:ToggleGMMode(value)
  MangAdmin:ChatMsg(".gm "..value)
  MangAdmin:LogAction("Turned GM-mode to "..value..".")
end

function MangAdmin:ToggleFlyMode(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    MangAdmin:ChatMsg(".flymode "..value)
    MangAdmin:LogAction("Turned Fly-mode "..value.." for "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:ToggleHoverMode(value)
  MangAdmin:ChatMsg(".hover "..value)
  local status
  if value == 1 then
    status = "on"
  else
    status = "off"
  end
  MangAdmin:LogAction("Turned Hover-mode "..status..".")
end

function MangAdmin:ToggleWhisper(value)
  MangAdmin:ChatMsg(".whispers "..value)
  MangAdmin:LogAction("Turned accepting whispers to "..value..".")
end

function MangAdmin:ToggleVisible(value)
  MangAdmin:ChatMsg(".visible "..value)
  if value == "on" then
    MangAdmin:LogAction("Turned you visible.")
  else
    MangAdmin:LogAction("Turned you invisible.")
  end  
end

function MangAdmin:ToggleTaxicheat(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    MangAdmin:ChatMsg(".taxicheat "..value)
    if value == 1 then
      MangAdmin:LogAction("Activated taxicheat to "..player..".")
    else
      MangAdmin:LogAction("Disabled taxicheat to "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:SetSpeed()
  local value = string.format("%.1f", ma_speedslider:GetValue())
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".modify speed "..value)
    self:ChatMsg(".modify fly "..value)
    self:ChatMsg(".modify swim "..value)
    self:LogAction("Set speed of "..player.." to "..value..".")
  else
    self:Print(Locale["selectionerror1"])
    ma_speedslider:SetValue(1)
  end
end

function MangAdmin:SetScale()
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

function MangAdmin:LearnSpell(value, state)
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
      for k,v in ipairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." spell "..v.." to "..player..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." spell "..value.." to "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:Quest(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".addquest"
    local logcmd = "Added"
    local logcmd2 = "to"
    if state == "RightButton" then
      command = ".removequest"
      logcmd = "Removed"
      logcmd2 = "from"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    elseif type(value) == "table" then
      for k,v in ipairs(value) do
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

function MangAdmin:Creature(value, state)
    local command = ".addspw"
    local logcmd = "Spawned"
    if state == "RightButton" then
      command = ".listcreature"
      logcmd = "Listed"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    elseif type(value) == "table" then
      for k,v in ipairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." creature with id "..value..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    end

end

function MangAdmin:AddItem(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local amount = ma_var1editbox:GetText()
    if state == "RightButton" then
      self:ChatMsg(".listitem "..value)
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

function MangAdmin:AddItemSet(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".additemset "..value)
    self:LogAction("Added itemset with id "..value.." to "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:AddObject(value, state)
  local loot = ma_var1editbox:GetText()
  local _time = ma_var2editbox:GetText()
  if state == "RightButton" then
    self:ChatMsg(".addgo "..value.." "..value)
    self:LogAction("Added object id "..value.." with loot template.")
  else
    if loot ~= "" and _time == "" then
      self:ChatMsg(".addgo "..value.. " "..loot)
      self:LogAction("Added object id "..value.." with loot "..loot..".")
    elseif loot ~= "" and _time ~= "" then
      self:ChatMsg(".addgo "..value.. " "..loot.." ".._time)
      self:LogAction("Added object id "..value.." with loot "..loot.." and spawntime ".._time..".")
    else
      self:ChatMsg(".addgo "..value)
      self:LogAction("Added object id "..value..".")
    end
  end
end

function MangAdmin:TelePlayer(value, player)
  if value == "gochar" then
    self:ChatMsg(".goname "..player)
    self:LogAction("Teleported to player "..player..".")
  elseif value == "getchar" then
    self:ChatMsg(".namego "..player)
    self:LogAction("Summoned player "..player..".")
  end
end

function MangAdmin:KickPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".kick")
    self:LogAction("Kicked player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:RevivePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".revive")
    self:LogAction("Revived player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:DismountPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".dismount")
    self:LogAction("Dismounted player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:SavePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".save")
    self:LogAction("Saved player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:KillSomething()
  local target = UnitName("target") or UnitName("player")
  self:ChatMsg(".die")
  self:LogAction("Killed "..target..".")
end

function MangAdmin:LevelupPlayer(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".levelup "..value)
    self:LogAction("Leveled up player "..player.." by "..value.." levels.")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:GridNavigate(x, y)
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
      self:ChatMsg(".goxy "..newx.." "..newy)
      self:LogAction("Navigated to grid position: X: "..newx.." Y: "..newy)
    else
      self:Print("Value must be a number!")
    end
  end
end

function MangAdmin:CreateGuild(leader, name)
  self:ChatMsg(".createguild "..leader.." "..name)
  self:LogAction("Created guild '"..name.."' with leader "..leader..".")
end

function MangAdmin:Screenshot()
  UIParent:Hide()
  Screenshot()
  UIParent:Show()
end

function MangAdmin:Announce(value)
  self:ChatMsg(".announce "..value)
  self:LogAction("Announced message: "..value)
end

function MangAdmin:Shutdown(value)
  if value == "" then
    self:ChatMsg(".shutdown 0")
    self:LogAction("Shut down server instantly.")
  else
    self:ChatMsg(".shutdown "..value)
    self:LogAction("Shut down server in "..value.." seconds.")
  end
end

function MangAdmin:SendMail(recipient, subject, body)
  self:ChatMsg(".sendm "..recipient.." "..subject.." "..body)
  self:LogAction("Sent a mail to "..recipient..". Subject was: "..subject)
end

function MangAdmin:UpdateMailBytesLeft()
  local bleft = 246 - strlen(ma_searcheditbox:GetText()) - strlen(ma_var1editbox:GetText()) - strlen(ma_maileditbox:GetText())
  ma_lookupresulttext:SetText("Bytes left: "..bleft)
end

function MangAdmin:Ticket(value)
  local ticket = self.db.account.tickets.selected
  if value == "delete" then
    self:ChatMsg(".delticket "..ticket["tNumber"])
    self:LogAction("Deleted ticket with number: "..ticket["tNumber"])
    self:ShowTicketTab()
    self:LoadTickets()
  elseif value == "gochar" then
    self:ChatMsg(".goname "..ticket["tChar"])
  elseif value == "getchar" then
    self:ChatMsg(".namego "..ticket["tChar"])
  elseif value == "answer" then
    self:TogglePopup("mail", {recipient = ticket["tChar"], subject = "Ticket("..ticket["tCat"]..")", body = ticket["tMsg"]})
  elseif value == "whisper" then
    ChatFrameEditBox:Show()
    ChatFrameEditBox:Insert("/w "..ticket["tChar"]);
  end
end

function MangAdmin:ToggleTickets(value)
  MangAdmin:ChatMsg(".ticket "..value)
  MangAdmin:LogAction("Turned receiving new tickets "..value..".")
end

function MangAdmin:ShowTicketTab()
  ma_tpinfo_text:SetText(Locale["ma_TicketsNoInfo"])
  ma_ticketeditbox:SetText(Locale["ma_TicketsNotLoaded"])
  ma_deleteticketbutton:Disable()
  ma_answerticketbutton:Disable()
  ma_getcharticketbutton:Disable()
  ma_gocharticketbutton:Disable()
  ma_whisperticketbutton:Disable()
  MangAdmin:InstantGroupToggle("ticket")
end

function MangAdmin:LoadTickets(number)
  self.db.char.newTicketQueue = {}
  self.db.account.tickets.requested = 0
  if number then
    if tonumber(number) > 0 then
      self.db.account.tickets.count = tonumber(number)
      if self.db.char.requests.ticket then
        self:LogAction("Load of tickets requested. Found "..number.." tickets!")
        self:RequestTickets()
        self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
        ma_resetsearchbutton:Enable()
      end
    else
      ma_resetsearchbutton:Disable()
      self:NoTickets()
    end
  else
    self.db.char.requests.ticket = true
    self.db.account.tickets.count = 0
    self.db.account.buffer.tickets = {}
    self:ChatMsg(".ticket")
    self:LogAction("Requesting ticket number!")
  end
end

function MangAdmin:RequestTickets()
  self.db.char.requests.ticket = true
  local count = self.db.account.tickets.count
  local ticketCount = 0
  table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
  ma_lookupresulttext:SetText(Locale["ma_TicketCount"]..count)
  local tnumber = count - ticketCount
  if tnumber == 0 then
    self:LogAction("Loaded all available tickets! No more to load...")
    ma_resetsearchbutton:Disable()
    --self.db.char.requests.ticket = false -- BUG check in next rev: while MA is activated you won't be able to request tickets in chat!!
  elseif self.db.account.tickets.requested < 7 then
    self:ChatMsg(".ticket "..tnumber)
    MangAdmin.db.account.tickets.requested = MangAdmin.db.account.tickets.requested + 1;
    self:LogAction("Loading ticket "..tnumber.."...")
  end
end

function MangAdmin:SearchStart(var, value)
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
  self:LogAction("Started search for "..var.."s with the keyword '"..value.."'.")
end

function MangAdmin:SearchReset()
  ma_searcheditbox:SetScript("OnTextChanged", function() end)
  ma_var1editbox:SetScript("OnTextChanged", function() end)
  ma_searcheditbox:SetText("")
  ma_var1editbox:SetText("")
  ma_var2editbox:SetText("")
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  self.db.char.requests.item = false
  self.db.char.requests.itemset = false
  self.db.char.requests.spell = false
  self.db.char.requests.quest = false
  self.db.char.requests.creature = false
  self.db.char.requests.object = false
  self.db.char.requests.tele = false
  self.db.char.requests.ticket = false
  self.db.account.buffer.items = {}
  self.db.account.buffer.itemsets = {}
  self.db.account.buffer.spells = {}
  self.db.account.buffer.quests = {}
  self.db.account.buffer.creatures = {}
  self.db.account.buffer.objects = {}
  self.db.account.buffer.teles = {}
  self.db.account.buffer.counter = 0
  PopupScrollUpdate()
end

function MangAdmin:PrepareScript(object, text, script)
  --if object then
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
  --end
end

--[[INITIALIZION FUNCTIONS]]
function MangAdmin:InitButtons()
  -- start tab buttons
  self:PrepareScript(ma_tabbutton_main      , Locale["tt_MainButton"]       , function() MangAdmin:InstantGroupToggle("main") end)
  self:PrepareScript(ma_tabbutton_char      , Locale["tt_CharButton"]       , function() MangAdmin:InstantGroupToggle("char") end)
  self:PrepareScript(ma_tabbutton_tele      , Locale["tt_TeleButton"]       , function() MangAdmin:InstantGroupToggle("tele") end)
  self:PrepareScript(ma_tabbutton_ticket    , Locale["tt_TicketButton"]     , function() MangAdmin:ShowTicketTab() end)
  self:PrepareScript(ma_tabbutton_server    , Locale["tt_ServerButton"]     , function() MangAdmin:InstantGroupToggle("server") end)
  self:PrepareScript(ma_tabbutton_misc      , Locale["tt_MiscButton"]       , function() MangAdmin:InstantGroupToggle("misc") end)
  self:PrepareScript(ma_tabbutton_log       , Locale["tt_LogButton"]        , function() MangAdmin:InstantGroupToggle("log") end)
  --end tab buttons
  self:PrepareScript(ma_languagebutton      , Locale["tt_LanguageButton"]   , function() MangAdmin:ChangeLanguage(UIDropDownMenu_GetSelectedValue(ma_languagedropdown)) end)
  self:PrepareScript(ma_speedslider         , Locale["tt_SpeedSlider"]      , {{"OnMouseUp", function() MangAdmin:SetSpeed() end},{"OnValueChanged", function() ma_speedsliderText:SetText(string.format("%.1f", ma_speedslider:GetValue())) end}})
  self:PrepareScript(ma_scaleslider         , Locale["tt_ScaleSlider"]      , {{"OnMouseUp", function() MangAdmin:SetScale() end},{"OnValueChanged", function() ma_scalesliderText:SetText(string.format("%.1f", ma_scaleslider:GetValue())) end}})  
  self:PrepareScript(ma_itembutton          , Locale["tt_ItemButton"]       , function() MangAdmin:TogglePopup("search", {type = "item"}) end)
  self:PrepareScript(ma_itemsetbutton       , Locale["tt_ItemSetButton"]    , function() MangAdmin:TogglePopup("search", {type = "itemset"}) end)
  self:PrepareScript(ma_spellbutton         , Locale["tt_SpellButton"]      , function() MangAdmin:TogglePopup("search", {type = "spell"}) end)
  self:PrepareScript(ma_questbutton         , Locale["tt_QuestButton"]      , function() MangAdmin:TogglePopup("search", {type = "quest"}) end)
  self:PrepareScript(ma_creaturebutton      , Locale["tt_CreatureButton"]   , function() MangAdmin:TogglePopup("search", {type = "creature"}) end)
  self:PrepareScript(ma_objectbutton        , Locale["tt_ObjectButton"]     , function() MangAdmin:TogglePopup("search", {type = "object"}) end)
  self:PrepareScript(ma_telesearchbutton    , Locale["ma_TeleSearchButton"] , function() MangAdmin:TogglePopup("search", {type = "tele"}) end)
  self:PrepareScript(ma_sendmailbutton      , "Tooltip not available yet."  , function() MangAdmin:TogglePopup("mail", {}) end)
  self:PrepareScript(ma_screenshotbutton    , Locale["tt_ScreenButton"]     , function() MangAdmin:Screenshot() end)
  self:PrepareScript(ma_gmonbutton          , Locale["tt_GMOnButton"]       , function() MangAdmin:ToggleGMMode("on") end)
  self:PrepareScript(ma_gmoffbutton         , Locale["tt_GMOffButton"]      , function() MangAdmin:ToggleGMMode("off") end)
  self:PrepareScript(ma_flyonbutton         , Locale["tt_FlyOnButton"]      , function() MangAdmin:ToggleFlyMode("on") end)
  self:PrepareScript(ma_flyoffbutton        , Locale["tt_FlyOffButton"]     , function() MangAdmin:ToggleFlyMode("off") end)
  self:PrepareScript(ma_hoveronbutton       , Locale["tt_HoverOnButton"]    , function() MangAdmin:ToggleHoverMode(1) end)
  self:PrepareScript(ma_hoveroffbutton      , Locale["tt_HoverOffButton"]   , function() MangAdmin:ToggleHoverMode(0) end)
  self:PrepareScript(ma_whisperonbutton     , Locale["tt_WhispOnButton"]    , function() MangAdmin:ToggleWhisper("on") end)
  self:PrepareScript(ma_whisperoffbutton    , Locale["tt_WhispOffButton"]   , function() MangAdmin:ToggleWhisper("off") end)
  self:PrepareScript(ma_invisibleonbutton   , Locale["tt_InvisOnButton"]    ,  function() MangAdmin:ToggleVisible("off") end)
  self:PrepareScript(ma_invisibleoffbutton  , Locale["tt_InvisOffButton"]   , function() MangAdmin:ToggleVisible("on") end)
  self:PrepareScript(ma_taxicheatonbutton   , Locale["tt_TaxiOnButton"]     , function() MangAdmin:ToggleTaxicheat("on") end)
  self:PrepareScript(ma_taxicheatoffbutton  , Locale["tt_TaxiOffButton"]    , function() MangAdmin:ToggleTaxicheat("off") end)
  self:PrepareScript(ma_ticketonbutton      , "Tooltip not available yet."  , function() MangAdmin:ToggleTickets("on") end)
  self:PrepareScript(ma_ticketoffbutton     , "Tooltip not available yet."  , function() MangAdmin:ToggleTickets("off") end)
  self:PrepareScript(ma_bankbutton          , Locale["tt_BankButton"]       , function() MangAdmin:ChatMsg(".bank") end)
  self:PrepareScript(ma_learnallbutton      , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all") end)
  self:PrepareScript(ma_learncraftsbutton   , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_crafts") end)
  self:PrepareScript(ma_learngmbutton       , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_gm") end)
  self:PrepareScript(ma_learnlangbutton     , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_lang") end)
  self:PrepareScript(ma_learnclassbutton    , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_myclass") end)
  self:PrepareScript(ma_levelupbutton       , "Tooltip not available yet."  , function() MangAdmin:LevelupPlayer(ma_levelupeditbox:GetText()) end)
  self:PrepareScript(ma_searchbutton        , "Tooltip not available yet."  , function() MangAdmin:SearchStart("item", ma_searcheditbox:GetText()) end)
  self:PrepareScript(ma_resetsearchbutton   , "Tooltip not available yet."  , function() MangAdmin:SearchReset() end)
  self:PrepareScript(ma_revivebutton        , "Tooltip not available yet."  , function() MangAdmin:RevivePlayer() end)
  self:PrepareScript(ma_killbutton          , "Tooltip not available yet."  , function() MangAdmin:KillSomething() end)
  self:PrepareScript(ma_savebutton          , "Tooltip not available yet."  , function() MangAdmin:SavePlayer() end)
  self:PrepareScript(ma_dismountbutton      , "Tooltip not available yet."  , function() MangAdmin:DismountPlayer() end)
  self:PrepareScript(ma_kickbutton          , Locale["tt_KickButton"]       , function() MangAdmin:KickPlayer() end)
  self:PrepareScript(ma_gridnaviaheadbutton , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "ahead" end)
  self:PrepareScript(ma_gridnavibackbutton  , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "back" end)
  self:PrepareScript(ma_gridnavirightbutton , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "right" end)
  self:PrepareScript(ma_gridnavileftbutton  , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "left" end)
  self:PrepareScript(ma_announcebutton      , Locale["tt_AnnounceButton"]   , function() MangAdmin:Announce(ma_announceeditbox:GetText()) end)
  self:PrepareScript(ma_resetannouncebutton , "Tooltip not available yet."  , function() ma_announceeditbox:SetText("") end)
  self:PrepareScript(ma_shutdownbutton      , Locale["tt_ShutdownButton"]   , function() MangAdmin:Shutdown(ma_shutdowneditbox:GetText()) end)
  self:PrepareScript(ma_closebutton         , "Tooltip not available yet."  , function() FrameLib:HandleGroup("bg", function(frame) frame:Hide() end) end)
  self:PrepareScript(ma_popupclosebutton    , "Tooltip not available yet."  , function() FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end) end)
  self:PrepareScript(ma_showticketsbutton   , "Tooltip not available yet."  , function() MangAdmin:TogglePopup("search", {type = "ticket"}); MangAdmin:LoadTickets() end)
  self:PrepareScript(ma_deleteticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("delete") end)
  self:PrepareScript(ma_answerticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("answer") end)
  self:PrepareScript(ma_getcharticketbutton , "Tooltip not available yet."  , function() MangAdmin:Ticket("getchar") end)
  self:PrepareScript(ma_gocharticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("gochar") end)
  self:PrepareScript(ma_whisperticketbutton , "Tooltip not available yet."  , function() MangAdmin:Ticket("whisper") end)
  self:PrepareScript(ma_bgcolorshowbutton   , "Tooltip not available yet."  , function() MangAdmin:ShowColorPicker("bg") end)
  self:PrepareScript(ma_frmcolorshowbutton  , "Tooltip not available yet."  , function() MangAdmin:ShowColorPicker("frm") end)
  self:PrepareScript(ma_btncolorshowbutton  , "Tooltip not available yet."  , function() MangAdmin:ShowColorPicker("btn") end)
  self:PrepareScript(ma_applystylebutton    , "Tooltip not available yet."  , function() MangAdmin:ApplyStyleChanges() end)
end

function MangAdmin:InitLangDropDown()
  local function LangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {"Czech","csCZ"},
      {"German","deDE"},
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
      {"Swedish","svSV"},
      {"Chinese","zhCN"}
    }
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

function MangAdmin:InitSliders()
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
end

function MangAdmin:InitScrollFrames()
  ma_PopupScrollBar:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(30, PopupScrollUpdate) end)
  ma_PopupScrollBar:SetScript("OnShow", function() PopupScrollUpdate() end)
  ma_ticketscrollframe:SetScrollChild(ma_ticketeditbox)
  self:PrepareScript(ma_ticketeditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
  ma_mailscrollframe:SetScrollChild(ma_maileditbox)
  self:PrepareScript(ma_maileditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged(); MangAdmin:UpdateMailBytesLeft() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
end

function MangAdmin:NoTickets()
  -- Reset list and make an entry "No Tickets"
  self:LogAction(Locale["ma_TicketsNoTickets"])
  ma_ticketeditbox:SetText(Locale["ma_TicketsNoTickets"])
  FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30)
  for line = 1,7 do
    getglobal("ma_PopupScrollBarEntry"..line):Disable()
    if line == 1 then
      getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["ma_TicketsNoTickets"])
      getglobal("ma_PopupScrollBarEntry"..line):Show()
    else
      getglobal("ma_PopupScrollBarEntry"..line):Hide()
    end
  end
end

function MangAdmin:NoSearchOrResult()
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30)
  for line = 1,7 do
    getglobal("ma_PopupScrollBarEntry"..line):Disable()
    if line == 1 then
      getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["tt_SearchDefault"])
      getglobal("ma_PopupScrollBarEntry"..line):Show()
    else
      getglobal("ma_PopupScrollBarEntry"..line):Hide()
    end
  end
end

function PopupScrollUpdate()
  local line -- 1 through 7 of our window to scroll
  local lineplusoffset -- an index into our data calculated from the scroll offset
  
  if MangAdmin.db.char.requests.item then --get items
    local itemCount = 0
    table.foreachi(MangAdmin.db.account.buffer.items, function() itemCount = itemCount + 1 end)
    if itemCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..itemCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,itemCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= itemCount then
          local item = MangAdmin.db.account.buffer.items[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..item["itId"].."|r Name: |cffffffff"..item["itName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.itemset then --get itemsets
    local itemsetCount = 0
    table.foreachi(MangAdmin.db.account.buffer.itemsets, function() itemsetCount = itemsetCount + 1 end)
    if itemsetCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..itemsetCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,itemsetCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= itemsetCount then
          local itemset = MangAdmin.db.account.buffer.itemsets[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..itemset["isId"].."|r Name: |cffffffff"..itemset["isName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItemSet(itemset["isId"]) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.quest then --get quests
    local questCount = 0
    table.foreachi(MangAdmin.db.account.buffer.quests, function() questCount = questCount + 1 end)
    if questCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..questCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,questCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= questCount then
          local quest = MangAdmin.db.account.buffer.quests[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..quest["qsId"].."|r Name: |cffffffff"..quest["qsName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Quest(quest["qsId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.creature then --get creatures
    local creatureCount = 0
    table.foreachi(MangAdmin.db.account.buffer.creatures, function() creatureCount = creatureCount + 1 end)
    if creatureCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..creatureCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,creatureCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= creatureCount then
          local creature = MangAdmin.db.account.buffer.creatures[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..creature["crId"].."|r Name: |cffffffff"..creature["crName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Creature(creature["crId"], arg1) end) 
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.spell then --get spells
    local spellCount = 0
    table.foreachi(MangAdmin.db.account.buffer.spells, function() spellCount = spellCount + 1 end)
    if spellCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..spellCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,spellCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= spellCount then
          local spell = MangAdmin.db.account.buffer.spells[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..spell["spId"].."|r Name: |cffffffff"..spell["spName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:LearnSpell(spell["spId"], arg1) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.object then --get objects
    local objectCount = 0
    table.foreachi(MangAdmin.db.account.buffer.objects, function() objectCount = objectCount + 1 end)
    if objectCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..objectCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,objectCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= objectCount then
          local object = MangAdmin.db.account.buffer.objects[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..object["objId"].."|r Name: |cffffffff"..object["objName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddObject(object["objId"], arg1) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.tele then --get teles
    local teleCount = 0
    table.foreachi(MangAdmin.db.account.buffer.teles, function() teleCount = teleCount + 1 end)
    if teleCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..teleCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,teleCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= teleCount then
          local tele = MangAdmin.db.account.buffer.teles[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Name: |cffffffff"..tele["tName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:ChatMsg(".tele "..tele["tName"]) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.ticket then --get tickets
    local ticketCount = 0
    table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
    if ticketCount > 0 then
      --FauxScrollFrame_Update(ma_PopupScrollBar,4,7,30) --for paged mode, only load 4 at a time
      FauxScrollFrame_Update(ma_PopupScrollBar,ticketCount,7,30)
      for line = 1,7 do
        --lineplusoffset = line + ((MangAdmin.db.account.tickets.page - 1) * 4)  --for paged mode
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= ticketCount then
          local object = MangAdmin.db.account.buffer.tickets[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..object["tNumber"].."|r Cat: |cffffffff"..object["tCat"].."|r Player: |cffffffff"..object["tChar"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() 
            ma_ticketeditbox:SetText(object["tMsg"])
            ma_tpinfo_text:SetText(string.format(Locale["ma_TicketTicketLoaded"], object["tNumber"]))
            MangAdmin.db.char.requests.tpinfo = true
            MangAdmin:ChatMsg(".pinfo "..object["tChar"])
            MangAdmin:LogAction("Loading player info of "..object["tChar"])
            MangAdmin.db.account.tickets.selected = object
            ma_deleteticketbutton:Enable()
            ma_answerticketbutton:Enable()
            ma_getcharticketbutton:Enable()
            ma_gocharticketbutton:Enable()
            ma_whisperticketbutton:Enable()
            MangAdmin:InstantGroupToggle("ticket")
          end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoTickets()
    end
    
  else
    MangAdmin:NoSearchOrResult()
  end
end

-- STYLE FUNCTIONS
function MangAdmin:ToggleTransparency()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    self.db.account.style.transparency.backgrounds = 1.0
  else
    self.db.account.style.transparency.backgrounds = 0.5
  end
  ReloadUI()
end

function MangAdmin:InitTransparencyButton()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    ma_checktransparencybutton:SetChecked(true)
  else
    ma_checktransparencybutton:SetChecked(false)
  end
end

function MangAdmin:ShowColorPicker(t)
  if t == "bg" then
    local r,g,b
    if MangAdmin.db.account.style.color.buffer.backgrounds then
      r = MangAdmin.db.account.style.color.buffer.backgrounds.r
      g = MangAdmin.db.account.style.color.buffer.backgrounds.g
      b = MangAdmin.db.account.style.color.buffer.backgrounds.b
    else
      r = MangAdmin.db.account.style.color.backgrounds.r
      g = MangAdmin.db.account.style.color.backgrounds.g
      b = MangAdmin.db.account.style.color.backgrounds.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_bgcolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB()
      ma_bgcolorshowbutton_texture:SetTexture(r,g,b)
      MangAdmin.db.account.style.color.buffer.backgrounds = {}
      MangAdmin.db.account.style.color.buffer.backgrounds.r = r
      MangAdmin.db.account.style.color.buffer.backgrounds.g = g
      MangAdmin.db.account.style.color.buffer.backgrounds.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  elseif t == "frm" then
    local r,g,b
    if MangAdmin.db.account.style.color.buffer.frames then
      r = MangAdmin.db.account.style.color.buffer.frames.r
      g = MangAdmin.db.account.style.color.buffer.frames.g
      b = MangAdmin.db.account.style.color.buffer.frames.b
    else
      r = MangAdmin.db.account.style.color.frames.r
      g = MangAdmin.db.account.style.color.frames.g
      b = MangAdmin.db.account.style.color.frames.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_frmcolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB()
      ma_frmcolorshowbutton_texture:SetTexture(r,g,b)
      MangAdmin.db.account.style.color.buffer.frames = {}
      MangAdmin.db.account.style.color.buffer.frames.r = r
      MangAdmin.db.account.style.color.buffer.frames.g = g
      MangAdmin.db.account.style.color.buffer.frames.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  elseif t == "btn" then
    local r,g,b
    if MangAdmin.db.account.style.color.buffer.buttons then
      r = MangAdmin.db.account.style.color.buffer.buttons.r
      g = MangAdmin.db.account.style.color.buffer.buttons.g
      b = MangAdmin.db.account.style.color.buffer.buttons.b
    else
      r = MangAdmin.db.account.style.color.buttons.r
      g = MangAdmin.db.account.style.color.buttons.g
      b = MangAdmin.db.account.style.color.buttons.b
    end
    ColorPickerFrame.cancelFunc = function(prev)
      local r,g,b = unpack(prev)
      ma_btncolorshowbutton_texture:SetTexture(r,g,b)
    end
    ColorPickerFrame.func = function()
      local r,g,b = ColorPickerFrame:GetColorRGB();
      ma_btncolorshowbutton_texture:SetTexture(r,g,b)
      MangAdmin.db.account.style.color.buffer.buttons = {}
      MangAdmin.db.account.style.color.buffer.buttons.r = r
      MangAdmin.db.account.style.color.buffer.buttons.g = g
      MangAdmin.db.account.style.color.buffer.buttons.b = b
    end
    ColorPickerFrame:SetColorRGB(r,g,b)
    ColorPickerFrame.previousValues = {r,g,b}
  end
  ColorPickerFrame.hasOpacity = false
  ColorPickerFrame:Show()
end

function MangAdmin:ApplyStyleChanges()
  if MangAdmin.db.account.style.color.buffer.backgrounds then
    MangAdmin.db.account.style.color.backgrounds = MangAdmin.db.account.style.color.buffer.backgrounds
  end
  if MangAdmin.db.account.style.color.buffer.frames then
    MangAdmin.db.account.style.color.frames = MangAdmin.db.account.style.color.buffer.frames
  end
  if MangAdmin.db.account.style.color.buffer.buttons then
    MangAdmin.db.account.style.color.buttons = MangAdmin.db.account.style.color.buffer.buttons
  end
  if ma_checktransparencybutton:GetChecked() then
    self.db.account.style.transparency.backgrounds = 0.5
  else
    self.db.account.style.transparency.backgrounds = 1.0
  end
  ReloadUI()
end

--===============================================================================================================--
--== Initializing Frames (with LUA) MUCH EASIER THAN WRITING F***ING HUGE XML-code
--== This lua script is like the xml files to create the frames
--===============================================================================================================--
function MangAdmin:CreateFrames()
  local transparency = {
    bg = MangAdmin.db.account.style.transparency.backgrounds,
    btn = MangAdmin.db.account.style.transparency.buttons,
    frm = MangAdmin.db.account.style.transparency.frames
  }
  local color = {
    bg = MangAdmin.db.account.style.color.backgrounds,
    btn = MangAdmin.db.account.style.color.buttons,
    frm = MangAdmin.db.account.style.color.frames
  }
  -- [[ Main Elements ]]
  FrameLib:BuildFrame({
    name = "ma_bgframe",
    group = "bg",
    parent = UIParent,
    texture = {
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
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
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
    },
    size = {
      width = 670,
      height = 22
    },
    setpoint = {
      pos = "TOPLEFT",
      offY = 22,
      offX = 4
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_topframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
  
  -- [[ Tab Buttons ]]
  FrameLib:BuildButton({
    name = "ma_tabbutton_main",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_main_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,1},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_menubgframe",
      relPos = "TOPLEFT",
      offX = 4,
      offY = -4
    },
    text = Locale["tabmenu_Main"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_char",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_char_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_main",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Char"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_tele",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_tele_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_char",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Tele"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_ticket",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_ticket_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 130,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_tele",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Ticket"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_misc",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_misc_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_ticket",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Misc"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_server",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_server_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_misc",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Server"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_log",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_log_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_server",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Log"]
  })
  
  --[[Lookup Buttons]]  
  FrameLib:BuildButton({
    name = "ma_itembutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_itembutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
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
    name = "ma_itemsetbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_itemsetbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -4
    },
    text = Locale["ma_ItemSetButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_spellbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_spellbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 218,
      offY = -4
    },
    text = Locale["ma_SpellButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_questbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_questbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -28
    },
    text = Locale["ma_QuestButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_objectbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_objectbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -28
    },
    text = Locale["ma_ObjectButton"]
  })

  FrameLib:BuildButton({
    name = "ma_creaturebutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_creaturebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 218,
      offY = -28
    },
    text = Locale["ma_CreatureButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_telesearchbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_telesearchbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -52
    },
    text = Locale["ma_TeleSearchButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_sendmailbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_sendmailbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -52
    },
    text = Locale["ma_Mail"]
  })
  
  FrameLib:BuildButton({
    name = "ma_closebutton",
    group = "bg",
    parent = ma_rightframe,
    texture = {
      name = "ma_languagebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 10,
      height = 10
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = "X"
  })
  
  -- [[Popup Frame]]
  FrameLib:BuildFrame({
    name = "ma_popupframe",
    group = "popup",
    parent = UIParent,
    texture = {
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
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
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
  
  FrameLib:BuildButton({
    name = "ma_popupclosebutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_popupclosebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 10,
      height = 10
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = "X"
  })
  
  -- Popup Editbox and Searchbutton
  FrameLib:BuildFontString({
    name = "ma_lookuptext",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    font = {
      size = 20,
      flags = "THICKOUTLINE"
    }
  })

  FrameLib:BuildFontString({
    name = "ma_lookupresulttext",
    group = "popup",
    parent = ma_popuptopframe,
    text = Locale["searchResults"].."0",
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    }
  })

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_searcheditbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 28
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_searchbutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_searchbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 94,
      offY = 28
    },
    text = Locale["ma_SearchButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_resetsearchbutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_resetsearchbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 178,
      offY = 28
    },
    text = Locale["ma_ResetButton"]
  })
  
  FrameLib:BuildFontString({
    name = "ma_var1text",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 8
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_var1editbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 94,
      offY = 4
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildFontString({
    name = "ma_var2text",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 200,
      offY = 8
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_var2editbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 284,
      offY = 4
    },
    inherits = "InputBoxTemplate"
  })
  
  -- Popup Search ScrollFrame
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_PopupScrollBar",
    group = "popup",
    parent = ma_popupmidframe,
    texture = {
      color = {0,0,0,0.7}
    },
    size = {
      width = 400,
      height = 274
    },
    setpoint = {
      pos = "CENTER",
      offX = -10
    },
    inherits = "FauxScrollFrameTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry1",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBar",
      relPos = "TOPLEFT",
      offX = 10,
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry1_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry2",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry1",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry2_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry3",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry2",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry3_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry4",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry3",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry4_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry5",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry4",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry5_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry6",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry5",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry6_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry7",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry6",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry7_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  -- [[Mail Popup]]
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_mailscrollframe",
    group = "popup",
    parent = ma_popupmidframe,
    size = {
      width = 400,
      height = 274
    },
    setpoint = {
      pos = "CENTER",
      offX = -10
    },
    inherits = "UIPanelScrollFrameTemplate"
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_maileditbox",
    group = "popup",
    parent = ma_mailscrollframe,
    texture = {
      name = "ma_maileditbox_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 400,
      --height = 200
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 0,
      offY = 0
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = 0,
      offY = 0
    },
    maxletters = 100000,
    multiline = true,
    textcolor = {0, 0, 0, 1.0}
  })

  -- [[ Group Elements ]]
  -- MAIN
  FrameLib:BuildButton({
    name = "ma_gmonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_gmonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    text = Locale["ma_GMOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_gmoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_gmoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -10
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_flyonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_flyonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -34
    },
    text = Locale["ma_FlyOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_flyoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_flyoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -34
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_hoveronbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_hoveronbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -58
    },
    text = Locale["ma_HoverOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_hoveroffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_hoveroffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -58
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_whisperonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -82
    },
    text = Locale["ma_WhisperOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_whisperoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -82
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_invisibleonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_invisibleonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -106
    },
    text = Locale["ma_InvisOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_invisibleoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_invisibleoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -106
    },
    text = Locale["ma_OffButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_taxicheatonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_taxicheatonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -130
    },
    text = Locale["ma_TaxiOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_taxicheatoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_taxicheatoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -130
    },
    text = Locale["ma_OffButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_ticketonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_ticketonbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -154
    },
    text = "Announce tickets"
  })

  FrameLib:BuildButton({
    name = "ma_ticketoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_ticketoffbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -154
    },
    text = Locale["ma_OffButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_screenshotbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_screenshotbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = Locale["ma_ScreenshotButton"]
  })

  FrameLib:BuildButton({
    name = "ma_bankbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_bankbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -34
    },
    text = Locale["ma_BankButton"]
  })
  
  -- TELE
  FrameLib:BuildFontString({
    name = "ma_gridnavigatortext",
    group = "tele",
    parent = ma_midframe,
    text = Locale["gridnavigator"],
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -2,
      offY = 86
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_gridnavieditbox",
    group = "tele",
    parent = ma_midframe,
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -32,
      offY = 34
    },
    maxLetters = 2,
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnaviaheadbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnaviaheadbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -34,
      offY = 58
    },
    text = "^"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavibackbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavibackbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -34,
      offY = 10
    },
    text = "v"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavirightbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavirightbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 34
    },
    text = ">"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavileftbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavileftbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -58,
      offY = 34
    },
    text = "<"
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

  --CHARACTER
  FrameLib:BuildButton({
    name = "ma_learnallbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnallbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -4
    },
    text = Locale["ma_LearnAllButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learncraftsbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learncraftsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 180,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -4
    },
    text = Locale["ma_LearnCraftsButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learngmbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learngmbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 140,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 318,
      offY = -4
    },
    text = Locale["ma_LearnGMButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learnclassbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnclassbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 200,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 462,
      offY = -4
    },
    text = Locale["ma_LearnClassButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learnlangbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnlangbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -28
    },
    text = Locale["ma_LearnLangButton"]
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_levelupeditbox",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 15,
      offY = -60
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_levelupbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_levelupbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 50,
      offY = -60
    },
    text = Locale["ma_LevelUpButton"]
  })

  FrameLib:BuildFrame({
    type = "Slider",
    name = "ma_speedslider",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 60
    },
    inherits = "OptionsSliderTemplate"
  })

  FrameLib:BuildFrame({
    type = "Slider",
    name = "ma_scaleslider",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 20
    },
    inherits = "OptionsSliderTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_killbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_killbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_KillButton"]
  })

  FrameLib:BuildButton({
    name = "ma_kickbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_kickbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_KickButton"]
  })

  FrameLib:BuildButton({
    name = "ma_dismountbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_dismountbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -178,
      offY = 10
    },
    text = Locale["ma_DismountButton"]
  })

  FrameLib:BuildButton({
    name = "ma_revivebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_revivebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -262,
      offY = 10
    },
    text = Locale["ma_ReviveButton"]
  })

  FrameLib:BuildButton({
    name = "ma_savebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_savebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -346,
      offY = 10
    },
    text = Locale["ma_SaveButton"]
  })

  --TICKET  
  FrameLib:BuildButton({
    name = "ma_showticketsbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_loadticketsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 150,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    text = Locale["ma_LoadTicketsButton"]
  })
  
    
  FrameLib:BuildFontString({
    name = "ma_tpinfo_text",
    group = "ticket",
    parent = ma_midframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -40
    }
  })
  
  FrameLib:BuildButton({
    name = "ma_whisperticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -346,
      offY = 10
    },
    text = "Whisper" --Locale["ma_WhisperButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_getcharticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_getcharticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -262,
      offY = 10
    },
    text = Locale["ma_GetCharTicketButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_gocharticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_gocharticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -178,
      offY = 10
    },
    text = Locale["ma_GoCharTicketButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_answerticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_answerticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_AnswerButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_deleteticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_deleteticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_DeleteButton"]
  })
  
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_ticketscrollframe",
    group = "ticket",
    parent = ma_midframe,
    size = {
      width = 450,
      --height = 200
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -30,
      offY = -10
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = -30,
      offY = 34
    },
    inherits = "UIPanelScrollFrameTemplate"
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_ticketeditbox",
    group = "ticket",
    parent = ma_ticketscrollframe,
    texture = {
      name = "ma_ticketeditbox_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 450,
      height = 200
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 0,
      offY = 0
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = 0,
      offY = 0
    },
    maxletters = 100000,
    multiline = true,
    textcolor = {0, 0, 0, 1.0}
  })
  
  --MISC
  FrameLib:BuildButton({
    type = "CheckButton",
    name = "ma_checktransparencybutton",
    group = "misc",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      offX = 6,
      offY = -4
    },
    text = "Transparency",
    inherits = "OptionsCheckButtonTemplate"
  })
  
  --merker = function()
  
  FrameLib:BuildButton({
    name = "ma_bgcolorshowbutton",
    group = "misc",
    parent = ma_midframe,
    texture = {
      name = "ma_bgcolorshowbutton_texture",
      color = {color.bg.r, color.bg.g, color.bg.b, 1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -34
    }
  })
  
  FrameLib:BuildFontString({
    name = "ma_bgcolorshowtext",
    group = "misc",
    parent = ma_midframe,
    text = "Backgroundcolor",
    setpoint = {
      pos = "LEFT",
      relTo = ma_bgcolorshowbutton,
      offX = 25
    }
  })
  
  FrameLib:BuildButton({
    name = "ma_frmcolorshowbutton",
    group = "misc",
    parent = ma_midframe,
    texture = {
      name = "ma_frmcolorshowbutton_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, 1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -58
    }
  })
  
  FrameLib:BuildFontString({
    name = "ma_frmcolorshowtext",
    group = "misc",
    parent = ma_midframe,
    text = "Framecolor",
    setpoint = {
      pos = "LEFT",
      relTo = ma_frmcolorshowbutton,
      offX = 25
    }
  })
  
  FrameLib:BuildButton({
    name = "ma_btncolorshowbutton",
    group = "misc",
    parent = ma_midframe,
    texture = {
      name = "ma_btncolorshowbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, 1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -82
    }
  })
  
  FrameLib:BuildFontString({
    name = "ma_btncolorshowtext",
    group = "misc",
    parent = ma_midframe,
    text = "Buttoncolor",
    setpoint = {
      pos = "LEFT",
      relTo = ma_btncolorshowbutton,
      offX = 25
    }
  })
  
  FrameLib:BuildButton({
    name = "ma_applystylebutton",
    group = "misc",
    parent = ma_midframe,
    texture = {
      name = "ma_applystylebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -106
    },
    text = "Apply changes"
  })
  
  --SERVER
  FrameLib:BuildFrame({
    name = "ma_netgraphframe",
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
  
  RealGraph=Graph:CreateGraphRealtime("ma_netgraph_lag",ma_netgraphframe,"CENTER","CENTER",0,0,150,150)
  local g=RealGraph
  g:SetAutoScale(true)
  g:SetGridSpacing(1.0,10.0)
  g:SetYMax(120)
  g:SetXAxis(-10,0)
  g:SetMode("RAW")
  g:SetBarColors({0.2,0.0,0.0,0.4},{1.0,0.0,0.0,1.0})
  local f = CreateFrame("Frame",name,parent)
  f.frames=0
  f.NextUpdate=GetTime()
  f:SetScript("OnUpdate",function() 
      if f.NextUpdate>GetTime() then
        return
      end
      local down, up, lag = GetNetStats();
      g:AddBar(lag)
      f.NextUpdate=f.NextUpdate+g.BarWidth
    end)
  f:Show()

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_announceeditbox",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 480,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 15,
      offY = 10
    },
    inherits = "InputBoxTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_announcebutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_announcebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_AnnounceButton"]
  })

  FrameLib:BuildButton({
    name = "ma_resetannouncebutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_resetannouncebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_ResetButton"]
  })

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_shutdowneditbox",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -98,
      offY = -10
    },
    inherits = "InputBoxTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_shutdownbutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_shutdownbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = Locale["ma_ShutdownButton"]
  })

  --FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  --FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  
end
