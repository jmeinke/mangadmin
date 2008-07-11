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

function ReturnStrings_csCZ()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_deDE()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "Neues Ticket von (.*)",
    ["ma_GmatchTicketCount"] = "Zahl der Tickets: (%d+) zeige neue Tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Anzahl der verbundenen Spieler: (%d+) (Maximum: (%d+)%)",
    ["ma_GmatchUptime"] = "Laufzeit des Servers: (.*)",
    ["ma_GmatchTickets"] = "Ticket von (.*) %(letztes Update:(.*)%) %(Kategorie: (%d+)%):(.*)"
  }
end

function ReturnStrings_enUS()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_esES()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_fiFI()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_frFR()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_huHU()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_itIT()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_liLI()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_nlNL()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_plPL()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_ptPT()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_roRO()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_ruRU()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end

function ReturnStrings_svSV()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end


function ReturnStrings_zhCN()
  return {
    ["ma_GmatchRevision"] = "%(Revision (.*)%) %((.*)%)",
    ["ma_GmatchGPS"] = "X: (.*) Y: (.*) Z",
    ["ma_GmatchItem"] = "|cffffffff|Hitem:(%d+):0:0:0:0:0:0:0|h%[(.-)%]|h|r",
    ["ma_GmatchItemSet"] = "|cffffffff|Hitemset:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSpell"] = "|cffffffff|Hspell:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchSkill"] = "|cffffffff|Hskill:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchCreature"] = "|cffffffff|Hcreature_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchGameObject"] = "|cffffffff|Hgameobject_entry:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchQuest"] = "|cffffffff|Hquest:(%d+)|h%[(.-)%]|h|r",
    ["ma_GmatchTele"] = "h%[(.-)%]",
    ["ma_GmatchNewTicket"] = "New ticket from (.*)",
    ["ma_GmatchTicketCount"] = "Tickets count: (%d+) show new tickets: (%w+)",
    ["ma_GmatchAccountInfo"] = "Player(.*) (.*) %(guid: (%d+)%) Account: (.*) %(id: (%d+)%) GMLevel: (%d+) Last IP: (.*) Last login: (.*) Latency: (%d+)ms",
    ["ma_GmatchAccountInfo2"] = "Played time: (.*) Level: (%d+) Money: (.*)",
    ["ma_GmatchOnlinePlayers"] = "Online players: (%d+) %(max: (%d+)%)",
    ["ma_GmatchUptime"] = "Server uptime: (.*)",
    ["ma_GmatchTickets"] = "Ticket of (.*) %(Last updated: (.*)%) %(Category: (%d+)%):(.*)"
  }
end
