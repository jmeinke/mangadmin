local FrameLib = AceLibrary("FrameLib-1.0")
local Locale   = AceLibrary("AceLocale-2.2"):new("MangAdmin")
local Graph    = AceLibrary("Graph-1.0")
-- Create the MangAdmin Frames with lua, so we need no xml at all

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
		width = 500,
		height = 22
	},
	setpoint = {
		pos = "TOPLEFT",
		offY = 22,
		offX = 10
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
		file = "Interface\\AddOns\\MangAdmin\\Textures\\logo.tga"
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
		offX = 12,
		offY = 20
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
		offX = 94,
		offY = 20
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
		width = 80,
		height = 20
	},
	setpoint = {
		pos = "TOPLEFT",
		offX = 176,
		offY = 20
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
		width = 80,
		height = 20
	},
	setpoint = {
		pos = "TOPLEFT",
		offX = 258,
		offY = 20
	},
	text = Locale["tabmenu_Ticket"]
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
		offX = 340,
		offY = 20
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
		offX = 422,
		offY = 20
	},
	text = Locale["tabmenu_Log"]
})

-- [[ Group Elements ]]
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
local Graph=AceLibrary("Graph-1.0")
local g = Graph:CreateGraphLine("ma_netstatframe",ma_graphframe,"LEFT","LEFT",1,-1,150,150)
g:SetAutoScale(true)
g:SetGridSpacing(1.0,10.0)
g:SetYMax(120)
g:SetXAxis(-11,-1)
g:SetFilterRadius(1)
g:SetBarColors({0.2,0.0,0.0,0.4},{1.0,0.0,0.0,1.0})
ma_graphframe:SetScript("OnUpdate",function() g:AddTimeData(lag) end)


FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
FrameLib:HandleGroup("server", function(frame) frame:Hide() end)
FrameLib:HandleGroup("log", function(frame) frame:Hide() end)
