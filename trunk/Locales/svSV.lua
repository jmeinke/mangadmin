-- swedish by dxers
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("svSV", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Svenska",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Karaktär:|r "..UnitName("player"),
  ["favourites"] = "Favoriter",
  ["tabmenu_Main"] = "Huvudmeny",
  ["tabmenu_Char"] = "Karaktärer",
  ["tabmenu_Tele"] = "Teleportering",
  ["tabmenu_Ticket"] = "Biljett system",
  ["tabmenu_Server"] = "Server",
  ["tabmenu_Log"] = "Log",
  ["tt_Default"] = "Flytta din muspekare över ett element för att aktivera tooltipen!",
  ["tt_MainButton"] = "Tryck på den här knappen för att visa MangAdmin huvudmeny.",
  ["tt_CharButton"] = "Inte klart.",
  ["tt_TeleButton"] = "Inte klar.",
  ["tt_TicketButton"] = "Inte klart.",
  ["tt_ServerButton"] = "Tryck på den här knappen för att öppna ett fönster med information om servern på den aktuella realmen.",
  ["tt_LogButton"] = "Tryck på den här knappen för att öppna ett protokoll över allting som du/MangAdmin har gjort än så länge."
} end)