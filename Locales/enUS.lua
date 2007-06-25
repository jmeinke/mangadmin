-- english by Josh
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("enUS", function() return {
	["slashcmds"] = { "/mangadmin", "/ma" },
	["lang"] = "English",
	["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
  ["charguid"] = "|cFF00FF00Guid:|r ",
	["favourites"] = "Favourites",
	["tabmenu_Main"] = "Main",
	["tabmenu_Char"] = "Charackter",
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
  ["tt_LanguageDropdown"] = "Clickthis button to change MangAdmins language.",
  ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
  ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
  ["ma_ToggleGMButton"] = "GM-mode",
  ["ma_ToggleFlyButton"] = "Fly-mode"
} end)