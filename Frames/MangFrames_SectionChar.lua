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
-- This script must be listed in the .toc after "MangFrames_SectionLog.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateCharSection()
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
    name = "ma_learnallbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_learnallbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
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
    name = "ma_modifydropdown",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = -10,
      offY = -55
    },
    inherits = "UIDropDownMenuTemplate"
  })
  
  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_modifyeditbox",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 135,
      offY = -60
    },
    inherits = "InputBoxTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_modifybutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_modifybutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 170,
      offY = -60
    },
    text = "Modify"
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
    text = Locale["ma_KillButton"]
  })

  FrameLib:BuildButton({
    name = "ma_kickbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_kickbutton_texture",
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
    text = Locale["ma_KickButton"]
  })

  FrameLib:BuildButton({
    name = "ma_dismountbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_dismountbutton_texture",
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
    text = Locale["ma_DismountButton"]
  })

  FrameLib:BuildButton({
    name = "ma_revivebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_revivebutton_texture",
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
    text = Locale["ma_ReviveButton"]
  })

  FrameLib:BuildButton({
    name = "ma_savebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_savebutton_texture",
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
    text = Locale["ma_SaveButton"]
  })
end
