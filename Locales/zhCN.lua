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

-- 简体中文翻译：埃尔维斯
-- znCN Translator: Elvis

function Return_zhCN()
  return {
    ["slashcmds"] = { "/mangadmin", "/ma" },
    ["lang"] = "简体中文",
    ["logged"] = "|cFF00FF00国度:|r "..GetCVar("realmName").." |cFF00FF00人物:|r "..UnitName("player").." ",
    ["charguid"] = "|cFF00FF00人物 GUID:|r ",
    ["selectionerror1"] = "请选择你自己、其他人物或不选择任何目标!",
    ["selectionerror2"] = "Please select only yourself or nothing!",
    ["selectionerror3"] = "Please select only another player!",
    ["selectionerror4"] = "Please select only a NPC!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",
    ["tabmenu_Main"] = "主菜单",
    ["tabmenu_Char"] = "人物",
    ["tabmenu_Tele"] = "传送",
    ["tabmenu_Ticket"] = "Ticket",
    ["tabmenu_Misc"] = "Miscellaneous",
    ["tabmenu_Server"] = "服务器",
    ["tabmenu_Log"] = "日志",
    ["tt_Default"] = "将鼠标移动到各元素上即可显示提示!",
    ["tt_MainButton"] = "单击此按钮显示 MangAdmins 主界面.",
    ["tt_CharButton"] = "Click to toggle a window with character-specific actions.",
    ["tt_TeleButton"] = "Click to toggle a window with teleport-functions.",
    ["tt_TicketButton"] = "Click to toggle a window which shows all tickets and lets you administrate them.",
    ["tt_MiscButton"] = "Click to toggle a window with miscellaneous actions.",
    ["tt_ServerButton"] = "单击显示各种服务器信息, 或执行服务器相关的操作.",
    ["tt_LogButton"] = "单击显示 MangAdmin 所做的各种操作的记录.",
    ["tt_LanguageButton"] = "单击更改界面语言并重新载入 MangAdmin.",
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
    ["tt_SpeedSlider"] = "移动滑块来增加或减少选定人物的速度.",
    ["tt_ScaleSlider"] = "移动滑块来增加或减少选定人物的大小.",
    ["tt_ItemButton"] = "单击切换搜索物品的窗口.",
    ["tt_SpellButton"] = "单击切换搜索法术的窗口.",
    ["tt_SearchDefault"] = "请输入关键字来进行搜索.",
    ["tt_AnnounceButton"] = "单击发送一个系统消息.",
    ["tt_KickButton"] = "单击将强制选定的人物离线.",
    ["tt_ShutdownButton"] = "单击将关闭服务器. 如不输入倒计时时间, 将立刻关闭服务器!",
    ["ma_ItemButton"] = "物品",
    ["ma_SpellButton"] = "法术",
    ["ma_LanguageButton"] = "更改语言",
    ["ma_GMOnButton"] = "GM-mode on",
    ["ma_FlyOnButton"] = "Fy-mode on",
    ["ma_HoverOnButton"] = "Hover-mode on",
    ["ma_WhisperOnButton"] = "Whisper on",
    ["ma_InvisOnButton"] = "Invisibility on",
    ["ma_TaxiOnButton"] = "Taxicheat on",    
    ["ma_ScreenshotButton"] = "Screenshot",
    ["ma_BankButton"] = "Bank",
    ["ma_OffButton"] = "Off",
    ["ma_LearnAllButton"] = "所有法术",
    ["ma_LearnCraftsButton"] = "所有职业技能和配方",
    ["ma_LearnGMButton"] = "默认的 GM 法术",
    ["ma_LearnLangButton"] = "所有语言",
    ["ma_LearnClassButton"] = "所有本职业法术",
    ["ma_SearchButton"] = "搜索...",
    ["ma_ResetButton"] = "重置",
    ["ma_KickButton"] = "踢出",
    ["ma_AnnounceButton"] = "公告",
    ["ma_ShutdownButton"] = "关闭服务器!"
  }
end
