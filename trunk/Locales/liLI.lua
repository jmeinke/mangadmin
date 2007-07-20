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
--
-------------------------------------------------------------------------------------------------------------

function Return_liLI()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Lietuviu",
    ["logged"] = "|cFF00FF00Karalyste:|r "..GetCVar("realmName").." |cFF00FF00Veikejas:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Please select yourself or another player or nothing!",
    ["tabmenu_Main"] = "Pagrindinis",
    ["tabmenu_Char"] = "Veikejas",
    ["tabmenu_Tele"] = "Perkelimas",
    ["tabmenu_Ticket"] = "Bilieteliai",
    ["tabmenu_Server"] = "Serveris",
    ["tabmenu_Log"] = "Irasai",
    ["tt_Default"] = "Uzvesk pelyte and elementu, kad suzinoti ka jie daro!",
    ["tt_MainButton"] = "Spauskite si mygtuka kad sugrysti i MangAdmins pradzia.",
    ["tt_CharButton"] = "Todo.",
    ["tt_TeleButton"] = "Todo.",
    ["tt_TicketButton"] = "Todo.",
    ["tt_ServerButton"] = "Spausk si mygtuka kad pamatytum siek tiek serverio informacijos ir kad galetum atlikti keleta veiksmu susijusiu su serveriu.",
    ["tt_LogButton"] = "Spausk cia kad rodyti visus veiksmus kurie buvo atlikti MangAdmin priedo pagalba.",
    ["tt_LanguageButton"] = "Spausk cia kad pakeisti kalba ir perkrauti MangAdmin.",
    ["tt_ToggleGMButton"] = "Spausk si mygtuka, kad ijungti GM-rezima.",
    ["tt_ToggleFlyButton"] = "Spausk si mygtuka, kad ijungti Fly-rezima",
    ["tt_SpeedSlider"] = "Paslink si slideri, kad padidintum arba sumazintum pasirinkto zaidejo greiti.",
    ["tt_ScaleSlider"] = "Slide this slider to increase or decrease the scale for the selected character.",
    ["tt_ItemButton"] = "Spausk si mygtuka kad atidaryti langa su galimybe ieskoti daiktu, bei sudaryti savo populiariu daiktu sarasa.",
    ["tt_SpellButton"] = "Spausk si mygtuka kad atidaryti langa su galimybe ieskoti magiju, bei sudaryti savo populiariu magiju sarasa.",
    ["tt_SearchDefault"] = "Now you can enter a keyword and start the search.",
    ["tt_AnnounceButton"] = "Click to announce a system message.",
    ["tt_KickButton"] = "Click to kick the selected player from the server.",
    ["tt_ShutdownButton"] = "Click to shut down the server in the amount of seconds from the field, if omitted shut down immediately!",
    ["ma_ItemButton"] = "Daiktai",
    ["ma_SpellButton"] = "Burtai",
    ["ma_LanguageButton"] = "Pakeisti kalba",
    ["ma_ToggleGMButton"] = "GM-Rezimas",
    ["ma_ToggleFlyButton"] = "Fly-Rezimas",
    ["ma_LearnAllButton"] = "All spells",
    ["ma_LearnCraftsButton"] = "All professions and recipes",
    ["ma_LearnGMButton"] = "Default GM spells",
    ["ma_LearnLangButton"] = "All languages",
    ["ma_LearnClassButton"] = "All class-spells",
    ["ma_SearchButton"] = "Search...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Announce",
    ["ma_ShutdownButton"] = "Shut down!"
  }
end
