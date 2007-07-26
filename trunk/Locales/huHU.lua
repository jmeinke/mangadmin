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

function Return_huHU()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Hungarian",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Please select yourself or another player or nothing!",
    ["selectionerror2"] = "Please select only yourself or nothing!",
    ["selectionerror3"] = "Please select only another player!",
    ["selectionerror4"] = "Please select only a NPC!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "Main",
    ["tabmenu_Char"] = "Karakter",
    ["tabmenu_Tele"] = "Teleport",
    ["tabmenu_Ticket"] = "Ticketfiók",
    ["tabmenu_Misc"] = "Miscellaneous",
    ["tabmenu_Server"] = "Szerver",
    ["tabmenu_Log"] = "Log",
    ["tt_Default"] = "Mozgasd az egeredet bármelyik gomb fölé, hogy megmutassa az adott tanácsot!",
    ["tt_MainButton"] = "Kattincs, hogy megnyissa a MangAdmint.",
    ["tt_CharButton"] = "Click to toggle a window with character-specific actions.",
    ["tt_TeleButton"] = "Click to toggle a window with teleport-functions.",
    ["tt_TicketButton"] = "Click to toggle a window which shows all tickets and lets you administrate them.",
    ["tt_MiscButton"] = "Click to toggle a window with miscellaneous actions.",
    ["tt_ServerButton"] = "Kattins ide, hogy megmutassa egy másik ablakban az adot informáciot a szerverrol.",
    ["tt_LogButton"] = "Kattins ide, hogy megmutassa az eddigi végrehajtott parancsokat a MangAdminnal.",
    ["tt_LanguageButton"] = "Kattincs, hogy megváltoztasd az adott nyelvet és újra töltsd a MangAdmint.",
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
    ["tt_SpeedSlider"] = "Kattincs, hogy megváltoztasd az adott játékosnak a sebességét.",
    ["tt_ScaleSlider"] = "Kattincs, hogy megváltoztasd az adott játékosnak a méretét.",
    ["tt_ItemButton"] = "Kattincs, hogy megnyiss vagy bezárj egy Popup-ot melyben megkereshetsz egy adott tárgyat és a kedvencekhez adhass.",
    ["tt_SpellButton"] = "Kattincs, hogy megnyiss vagy bezárj egy Popup-ot melyben megkereshetsz egy adott varázslatot és a kevencekhez adhass.",
    ["tt_SearchDefault"] = "Most megadhatsz egy keresett szót és elindithatod a keresést.",
    ["tt_AnnounceButton"] = "Kattincs, hogy egy hírdetést írjál amit minden játékos lát.",
    ["tt_KickButton"] = "Kattincs, hogy a kiválasztott játékosd kickeld.",
    ["tt_ShutdownButton"] = "Kattincs, hogy egy visszaszámlálás után leálljon. Ha a rubrikában nem áll egy szám sem, akkor a szerver automatikusan leáll!",
    ["ma_ItemButton"] = "Tárgyak",
    ["ma_SpellButton"] = "Varázslatok",    
    ["ma_LanguageButton"] = "Nyelv választás",
    ["ma_GMOnButton"] = "GM-mode on",
    ["ma_FlyOnButton"] = "Fy-mode on",
    ["ma_HoverOnButton"] = "Hover-mode on",
    ["ma_WhisperOnButton"] = "Whisper on",
    ["ma_InvisOnButton"] = "Invisibility on",
    ["ma_TaxiOnButton"] = "Taxicheat on",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Bank",
    ["ma_OffButton"] = "Off",
    ["ma_LearnAllButton"] = "Öszzes varázslat",
    ["ma_LearnCraftsButton"] = "Összes munka és recept",
    ["ma_LearnGMButton"] = "Alap GM varázslatok",
    ["ma_LearnLangButton"] = "Összes nyelv",
    ["ma_LearnClassButton"] = "Összes kaszt varázslat",
    ["ma_SearchButton"] = "Keresés...",
    ["ma_ResetButton"] = "Reset",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Hírdetés",
    ["ma_ShutdownButton"] = "Leállás!"
  }
end
