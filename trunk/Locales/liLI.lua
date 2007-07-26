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
    ["selectionerror2"] = "Please select only yourself or nothing!",
    ["selectionerror3"] = "Please select only another player!",
    ["selectionerror4"] = "Please select only a NPC!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "Pagrindinis",
    ["tabmenu_Char"] = "Veikejas",
    ["tabmenu_Tele"] = "Perkelimas",
    ["tabmenu_Ticket"] = "Bilieteliai",
    ["tabmenu_Misc"] = "Miscellaneous",
    ["tabmenu_Server"] = "Serveris",
    ["tabmenu_Log"] = "Irasai",
    ["tt_Default"] = "Uzvesk pelyte and elementu, kad suzinoti ka jie daro!",
    ["tt_MainButton"] = "Spauskite si mygtuka kad sugrysti i MangAdmins pradzia.",
    ["tt_CharButton"] = "Click to toggle a window with character-specific actions.",
    ["tt_TeleButton"] = "Click to toggle a window with teleport-functions.",
    ["tt_TicketButton"] = "Click to toggle a window which shows all tickets and lets you administrate them.",
    ["tt_MiscButton"] = "Click to toggle a window with miscellaneous actions.",
    ["tt_ServerButton"] = "Spausk si mygtuka kad pamatytum siek tiek serverio informacijos ir kad galetum atlikti keleta veiksmu susijusiu su serveriu.",
    ["tt_LogButton"] = "Spausk cia kad rodyti visus veiksmus kurie buvo atlikti MangAdmin priedo pagalba.",
    ["tt_LanguageButton"] = "Spausk cia kad pakeisti kalba ir perkrauti MangAdmin.",
    ["tt_GMOnButton"] = "Click to activate your GM-mode.",
    ["tt_GMOffButton"] = "Click to deactivate your GM-mode.",
    ["tt_FlyOnButton"] = "Click to activate the Fly-mode for the selected character.",
    ["tt_FlyOffButton"] = "Click to deactivate the Fly-mode for the selected character.",
    ["tt_HoverOnButton"] = "Click to activate your Hover-mode.",
    ["tt_HoverOffButton"] = "Click to deactivate your Hover-mode.",
    ["tt_WhispOnButton"] = "Click to accept whispers from other players.",
    ["tt_WhispOffButton"] = "Click to not accept whispers from other players.",
    ["tt_InvisOnButton"] = "Click to make you invisible.",
    ["tt_InvisOffButton"] = "Click to make you visible.",
    ["tt_TaxiOnButton"] = "Click to show all taxi-routes to the selected player. This cheat will be deactivated on logout.",
    ["tt_TaxiOffButton"] = "Click to deactivate the taxi-cheat and restore the players known taxi-routes.",
    ["tt_BankButton"] = "Click to show your bank.",
    ["tt_ScreenButton"] = "Click to make a screenshot.",
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
    ["ma_GMOnButton"] = "GM-mode on",
    ["ma_FlyOnButton"] = "Fy-mode on",
    ["ma_HoverOnButton"] = "Hover-mode on",
    ["ma_WhisperOnButton"] = "Whisper on",
    ["ma_InvisOnButton"] = "Invisibility on",
    ["ma_TaxiOnButton"] = "Taxicheat on",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Bank",
    ["ma_OffButton"] = "Off",
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
