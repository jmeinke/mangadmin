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

function Return_ptPT() 
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "Portuguese (PT)",
    ["logged"] = "|cFF00FF00Realm:|r "..GetCVar("realmName").." |cFF00FF00Char:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00Guid:|r ",
    ["selectionerror1"] = "Apenas jogadores podem ser selecionados!",
    ["selectionerror2"] = "Apenas tu podes ser selecionado!",
    ["selectionerror3"] = "Apenas outro jogador pode ser selecionado!",
    ["selectionerror4"] = "Apenas um NPC pode ser selecionado!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "Geral",
    ["tabmenu_Char"] = "Personagem",
    ["tabmenu_Tele"] = "Teleporte",
    ["tabmenu_Ticket"] = "Systema de Ticket",
    ["tabmenu_Misc"] = "Variados",
    ["tabmenu_Server"] = "Servidor",
    ["tabmenu_Log"] = "Histórico",
    ["tt_Default"] = "Move o cursor sobre um elemento para mostrar a sua informação!",
    ["tt_MainButton"] = "Clique para alterar a janela mostrando a parte Geral do MangAdmin.",
    ["tt_CharButton"] = "Clique para alterar a janela com acções específicas de personagens.",
    ["tt_TeleButton"] = "Clique para alterar a janela com funções de teleporte.",
    ["tt_TicketButton"] = "Clique para alterar a janela que te mostra e possibilita a gestão de tickets.",
    ["tt_MiscButton"] = "Clique para alterar a janela que mostra várias acções.",
    ["tt_ServerButton"] = "Clique para mostrar varias informações e acções que ocorrem no servidor.",
    ["tt_LogButton"] = "Click to show the log of all actions done with MangAdmin.",
    ["tt_LanguageButton"] = "Clique para alterar o idioma e reniciar o MangAdmin.",
    ["tt_GMOnButton"] = "Clique para activar o teu modo de GM.",
    ["tt_GMOffButton"] = "Clique para desactivar o teu modo de GM.",
    ["tt_FlyOnButton"] = "Clique para activar o modo de Voar no jogador selecionado.",
    ["tt_FlyOffButton"] = "Clique para desactivar o modo de Voar no jogador selecionado.",
    ["tt_HoverOnButton"] = "Clique para activar o modo de Sobreposição.",
    ["tt_HoverOffButton"] = "Clique para desactivar o modo de Sobreposição",
    ["tt_WhispOnButton"] = "Clique para aceitar whispers de outros jogadores.",
    ["tt_WhispOffButton"] = "Clique para não aceitar whispers de outros jogadores.",
    ["tt_InvisOnButton"] = "Clique para ficar invisível.",
    ["tt_InvisOffButton"] = "Clique para ficar visível.",
    ["tt_TaxiOnButton"] = "Clique para mostrar todos as rotas de taxi no jogador selecionado. Esta opção irá ficar desactivada assim que esse jogador terminar a sessão.",
    ["tt_TaxiOffButton"] = "Clique para restaurar apenas as rotas de taxi conhecidas no jogador selecionado.",
    ["tt_BankButton"] = "Clique para mostrar o teu banco.",
    ["tt_ScreenButton"] = "Clique para criar um screenshot.",
    ["tt_SpeedSlider"] = "Arraste para aumentar ou diminuir a velocidade do jogador selecionado.",
    ["tt_ScaleSlider"] = "Arraste para aumentar ou diminuir a escala do jogador selecionado.",
    ["tt_ItemButton"] = "Clique e uma janela abrir-se-á com a função de procurar e gerir os teus items favoritos.",
    ["tt_SpellButton"] = "Clique e uma janela abrir-se-á com a função de procurar e gerir os teus feitíços favoritos.",
    ["tt_SearchDefault"] = "Agora insira uma palavra-chave e começe a procura.",
    ["tt_AnnounceButton"] = "Clique para anunciar uma mensagem de systema.",
    ["tt_KickButton"] = "Clique para \"kickar\" um jogador do servidor.",
    ["tt_ShutdownButton"] = "Clique para desligar o servidor de acordo com o tempo em segundos escolhidos no campo (se nenhum, então desligar-se-á instantaneamente)!",
    ["ma_ItemButton"] = "Procurar Itens",
    ["ma_SpellButton"] = "Procurar Feitíços",
    ["ma_LanguageButton"] = "Mudar de Idioma",
    ["ma_GMOnButton"] = "GM Ligar",
    ["ma_FlyOnButton"] = "Voar Ligar",
    ["ma_HoverOnButton"] = "Sobreposição Ligar",
    ["ma_WhisperOnButton"] = "Whisper Ligar",
    ["ma_InvisOnButton"] = "Invisibilidade Ligar",
    ["ma_TaxiOnButton"] = "Taxicheat Ligar",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Banco",
    ["ma_OffButton"] = "Desligar",
    ["ma_LearnAllButton"] = "Todos os feitiços",
    ["ma_LearnCraftsButton"] = "Todas as profissões e receitas",
    ["ma_LearnGMButton"] = "Feitiços padrão de GM",
    ["ma_LearnLangButton"] = "Todas as línguas",
    ["ma_LearnClassButton"] = "Todos os feitíços da classe",
    ["ma_SearchButton"] = "Procurar...",
    ["ma_ResetButton"] = "Reniciar",
    ["ma_KickButton"] = "Kick",
    ["ma_AnnounceButton"] = "Anunciar",
    ["ma_ShutdownButton"] = "Desligar!"
  }
end
