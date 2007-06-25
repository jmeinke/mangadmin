-- finnish by Lone
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("fiFI", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Suomi",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
  ["charguid"] = "|cFF00FF00Guid:|r ",
  ["favourites"] = "Suosikit",
  ["tabmenu_Main"] = "Päävalikko",
  ["tabmenu_Char"] = "Hahmot",
  ["tabmenu_Tele"] = "Teleportti",
  ["tabmenu_Ticket"] = "GM tiketit",
  ["tabmenu_Server"] = "Serveri",
  ["tabmenu_Log"] = "Loki",
  ["tt_Default"] = "Liikuta hiiren kursori kohteen päälle nähdäksesi neuvoja!",
  ["tt_MainButton"] = "MangAdminin päämenu",
  ["tt_CharButton"] = "Työn alla",
  ["tt_TeleButton"] = "Työn alla",
  ["tt_TicketButton"] = "Työn alla",
  ["tt_ServerButton"] = "Näytä serverin realmien nykyinen tila sekä tee serveriin liittyviä muokkauksia.",
  ["tt_LogButton"] = "Näytä MangAdminilla tehtyjen toimenpiteiden loki.",
  ["tt_LanguageDropdown"] = "Clickthis button to change MangAdmins language.",
  ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
  ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
  ["ma_ToggleGMButton"] = "GM-mode",
  ["ma_ToggleFlyButton"] = "Fly-mode"
} end)