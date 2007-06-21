--polish by gerard
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("plPL", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Polish",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player"),
  ["favourites"] = "Favourites",
  ["tabmenu_Main"] = "Glówna",
  ["tabmenu_Char"] = "Postac",
  ["tabmenu_Tele"] = "Teleport",
  ["tabmenu_Ticket"] = "System Ticketów",
  ["tabmenu_Server"] = "Serwer",
  ["tabmenu_Log"] = "Log",
  ["tt_Default"] = "Przesun kursor na element aby zobczyc podpowiedz!",
  ["tt_MainButton"] = "Nacisnij aby przejsc do glównej strony.",
  ["tt_CharButton"] = "Todo.",
  ["tt_TeleButton"] = "Todo.",
  ["tt_TicketButton"] = "Todo.",
	["tt_ServerButton"] = "Click this button to show several server informations and do actions concerning the server.",
	["tt_LogButton"] = "Click this button to show the log of all actions done with MangAdmin."
} end)