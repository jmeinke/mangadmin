-------------------------------------------------------------------------------------------------------------
--
-- MangAdmin Version 1.0
--
-- Copyright (C) 2007 Free Software Foundation, Inc.
-- License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
-- This is free software: you are free to change and redistribute it.
-- There is NO WARRANTY, to the extent permitted by law.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--   Official Website    : http://mangadmin.all-mag.de
-- GoogleCode Website    : http://code.google.com/p/mangadmin/
-- Subversion Repository : http://mangadmin.googlecode.com/svn/
-------------------------------------------------------------------------------------------------------------

-- Czech Mangos Testing  : http://wow.fakaheda.eu/
-- Czech Mangos Support  : http://wow.fakaheda.eu/forum

function Return_csCZ()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Czech",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Prosím vyberte sebe, jiný charakter nebo nic!",
    ["tabmenu_Main"] = "Hlavní",
    ["tabmenu_Char"] = "Postava",
    ["tabmenu_Tele"] = "Teleport",
    ["tabmenu_Ticket"] = "Ticket System",
    ["tabmenu_Server"] = "Server",
    ["tabmenu_Log"] = "Záznam",
    ["tt_Default"] = "Prejeďte kurzorem přes element pro aktivaci nápovědy!",
    ["tt_MainButton"] = "Klikni sem pro návrat na hlavní obrazovku MangAdmina.",
    ["tt_CharButton"] = "Klikni sem pro přepnutí na editaci postav.",
    ["tt_TeleButton"] = "Klikni sem pro přepnutí na obrazovku teleportací.",
    ["tt_TicketButton"] = "Klikni sem pro přepnutí na správu ticketu.",
    ["tt_ServerButton"] = "Klikni sem pro zobrazení informací o serveru a pro nastavení věcí týkajících se serveru.",
    ["tt_LogButton"] = "Klikni sem pro zobrazení záznamu všech akcí provedených MangAdminem.",
    ["tt_LanguageButton"] = "Klikni sem pro změnu výchozího jazyka a restart MangAdmina.",
    ["tt_ToggleGMButton"] = "Klikni sem pro přepnutí GM režimu.",
    ["tt_ToggleFlyButton"] = "Klikni sem pro přepnutí Fly režimu.",
    ["tt_SpeedSlider"] = "Posunutím jezdce zvětšíš nebo zmenšíš rychlost vybrané postavy.",
    ["tt_ScaleSlider"] = "Posunutím jezdce zvětšíš nebo zmenšíš vybranou postavu.",
    ["tt_ItemButton"] = "Klikni sem pro přepnutí na správu předmetů, funkce hledání věcí, správu položek oblíbených.",
    ["tt_SpellButton"] = "Klikni sem pro přepnutí na správu kouzel, funce hledání kouzel, správu položek oblíbených.",
    ["tt_SearchDefault"] = "Vložte klíčové slovo a můžete spustit vyhledávání.",
    ["tt_AnnounceButton"] = "Klikni pro odeslání systémové zprávy.",
    ["tt_KickButton"] = "Klikni pro vykopnutí vybraného hráče ze serveru.",
    ["tt_ShutdownButton"] = "Klikni pro vypnutí serveru za definované množství sekund. Pokud nespecifikováno, server bude vypnut okamžitě!",
    ["ma_ItemButton"] = "Předmety",
    ["ma_SpellButton"] = "Kouzla",
    ["ma_LanguageButton"] = "Změnit Jazyk",
    ["ma_ToggleGMButton"] = "GM režim",
    ["ma_ToggleFlyButton"] = "Fly režim",
    ["ma_LearnAllButton"] = "Všechna kouzla",
    ["ma_LearnCraftsButton"] = "Všechny profese a recepty",
    ["ma_LearnGMButton"] = "Základní GM kouzla",
    ["ma_LearnLangButton"] = "Všechny jazyky",
    ["ma_LearnClassButton"] = "Všechna kouzla dané profese",
    ["ma_SearchButton"] = "Hledat...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Vykopnout",
    ["ma_AnnounceButton"] = "Zveřejnit",
    ["ma_ShutdownButton"] = "Vypnout!"
  }
end
