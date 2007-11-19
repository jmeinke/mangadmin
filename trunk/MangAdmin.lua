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

local MAJOR_VERSION = "MangAdmin-1.0"
local MINOR_VERSION = "$Revision: 1 $"
local ROOT_PATH     = "Interface\\AddOns\\MangAdmin\\"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local MangAdmin  = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0", "AceDebug-2.0")
local Locale     = AceLibrary("AceLocale-2.2"):new("MangAdmin")
local FrameLib   = AceLibrary("FrameLib-1.0")
local Graph      = AceLibrary("Graph-1.0")

MangAdmin:RegisterDB("MangAdminDb", "MangAdminDbPerChar")
MangAdmin:RegisterDefaults("char", 
  {
    getValueCallHandler = {
      calledGetGuid = false,
      realGuid = nil
    },
    functionQueue = {},
    workaroundValues = {
      flymode = nil
    },
    requests = {
      ticket = false,
      item = false,
      itemset = false,
      spell = false,
      quest = false,
      creature = false,
      object = false,
      tele = false
    },
    nextGridWay = "ahead"
  }
)
MangAdmin:RegisterDefaults("account", 
  {
    language = nil,
    favourites = {
      items = {},
      itemsets = {},
      spells = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {}
    },
    buffer = {
      ticketselected = 0,
      ticketa = 0,
      tickets = {},
      items = {},
      itemsets = {},
      spells = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {},
      counter = 0
    },
    hardcodetele = function() return Return_TelePositions() end;
  }
)


-- Register Translations
Locale:EnableDynamicLocales(true)
--Locale:EnableDebugging()
Locale:RegisterTranslations("enUS", function() return Return_enUS() end)
Locale:RegisterTranslations("deDE", function() return Return_deDE() end)
Locale:RegisterTranslations("frFR", function() return Return_frFR() end)
Locale:RegisterTranslations("itIT", function() return Return_itIT() end)
Locale:RegisterTranslations("fiFI", function() return Return_fiFI() end)
Locale:RegisterTranslations("plPL", function() return Return_plPL() end)
Locale:RegisterTranslations("svSV", function() return Return_svSV() end)
Locale:RegisterTranslations("liLI", function() return Return_liLI() end)
Locale:RegisterTranslations("roRO", function() return Return_roRO() end)
Locale:RegisterTranslations("csCZ", function() return Return_csCZ() end)
Locale:RegisterTranslations("huHU", function() return Return_huHU() end)
Locale:RegisterTranslations("esES", function() return Return_esES() end)
Locale:RegisterTranslations("zhCN", function() return Return_zhCN() end)
Locale:RegisterTranslations("ptPT", function() return Return_ptPT() end)
--Locale:Debug()
--Locale:SetLocale("enUS")

--===============================================================================================================--
--== Initializing Frames (with LUA) MUCH EASIER THAN WRITING F***ING HUGE XML-code
--== This lua script is like the xml files to create the frames
--===============================================================================================================--

function MangAdmin:CreateFrames()
  -- [[ Main Elements ]]
  FrameLib:BuildFrame({
    name = "ma_bgframe",
    group = "bg",
    parent = UIParent,
    texture = {
      color = {0,0,0,0.5}
    },
    draggable = true,
    size = {
      width = 680,
      height = 440
    },
    setpoint = {
      pos = "CENTER"
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_menubgframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {0,0,0,0.5}
    },
    size = {
      width = 670,
      height = 22
    },
    setpoint = {
      pos = "TOPLEFT",
      offY = 22,
      offX = 4
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_topframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 675,
      height = 80
    },
    setpoint = {
      pos = "TOP",
      offY = -2
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_midframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 675,
      height = 254
    },
    setpoint = {
      pos = "TOP",
      offY = -83
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_leftframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 374,
      height = 100
    },
    setpoint = {
      pos = "TOP",
      offX = -150.5,
      offY = -338
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_rightframe",
    group = "bg",
    parent = ma_bgframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 300,
      height = 100
    },
    setpoint = {
      pos = "TOP",
      offX = 187.5,
      offY = -338
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_logoframe",
    group = "bg",
    parent = ma_topframe,
    texture = {
      file = ROOT_PATH.."Textures\\logo.tga"
    },
    size = {
      width = 512,
      height = 64
    },
    setpoint = {
      pos = "LEFT",
      offX = 10
    },
    inherits = nil
  })

  FrameLib:BuildFontString({
    name = "ma_loggedtext",
    group = "bg",
    parent = ma_topframe,
    text = Locale["logged"],
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    }
  })

  FrameLib:BuildFontString({
    name = "ma_tooltiptext",
    group = "bg",
    parent = ma_rightframe,
    text = Locale["tt_Default"],
    color = {
      r = 0,
      g = 255,
      b = 0,
      a = 1.0
    }
  })

  FrameLib:BuildFrame({
    name = "ma_languagedropdown",
    group = "bg",
    parent = ma_topframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -130,
      offY = -10
    },
    inherits = "UIDropDownMenuTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_languagebutton",
    group = "bg",
    parent = ma_topframe,
    texture = {
      name = "ma_languagebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -14
    },
    text = Locale["ma_LanguageButton"]
  })

  FrameLib:BuildButton({
    name = "ma_itembutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_itembutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -4
    },
    text = Locale["ma_ItemButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_itemsetbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_itemsetbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -4
    },
    text = Locale["ma_ItemSetButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_spellbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_spellbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 218,
      offY = -4
    },
    text = Locale["ma_SpellButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_questbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_questbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -28
    },
    text = Locale["ma_QuestButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_objectbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_objectbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -28
    },
    text = Locale["ma_ObjectButton"]
  })

  FrameLib:BuildButton({
    name = "ma_creaturebutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_creaturebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 218,
      offY = -28
    },
    text = Locale["ma_CreatureButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_telesearchbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_telesearchbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -52
    },
    text = Locale["ma_TeleSearchButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_sendmailbutton",
    group = "bg",
    parent = ma_leftframe,
    texture = {
      name = "ma_sendmailbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 114,
      offY = -52
    },
    text = "Send Mail"
  })
  
  FrameLib:BuildButton({
    name = "ma_closebutton",
    group = "bg",
    parent = ma_rightframe,
    texture = {
      name = "ma_languagebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 10,
      height = 10
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = "X"
  })
  
  -- [[Popup Frame]]
  FrameLib:BuildFrame({
    name = "ma_popupframe",
    group = "popup",
    parent = UIParent,
    texture = {
      color = {0,0,0,0.5}
    },
    draggable = true,
    size = {
      width = 440,
      height = 380
    },
    setpoint = {
      pos = "CENTER"
    },
    frameStrata = "HIGH",
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_popuptopframe",
    group = "popup",
    parent = ma_popupframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 435,
      height = 80
    },
    setpoint = {
      pos = "TOP",
      offY = -2
    },
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_popupmidframe",
    group = "popup",
    parent = ma_popupframe,
    texture = {
      color = {102,102,102,0.7}
    },
    size = {
      width = 435,
      height = 294
    },
    setpoint = {
      pos = "TOP",
      offY = -83
    },
    inherits = nil
  })
  
  FrameLib:BuildButton({
    name = "ma_popupclosebutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_popupclosebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 10,
      height = 10
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = "X"
  })
  
  -- Popup Editbox and Searchbutton
  FrameLib:BuildFontString({
    name = "ma_lookuptext",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    font = {
      size = 20,
      flags = "THICKOUTLINE"
    }
  })

  FrameLib:BuildFontString({
    name = "ma_lookupresulttext",
    group = "popup",
    parent = ma_popuptopframe,
    text = Locale["searchResults"].."0",
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    }
  })

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_searcheditbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 28
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_searchbutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_searchbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 94,
      offY = 28
    },
    text = Locale["ma_SearchButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_resetsearchbutton",
    group = "popup",
    parent = ma_popuptopframe,
    texture = {
      name = "ma_resetsearchbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 178,
      offY = 28
    },
    text = Locale["ma_ResetButton"]
  })
  
  FrameLib:BuildFontString({
    name = "ma_var1text",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 8
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_var1editbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 94,
      offY = 4
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildFontString({
    name = "ma_var2text",
    group = "popup",
    parent = ma_popuptopframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 200,
      offY = 8
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_var2editbox",
    group = "popup",
    parent = ma_popuptopframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 284,
      offY = 4
    },
    inherits = "InputBoxTemplate"
  })
  
  -- Popup Search ScrollFrame
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_PopupScrollBar",
    group = "popup",
    parent = ma_popupmidframe,
    texture = {
      color = {0,0,0,0.7}
    },
    size = {
      width = 400,
      height = 274
    },
    setpoint = {
      pos = "CENTER",
      offX = -10
    },
    inherits = "FauxScrollFrameTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry1",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBar",
      relPos = "TOPLEFT",
      offX = 10,
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry1_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry2",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry1",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry2_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry3",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry2",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry3_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry4",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry3",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry4_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry5",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry4",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry5_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry6",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry5",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry6_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_PopupScrollBarEntry7",
    group = "popup",
    parent = ma_popupmidframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_PopupScrollBarEntry6",
      relPos = "BOTTOMLEFT",
      offY = -8
    },
    texture = {
      name = "ma_PopupScrollBarEntry7_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 380,
      height = 30
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  -- [[Mail Popup]]
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_mailscrollframe",
    group = "popup",
    parent = ma_popupmidframe,
    size = {
      width = 400,
      height = 274
    },
    setpoint = {
      pos = "CENTER",
      offX = -10
    },
    inherits = "UIPanelScrollFrameTemplate"
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_maileditbox",
    group = "popup",
    parent = ma_mailscrollframe,
    texture = {
      name = "ma_maileditbox_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 400,
      --height = 200
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 0,
      offY = 0
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = 0,
      offY = 0
    },
    maxletters = 100000,
    multiline = true,
    textcolor = {0, 0, 0, 1.0}
  })
  
  -- [[ Tab Buttons ]]
  FrameLib:BuildButton({
    name = "ma_mainbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_mainbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,1},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_menubgframe",
      relPos = "TOPLEFT",
      offX = 4,
      offY = -4
    },
    text = Locale["tabmenu_Main"]
  })

  FrameLib:BuildButton({
    name = "ma_charbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_charbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_mainbutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Char"]
  })

  FrameLib:BuildButton({
    name = "ma_telebutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_telebutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_charbutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Tele"]
  })

  FrameLib:BuildButton({
    name = "ma_ticketbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_ticketbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 130,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_telebutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Ticket"]
  })

  FrameLib:BuildButton({
    name = "ma_miscbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_miscbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_ticketbutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Misc"]
  })

  FrameLib:BuildButton({
    name = "ma_serverbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_serverbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_miscbutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Server"]
  })

  FrameLib:BuildButton({
    name = "ma_logbutton",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_logbutton_texture",
      color = {102,102,102,0.7},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {102,102,102,0.7}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_serverbutton",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Log"]
  })

  -- [[ Group Elements ]]
  -- MAIN
  FrameLib:BuildButton({
    name = "ma_gmonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_gmonbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    text = Locale["ma_GMOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_gmoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_gmoffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -10
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_flyonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_flyonbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -34
    },
    text = Locale["ma_FlyOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_flyoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_flyoffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -34
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_hoveronbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_hoveronbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -58
    },
    text = Locale["ma_HoverOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_hoveroffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_hoveroffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -58
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_whisperonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperonbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -82
    },
    text = Locale["ma_WhisperOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_whisperoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperoffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -82
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_invisibleonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_invisibleonbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -106
    },
    text = Locale["ma_InvisOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_invisibleoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_invisibleoffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -106
    },
    text = Locale["ma_OffButton"]
  })

  FrameLib:BuildButton({
    name = "ma_taxicheatonbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_taxicheatonbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -130
    },
    text = Locale["ma_TaxiOnButton"]
  })

  FrameLib:BuildButton({
    name = "ma_taxicheatoffbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_taxicheatoffbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 40,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -130
    },
    text = Locale["ma_OffButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_screenshotbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_screenshotbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = Locale["ma_ScreenshotButton"]
  })

  FrameLib:BuildButton({
    name = "ma_bankbutton",
    group = "main",
    parent = ma_midframe,
    texture = {
      name = "ma_bankbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -34
    },
    text = Locale["ma_BankButton"]
  })
  
  -- TELE
  FrameLib:BuildFontString({
    name = "ma_gridnavigatortext",
    group = "tele",
    parent = ma_midframe,
    text = Locale["gridnavigator"],
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -2,
      offY = 86
    }
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_gridnavieditbox",
    group = "tele",
    parent = ma_midframe,
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -32,
      offY = 34
    },
    maxLetters = 2,
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnaviaheadbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnaviaheadbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -34,
      offY = 58
    },
    text = "^"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavibackbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavibackbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -34,
      offY = 10
    },
    text = "v"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavirightbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavirightbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 34
    },
    text = ">"
  })
  
  FrameLib:BuildButton({
    name = "ma_gridnavileftbutton",
    group = "tele",
    parent = ma_midframe,
    texture = {
      name = "ma_gridnavileftbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 20,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -58,
      offY = 34
    },
    text = "<"
  })
  
  -- LOG
  FrameLib:BuildFrame({
    type = "ScrollingMessageFrame",
    name = "ma_logframe",
    group = "log",
    parent = ma_midframe,
    texture = {
      color = {10,10,10,0.7},
      gradient = {
        orientation = "horizontal",
        min = {10,10,10,0.7},
        max = {10,10,10,0}
      }
    },
    size = {
      width = 400,
      height = 234
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    justify = {
      h = "LEFT",
      v = "TOP"
    },
    fading = false,
    scrollMouseWheel = true
  })

  FrameLib:BuildButton({
    name = "ma_logscrollupbutton",
    group = "log",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    inherits = "UIPanelScrollUpButtonTemplate",
    script = function() ma_logframe:ScrollUp() end
  })

  FrameLib:BuildButton({
    name = "ma_logscrolldownbutton",
    group = "log",
    parent = ma_midframe,
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    inherits = "UIPanelScrollDownButtonTemplate",
    script = function() ma_logframe:ScrollDown() end
  })

  --CHARACTER
  FrameLib:BuildButton({
    name = "ma_learnallbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnallbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -4
    },
    text = Locale["ma_LearnAllButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learncraftsbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learncraftsbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 180,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 134,
      offY = -4
    },
    text = Locale["ma_LearnCraftsButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learngmbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learngmbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 140,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 318,
      offY = -4
    },
    text = Locale["ma_LearnGMButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learnclassbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnclassbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 200,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 462,
      offY = -4
    },
    text = Locale["ma_LearnClassButton"]
  })

  FrameLib:BuildButton({
    name = "ma_learnlangbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnlangbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 120,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -28
    },
    text = Locale["ma_LearnLangButton"]
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_levelupeditbox",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 15,
      offY = -60
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_levelupbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_levelupbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 50,
      offY = -60
    },
    text = Locale["ma_LevelUpButton"]
  })

  FrameLib:BuildFrame({
    type = "Slider",
    name = "ma_speedslider",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 60
    },
    inherits = "OptionsSliderTemplate"
  })

  FrameLib:BuildFrame({
    type = "Slider",
    name = "ma_scaleslider",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 20
    },
    inherits = "OptionsSliderTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_killbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_killbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_KillButton"]
  })

  FrameLib:BuildButton({
    name = "ma_kickbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_kickbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_KickButton"]
  })

  FrameLib:BuildButton({
    name = "ma_dismountbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_dismountbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -178,
      offY = 10
    },
    text = Locale["ma_DismountButton"]
  })

  FrameLib:BuildButton({
    name = "ma_revivebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_revivebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -262,
      offY = 10
    },
    text = Locale["ma_ReviveButton"]
  })

  FrameLib:BuildButton({
    name = "ma_savebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_savebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -346,
      offY = 10
    },
    text = Locale["ma_SaveButton"]
  })

  --TICKET  
  FrameLib:BuildButton({
    name = "ma_loadticketsbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_loadticketsbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    text = Locale["ma_LoadTicketsButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_getcharticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_getcharticketbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -262,
      offY = 10
    },
    text = Locale["ma_GetCharTicketButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_gocharticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_gocharticketbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -178,
      offY = 10
    },
    text = Locale["ma_GoCharTicketButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_answerticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_answerticketbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_AnswerButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_deleteticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_deleteticketbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_DeleteButton"]
  })
  
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_TicketScrollBar",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      color = {0,0,0,0.7}
    },
    size = {
      width = 150,
      height = 200
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -34
    },
    inherits = "FauxScrollFrameTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry1",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBar",
      relPos = "TOPLEFT",
      offX = 0,
      offY = 0
    },
    texture = {
      name = "ma_TicketScrollBarEntry1_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry2",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry1",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry2_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry3",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry2",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry3_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry4",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry3",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry4_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })  

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry5",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry4",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry5_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry6",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry5",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry6_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })

  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry7",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry6",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry7_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry8",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry7",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry8_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry9",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry8",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry9_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry10",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry9",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry10_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry11",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry10",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry11_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry12",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry11",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry12_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry13",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry12",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry13_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry14",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry13",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry14_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry15",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry14",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry15_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildButton({
    name = "ma_TicketScrollBarEntry16",
    group = "ticket",
    parent = ma_midframe,
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_TicketScrollBarEntry15",
      relPos = "BOTTOMLEFT",
      offY = -2
    },
    texture = {
      name = "ma_TicketScrollBarEntry16_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 150,
      height = 10
    },
    script = {{"OnShow", function() this:RegisterForClicks("LeftButtonDown", "RightButtonDown") end}}
  })
  
  FrameLib:BuildFrame({
    type = "ScrollFrame",
    name = "ma_ticketscrollframe",
    group = "ticket",
    parent = ma_midframe,
    size = {
      width = 450,
      --height = 200
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -30,
      offY = -10
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = -30,
      offY = 34
    },
    inherits = "UIPanelScrollFrameTemplate"
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_ticketeditbox",
    group = "ticket",
    parent = ma_ticketscrollframe,
    texture = {
      name = "ma_ticketeditbox_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 450,
      height = 200
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 0,
      offY = 0
    },
    setpoint2 = {
      pos = "BOTTOMRIGHT",
      offX = 0,
      offY = 0
    },
    maxletters = 100000,
    multiline = true,
    textcolor = {0, 0, 0, 1.0}
  })
  
  
  --SERVER
  FrameLib:BuildFrame({
    name = "ma_graphframe",
    group = "server",
    parent = ma_midframe,
    texture = {
      color = {0,0,0,0.7}
    },
    size = {
      width = 152,
      height = 152
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    inherits = nil
  })

  local down, up, lag = GetNetStats();
  g=Graph:CreateGraphRealtime("ma_netstatframe",ma_graphframe,"CENTER","CENTER",0,0,150,150)
  f = CreateFrame("Frame",name,ma_netstatframe)
  f:SetScript("OnUpdate",function() g:AddTimeData(1) end)
  f:Show()

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_announceeditbox",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 480,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 15,
      offY = 10
    },
    inherits = "InputBoxTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_announcebutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_announcebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -94,
      offY = 10
    },
    text = Locale["ma_AnnounceButton"]
  })

  FrameLib:BuildButton({
    name = "ma_resetannouncebutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_resetannouncebutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMRIGHT",
      offX = -10,
      offY = 10
    },
    text = Locale["ma_ResetButton"]
  })

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_shutdowneditbox",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -98,
      offY = -10
    },
    inherits = "InputBoxTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_shutdownbutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_shutdownbutton_texture",
      color = {33,164,210,1.0}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = Locale["ma_ShutdownButton"]
  })

  --FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  --FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
  --FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  
end

--===============================================================================================================--
--== MangAdmin Frame Generation End
--== MangAdmin Functions Start
--===============================================================================================================--



function MangAdmin:OnInitialize()
  -- initializing MangAdmin
  self:SetLanguage()
  self:CreateFrames()
  self:RegisterChatCommand(Locale["slashcmds"], opts) -- this registers the chat commands
  self:InitButtons() -- this prepares the actions and tooltips of nearly all MangAdmin buttons  
  self:SearchReset()
  -- FuBar plugin config
  self.hasNoColor = true
  self.hasNoText = false
  self.clickableTooltip = true
  self.hasIcon = true
  self.hideWithoutStandby = true
  self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  -- make MangAdmin frames closable with escape key
  tinsert(UISpecialFrames,"ma_bgframe")
  tinsert(UISpecialFrames,"ma_popupframe")
  -- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to MangAdmin:AddMessage(...)
  for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
  -- initializing Frames, like DropDowns, Sliders, aso
  self:InitLangDropDown()
  self:InitSliders()
  self:InitScrollFrames()
end

function MangAdmin:OnEnable()
  self:SetDebugging(true) -- to have debugging through the whole app.    
  -- init guid for callhandler, not implemented yet, comes in next revision
  self.GetGuid()
  self:SearchReset()
end

function MangAdmin:OnDisable()
  -- called when the addon is disabled
  self:SearchReset()
end

function MangAdmin:OnClick()
  -- this toggles the MangAdmin frame when clicking on the mini icon
  if ma_bgframe:IsVisible() and not ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  elseif ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
    FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  elseif not ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  else
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  end
end

function MangAdmin:ToggleTabButton(btn)
  --this modifies the look of tab buttons when clocked on them 
  FrameLib:HandleGroup("tabbuttons", 
  function(button) 
    if button:GetName() == btn then
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    else
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    end
  end)
end

function MangAdmin:ToggleContentGroup(group)
  --MangAdmin:LogAction("Toggled navigation point '"..group.."'.")
  self:HideAllGroups()
  FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function MangAdmin:TogglePopup(value, param)
  -- this toggles the MangAdmin Search Popup frame, toggling deactivated, popup will be overwritten
  --[[if ma_popupframe:IsVisible() then 
    FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end)
  else]]
  if value == "search" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    ma_mailscrollframe:Hide()
    ma_maileditbox:Hide()
    ma_var1editbox:Hide()
    ma_var2editbox:Hide()
    ma_var1text:Hide()
    ma_var2text:Hide()
    ma_searchbutton:SetScript("OnClick", function() self:SearchStart(param.type, ma_searcheditbox:GetText()) end)
    if param.type == "item" then
      ma_lookuptext:SetText(Locale["ma_ItemButton"])
      ma_var1editbox:Show()
      ma_var1text:Show()
      ma_var1text:SetText(Locale["ma_ItemVar1Button"])
    elseif param.type == "itemset" then
      ma_lookuptext:SetText(Locale["ma_ItemSetButton"])
    elseif param.type == "spell" then
      ma_lookuptext:SetText(Locale["ma_SpellButton"])
    elseif param.type == "quest" then
      ma_lookuptext:SetText(Locale["ma_QuestButton"])
    elseif param.type == "creature" then
      ma_lookuptext:SetText(Locale["ma_CreatureButton"])
    elseif param.type == "object" then
      ma_lookuptext:SetText(Locale["ma_ObjectButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_ObjectVar1Button"])
      ma_var2text:SetText(Locale["ma_ObjectVar2Button"])
    elseif param.type == "tele" then
      ma_lookuptext:SetText(Locale["ma_TeleSearchButton"])
    end
    self:SearchReset()
  elseif value == "mail" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    for n = 1,7 do
      getglobal("ma_PopupScrollBarEntry"..n):Hide()
    end
    ma_lookupresulttext:Hide()
    ma_resetsearchbutton:Hide()
    ma_PopupScrollBar:Hide()
    if param.recipient then
      ma_searcheditbox:SetText(param.recipient)
    else
      ma_searcheditbox:SetText("Recipient")
    end
    ma_lookuptext:SetText("Send a Mail")
    ma_searchbutton:SetText("Send")
    ma_searchbutton:SetScript("OnClick", function() self:SendMail(ma_searcheditbox:GetText(), ma_var1editbox:GetText(), ma_maileditbox:GetText()) end)
    ma_var2editbox:Hide()
    ma_var2text:Hide()
    if param.subject then
      ma_var1editbox:SetText(param.subject)
    else
      ma_var1editbox:SetText("Subject")
    end
    ma_var1editbox:Show()
    ma_var1text:SetText("Subject")
    ma_var1text:Show()
    if param.body then
      ma_maileditbox:SetText(param.body)
    else
      ma_maileditbox:SetText("Here your message!")
    end
  end
end

function MangAdmin:HideAllGroups()
  FrameLib:HandleGroup("main", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("char", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("tele", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
  --FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
end

function MangAdmin:AddMessage(frame, text, r, g, b, id)
  -- frame is the object that was hooked (one of the ChatFrames)  
  local catchedSth = false

  if id == 11 then --make sure that the message comes from the server, message id = 11, I don't know why exactly this id but i think it's right
    -- hook all uint32 .getvalue requests
    for guid, field, value in string.gmatch(text, "The uint32 value of (%w+) in (%w+) is: (%w+)") do
      catchedSth = true
      output = self:GetValueCallHandler(guid, field, value)
    end
    
    -- hook .gps for gridnavigation
    for x, y in string.gmatch(text, "X: (.*) Y: (.*) Z") do
      for k,v in pairs(self.db.char.functionQueue) do
        if v == "GridNavigate" then
          --catchedSth = true
          --output = false
          self:GridNavigate(string.format("%.1f", x), string.format("%.1f", y), nil)
          table.remove(self.db.char.functionQueue, k)
          break
        end
      end
    end
    
    -- hook all item lookups
    for id, name in string.gmatch(text, "|cffffffff|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r") do
      if self.db.char.requests.item then
        table.insert(self.db.account.buffer.items, {itId = id, itName = name})
        -- for item info in cache
        local itemName, itemLink, itemQuality, _, _, _, _, _, _ = GetItemInfo(id);
        if not itemName then
          GameTooltip:SetOwner(ma_popupframe, "ANCHOR_RIGHT")
          GameTooltip:SetHyperlink("item:"..id..":0:0:0:0:0:0:0")
          GameTooltip:Hide()
        end
        PopupScrollUpdate()
        catchedSth = true
        output = false  
      end
    end
    
    -- hook all itemset lookups
    for id, name in string.gmatch(text, "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.itemset then
        table.insert(self.db.account.buffer.itemsets, {isId = id, isName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all spell lookups
    for id, name in string.gmatch(text, "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.spell then
        table.insert(self.db.account.buffer.spells, {spId = id, spName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all creature lookups
    for id, name in string.gmatch(text, "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.creature then
        table.insert(self.db.account.buffer.creatures, {crId = id, crName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all object lookups
    for id, name in string.gmatch(text, "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.object then
        table.insert(self.db.account.buffer.objects, {objId = id, objName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
    
    -- hook all quest lookups
    for id, name in string.gmatch(text, "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r") do
      if self.db.char.requests.quest then
        table.insert(self.db.account.buffer.quests, {qsId = id, qsName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
 
    -- hook all tele lookups
    for name in string.gmatch(text, "h%[(.-)%]") do
      if self.db.char.requests.tele then
        table.insert(self.db.account.buffer.teles, {tName = name})
        PopupScrollUpdate()
        catchedSth = true
        output = false
      end
    end
   
    -- hook all new tickets
    for name in string.gmatch(text, "New ticket from (%w+)") do
      catchedSth = true
      output = true
      -- now need function for: Got new ticket
      self:LogAction("Got new ticket from: "..name)
    end
    
    for count, status in string.gmatch(text, "Tickets count: (%d+) show new tickets: (%w+)\n") do
      if self.db.char.requests.ticket then
        catchedSth = true
        output = false
        self:ReLoadTickets(count)
      end
    end
    
    -- get tickets
    for char, category, message in string.gmatch(text, "Ticket of (%w+) %(Category: (%d+)%):\n(.*)\n") do
      if self.db.char.requests.ticket then
        --local message = string.gsub(message, "\n", " ")
        --self:LogAction("Fetching ticket from "..char.." (Category: "..category..")!")
        local ticketCount = 0
        table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
        local number = self.db.account.buffer.ticketa - ticketCount
        table.insert(self.db.account.buffer.tickets, {tNumber = number, tChar = char, tCat = category, tMsg = message})
        TicketScrollUpdate()
        self:RequestTickets()
        catchedSth = true
        output = false
      end
    end
  else
    -- message is not from server
  end
  
  if not catchedSth then
    -- output
    self.hooks[frame].AddMessage(frame, text, r, g, b, id)
  else
    if output == false then
      -- so far nothing to do here
      -- don't output anything
    elseif output == true then
      self.hooks[frame].AddMessage(frame, text, r, g, b, id)
    else
      -- output
      self.hooks[frame].AddMessage(frame, output, r, g, b, id)
    end
  end
end

function MangAdmin:GetValueCallHandler(guid, field, value)
  -- checks for specific actions and calls functions by checking the function-order
  local called = self.db.char.getValueCallHandler.calledGetGuid
  local realGuid = self.db.char.getValueCallHandler.realGuid
  -- case checking
  if guid == value and field == "0" and not called then
    -- getting GUID and setting db variables and logged text
    self.db.char.getValueCallHandler.calledGetGuid = true
    self.db.char.getValueCallHandler.realGuid = value
    ma_loggedtext:SetText(Locale["logged"]..Locale["charguid"]..guid)
    return false    
  elseif guid == realGuid then
    -- HERE WE CAN CALL AN ACTION, ATM UNUSED!
    return true
  else
    MangAdmin:LogAction("DEBUG: Getvalues are: GUID = "..guid.."; field = "..field.."; value = "..value..";")
    return true
  end
end

function MangAdmin:LogAction(msg)
  ma_logframe:AddMessage("|cFF00FF00["..date("%H:%M:%S").."]|r "..msg, 1.0, 1.0, 0.0)
end

function MangAdmin:ChatMsg(msg)
  if not type then local type = "say" end
  SendChatMessage(msg, type, nil, nil)
end

function MangAdmin:GetGuid()
  local called = MangAdmin.db.char.getValueCallHandler.calledGetGuid
  local realGuid = MangAdmin.db.char.getValueCallHandler.realGuid
  if not called then
    if MangAdmin:Selection("self") or MangAdmin:Selection("none") then
      MangAdmin:ChatMsg(".getvalue 0")
    end
  else
    ma_loggedtext:SetText(Locale["logged"]..Locale["charguid"]..realGuid)
  end
end

function MangAdmin:Selection(selection)
  if selection == "player" then
    if UnitIsPlayer("target") then
      return true
    end
  elseif selection == "self" then
    if UnitIsUnit("target", "player") then
      return true
    end
  elseif selection == "none" then
    if not UnitName("target") then
      return true
    end
  else
    error("Argument 'selection' can be 'player',''self', or 'none'!")
    return false
  end
end

function MangAdmin:AndBit(value, test) 
  return mod(value, test*2) >= test 
end

--[[USABILITY FUNCTIONS - MANGADMIN MAIN PART]]
function MangAdmin:SetLanguage()
  if self.db.account.language then
    Locale:SetLocale(self.db.account.language)
  else
    self.db.account.language = Locale:GetLocale()
  end
end

function MangAdmin:ChangeLanguage(locale)
  self.db.account.language = locale
  ReloadUI()
end

function MangAdmin:ToggleGMMode(value)
  MangAdmin:ChatMsg(".gm "..value)
  MangAdmin:LogAction("Turned GM-mode to "..value..".")
end

function MangAdmin:ToggleFlyMode(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    MangAdmin:ChatMsg(".flymode "..value)
    MangAdmin:LogAction("Turned Fly-mode "..value.." for "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:ToggleHoverMode(value)
  MangAdmin:ChatMsg(".hover "..value)
  local status
  if value == 1 then
    status = "on"
  else
    status = "off"
  end
  MangAdmin:LogAction("Turned Hover-mode "..status..".")
end

function MangAdmin:ToggleWhisper(value)
  MangAdmin:ChatMsg(".whispers "..value)
  MangAdmin:LogAction("Turned accepting whispers to "..value..".")
end

function MangAdmin:ToggleVisible(value)
  MangAdmin:ChatMsg(".visible "..value)
  if value == "on" then
    MangAdmin:LogAction("Turned you visible.")
  else
    MangAdmin:LogAction("Turned you invisible.")
  end  
end

function MangAdmin:ToggleTaxicheat(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    MangAdmin:ChatMsg(".taxicheat "..value)
    if value == 1 then
      MangAdmin:LogAction("Activated taxicheat to "..player..".")
    else
      MangAdmin:LogAction("Disabled taxicheat to "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:SetSpeed()
  local value = string.format("%.1f", ma_speedslider:GetValue())
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".modify speed "..value)
    self:ChatMsg(".modify fly "..value)
    self:ChatMsg(".modify swim "..value)
    self:LogAction("Set speed of "..player.." to "..value..".")
  else
    self:Print(Locale["selectionerror1"])
    ma_speedslider:SetValue(1)
  end
end

function MangAdmin:SetScale()
  local value = string.format("%.1f", ma_scaleslider:GetValue())
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".modify scale "..value)
    self:LogAction("Set scale of "..player.." to "..value..".")
  else
    self:Print(Locale["selectionerror1"])
    ma_scaleslider:SetValue(1)
  end
end

function MangAdmin:LearnSpell(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".learn"
    local logcmd = "Learned"
    if state == "RightButton" then
      command = ".unlearn"
      logcmd = "Unlearned"
    end
    if type(value) == "string" then
      if value == "all" then
        self:ChatMsg(command.." all")
        self:LogAction(logcmd.." all spells to "..player..".")
      elseif value == "all_crafts" then
        self:ChatMsg(command.." all_crafts")
        self:LogAction(logcmd.." all professions and recipes to "..player..".")
      elseif value == "all_gm" then
        self:ChatMsg(command.." all_gm")
        self:LogAction(logcmd.." all default spells for Game Masters to "..player..".")
      elseif value == "all_lang" then
        self:ChatMsg(command.." all_lang")
        self:LogAction(logcmd.." all languages to "..player..".")
      elseif value == "all_myclass" then
        self:ChatMsg(command.." all_myclass")
        self:LogAction(logcmd.." all spells available to the "..class.."-class to "..player..".")
      else
        self:ChatMsg(command.." "..value)
        self:LogAction(logcmd.." spell "..value.." to "..player..".")
      end
    elseif type(value) == "table" then
      for k,v in ipairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." spell "..v.." to "..player..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." spell "..value.." to "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:Quest(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".addquest"
    local logcmd = "Added"
    local logcmd2 = "to"
    if state == "RightButton" then
      command = ".removequest"
      logcmd = "Removed"
      logcmd2 = "from"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    elseif type(value) == "table" then
      for k,v in ipairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:Creature(value, state)
    local command = ".addspw"
    local logcmd = "Spawned"
    if state == "RightButton" then
      command = ".listcreature"
      logcmd = "Listed"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    elseif type(value) == "table" then
      for k,v in ipairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." creature with id "..value..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    end

end

function MangAdmin:AddItem(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local amount = ma_var1editbox:GetText()
    if state == "RightButton" then
      self:ChatMsg(".listitem "..value)
      self:LogAction("Listed item with id "..value..".")
    else
      if amount == "" then
        self:ChatMsg(".additem "..value)
        self:LogAction("Added item with id "..value.." to "..player..".")
      else
        self:ChatMsg(".additem "..value.." "..amount)
        self:LogAction("Added "..amount.." items with id "..value.." to "..player..".")
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:AddItemSet(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".additemset "..value)
    self:LogAction("Added itemset with id "..value.." to "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:AddObject(value, state)
  local loot = ma_var1editbox:GetText()
  local _time = ma_var2editbox:GetText()
  if state == "RightButton" then
    self:ChatMsg(".addgo "..value.." "..value)
    self:LogAction("Added object id "..value.." with loot template.")
  else
    if loot ~= "" and _time == "" then
      self:ChatMsg(".addgo "..value.. " "..loot)
      self:LogAction("Added object id "..value.." with loot "..loot..".")
    elseif loot ~= "" and _time ~= "" then
      self:ChatMsg(".addgo "..value.. " "..loot.." ".._time)
      self:LogAction("Added object id "..value.." with loot "..loot.." and spawntime ".._time..".")
    else
      self:ChatMsg(".addgo "..value)
      self:LogAction("Added object id "..value..".")
    end
  end
end

function MangAdmin:KickPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".kick")
    self:LogAction("Kicked player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:RevivePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".revive")
    self:LogAction("Revived player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:DismountPlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".dismount")
    self:LogAction("Dismounted player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:SavePlayer()
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".save")
    self:LogAction("Saved player "..player..".")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:KillSomething()
  local target = UnitName("target") or UnitName("player")
  self:ChatMsg(".die")
  self:LogAction("Killed "..target..".")
end

function MangAdmin:LevelupPlayer(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".levelup "..value)
    self:LogAction("Leveled up player "..player.." by "..value.." levels.")
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:GridNavigate(x, y)
  local way = self.db.char.nextGridWay
  if not x and not y then
    table.insert(self.db.char.functionQueue, "GridNavigate")
    self:ChatMsg(".gps")
  else
    if pcall(function() return ma_gridnavieditbox:GetText() + 10 end) then
      local step = ma_gridnavieditbox:GetText()
      local newy
      local newx
      if way == "back" then
        newy = y - step
        newx = x
      elseif way == "right" then
        newy = y
        newx = x + step
      elseif way == "left" then
        newy = y
        newx = x - step
      else
        newy = y + step
        newx = x
      end
      self:ChatMsg(".goxy "..newx.." "..newy)
      self:LogAction("Navigated to grid position: X: "..newx.." Y: "..newy)
    else
      self:Print("Value must be a number!")
    end
  end
end

function MangAdmin:CreateGuild(leader, name)
  self:ChatMsg(".createguild "..leader.." "..name)
  self:LogAction("Created guild '"..name.."' with leader "..leader..".")
end

function MangAdmin:Screenshot()
  --SetCVar("UnitNamePlayer", 0)
  --UIParent:Hide()
  Screenshot()
  --UIParent:Show()
  --SetCVar("UnitNamePlayer", 1)
end

function MangAdmin:Announce(value)
  self:ChatMsg(".announce "..value)
  self:LogAction("Announced message: "..value)
end

function MangAdmin:Shutdown(value)
  if value == "" then
    self:ChatMsg(".shutdown 0")
    self:LogAction("Shut down server instantly.")
  else
    self:ChatMsg(".shutdown "..value)
    self:LogAction("Shut down server in "..value.." seconds.")
  end
end

function MangAdmin:SendMail(recipient, subject, body)
  self:ChatMsg(".sendmail "..recipient.." "..subject.." "..body)
  self:LogAction("Sent a mail to "..recipient..". Subject was: "..subject)
end

function MangAdmin:Ticket(value)
  local ticket = self.db.account.buffer.ticketselected
  if value == "delete" then
    self:ChatMsg(".delticket "..ticket["tNumber"])
    self:LogAction("Deleted ticket with number: "..ticket["tNumber"])
    --self:ReLoadTickets(nil) -- doesn't work, server delay?
  elseif value == "gochar" then
    self:ChatMsg(".goname "..ticket["tChar"])
  elseif value == "getchar" then
    self:ChatMsg(".namego "..ticket["tChar"])
  elseif value == "answer" then
    self:TogglePopup("mail", {recipient = ticket["tChar"], subject = "RE:Ticket(Category:"..ticket["tCat"]..")", body = "------------------------------\n"..ticket["tMsg"]})
  end
end

function MangAdmin:ReLoadTickets(number)
  self.db.account.buffer.tickets = {}
  if number then
    if tonumber(number) > 0 then
      self.db.account.buffer.ticketa = tonumber(number)
      if self.db.char.requests.ticket then
        self:LogAction("(Re-)Load of tickets requested. Found "..number.." tickets!")
        self:RequestTickets()
      end
    else
      self:NoTickets()
    end
  else
    self.db.char.requests.ticket = true
    self.db.account.buffer.tickets = 0
    self:ChatMsg(".ticket")
  end
  ma_ticketeditbox:SetText("")
  ma_deleteticketbutton:Disable()
  ma_answerticketbutton:Disable()
  ma_getcharticketbutton:Disable()
  ma_gocharticketbutton:Disable()
end

function MangAdmin:RequestTickets()
  self.db.char.requests.ticket = true
  local ticketCount = 0
  table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
  local tnumber = self.db.account.buffer.ticketa - ticketCount
  if tnumber == 0 then
    self.db.char.requests.ticket = false
  else
    self:ChatMsg(".ticket "..tnumber)
  end
end

function MangAdmin:NoTickets()
  -- Reset list and make an entry "No Tickets"
  self:LogAction("(Re-)Load of tickets requested. No tickets were found!")
  ma_ticketeditbox:SetText("There are no tickets available!")
  --ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  FauxScrollFrame_Update(ma_TicketScrollBar,16,16,10)
  for line = 1,16 do
    getglobal("ma_TicketScrollBarEntry"..line):Disable()
    if line == 1 then
      getglobal("ma_TicketScrollBarEntry"..line):SetText("No Tickets!")
      getglobal("ma_TicketScrollBarEntry"..line):Show()
    else
      getglobal("ma_TicketScrollBarEntry"..line):Hide()
    end
  end
end

function MangAdmin:SearchStart(var, value)
  if var == "item" then
    self.db.char.requests.item = true
    self.db.account.buffer.items = {}
    self:ChatMsg(".lookup item "..value)
  elseif var == "itemset" then
    self.db.char.requests.itemset = true
    self.db.account.buffer.itemsets = {}
    self:ChatMsg(".lookup itemset "..value)
  elseif var == "spell" then
    self.db.char.requests.spell = true
    self.db.account.buffer.spells = {}
    self:ChatMsg(".lookup spell "..value)
  elseif var == "quest" then
    self.db.char.requests.quest = true
    self.db.account.buffer.quests = {}
    self:ChatMsg(".lookup quest "..value)
  elseif var == "creature" then
    self.db.char.requests.creature = true
    self.db.account.buffer.creatures = {}
    self:ChatMsg(".lookup creature "..value)
  elseif var == "object" then
    self.db.char.requests.object = true
    self.db.account.buffer.objects = {}
    self:ChatMsg(".lookup object "..value)
  elseif var == "tele" then
    self.db.char.requests.tele = true
    self.db.account.buffer.teles = {}
    self:ChatMsg(".lookup tele "..value)
  end
  self.db.account.buffer.counter = 0
  self:LogAction("Started search for "..var.."s with the keyword '"..value.."'.")
end

function MangAdmin:SearchReset()
  ma_searcheditbox:SetText("")
  ma_var1editbox:SetText("")
  ma_var2editbox:SetText("")
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  self.db.char.requests.item = false
  self.db.char.requests.itemset = false
  self.db.char.requests.spell = false
  self.db.char.requests.quest = false
  self.db.char.requests.creature = false
  self.db.char.requests.object = false
  self.db.char.requests.tele = false
  self.db.account.buffer.items = {}
  self.db.account.buffer.itemsets = {}
  self.db.account.buffer.spells = {}
  self.db.account.buffer.quests = {}
  self.db.account.buffer.creatures = {}
  self.db.account.buffer.objects = {}
  self.db.account.buffer.teles = {}
  self.db.account.buffer.counter = 0
  PopupScrollUpdate()
end

function MangAdmin:PrepareScript(object, text, script)
  --if object then
    if text then
      object:SetScript("OnEnter", function() ma_tooltiptext:SetText(text) end)
      object:SetScript("OnLeave", function() ma_tooltiptext:SetText(Locale["tt_Default"]) end)
    end
    if type(script) == "function" then
      object:SetScript("OnClick", script)
    elseif type(script) == "table" then
      for k,v in pairs(script) do
        object:SetScript(unpack(v))
      end
    end
  --end
end

--[[INITIALIZION FUNCTIONS]]
function MangAdmin:InitButtons()
  -- start tab buttons
  self:PrepareScript(ma_mainbutton          , Locale["tt_MainButton"]       , function() MangAdmin:ToggleTabButton("ma_mainbutton"); MangAdmin:ToggleContentGroup("main") end)
  self:PrepareScript(ma_charbutton          , Locale["tt_CharButton"]       , function() MangAdmin:ToggleTabButton("ma_charbutton"); MangAdmin:ToggleContentGroup("char") end)
  self:PrepareScript(ma_telebutton          , Locale["tt_TeleButton"]       , function() MangAdmin:ToggleTabButton("ma_telebutton"); MangAdmin:ToggleContentGroup("tele") end)
  self:PrepareScript(ma_ticketbutton        , Locale["tt_TicketButton"]     , function() MangAdmin:ToggleTabButton("ma_ticketbutton"); MangAdmin:ToggleContentGroup("ticket") end)
  self:PrepareScript(ma_serverbutton        , Locale["tt_ServerButton"]     , function() MangAdmin:ToggleTabButton("ma_serverbutton"); MangAdmin:ToggleContentGroup("server") end)
  self:PrepareScript(ma_miscbutton          , Locale["tt_MiscButton"]       , function() --[[MangAdmin:ToggleTabButton("ma_miscbutton"); MangAdmin:ToggleContentGroup("misc") ]] MangAdmin:Print("Not available yet!") end)
  self:PrepareScript(ma_logbutton           , Locale["tt_LogButton"]        , function() MangAdmin:ToggleTabButton("ma_logbutton"); MangAdmin:ToggleContentGroup("log") end)
  --end tab buttons
  self:PrepareScript(ma_languagebutton      , Locale["tt_LanguageButton"]   , function() MangAdmin:ChangeLanguage(UIDropDownMenu_GetSelectedValue(ma_languagedropdown)) end)
  self:PrepareScript(ma_speedslider         , Locale["tt_SpeedSlider"]      , {{"OnMouseUp", function() MangAdmin:SetSpeed() end},{"OnValueChanged", function() ma_speedsliderText:SetText(string.format("%.1f", ma_speedslider:GetValue())) end}})
  self:PrepareScript(ma_scaleslider         , Locale["tt_ScaleSlider"]      , {{"OnMouseUp", function() MangAdmin:SetScale() end},{"OnValueChanged", function() ma_scalesliderText:SetText(string.format("%.1f", ma_scaleslider:GetValue())) end}})  
  self:PrepareScript(ma_itembutton          , Locale["tt_ItemButton"]       , function() MangAdmin:TogglePopup("search", {type = "item"}) end)
  self:PrepareScript(ma_itemsetbutton       , Locale["tt_ItemSetButton"]    , function() MangAdmin:TogglePopup("search", {type = "itemset"}) end)
  self:PrepareScript(ma_spellbutton         , Locale["tt_SpellButton"]      , function() MangAdmin:TogglePopup("search", {type = "spell"}) end)
  self:PrepareScript(ma_questbutton         , Locale["tt_QuestButton"]      , function() MangAdmin:TogglePopup("search", {type = "quest"}) end)
  self:PrepareScript(ma_creaturebutton      , Locale["tt_CreatureButton"]   , function() MangAdmin:TogglePopup("search", {type = "creature"}) end)
  self:PrepareScript(ma_objectbutton        , Locale["tt_ObjectButton"]     , function() MangAdmin:TogglePopup("search", {type = "object"}) end)
  self:PrepareScript(ma_telesearchbutton    , Locale["ma_TeleSearchButton"] , function() MangAdmin:TogglePopup("search", {type = "tele"}) end)
  self:PrepareScript(ma_sendmailbutton      , "Tooltip not available yet."  , function() MangAdmin:TogglePopup("mail", {}) end)
  self:PrepareScript(ma_screenshotbutton    , Locale["tt_ScreenButton"]     , function() MangAdmin:Screenshot() end)
  self:PrepareScript(ma_gmonbutton          , Locale["tt_GMOnButton"]       , function() MangAdmin:ToggleGMMode("on") end)
  self:PrepareScript(ma_gmoffbutton         , Locale["tt_GMOffButton"]      , function() MangAdmin:ToggleGMMode("off") end)
  self:PrepareScript(ma_flyonbutton         , Locale["tt_FlyOnButton"]      , function() MangAdmin:ToggleFlyMode("on") end)
  self:PrepareScript(ma_flyoffbutton        , Locale["tt_FlyOffButton"]     , function() MangAdmin:ToggleFlyMode("off") end)
  self:PrepareScript(ma_hoveronbutton       , Locale["tt_HoverOnButton"]    , function() MangAdmin:ToggleHoverMode(1) end)
  self:PrepareScript(ma_hoveroffbutton      , Locale["tt_HoverOffButton"]   , function() MangAdmin:ToggleHoverMode(0) end)
  self:PrepareScript(ma_whisperonbutton     , Locale["tt_WhispOnButton"]    , function() MangAdmin:ToggleWhisper("on") end)
  self:PrepareScript(ma_whisperoffbutton    , Locale["tt_WhispOffButton"]   , function() MangAdmin:ToggleWhisper("off") end)
  self:PrepareScript(ma_invisibleonbutton   , Locale["tt_InvisOnButton"]    ,  function() MangAdmin:ToggleVisible("off") end)
  self:PrepareScript(ma_invisibleoffbutton  , Locale["tt_InvisOffButton"]   , function() MangAdmin:ToggleVisible("on") end)
  self:PrepareScript(ma_taxicheatonbutton   , Locale["tt_TaxiOnButton"]     , function() MangAdmin:ToggleTaxicheat("on") end)
  self:PrepareScript(ma_taxicheatoffbutton  , Locale["tt_TaxiOffButton"]    , function() MangAdmin:ToggleTaxicheat("off") end)
  self:PrepareScript(ma_bankbutton          , Locale["tt_BankButton"]       , function() MangAdmin:ChatMsg(".bank") end)
  self:PrepareScript(ma_learnallbutton      , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all") end)
  self:PrepareScript(ma_learncraftsbutton   , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_crafts") end)
  self:PrepareScript(ma_learngmbutton       , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_gm") end)
  self:PrepareScript(ma_learnlangbutton     , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_lang") end)
  self:PrepareScript(ma_learnclassbutton    , "Tooltip not available yet."  , function() MangAdmin:LearnSpell("all_myclass") end)
  self:PrepareScript(ma_levelupbutton       , "Tooltip not available yet."  , function() MangAdmin:LevelupPlayer(ma_levelupeditbox:GetText()) end)
  self:PrepareScript(ma_searchbutton        , "Tooltip not available yet."  , function() MangAdmin:SearchStart("item", ma_searcheditbox:GetText()) end)
  self:PrepareScript(ma_resetsearchbutton   , "Tooltip not available yet."  , function() MangAdmin:SearchReset() end)
  self:PrepareScript(ma_revivebutton        , "Tooltip not available yet."  , function() MangAdmin:RevivePlayer() end)
  self:PrepareScript(ma_killbutton          , "Tooltip not available yet."  , function() MangAdmin:KillSomething() end)
  self:PrepareScript(ma_savebutton          , "Tooltip not available yet."  , function() MangAdmin:SavePlayer() end)
  self:PrepareScript(ma_dismountbutton      , "Tooltip not available yet."  , function() MangAdmin:DismountPlayer() end)
  self:PrepareScript(ma_kickbutton          , Locale["tt_KickButton"]       , function() MangAdmin:KickPlayer() end)
  self:PrepareScript(ma_gridnaviaheadbutton , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "ahead" end)
  self:PrepareScript(ma_gridnavibackbutton  , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "back" end)
  self:PrepareScript(ma_gridnavirightbutton , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "right" end)
  self:PrepareScript(ma_gridnavileftbutton  , "Tooltip not available yet."  , function() MangAdmin:GridNavigate(nil, nil); self.db.char.nextGridWay = "left" end)
  self:PrepareScript(ma_announcebutton      , Locale["tt_AnnounceButton"]   , function() MangAdmin:Announce(ma_announceeditbox:GetText()) end)
  self:PrepareScript(ma_resetannouncebutton , "Tooltip not available yet."  , function() ma_announceeditbox:SetText("") end)
  self:PrepareScript(ma_shutdownbutton      , Locale["tt_ShutdownButton"]   , function() MangAdmin:Shutdown(ma_shutdowneditbox:GetText()) end)
  self:PrepareScript(ma_closebutton         , "Tooltip not available yet."  , function() FrameLib:HandleGroup("bg", function(frame) frame:Hide() end) end)
  self:PrepareScript(ma_popupclosebutton    , "Tooltip not available yet."  , function() FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end) end)
  self:PrepareScript(ma_loadticketsbutton   , "Tooltip not available yet."  , function() MangAdmin:ReLoadTickets() end)
  self:PrepareScript(ma_deleteticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("delete") end)
  self:PrepareScript(ma_answerticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("answer") end)
  self:PrepareScript(ma_getcharticketbutton , "Tooltip not available yet."  , function() MangAdmin:Ticket("getchar") end)
  self:PrepareScript(ma_gocharticketbutton  , "Tooltip not available yet."  , function() MangAdmin:Ticket("gochar") end)
  
end

function MangAdmin:InitLangDropDown()
  local function LangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {"English","enUS"},
      {"German","deDE"},
      {"French","frFR"},
      {"Italian","itIT"},
      {"Finnish","fiFI"},
      {"Polish","plPL"},
      {"Swedish","svSV"},
      {"Lithuania","liLI"},
      {"Romania","roRO"},
      {"Czech","csCZ"},
      {"Hungarian","huHU"},
      {"Spanish","esES"},
      {"Chinese","zhCN"},
      {"Portuguese","ptPT"}
    }
    for k,v in ipairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_languagedropdown, this.value) end
      if v[2] == Locale:GetLocale() then
        info.checked = true
      else
        info.checked = nil
      end
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
  end  
  UIDropDownMenu_Initialize(ma_languagedropdown, LangDropDownInitialize)
  UIDropDownMenu_SetWidth(100, ma_languagedropdown)
  UIDropDownMenu_SetButtonWidth(20, ma_languagedropdown)
end

function MangAdmin:InitSliders()
  -- Speed Slider
  ma_speedslider:SetOrientation("HORIZONTAL")
  ma_speedslider:SetMinMaxValues(1, 10)
  ma_speedslider:SetValueStep(0.1)
  ma_speedslider:SetValue(1)
  ma_speedsliderText:SetText("1.0")
  -- Scale Slider
  ma_scaleslider:SetOrientation("HORIZONTAL")
  ma_scaleslider:SetMinMaxValues(0.1, 3)
  ma_scaleslider:SetValueStep(0.1)
  ma_scaleslider:SetValue(1)
  ma_scalesliderText:SetText("1.0")
end

function MangAdmin:InitScrollFrames()
  ma_PopupScrollBar:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(30, PopupScrollUpdate) end)
  ma_PopupScrollBar:SetScript("OnShow", function() PopupScrollUpdate() end)
  ma_TicketScrollBar:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(10, TicketScrollUpdate) end)
  ma_TicketScrollBar:SetScript("OnShow", function() MangAdmin:ReLoadTickets() end)
  ma_ticketscrollframe:SetScrollChild(ma_ticketeditbox)
  self:PrepareScript(ma_ticketeditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
  ma_mailscrollframe:SetScrollChild(ma_maileditbox)
  self:PrepareScript(ma_maileditbox, nil, {{"OnTextChanged", function() ScrollingEdit_OnTextChanged() end},
    {"OnCursorChanged", function() ScrollingEdit_OnCursorChanged(arg1, arg2, arg3, arg4) end},
    {"OnUpdate", function() ScrollingEdit_OnUpdate() end}})
end

function MangAdmin:NoSearchOrResult()
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30)
  for line = 1,7 do
    getglobal("ma_PopupScrollBarEntry"..line):Disable()
    if line == 1 then
      getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["tt_SearchDefault"])
      getglobal("ma_PopupScrollBarEntry"..line):Show()
    else
      getglobal("ma_PopupScrollBarEntry"..line):Hide()
    end
  end
end

function PopupScrollUpdate()
  local line -- 1 through 7 of our window to scroll
  local lineplusoffset -- an index into our data calculated from the scroll offset
  
  if MangAdmin.db.char.requests.item then --get items
    local itemCount = 0
    table.foreachi(MangAdmin.db.account.buffer.items, function() itemCount = itemCount + 1 end)
    if itemCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..itemCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,itemCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= itemCount then
          local item = MangAdmin.db.account.buffer.items[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..item["itId"].."|r Name: |cffffffff"..item["itName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.itemset then --get itemsets
    local itemsetCount = 0
    table.foreachi(MangAdmin.db.account.buffer.itemsets, function() itemsetCount = itemsetCount + 1 end)
    if itemsetCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..itemsetCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,itemsetCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= itemsetCount then
          local itemset = MangAdmin.db.account.buffer.itemsets[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..itemset["isId"].."|r Name: |cffffffff"..itemset["isName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItemSet(itemset["isId"]) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.quest then --get quests
    local questCount = 0
    table.foreachi(MangAdmin.db.account.buffer.quests, function() questCount = questCount + 1 end)
    if questCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..questCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,questCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= questCount then
          local quest = MangAdmin.db.account.buffer.quests[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..quest["qsId"].."|r Name: |cffffffff"..quest["qsName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Quest(quest["qsId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.creature then --get creatures
    local creatureCount = 0
    table.foreachi(MangAdmin.db.account.buffer.creatures, function() creatureCount = creatureCount + 1 end)
    if creatureCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..creatureCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,creatureCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= creatureCount then
          local creature = MangAdmin.db.account.buffer.creatures[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..creature["crId"].."|r Name: |cffffffff"..creature["crName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Creature(creature["crId"], arg1) end) 
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.spell then --get spells
    local spellCount = 0
    table.foreachi(MangAdmin.db.account.buffer.spells, function() spellCount = spellCount + 1 end)
    if spellCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..spellCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,spellCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= spellCount then
          local spell = MangAdmin.db.account.buffer.spells[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..spell["spId"].."|r Name: |cffffffff"..spell["spName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:LearnSpell(spell["spId"], arg1) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end
    
  elseif MangAdmin.db.char.requests.object then --get objects
    local objectCount = 0
    table.foreachi(MangAdmin.db.account.buffer.objects, function() objectCount = objectCount + 1 end)
    if objectCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..objectCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,objectCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= objectCount then
          local object = MangAdmin.db.account.buffer.objects[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..object["objId"].."|r Name: |cffffffff"..object["objName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddObject(object["objId"], arg1) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end

  elseif MangAdmin.db.char.requests.tele then --get teles
    local teleCount = 0
    table.foreachi(MangAdmin.db.account.buffer.teles, function() teleCount = teleCount + 1 end)
    if teleCount > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..teleCount)
      FauxScrollFrame_Update(ma_PopupScrollBar,teleCount,7,30)
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= teleCount then
          local tele = MangAdmin.db.account.buffer.teles[lineplusoffset]
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Name: |cffffffff"..tele["tName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:ChatMsg(".tele "..tele["tName"]) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      MangAdmin:NoSearchOrResult()
    end

  else
    MangAdmin:NoSearchOrResult()
  end
end

function TicketScrollUpdate()
  local line -- 1 through 16 of our window to scroll
  local lineplusoffset -- an index into our data calculated from the scroll offset

  local ticketCount = 0
  table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
  if ticketCount > 0 then
    --ma_ticketnumbertext:SetText("Number of Tickets: "..ticketCount)
    FauxScrollFrame_Update(ma_TicketScrollBar,ticketCount,16,10)
    for line = 1,16 do
      lineplusoffset = line + FauxScrollFrame_GetOffset(ma_TicketScrollBar)
      if lineplusoffset <= ticketCount then
        local object = MangAdmin.db.account.buffer.tickets[lineplusoffset]
        getglobal("ma_TicketScrollBarEntry"..line):SetText("Cat: |cffffffff"..object["tCat"].."|r Player: |cffffffff"..object["tChar"].."|r")
        getglobal("ma_TicketScrollBarEntry"..line):SetScript("OnClick", function() 
          ma_ticketeditbox:SetText(object["tMsg"])
          MangAdmin.db.account.buffer.ticketselected = object
          ma_deleteticketbutton:Enable()
          ma_answerticketbutton:Enable()
          ma_getcharticketbutton:Enable()
          ma_gocharticketbutton:Enable()
        end)
        getglobal("ma_TicketScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
        getglobal("ma_TicketScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
        getglobal("ma_TicketScrollBarEntry"..line):Enable()
        getglobal("ma_TicketScrollBarEntry"..line):Show()
      else
        getglobal("ma_TicketScrollBarEntry"..line):Hide()
      end
    end
  else
    MangAdmin:NoTickets()
  end
end
