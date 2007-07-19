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

function Return_itIT() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Italian",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Please select yourself or another player or nothing!",
    ["tabmenu_Main"] = "Generale",
    ["tabmenu_Char"] = "Personaggio",
    ["tabmenu_Tele"] = "Teletrasporto",
    ["tabmenu_Ticket"] = "Ticket System",
    ["tabmenu_Server"] = "Server",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Sposta il mouse su di un elemento per visualizzarne la descrizione!",
    ["tt_MainButton"] = "Clicca questo pulsante per attivare/disattivare la finestra di MangAdmin.",
    ["tt_CharButton"] = "Esegui.",
    ["tt_TeleButton"] = "Esegui.",
    ["tt_TicketButton"] = "Esegui.",
    ["tt_ServerButton"] = "Clicca questo pulsante per mostrare info sul Server e per interagire con esso.",
    ["tt_LogButton"] = "Clicca questo pulsante per mostrare il Log delle azioni fatte con MangAdmin.",
    ["tt_LanguageButton"] = "Click this button to change the language and reload MangAdmin.",
    ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
    ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
    ["tt_SpeedSlider"] = "Slide this slider to increase or decrease the speed for the selected character.",
    ["tt_ScaleSlider"] = "Slide this slider to increase or decrease the scale for the selected character.",
    ["tt_ItemButton"] = "Click this button to toggle a popup with the function to search for items and manage your favorites.",
    ["tt_SpellButton"] = "Click this button to toggle a popup with the function to search for spells and manage your favorites.",
    ["tt_SearchDefault"] = "Now you can enter a keyword and start the search.",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Change language",
    ["ma_ToggleGMButton"] = "GM-mode",
    ["ma_ToggleFlyButton"] = "Fly-mode",
    ["ma_LearnAllButton"] = "All spells",
    ["ma_LearnCraftsButton"] = "All professions and recipes",
    ["ma_LearnGMButton"] = "Default GM spells",
    ["ma_LearnLangButton"] = "All languages",
    ["ma_LearnClassButton"] = "All class-spells",
    ["ma_SearchButton"] = "Search...",
    ["ma_ResetButton"] = "Reset"
  }
end
