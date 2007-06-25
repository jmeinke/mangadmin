-- swedish by dxers
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("svSV", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Svenska",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Karakt\195\164r:|r "..UnitName("player").." ",
  ["charguid"] = "|cFF00FF00Guid:|r ",
  ["favourites"] = "Favoriter",
  ["tabmenu_Main"] = "Huvudmeny",
  ["tabmenu_Char"] = "Karakt\195\164rer",
  ["tabmenu_Tele"] = "Teleportering",
  ["tabmenu_Ticket"] = "Biljett system",
  ["tabmenu_Server"] = "Server",
  ["tabmenu_Log"] = "Log",
  ["tt_Default"] = "Flytta din muspekare \195\182ver ett element f\195\182r att aktivera tooltipen!",
  ["tt_MainButton"] = "Tryck på den h\195\164r knappen f\195\182r att visa MangAdmin huvudmeny.",
  ["tt_CharButton"] = "Inte klart.",
  ["tt_TeleButton"] = "Inte klar.",
  ["tt_TicketButton"] = "Inte klart.",
  ["tt_ServerButton"] = "Tryck på den h\195\164r knappen f\195\182r att \195\182ppna ett f\195\182nster med information om servern på den aktuella realmen.",
  ["tt_LogButton"] = "Tryck på den h\195\164r knappen f\195\182r att \195\182ppna ett protokoll \195\182ver allting som du/MangAdmin har gjort \195\164n så l\195\164nge.",
  ["tt_LanguageDropdown"] = "Clickthis button to change MangAdmins language.",
  ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
  ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
  ["ma_ToggleGMButton"] = "GM-mode",
  ["ma_ToggleFlyButton"] = "Fly-mode"
} end)