-- finnish by Seizer
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("fiFI", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Finnish",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("Realmin nimi").." |cFF00FF00Char:|r "..UnitName("Pelaaja"),
  ["favourites"] = "Suosikit",
  ["tabmenu_Main"] = "Päävalikko",
  ["tabmenu_Char"] = "Hahmot",
  ["tabmenu_Tele"] = "Teleportti",
  ["tabmenu_Ticket"] = "Gm tiketit",
  ["tabmenu_Server"] = "Serveri",
  ["tabmenu_Log"] = "Serverin loki",
  ["tt_Default"] = "Liikuta hiiren kursori kohteen päälle nähdäksesi neuvoja!",
  ["tt_MainButton"] = "MangAdminin päämenu",
  ["tt_CharButton"] = "Työn alla",
  ["tt_TeleButton"] = "Työn alla",
  ["tt_TicketButton"] = "Työn alla",
  ["tt_ServerButton"] = "Näytä serverin realmien nykyinen tila sekä muuta infoa.",
  ["tt_LogButton"] = "MangAdminin loki."
} end)