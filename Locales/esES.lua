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

function Return_esES()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Español",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["gridnavigator"] = "Grid-Navigator",
    ["selectionerror1"] = "!Por favor, selecciónate o a otro jugador o a nada!",
    ["selectionerror2"] = "Please select only yourself or nothing!",
    ["selectionerror3"] = "Please select only another player!",
    ["selectionerror4"] = "Please select only a NPC!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "Principal",
    ["tabmenu_Char"] = "Personaje",
    ["tabmenu_Tele"] = "Teleportar",
    ["tabmenu_Ticket"] = "Sistema de soporte",
    ["tabmenu_Misc"] = "Miscellaneous",
    ["tabmenu_Server"] = "Servidor",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Mueve el cursor sobre un elemento para para cambiar el tooltip!",
    ["tt_MainButton"] = "Pulsa este botón para cambiar el marcar principal.",
    ["tt_CharButton"] = "Click to toggle a window with character-specific actions.",
    ["tt_TeleButton"] = "Click to toggle a window with teleport-functions.",
    ["tt_TicketButton"] = "Click to toggle a window which shows all tickets and lets you administrate them.",
    ["tt_MiscButton"] = "Click to toggle a window with miscellaneous actions.",
    ["tt_ServerButton"] = "Pulsa para ver varia informatción del servidor y realizar acciones sobre el servidor.",
    ["tt_LogButton"] = "Pulsa para ver el log de todas las acciones realizadas con MangAdmin.",
    ["tt_LanguageButton"] = "Pulsa para cambiar el idioma y reiniciar MangAdmin.",
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
    ["tt_SpeedSlider"] = "Desplaza para aumentar o disminuir la velocidad para el personaje seleccionado.",
    ["tt_ScaleSlider"] = "Desplaza para aumentar o disminuir la escala para el personaje seleccionado.",
    ["tt_ItemButton"] = "Pulsa para activar o desactivar un popup con la función a buscar objetos y gestionar tus favoritos.",
    ["tt_SpellButton"] = "Pulsa para activar/desactivar un popup con la función a buscar hechizos y gestionar tus favoritos.",
    ["tt_SearchDefault"] = "Ahora puedes escribir una palabra y empezar la búsqueda.",
    ["tt_AnnounceButton"] = "Pulsa para anunciar un mensaje del sistema.",
    ["tt_KickButton"] = "Pulsa para echar al personaje seleccionado del servidor.",
    ["tt_ShutdownButton"] = "Pulsa para apagar el servidor en el tiempo establecido en el campo, !si se omite se apagará inmediatamente!",
    ["ma_ItemButton"] = "Objetos",
    ["ma_SpellButton"] = "Hechizos",
    ["ma_LanguageButton"] = "Cambiar idioma",
    ["ma_GMOnButton"] = "GM-mode on",
    ["ma_FlyOnButton"] = "Fly-mode on",
    ["ma_HoverOnButton"] = "Hover-mode on",
    ["ma_WhisperOnButton"] = "Whisper on",
    ["ma_InvisOnButton"] = "Invisibility on",
    ["ma_TaxiOnButton"] = "Taxicheat on",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Bank",
    ["ma_OffButton"] = "Off",
    ["ma_LearnAllButton"] = "Todos los hechizos",
    ["ma_LearnCraftsButton"] = "Todas las profesiones y recetas",
    ["ma_LearnGMButton"] = "Hechizos de GM por defecto",
    ["ma_LearnLangButton"] = "Todos los idiomas",
    ["ma_LearnClassButton"] = "Todos los hechizos de todas las clases",
    ["ma_SearchButton"] = "Buscar...",
    ["ma_ResetButton"] = "Reiniciar",
    ["ma_KickButton"] = "Echar",
    ["ma_KillButton"] = "Kill",
    ["ma_DismountButton"] = "Dismount",
    ["ma_ReviveButton"] = "Revive",
    ["ma_SaveButton"] = "Save",
    ["ma_AnnounceButton"] = "Anunciar",
    ["ma_ShutdownButton"] = "!Apagar!"
  }
end
