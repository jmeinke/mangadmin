
MangAdmin2 = LibStub("AceAddon-3.0"):NewAddon("MangAdmin2", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("MangAdmin2")


local options = {
  name = "WelcomeHome",
  handler = MangAdmin2,
  type = "group",
  args = {
    msg = {
      type = "input",
      name = L["Message"],
      desc = L["The message to be displayed when you get home."],
      usage = L["<Your message>"],
      get = "GetMessage",
      set = "SetMessage",
    },
    showInChat = {
      type = "toggle",
      name = L["Show in Chat"],
      desc = L["Toggles the display of the message in the chat window."],
      get = "IsShowInChat",
      set = "ToggleShowInChat",
    },
    showOnScreen = {
      type = "toggle",
      name = L["Show on Screen"],
      desc = L["Toggles the display of the message on the screen."],
      get = "IsShowOnScreen",
      set = "ToggleShowOnScreen",
    },
  },
}

function MangAdmin2:OnInitialize()
  -- Called when the addon is loaded
  self.db = LibStub("AceDB-3.0"):New("WelcomeHomeDB", defaults, "Default")

  LibStub("AceConfig-3.0"):RegisterOptionsTable("MangAdmin2", options)
  --self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MangAdmin2", "MangAdmin2")
  self:RegisterChatCommand("wh", "ChatCommand")
  self:RegisterChatCommand("welcomehome", "ChatCommand")
end

function MangAdmin2:OnEnable()
  -- Called when the addon is enabled
  self:RegisterEvent("ZONE_CHANGED")
end

function MangAdmin2:ZONE_CHANGED()
  if GetBindLocation() == GetSubZoneText() then
    if self.db.profile.showInChat then
      self:Print(self.db.profile.message)
    end

    if self.db.profile.showOnScreen then
      UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
    end
  end
end

function MangAdmin2:ChatCommand(input)
  if not input or input:trim() == "" then
    InterfaceOptionsFrame_OpenToFrame(self.optionsFrame)
  else
    LibStub("AceConfigCmd-3.0").HandleCommand(MangAdmin2, "wh", "WelcomeHome", input)
  end
end

function MangAdmin2:GetMessage(info)
  return self.db.profile.message
end

function MangAdmin2:SetMessage(info, newValue)
  self.db.profile.message = newValue
end

function MangAdmin2:IsShowInChat(info)
  return self.db.profile.showInChat
end

function MangAdmin2:ToggleShowInChat(info, value)
  self.db.profile.showInChat = value
end

function MangAdmin2:IsShowOnScreen(info)
  return self.db.profile.showOnScreen
end

function MangAdmin2:ToggleShowOnScreen(info, value)
  self.db.profile.showOnScreen = value
end
