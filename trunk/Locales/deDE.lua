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

function Return_deDE() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "German",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Bitte selektiere nur dich selbst, einen anderen Spieler, oder gar nichts!",
    ["tabmenu_Main"] = "Main",
    ["tabmenu_Char"] = "Charakter",
    ["tabmenu_Tele"] = "Teleport",
    ["tabmenu_Ticket"] = "Ticketsystem",
    ["tabmenu_Server"] = "Server",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Bewege deine Maus \195\188ber ein Element um die jeweils dazugeh\195\182rige Hilfe anzuzeigen!",
    ["tt_MainButton"] = "Klicke um das Hauptfenster von MangAdmin anzuzeigen.",
    ["tt_CharButton"] = "Todo.",
    ["tt_TeleButton"] = "Todo.",
    ["tt_TicketButton"] = "Todo.",
    ["tt_ServerButton"] = "Klicke um ein Fenster mit Informationen \195\188ber den Server des aktuellen Realms anzuzeigen.",
    ["tt_LogButton"] = "Klicke um ein Fenster mit einem Protokoll aller bisher ausgef\195\188hrten Aktionen von MangAdmin anzuzeigen.",
    ["tt_LanguageButton"] = "Klicke um die Sprache von MangAdmin zu \195\164ndern und anschliessend neu zu laden.",
    ["tt_ToggleGMButton"] = "Klicke um den GameMaster-Modus zu aktivieren oder zu deaktivieren.",
    ["tt_ToggleFlyButton"] = "Klicke um den Flug-Modus zu aktivieren oder zu deaktivieren.",
    ["tt_SpeedSlider"] = "Verschiebe den Regler auf die gew\195\188nschte Position um die Schnelligkeit des ausgew\195\164hlten Charakters zu ver\195\164ndern.",
    ["tt_ScaleSlider"] = "Verschiebe den Regler auf die gew\195\188nschte Position um die Gr\195\182\195\159e des ausgew\195\164hlten Charakters zu ver\195\164ndern.",
    ["tt_ItemButton"] = "Klicke um eine Popup zu \195\182ffnen bzw. zu schlie\195\159en, in welchem man Items suchen und sie als Favoriten verwalten kann.",
    ["tt_SpellButton"] = "Klicke um eine Popup zu \195\182ffnen bzw. zu schlie\195\159en, in welchem man Spells suchen und sie als Favoriten verwalten kann.",
    ["tt_SearchDefault"] = "Jetzt kannst du ein Suchwort eingeben und die Suche starten.",
    ["tt_AnnounceButton"] = "Klicke um eine System-Nachricht anzuzeigen, die von allen Spielern gesehen wird.",
    ["tt_KickButton"] = "Klicke um den selektierten Spieler zu kicken.",
    ["tt_ShutdownButton"] = "Klicke um den Server nach einem Countdown herunterzufahren. Wenn im Feld keine Zahl eingegeben wurde wird der Server sofort heruntergefahren!",
    ["ma_ItemButton"] = "Items",
    ["ma_SpellButton"] = "Spells",
    ["ma_LanguageButton"] = "Sprache \195\164ndern",
    ["ma_ToggleGMButton"] = "GM-Modus",
    ["ma_ToggleFlyButton"] = "Flug-Modus",
    ["ma_LearnAllButton"] = "Alle Spells",
    ["ma_LearnCraftsButton"] = "Alle Berufe und Rezepte",
    ["ma_LearnGMButton"] = "Default GM Spells",
    ["ma_LearnLangButton"] = "Alle Sprachen",
    ["ma_LearnClassButton"] = "Alle Class-Spells",
    ["ma_SearchButton"] = "Suchen...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Announce",
    ["ma_ShutdownButton"] = "Shutdown!"
  } 
end
