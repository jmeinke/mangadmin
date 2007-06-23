--polish by sahib
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("plPL", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Polish",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player"),
  ["favourites"] = "Ulubione",
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
  ["tt_ToogleGMButton"] = "Click this button to toggle the GameMaster mode.",
  ["ma_tooglegmbutton"] = "Toggle GM"
} end)