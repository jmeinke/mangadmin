local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("frFR", function() return {
	["slashcmds"] = { "/mangadmin", "/ma" },
	["lang"] = "Francais",
	["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player"),
	["favourites"] = "Favorits",
	["tabmenu_Main"] = "Main",
	["tabmenu_Char"] = "Charackter",
	["tabmenu_Tele"] = "Teleport",
	["tabmenu_Ticket"] = "Ticketsystem",
	["tabmenu_Server"] = "Serveur",
	["tabmenu_Log"] = "Log",
	["tt_Default"] = "Move your cursor over an element to toggle the tooltip!",
	["tt_MainButton"] = "Click this button to toggle MangAdmins Mainframe.",
	["tt_CharButton"] = "Todo.",
	["tt_TeleButton"] = "Todo.",
	["tt_TicketButton"] = "Todo.",
	["tt_ServerButton"] = "Klicke diesen Button um ein Fenster mit Informationen über den Server des aktuellen Realms anzuzeigen.",
	["tt_LogButton"] = "Klicke diesen Button um ein Fenster mit einem Protokoll aller bisher ausgeführten Aktionen von MangAdmin anzuzeigen."
} end)