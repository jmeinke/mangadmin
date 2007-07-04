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

function Return_frFR() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "French",
    ["logged"] = "|cFF00FF00Royaume:|r "..GetCVar("realmName").." |cFF00FF00Personnage:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["tabmenu_Main"] = "Accueil",
    ["tabmenu_Char"] = "Personnage",
    ["tabmenu_Tele"] = "Teleportations",
    ["tabmenu_Ticket"] = "Syst√\168me de support",
    ["tabmenu_Server"] = "Serveur",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "D\195\169placez votre curseur sur une ic\195\180ne pour activer l'outil correspondant.",
    ["tt_MainButton"] = "Cliquez sur ce bouton pour activer la page de garde.",
    ["tt_CharButton"] = "Todo.",
    ["tt_TeleButton"] = "Todo.",
    ["tt_TicketButton"] = "Todo.",
    ["tt_ServerButton"] = "Cliquez sur ce bouton pour avoir des infomations sur le serveur.",
    ["tt_LogButton"] = "Cliquez sur ce bouton pour acc\195\169der au protocole de gestion des ench√\168res.",
    ["tt_LanguageButton"] = "Click this button to change the language and reload MangAdmin.",
    ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
    ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
    ["tt_SpeedSlider"] = "Slide this slider to increase or decrease the speed for the targeted character.",
    ["tt_ItemButton"] = "Click this button to toggle a popup with the function to search for items and manage your favorites.",
    ["tt_SpellButton"] = "Click this button to toggle a popup with the function to search for spells and manage your favorites.",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Change language",
    ["ma_ToggleGMButton"] = "GM-mode",
    ["ma_ToggleFlyButton"] = "Fly-mode"
  }
end