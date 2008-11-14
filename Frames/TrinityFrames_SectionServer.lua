-------------------------------------------------------------------------------------------------------------
--
-- Trinityadmin Version 1.0
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
-- This script must be listed in the .toc after "TrinityFrames_SectionMisc.lua"
-- Also some variables are globally taken from TrinityAdmin.lua

function TrinityAdmin:CreateServerSection()
  local transparency = {
    bg = TrinityAdmin.db.account.style.transparency.backgrounds,
    btn = TrinityAdmin.db.account.style.transparency.buttons,
    frm = TrinityAdmin.db.account.style.transparency.frames
  }
  local color = {
    bg = TrinityAdmin.db.account.style.color.backgrounds,
    btn = TrinityAdmin.db.account.style.color.buttons,
    frm = TrinityAdmin.db.account.style.color.frames
  }
  
  FrameLib:BuildFrame({
    name = "ma_netgraphframe",
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
  
  RealGraph=Graph:CreateGraphRealtime("ma_netgraph_lag",ma_netgraphframe,"CENTER","CENTER",0,0,150,150)
  local g=RealGraph
  g:SetAutoScale(true)
  g:SetGridSpacing(1.0,10.0)
  g:SetYMax(120)
  g:SetXAxis(-10,0)
  g:SetMode("RAW")
  g:SetBarColors({0.2,0.0,0.0,0.4},{1.0,0.0,0.0,1.0})
  local f = CreateFrame("Frame",name,parent)
  f.frames=0
  f.NextUpdate=GetTime()
  f:SetScript("OnUpdate",function() 
      if f.NextUpdate>GetTime() then
        return
      end
      local down, up, lag = GetNetStats();
      g:AddBar(lag)
      f.NextUpdate=f.NextUpdate+g.BarWidth
    end)
  f:Show()

  FrameLib:BuildFrame({
    type = "EditBox",
    name = "ma_announceeditbox",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 460,
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
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
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
    text = Locale["ma_ResetButton"]
  })
  
  FrameLib:BuildFrame({
    name = "ma_reloadtabledropdown",
    group = "server",
    parent = ma_midframe,
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -98,
      offY = -10
    },
    inherits = "UIDropDownMenuTemplate"
  })
  
  FrameLib:BuildButton({
    name = "ma_loadtablebutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_loadtablebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 90,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = "Reload table"
  })
  
  FrameLib:BuildButton({
    name = "ma_saveallbutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_saveallbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 80,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -44
    },
    text = "Save all"
  })
  
  FrameLib:BuildButton({
    name = "ma_loadscriptsbutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_loadscriptsbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -94,
      offY = -44
    },
    text = "(Re-)Load Scripts"
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
      offX = -118,
      offY = -68
    },
    inherits = "InputBoxTemplate"
  })

  FrameLib:BuildButton({
    name = "ma_shutdownbutton",
    group = "server",
    parent = ma_midframe,
    texture = {
      name = "ma_shutdownbutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 100,
      height = 20
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -68
    },
    text = Locale["ma_ShutdownButton"]
  })
end
