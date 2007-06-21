-- french by luciolis
local L = AceLibrary("AceLocale-2.2"):new("MangAdmin")

L:RegisterTranslations("frFR", function() return {
["slashcmds"] = { "/mangadmin", "/ma" },
["lang"] = "French",
["logged"] = "|cFF00FF00Royaume:|r "..GetCVar("realmName").." |cFF00FF00Personnage:|r "..UnitName("player"),
["favourites"] = "Favoris",
["tabmenu_Main"] = "Accueil",
["tabmenu_Char"] = "Personnage",
["tabmenu_Tele"] = "Teleportations",
["tabmenu_Ticket"] = "Système de support",
["tabmenu_Server"] = "Serveur",
["tabmenu_Log"] = "Log",
["tt_Default"] = "Déplacez votre curseur sur une icône pour activer l'outil correspondant.",
["tt_MainButton"] = "Cliquez sur ce bouton pour activer la page de garde.",
["tt_CharButton"] = "Todo.",
["tt_TeleButton"] = "Todo.",
["tt_TicketButton"] = "Todo.",
["tt_ServerButton"] = "Cliquez sur ce bouton pour avoir des infomations sur le serveur.",
["tt_LogButton"] = "Cliquez sur ce bouton pour accéder au protocole de gestion des enchères."
} end)