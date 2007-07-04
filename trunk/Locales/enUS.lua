-- english by Josh
function Return_enUS()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "English",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["tabmenu_Main"] = "Main",
    ["tabmenu_Char"] = "Character",
    ["tabmenu_Tele"] = "Teleport",
    ["tabmenu_Ticket"] = "Ticketsystem",
    ["tabmenu_Server"] = "Server",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Move your cursor over an element to toggle the tooltip!",
    ["tt_MainButton"] = "Click this button to toggle MangAdmins Mainframe.",
    ["tt_CharButton"] = "Todo.",
    ["tt_TeleButton"] = "Todo.",
    ["tt_TicketButton"] = "Todo.",
    ["tt_ServerButton"] = "Click this button to show several server informations and do actions concerning the server.",
    ["tt_LogButton"] = "Click this button to show the log of all actions done with MangAdmin.",
    ["tt_LanguageButton"] = "Click this button to change the language and reload MangAdmin.",
    ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
    ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
    ["tt_SpeedSlider"] = "Slide this slider to increase or decrease the speed for the targeted character.",
    ["tt_ItemButton"] = "Click this button to toggle a popup with the function to search for items and manage your favorites.",
    ["tt_SpellButton"] = "Click this button to toggle a popup with the function to search for spells and manage your favorites.",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Change language",
    ["ma_ToggleGMButton"] = "GM-mode",
    ["ma_ToggleFlyButton"] = "Fly-mode"
  }
end
