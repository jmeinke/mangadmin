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
-- Official Forums: http://www.manground.de/forum/
-- GoogleCode Website: http://code.google.com/p/mangadmin/
-- Subversion Repository: http://mangadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

-- Initializing dynamic frames with LUA and FrameLib
-- This script must be listed in the .toc after "MangFrames_SectionChar.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateTicketSection()
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
  
  FrameLib:BuildButton({
    name = "ma_showticketsbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_loadticketsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
  
    
  FrameLib:BuildFontString({
    name = "ma_tpinfo_text",
    group = "ticket",
    parent = ma_midframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -40
    }
  })
  
  FrameLib:BuildButton({
    name = "ma_whisperticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_whisperticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
    text = "Whisper" --Locale["ma_WhisperButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_getcharticketbutton",
    group = "ticket",
    parent = ma_midframe,
    texture = {
      name = "ma_getcharticketbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
end
