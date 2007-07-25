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
    ["tt_LanguageButton"] = "Clicca questo pulsante per cambiare la Lingua e ricaricare MangAdmin.",
    ["tt_ToggleGMButton"] = "Clicca questo pulsante per attivare/disattivare la Modalit\195\160 GM.",
    ["tt_ToggleFlyButton"] = "Clicca questo pulsante per attivare/disattivare la Modalit\195\160 Volo",
    ["tt_SpeedSlider"] = "Scorri questa barra per aumentare/ridurre la Velocità per il Personaggio selezionato.",
    ["tt_ScaleSlider"] = "Scorri questa barra per aumentare/ridurre la Dimensione per il Personaggio selezionato.",
    ["tt_ItemButton"] = "Clicca questo pulsante per attivare/disattivare un popup con la funzione di ricerca degli Items e per gestire i tuoi preferiti.",
    ["tt_SpellButton"] = "Clicca questo pulsante per attivare/disattivare un popup con la funzione di ricerca delle Spells e per gestire le tue preferite.",
    ["tt_SearchDefault"] = "Ora puoi inserire una parola chiave ed iniziare la ricerca.",
    ["tt_AnnounceButton"] = "Clicca per annunciare un System Message.",
    ["tt_KickButton"] = "Clicca per kickare il Personaggio selezionato dal Server.",
    ["tt_ShutdownButton"] = "Clicca per eseguire uno Shutdown del Server nell'ammontare di secondi inseriti nel campo (se omesso, lo Shutdown sar\195\160 immediato!).",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Cambia Lingua",
    ["ma_ToggleGMButton"] = "Modalit\195\160 GM",
    ["ma_ToggleFlyButton"] = "Modalit\195\160 Volo",
    ["ma_LearnAllButton"] = "Tutte le spells",
    ["ma_LearnCraftsButton"] = "Tutte le Professioni e Recipes",
    ["ma_LearnGMButton"] = "Spells predefinite per GM",
    ["ma_LearnLangButton"] = "Tutte le lingue",
    ["ma_LearnClassButton"] = "Tutte le Spells di classe",
    ["ma_SearchButton"] = "Cerca...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Announce",
    ["ma_ShutdownButton"] = "Shutdown!"
  }
end
