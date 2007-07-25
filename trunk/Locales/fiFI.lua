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
    ["selectionerror1"] = "Valitse itsesi, toinen pelaaja tai ei mit\195\177\195\177n!",
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
    ["tt_LanguageButton"] = "Paina t\195\177\195\177st\195\177 vaihtaaksesi MangAdminin kielen ja uudelleenk\195\177ynnist\195\177\195\177ksesi sen.",
    ["tt_ToggleGMButton"] = "Painamalla t\195\177st\195\177 sallit GM-moodi napin k\195\177yt\195\182n.",
    ["tt_ToggleFlyButton"] = "Painamalla t\195\177st\195\177 sallit Lento-moodi napin k\195\177yt\195\182n",
    ["tt_SpeedSlider"] = "Liuta t\195\177t\195\177 nappia kasvattaaksesi tai hidastaaksesi valitun hahmon liikumisnopeutta.",
    ["tt_ScaleSlider"] = "Liuta t\195\177t\195\177 nappia kasvattaaksesi tai pienent\195\177\195\177ksesi valitun hahmon kokoa.",
    ["tt_ItemButton"] = "Paina t\195\177st\195\177 napista saadaksesi pop-up ikkunan jonka kautta voit etsi\195\177 varusteita  sek\195\177 tavaroita ja hallinoida suosikkejasi.",
    ["tt_SpellButton"] = "Paina t\195\177st\195\177 napista saadaksesi pop-up ikkunan jonka kautta voit etsi\195\177 loitsuja ja hallinoida suosikkejasi.",
    ["tt_SearchDefault"] = "Nyt voit kirjoittaa hakusanan aloittaaksesi haun.",
    ["tt_AnnounceButton"] = "Paina kirjoittaaksesi systeemikuulutuksen.",
    ["tt_KickButton"] = "Paina potkaistaksesi valittu pelaaja serverilt\195\177",
    ["tt_ShutdownButton"] = "Paina sammuttaaksesi serveri kentt\195\177\195\177n laitettujen sekuntien kuluttua, jos kentt\195\177 j\195\177tet\195\177\195\177n tyhj\195\177ksi, serveri sammuu heti!",
    ["ma_ItemButton"] = "Varusteet ja tavarat",
    ["ma_SpellButton"] = "Loitsut",
    ["ma_LanguageButton"] = "Vaihda kielt\195\177",
    ["ma_ToggleGMButton"] = "GM-moodi",
    ["ma_ToggleFlyButton"] = "Lento-moodi",
    ["ma_LearnAllButton"] = "Kaikki loitsut",
    ["ma_LearnCraftsButton"] = "Kaikki ammatit ja reseptit",
    ["ma_LearnGMButton"] = "Normaalit GM loitsut",
    ["ma_LearnLangButton"] = "Kaikki kielet",
    ["ma_LearnClassButton"] = "Kaikki luokan loitsut",
    ["ma_SearchButton"] = "Haku...",
    ["ma_ResetButton"] = "Resetoi",
    ["ma_KickButton"] = "Potkaise",
    ["ma_AnnounceButton"] = "Kuulutus",
    ["ma_ShutdownButton"] = "Sammuta!"
  }
end
