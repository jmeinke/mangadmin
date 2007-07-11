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

function Return_fiFI() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Suomi",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["tabmenu_Main"] = "P\195\177\195\177valikko",
    ["tabmenu_Char"] = "Hahmot",
    ["tabmenu_Tele"] = "Teleportti",
    ["tabmenu_Ticket"] = "GM tiketit",
    ["tabmenu_Server"] = "Serveri",
    ["tabmenu_Log"] = "Loki",
    ["tt_Default"] = "Liikuta hiiren kursori kohteen p\195\177\195\177lle n\195\177hd\195\177ksesi neuvoja!",
    ["tt_MainButton"] = "MangAdminin p\195\177\195\177menu",
    ["tt_CharButton"] = "Ty\195\182n alla",
    ["tt_TeleButton"] = "Ty\195\182n alla",
    ["tt_TicketButton"] = "Ty\195\182n alla",
    ["tt_ServerButton"] = "N\195\177yt\195\177 serverin realmien nykyinen tila sek\195\177 tee serveriin liittyvi\195\177 muokkauksia.",
    ["tt_LogButton"] = "N\195\177yt\195\177 MangAdminilla tehtyjen toimenpiteiden loki.",
    ["tt_LanguageButton"] = "Click this button to change the language and reload MangAdmin.",
    ["tt_ToggleGMButton"] = "Painamalla t\195\177st\195\177 sallit GM-moodi napin k\195\177yt\195\182n.",
    ["tt_ToggleFlyButton"] = "Painamalla t\195\177st\195\177 sallit Lento-moodi napin k\195\177yt\195\182n",
    ["tt_SpeedSlider"] = "Slide this slider to increase or decrease the speed for the selected character.",
    ["tt_ScaleSlider"] = "Slide this slider to increase or decrease the scale for the selected character.",
    ["tt_ItemButton"] = "Click this button to toggle a popup with the function to search for items and manage your favorites.",
    ["tt_SpellButton"] = "Click this button to toggle a popup with the function to search for spells and manage your favorites.",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Change language",
    ["ma_ToggleGMButton"] = "GM-moodi",
    ["ma_ToggleFlyButton"] = "Lento-moodi"
  }
end
