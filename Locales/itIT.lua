-- italian by hybrid
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("itIT", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Italian",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player"),
  ["favourites"] = "Preferiti",
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
  ["tt_ToogleGMButton"] = "Click this button to toggle the GameMaster mode.",
  ["ma_tooglegmbutton"] = "Toggle GM"
} end)