--polish by sahib
function Return_plPL() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Polish",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["tabmenu_Main"] = "Gl\195\179wna",
    ["tabmenu_Char"] = "Postac",
    ["tabmenu_Tele"] = "Teleport",
    ["tabmenu_Ticket"] = "System ticket\195\179w",
    ["tabmenu_Server"] = "Serwer",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Przesun kursor nad element aby zobaczyc podpowiedz",
    ["tt_MainButton"] = "Nacisnij, aby przejsc do strony gl\195\179wnej",
    ["tt_CharButton"] = "Todo.",
    ["tt_TeleButton"] = "Todo.",
    ["tt_TicketButton"] = "Todo.",
    ["tt_ServerButton"] = "Nacisnij przycisk, aby wyswietlic informacje o serwerze i przeprowadzic na nim operacje.",
    ["tt_LogButton"] = "Nacisnij przycisk, aby zobaczyc historie operacji wykonanych przez MangAdmin.",
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
