-- german by Josh
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("deDE", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "German",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player"),
  ["favourites"] = "Favoriten",
  ["tabmenu_Main"] = "Main",
  ["tabmenu_Char"] = "Charackter",
  ["tabmenu_Tele"] = "Teleport",
  ["tabmenu_Ticket"] = "Ticketsystem",
  ["tabmenu_Server"] = "Server",
  ["tabmenu_Log"] = "Log",
  ["tt_Default"] = "Bewege deine Maus \195\188ber ein Element um die jeweils dazugeh\195\182rige Hilfe anzuzeigen!",
  ["tt_MainButton"] = "Klicke diesen Button um das Hauptfenster von MangAdmin anzuzeigen.",
  ["tt_CharButton"] = "Todo.",
  ["tt_TeleButton"] = "Todo.",
  ["tt_TicketButton"] = "Todo.",
  ["tt_ServerButton"] = "Klicke diesen Button um ein Fenster mit Informationen \195\188ber den Server des aktuellen Realms anzuzeigen.",
  ["tt_LogButton"] = "Klicke diesen Button um ein Fenster mit einem Protokoll aller bisher ausgef\195\188hrten Aktionen von MangAdmin anzuzeigen.",
  ["tt_ToogleGMButton"] = "Klicke diesen Button um dich als GM anzeigen zu lassen.",
  ["ma_tooglegmbutton"] = "Toggle GM"
} end)