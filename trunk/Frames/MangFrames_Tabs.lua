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
-- Official Forums: http://www.manground.de/forums/
-- GoogleCode Website: http://code.google.com/p/mangadmin/
-- Subversion Repository: http://mangadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

-- Initializing dynamic frames with LUA and FrameLib
-- This script must be listed in the .toc after "MangFrames_Start.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateTabs()
  local transparency = {
    bg = MangAdmin.db.account.style.transparency.backgrounds,
    btn = MangAdmin.db.account.style.transparency.buttons,
    frm = MangAdmin.db.account.style.transparency.frames
  }
  local color = {
    bg = MangAdmin.db.account.style.color.backgrounds,
    btn = MangAdmin.db.account.style.color.buttons,
    frm = MangAdmin.db.account.style.color.frames
  }
  
  -- [[ Tab Buttons ]]
  FrameLib:BuildButton({
    name = "ma_tabbutton_main",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_main_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,1},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
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
    name = "ma_tabbutton_char",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_char_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_main",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Char"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_tele",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_tele_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_char",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Tele"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_ticket",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_ticket_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 130,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_tele",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Ticket"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_misc",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_misc_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_ticket",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Misc"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_server",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {

      name = "ma_tabbutton_server_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_misc",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Server"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_log",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_log_texture",
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
      }
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_server",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Log"]
  })
end
