﻿-------------------------------------------------------------------------------------------------------------
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
--
-------------------------------------------------------------------------------------------------------------

function Return_roRO()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Romania",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Please select yourself or another player or nothing!",
    ["tabmenu_Main"] = "Main",
    ["tabmenu_Char"] = "Character",
    ["tabmenu_Tele"] = "Teleportare",
    ["tabmenu_Ticket"] = "Ticketsystem",
    ["tabmenu_Server"] = "Server",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Misca cursorul deasupra unui element pentru a afla mai multe informatii!",
    ["tt_MainButton"] = "Apasa aici pentru a activa Fereastra principala MangAdmin.",
    ["tt_CharButton"] = "In curs de desfasurare.",
    ["tt_TeleButton"] = "In curs de desfasurare.",
    ["tt_TicketButton"] = "In curs de desfasurare.",
    ["tt_ServerButton"] = "Apasa acest buton pentru a arata anumite informatii si actiuni despre server.",
    ["tt_LogButton"] = "Apasa acest buton pentru a arata arhiva cu actiunile desfasurate cu MangAdmin.",
    ["tt_LanguageButton"] = "Apasa acest buton pentru a schimba limba si pentru a reincarca MangAdmin.",
    ["tt_ToggleGMButton"] = "Apasa acest buton pentru a activa GM-mode (modul gm).",
    ["tt_ToggleFlyButton"] = "Apasa acest buton pentru a activa Fly-mode (modul zburator).",
    ["tt_SpeedSlider"] = "Misca aceasta bara in stanga sau in dreapta pentru a mari sau a micsora viteza caracterului selectat.",
    ["tt_ScaleSlider"] = "Slide this slider to increase or decrease the scale for the selected character.",
    ["tt_ItemButton"] = "Apasa acest buton pentru a activa o noua fereastra care va avea rolul de a cauta iteme noi sau de a le  mentena pe cele deja existente.",
    ["tt_SpellButton"] = "Apasa acest buton pentru a activa o noua fereastra ceva va avea rolul de a cauta spell-uri noi sau de a le mentena pe cele deja existente.",
    ["tt_SearchDefault"] = "Now you can enter a keyword and start the search.",
    ["tt_AnnounceButton"] = "Click to announce a system message.",
    ["tt_KickButton"] = "Click to kick the selected player from the server.",
    ["tt_ShutdownButton"] = "Click to shut down the server in the amount of seconds from the field, if omitted shut down immediately!",
    ["ma_ItemButton"] = "Iteme",
    ["ma_SpellButton"] = "Spell-uri",
    ["ma_LanguageButton"] = "Schimba limba",
    ["ma_ToggleGMButton"] = "GM-mode",
    ["ma_ToggleFlyButton"] = "Fly-mode",
    ["ma_LearnAllButton"] = "All spells",
    ["ma_LearnCraftsButton"] = "All professions and recipes",
    ["ma_LearnGMButton"] = "Default GM spells",
    ["ma_LearnLangButton"] = "All languages",
    ["ma_LearnClassButton"] = "All class-spells",
    ["ma_SearchButton"] = "Search...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Announce",
    ["ma_ShutdownButton"] = "Shutdown!"
  }
end
