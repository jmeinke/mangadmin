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

function RGBToHex(r, g, b)
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r, g, b)
end

function MangLinkifier_Decompose(chatstring)
  if chatstring ~= nil then
    ----------====~~Target Command Match Text ~~====----------
    for guid in string.gmatch(chatstring, "GUID: (%d+) ID: (%d+)") do --TARGET ID
      chatstring = string.gsub (chatstring, "GUID: (%d+) ID: (%d+)", MangLinkifier_Link("GUID: %1 ID: %2", "%2", "targid"))
    end
    for guid in string.gmatch(chatstring, "GUID: (%d+) ID") do --TARGET GUID
      chatstring = string.gsub (chatstring, "GUID: (%d+) ", MangLinkifier_Link("GUID: %1", "%1", "targguid"))
    end
    for guid in string.gmatch(chatstring, "X: ([%p%d.%d]+) Y: ([%p%d.%d]+) Z: ([%p%d.%d]+) MapId: (%d+)") do --TARGET XYZ
      chatstring = string.gsub (chatstring, "X: ([%p%d.%d]+) Y: ([%p%d.%d]+) Z: ([%p%d.%d]+) MapId: (%d+)", MangLinkifier_Link("X: %1  Y: %2  Z: %3 MapId: %4", "%1 %2 %3 %4", "targxyz"))
    end
    ----------====~~ NPC Info Command Match Text ~~====----------
    for guid in string.gmatch(chatstring, "GUID: (%d+)%.") do --NPCINFO GUID
      chatstring = string.gsub (chatstring, "GUID: (%d+)%.", MangLinkifier_Link("GUID: %1.", "%1", "npcguid"))
    end
    for guid in string.gmatch(chatstring, "Entry: (%d+)%.") do --NPCINFO Entry
      chatstring = string.gsub (chatstring, "Entry: (%d+)%.", MangLinkifier_Link("Entry: %1.", "%1", "npcentry"))
    end
    for guid in string.gmatch(chatstring, "DisplayID: (%d+)") do --NPCINFO Display
      chatstring = string.gsub (chatstring, "DisplayID: (%d+)", MangLinkifier_Link("DisplayID: %1.", "%1", "npcdisplay"))
    end
    for guid in string.gmatch(chatstring, "%(Native: (%d+)%)") do --NPCINFO Display Native
      chatstring = string.gsub (chatstring, "%(Native: (%d+)%)", MangLinkifier_Link("(Native: (%1))", "%1", "npcdisplay2"))
    end
    ----------====~~ ADD GO Command Match Text ~~====----------
    for guid in string.gmatch(chatstring, "%) %(GUID: (%d+)%)") do --ADDGO GUID
      chatstring = string.gsub (chatstring, "%(GUID: (%d+)%)", MangLinkifier_Link("(GUID: %1)", "%1", "addgoguid"))
    end
    for guid in string.gmatch(chatstring, "Object '(%d+)'") do --ADDGO ID
      chatstring = string.gsub (chatstring, "Object '(%d+)'", MangLinkifier_Link("Object '%1')", "%1", "addgoid"))
    end
    for guid in string.gmatch(chatstring, "'([%p%d.%d]+) ([%p%d.%d]+) ([%p%d.%d]+)'") do --ADDGO XYZ
      chatstring = string.gsub (chatstring, "'([%p%d.%d]+) ([%p%d.%d]+) ([%p%d.%d]+)'", MangLinkifier_Link("'%1 %2 %3'", "%1 %2 %3", "addgoxyz"))
    end
    ----------====~~ GPS Command Match Text ~~====----------
    for guid in string.gmatch(chatstring, "X: ([%p%d.%d]+) Y: ([%p%d.%d]+) Z: ([%p%d.%d]+)") do --GPS XYZ
      chatstring = string.gsub (chatstring, "X: ([%p%d.%d]+) Y: ([%p%d.%d]+) Z: ([%p%d.%d]+)", MangLinkifier_Link("X: %1 Y: %2 Z: %3", "%1 %2 %3", "gpsxyz"))
    end
    ----------====~~ Added Options for Clickable Links Made by Mangos ~~====----------
    for guid in string.gmatch(chatstring, "%|cffffffff%|Hquest:(.*)%|h%[(.*)%]%|h%|r") do --LOOKUP QUEST
      chatstring = string.gsub (chatstring, "%|cffffffff%|Hquest:(.*)%|h%[(.*)%]%|h%|r", MangLinkifier_Link("%2", "%1", "lookupquest"))
    end
    for guid in string.gmatch(chatstring, "%|cff(.*)%|Hitem:(.*)%|h%[(.*)%]%|h%|r") do --LOOKUP ITEM -- Bug when more than 1 item is linked in chat, it is not  translated
      chatstring = string.gsub (chatstring, "%|cff(.*)%|Hitem:(.*)%|h%[(.*)%]%|h%|r", MangLinkifier_Link("%3-%1", "%2", "lookupitem"))
    end
    for guid in string.gmatch(chatstring, "%|cffffffff%|Hgameobject_entry:(.*)%|h%[(.*)%]%|h%|r") do --LOOKUP OBJECT
      chatstring = string.gsub (chatstring, "%|cffffffff%|Hgameobject_entry:(.*)%|h%[(.*)%]%|h%|r", MangLinkifier_Link("%2", "%1", "lookupgo"))
    end
    for guid in string.gmatch(chatstring, "%|cffffffff%|Hcreature_entry:(.*)%|h%[(.*)%]%|h%|r") do --LOOKUP CREATURE
      chatstring = string.gsub (chatstring, "%|cffffffff%|Hcreature_entry:(.*)%|h%[(.*)%]%|h%|r", MangLinkifier_Link("%2", "%1", "lookupcreature"))
    end
    for guid in string.gmatch(chatstring, "%|cffffffff%|Hspell:(.*)%|h%[(.*)%]%|h%|r") do --LOOKUP SPELL
      chatstring = string.gsub (chatstring, "%|cffffffff%|Hspell:(.*)%|h%[(.*)%]%|h%|r", MangLinkifier_Link("%2", "%1", "lookupspell"))
    end
  end
  return chatstring
end

function MangLinkifier_Link(orgtxt, id, type)
  local color = MangAdmin.db.account.style.color.linkifier
  local urlcolor = RGBToHex(color.r,color.g,color.b)
  --local urlcolor = (string.rep("0",6-string.len((string.upper(string.format("%x", dec)))))..(string.upper(string.format("%x", dec))))
  if(type == "targid") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Htargidadd:" .. id .. "|h[Spawn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Htargidlist:" .. id .. "|h[List]|h|r "
  elseif(type == "targguid") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Htargguidgo:" .. id .. "|h[Goto]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Htargguidmove:" .. id .. "|h[Move]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Htargguidturn:" .. id .. "|h[Turn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Htargguiddel:" .. id .. "|h[Delete]|h|r \n"
  elseif(type == "targxyz") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Htargxyz:" .. id .. "|h[Teleport]|h|r "
  ----------====~~ NPC Info Command Replace Text ~~====----------
  elseif(type == "npcguid") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Hnpcguidgo:" .. id .. "|h[Goto]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hnpcguidmove:" .. id .. "|h[Move]|h|r "
  elseif(type == "npcentry") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Hnpcentryadd:" .. id .. "|h[Spawn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hnpcentrylist:" .. id .. "|h[List]|h|r "
  elseif(type == "npcdisplay") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Hnpcdisplay:" .. id .. "|h[Morph]|h|r "
  elseif(type == "npcdisplay2") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Hnpcdisplay2:" .. id .. "|h[Morph]|h|r "
  ----------====~~ ADD GO Command Replace Text ~~====----------
  elseif(type == "addgoguid") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Haddgoguidgo:" .. id .. "|h[Goto]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Haddgoguidmove:" .. id .. "|h[Move]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Haddgoguidturn:" .. id .. "|h[Turn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Haddgoguiddel:" .. id .. "|h[Delete]|h|r \n"
  elseif(type == "addgoid") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Haddgoid:" .. id .. "|h[Spawn]|h|r \n"
  elseif(type == "addgoxyz") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Haddgoxyz:" .. id .. "|h[Teleport]|h|r "
  ----------====~~ GPS Command Replace Text ~~====----------
  elseif(type == "gpsxyz") then
    link = orgtxt .." - |cff" .. urlcolor .. "|Hgpsxyz:" .. id .. "|h[Teleport]|h|r "
  ----------====~~ Added Options for Clickable Links Made by Mangos ~~====----------
  elseif(type == "lookupquest") then
    link = "|cffffffff|Hquest:" .. id .. "|h[" .. orgtxt .. "]|h|r"
    link = link .." - |cff" .. urlcolor .. "|Hlookupquestadd:" .. id .. "|h[Add]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hlookupquestrem:" .. id .. "|h[Remove]|h|r "
  elseif(type == "lookupitem") then
    for orgtxt, color in string.gmatch (orgtxt, "(.*)%-(.*)") do
      link = "|cff" .. color .."|Hitem:" .. id .. "|h[" .. orgtxt .. "]|h|r"
      link = link .." - |cff" .. urlcolor .. "|Hlookupitemadd:" .. id .. "|h[Add]|h|r "
      link = link .." - |cff" .. urlcolor .. "|Hlookupitemlist:" .. id .. "|h[List]|h|r "
    end
  elseif(type == "lookupgo") then
    link = "|cffffffff|Hgameobject_entry:" .. id .. "|h[" .. orgtxt .. "]|h|r"
    link = link .." - |cff" .. urlcolor .. "|Hlookupgoadd:" .. id .. "|h[Spawn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hlookupgolist:" .. id .. "|h[List]|h|r "
  elseif(type == "lookupcreature") then
    link = "|cffffffff|Hcreature_entry:" .. id .. "|h[" .. orgtxt .. "]|h|r"
    link = link .." - |cff" .. urlcolor .. "|Hlookupcreatureadd:" .. id .. "|h[Spawn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hlookupcreaturelist:" .. id .. "|h[List]|h|r "
  elseif(type == "lookupspell") then
    link = "|cffffffff|Hspell:" .. id .. "|h[" .. orgtxt .. "]|h|r"
    link = link .." - |cff" .. urlcolor .. "|Hlookupspelllearn:" .. id .. "|h[Learn]|h|r "
    link = link .." - |cff" .. urlcolor .. "|Hlookupspellunlearn:" .. id .. "|h[Unlearn]|h|r "
  else 
    link = orgtxt .." - |cffc20000Error Search String Matched but an error occured or unable to find type |r |cff008873" .. type .. "|r"
  end
  return link
end

function MangLinkifier_SetItemRef(link, text, button)
  ----------====~~Target Command Functions ~~====----------
  if ( strsub(link, 1, 9) == "targidadd" ) then
    SendChatMessage(".addgo "..strsub(link, 11), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 10) == "targidlist" ) then
    SendChatMessage(".listobject "..strsub(link, 12), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 10) == "targguidgo" ) then
    SendChatMessage(".goobject "..strsub(link, 12), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 12) == "targguidmove" ) then
    SendChatMessage(".moveobject "..strsub(link, 14), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 12) == "targguidturn" ) then
    SendChatMessage(".turnobject "..strsub(link, 14), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 11) == "targguiddel" ) then
    SendChatMessage(".delobject "..strsub(link, 13), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 7) == "targxyz" ) then
    SendChatMessage(".goxyz "..strsub(link, 9), say, nil, nil)
    return;
  ----------====~~ NPC Info Command Functions ~~====----------
  elseif ( strsub(link, 1, 9) == "npcguidgo" ) then
    SendChatMessage(".gocreature "..strsub(link, 11), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 11) == "npcguidmove" ) then
    SendChatMessage(".gocreature "..strsub(link, 13), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 11) == "npcentryadd" ) then
    SendChatMessage(".addspw "..strsub(link, 13), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 12) == "npcentrylist" ) then
    SendChatMessage(".listcreature "..strsub(link, 14), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 10) == "npcdisplay" ) then
    SendChatMessage(".morph "..strsub(link, 12), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 11) == "npcdisplay2" ) then
    SendChatMessage(".morph "..strsub(link, 13), say, nil, nil)
    return;
  ----------====~~ ADD GO Command Functions ~~====----------
  elseif ( strsub(link, 1, 11) == "addgoguidgo" ) then
    SendChatMessage(".goobject "..strsub(link, 13), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 13) == "addgoguidmove" ) then
    SendChatMessage(".moveobject "..strsub(link, 15), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 13) == "addgoguidturn" ) then
    SendChatMessage(".turnobject "..strsub(link, 15), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 12) == "addgoguiddel" ) then
    SendChatMessage(".delobject "..strsub(link, 14), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 7) == "addgoid" ) then
    SendChatMessage(".addgo "..strsub(link, 9), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 8) == "addgoxyz" ) then
    SendChatMessage(".goxyz "..strsub(link, 10), say, nil, nil)
    return;
  ----------====~~ GPS Command Functions ~~====----------
  elseif ( strsub(link, 1, 6) == "gpsxyz" ) then
    SendChatMessage(".goxyz "..strsub(link, 8), say, nil, nil)
    return;
  ----------====~~ Support for Clickable Links Made by Mangos and Added Options ~~====----------
  elseif ( strsub(link, 1, 5) == "quest" ) then
    SendChatMessage(".addquest "..strsub(link, 7), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 14) == "lookupquestadd" ) then
    SendChatMessage(".addquest "..strsub(link, 16), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 14) == "lookupquestrem" ) then
    SendChatMessage(".removequest "..strsub(link, 16), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 13) == "lookupitemadd" ) then
    SendChatMessage(".additem "..strsub(link, 15), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 14) == "lookupitemlist" ) then
    SendChatMessage(".listitem "..strsub(link, 16), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 16) == "gameobject_entry" ) then
    SendChatMessage(".addgo "..strsub(link, 18), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 11) == "lookupgoadd" ) then
    SendChatMessage(".addgo "..strsub(link, 13), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 12) == "lookupgolist" ) then
    SendChatMessage(".listobject "..strsub(link, 14), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 14) == "creature_entry" ) then
    SendChatMessage(".addspw "..strsub(link, 16), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 17) == "lookupcreatureadd" ) then
    SendChatMessage(".addspw "..strsub(link, 19), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 18) == "lookupcreaturelist" ) then
    SendChatMessage(".listcreature "..strsub(link, 20), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 10) == "gameobject" ) then
    SendChatMessage(".goobject "..strsub(link, 12), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 8) == "creature" ) then
    SendChatMessage(".gocreature "..strsub(link, 10), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 5) == "spell" ) then
    SendChatMessage(".learn "..strsub(link, 7), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 16) == "lookupspelllearn" ) then
    SendChatMessage(".learn "..strsub(link, 18), say, nil, nil)
    return;
  elseif ( strsub(link, 1, 18) == "lookupspellunlearn" ) then
    SendChatMessage(".unlearn "..strsub(link, 20), say, nil, nil)
    return;
  end
  MangLinkifier_SetItemRef_Original(link, text, button);
end
