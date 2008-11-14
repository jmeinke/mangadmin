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
-- This script must be listed in the .toc after "TrinityFrames_SectionTele.lua"
-- Also some variables are globally taken from TrinityAdmin.lua

function TrinityAdmin:CreateGOSection()
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

  FrameLib:BuildFontString({
    name = "ma_golabel",
    group = "go",
    parent = ma_midframe,
    text = "This tab for future use",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -10
    }
  })  
  
end
