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
-- Official Forums: http://www.manground.org/forum/
-- GoogleCode Website: http://code.google.com/p/mangadmin/
-- Subversion Repository: http://mangadmin.googlecode.com/svn/
--
-------------------------------------------------------------------------------------------------------------

-- Initializing dynamic frames with LUA and FrameLib
-- This script must be listed in the .toc after "MangFrames_SectionLog.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateChar2Section()
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
  
  
  
  FrameLib:BuildFontString({
    name = "ma_char2placeholder",
    group = "char2",
    parent = ma_midframe,
    text = "Parameterized Commands",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = 0
    }
  })

 FrameLib:BuildFontString({
    name = "ma_parameterboxtext",
    group = "char2",
    parent = ma_midframe,
    text = "Parameter(s)",
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 10,
      offY = 10
    }
  })
  
    FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_charactertarget",
    group = "char2",
    parent = ma_midframe,
    size = {
      width = 200,
      height = 20
    },
    setpoint = {
      pos = "BOTTOMLEFT",
      offX = 100,
      offY = 5
    },
    inherits = "InputBoxTemplate"
  })

FrameLib:BuildButton({
    name = "ma_r1c1button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r1c1button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -15
    },
    text = Locale["ma_r1c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_charmorphbutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_charmorphbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -103
    },
    text = Locale["Morph"]
    })

FrameLib:BuildButton({
    name = "ma_r1c2button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r1c2button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -15
    },
    text = Locale["ma_r1c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r1c3button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r1c3button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -15
    },
    text = Locale["ma_r1c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r1c4button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r1c4button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -15
    },
    text = Locale["ma_r1c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c1button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r2c1button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -37
    },
    text = Locale["ma_r2c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c2button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r2c2button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -37
    },
    text = Locale["ma_r2c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c3button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r2c3button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -37
    },
    text = Locale["ma_r2c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c4button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r2c4button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -37
    },
    text = Locale["ma_r2c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c1button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r3c1button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -59
    },
    text = Locale["ma_r3c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c2button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r3c2button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -59
    },
    text = Locale["ma_r3c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c3button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r3c3button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -59
    },
    text = Locale["ma_r3c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c4button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r3c4button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -59
    },
    text = Locale["ma_r3c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c1button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r4c1button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -81
    },
    text = Locale["ma_r4c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c2button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r4c2button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -81
    },
    text = Locale["ma_r4c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c3button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r4c3button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -81
    },
    text = Locale["ma_r4c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c4button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r4c4button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -81
    },
    text = Locale["ma_r4c4Button"]
    })

  FrameLib:BuildButton({
    name = "ma_r4c5button",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_r4c5button_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -103
    },
    text = Locale["ma_r4c5Button"]
})

FrameLib:BuildButton({
    name = "ma_charaurabutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_charaurabutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -103
    },
    text = "Aura"
    })

FrameLib:BuildButton({
    name = "ma_charunaurabutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_charunaurabutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -103
    },
    text = "UnAura"
    })
      
  FrameLib:BuildButton({
    name = "ma_jailabutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_jailabutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -125
    },
    text = Locale["ma_JailAButton"]
    })

  FrameLib:BuildButton({
    name = "ma_jailhbutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_jailhbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -125
    },
    text = Locale["ma_JailHButton"]
  })

  FrameLib:BuildButton({
    name = "ma_unjailbutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_unjailbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -125
    },
    text = Locale["ma_UnJailButton"]
  })

  FrameLib:BuildButton({
    name = "ma_damagebutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_damagebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -147
    },
    text = Locale["ma_DamageButton"]
  })

  FrameLib:BuildButton({
    name = "ma_questaddbutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_questaddbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -147
    },
    text = Locale["ma_QuestAddButton"]
  })

  FrameLib:BuildButton({
    name = "ma_questcompletebutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_questcompletebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -147
    },
    text = Locale["ma_QuestCompleteButton"]
  })

  FrameLib:BuildButton({
    name = "ma_questremovebutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_questremovebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -147
    },
    text = Locale["ma_QuestRemoveButton"]
  })

  FrameLib:BuildButton({
    name = "ma_unmutebutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_unmutebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -125
    },
    text = Locale["ma_UnMuteButton"]
  })

  FrameLib:BuildButton({
    name = "ma_hideareabutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_hideareabutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -169
    },
    text = Locale["ma_HideAreaButton"]
  })

  FrameLib:BuildButton({
    name = "ma_showareabutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_showareabutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 92,
      offY = -169
    },
    text = Locale["ma_ShowAreaButton"]
  })

  FrameLib:BuildButton({
    name = "ma_honoraddbutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_honoraddbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 174,
      offY = -169
    },
    text = Locale["ma_HonorAddButton"]
  })

  FrameLib:BuildButton({
    name = "ma_honorupdatebutton",
    group = "char2",
    parent = ma_midframe,
    texture = {
      name = "ma_honorupdatebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 256,
      offY = -169
    },
    text = Locale["ma_HonorUpdateButton"]
  })


end
