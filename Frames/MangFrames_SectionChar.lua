﻿-------------------------------------------------------------------------------------------------------------
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
  
  --[[FrameLib:BuildButton({
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
  })]]
  
  FrameLib:BuildFrame({
    type = "PlayerModel",
    name = "ma_modelframe",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 233,
      height = 300
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = -70,
      offY = 10
    },
    inherits = nil
  })
  
  FrameLib:BuildButton({
    name = "ma_modelrotatelbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_modelrotatelbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    },
    text = "<<="
  })
  
  FrameLib:BuildButton({
    name = "ma_modelrotaterbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_modelrotaterbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 30,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 44,
      offY = -10
    },
    text = "=>>"
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
      pos = "TOPLEFT",
      offX = 100,
      offY = -10
    },
    text = Locale["ma_KillButton"]
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
      pos = "TOPLEFT",
      offX = 100,
      offY = -34
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
      pos = "TOPLEFT",
      offX = 100,
      offY = -58
    },
    text = Locale["ma_SaveButton"]
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
      pos = "TOPLEFT",
      offX = 100,
      offY = -82
    },
    text = Locale["ma_KickButton"]
  })

  FrameLib:BuildButton({
    name = "ma_cooldownbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_cooldownbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 100,
      offY = -106
    },
    text = Locale["ma_CooldownButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_demorphbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_demorphbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 100,
      offY = -130
    },
    text = Locale["ma_DemorphButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_showmapsbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_showmapsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 100,
      offY = -154
    },
    text = Locale["ma_ShowMapsButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_hidemapsbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_hidemapsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 100,
      offY = -178
    },
    text = Locale["ma_HideMapsButton"]
  })

FrameLib:BuildButton({
    name = "ma_gpsbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_gpsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 100,
      offY = -202
    },
    text = Locale["ma_GPSButton"]
  })
  
  FrameLib:BuildButton({
    name = "ma_guidbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_guidbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 184,
      offY = -10
    },
    text = Locale["ma_GUIDButton"]
  })


    FrameLib:BuildButton({
    name = "ma_pinfobutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_pinfobutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 184,
      offY = -34
    },
    text = Locale["ma_PinfoButton"]
  })

    FrameLib:BuildButton({
    name = "ma_distancebutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_distancebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 184,
      offY = -58
    },
    text = Locale["ma_DistanceButton"]
  })

    FrameLib:BuildButton({
    name = "ma_recallbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_recallbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      offX = 184,
      offY = -82
    },
    text = Locale["ma_RecallButton"]
  })

  
  FrameLib:BuildFrame({
    name = "ma_learnlangdropdown",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -90,
      offY = -10
    },
    inherits = "UIDropDownMenuTemplate"
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
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -15
    },
    text = "Learn"
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
      pos = "TOPRIGHT",
      offX = -130,
      offY = -40
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
      pos = "TOPRIGHT",
      offX = -100,
      offY = -45
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
      pos = "TOPRIGHT",
      offX = -10,
      offY = -45
    },
    text = "Modify"
  })
  
  FrameLib:BuildFrame({
    name = "ma_resetdropdown",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -90,
      offY = -70
    },
    inherits = "UIDropDownMenuTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_resetbutton",
    group = "char",
    parent = ma_midframe,
    texture = {
      name = "ma_resetbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -75
    },
    text = "Reset"
  })
 
  FrameLib:BuildFontString({
    name = "ma_parameterboxtext",
    group = "char",
    parent = ma_midframe,
    text = "Parameter(s)",
    setpoint = {
      pos = "TOPRIGHT",
      offX = -150,
      offY = -110
    }
  })
  
    FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_charactertarget",
    group = "char",
    parent = ma_midframe,
    size = {
      width = 200,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -50,
      offY = -125
    },
    inherits = "InputBoxTemplate"
  })

FrameLib:BuildButton({
    name = "ma_r1c1button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -329,
      offY = -150
    },
    text = Locale["ma_r1c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r1c2button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -248,
      offY = -150
    },
    text = Locale["ma_r1c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r1c3button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -167,
      offY = -150
    },
    text = Locale["ma_r1c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r1c4button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -86,
      offY = -150
    },
    text = Locale["ma_r1c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c1button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -329,
      offY = -175
    },
    text = Locale["ma_r2c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c2button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -248,
      offY = -175
    },
    text = Locale["ma_r2c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c3button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -167,
      offY = -175
    },
    text = Locale["ma_r2c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r2c4button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -86,
      offY = -175
    },
    text = Locale["ma_r2c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c1button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -329,
      offY = -200
    },
    text = Locale["ma_r3c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c2button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -248,
      offY = -200
    },
    text = Locale["ma_r3c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c3button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -167,
      offY = -200
    },
    text = Locale["ma_r3c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r3c4button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -86,
      offY = -200
    },
    text = Locale["ma_r3c4Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c1button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -329,
      offY = -225
    },
    text = Locale["ma_r4c1Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c2button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -248,
      offY = -225
    },
    text = Locale["ma_r4c2Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c3button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -167,
      offY = -225
    },
    text = Locale["ma_r4c3Button"]
    })

FrameLib:BuildButton({
    name = "ma_r4c4button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -86,
      offY = -225
    },
    text = Locale["ma_r4c4Button"]
    })

  
  FrameLib:BuildButton({
    name = "ma_jailabutton",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -5,
      offY = -150
    },
    text = Locale["ma_JailAButton"]
    })

  FrameLib:BuildButton({
    name = "ma_jailhbutton",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -5,
      offY = -175
    },
    text = Locale["ma_JailHButton"]
  })

  FrameLib:BuildButton({
    name = "ma_unjailbutton",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -5,
      offY = -200
    },
    text = Locale["ma_UnJailButton"]
  })

  FrameLib:BuildButton({
    name = "ma_r4c5button",
    group = "char",
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
      pos = "TOPRIGHT",
      offX = -5,
      offY = -225
    },
    text = Locale["ma_r4c5Button"]
})


end
