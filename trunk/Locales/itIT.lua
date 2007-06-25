-- italian by hybrid
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("itIT", function() return {
  ["slashcmds"] = { "/mangadmin", "/ma" },
  ["lang"] = "Italian",
  ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
  ["charguid"] = "|cFF00FF00Guid:|r ",
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
  ["tt_LanguageDropdown"] = "Clickthis button to change MangAdmins language.",
  ["tt_ToggleGMButton"] = "Click this button to toggle GM-mode.",
  ["tt_ToggleFlyButton"] = "Click this button to toggle Fly-mode",
  ["ma_ToggleGMButton"] = "GM-mode",
  ["ma_ToggleFlyButton"] = "Fly-mode"
} end)