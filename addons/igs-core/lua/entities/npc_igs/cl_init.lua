IGS.sh("shared.lua")

-- #todo сделать такое же для подарка?

local COL_TEXT = Color(255,255,255)
local COL_BG   = Color(0,0,0,150)
local FONT     = "igs.40"

local function textPlate(text,y)
	surface.SetFont(FONT)
	local tw,th = surface.GetTextSize(text)
	local bx,by = -tw / 2 - 10, y - 5
	local bw,bh = tw + 10 + 10, th + 10 + 10

	-- Background
	surface.SetDrawColor(COL_BG)
	surface.DrawRect(bx,by, bw,bh)
	surface.SetDrawColor(COL_TEXT)
	surface.DrawRect(bx, by + bh - 4, bw, 4)

	-- text
	surface.SetTextColor(COL_TEXT)
	surface.SetTextPos(-tw / 2,y)
	surface.DrawText(text)
end

local function drawInfo(ent, text, dist)
	cam.Start3D2D(pos + self:GetUp() * 90, Angle(0, eyeAngle.y - 90, 90), 0.04)
		XeninUI:DrawNPCOverhead(self, {
			alpha = alpha,
			text = "Донат",
			-- icon = XeninInventory.Config.NPCIcon,
			sin = true,
			textOffset = -20,
			iconMargin = 50,
			color = BATTLEPASS.Config.NPC.OutlineColor
		})
	cam.End3D2D()
end

-- https://vk.com/gim143836547?msgid=46147&q=рендер&sel=88943099
IGS_NPC_HIDE_ON_DISTANCE = nil -- 100000
function ENT:Draw()
	local dist = EyePos():DistToSqr(self:GetPos())
	if IGS_NPC_HIDE_ON_DISTANCE and dist > IGS_NPC_HIDE_ON_DISTANCE then return end -- не отрисовывать

	cam.Start3D2D(pos + self:GetUp() * 90, Angle(0, eyeAngle.y - 90, 90), 0.04)
		XeninUI:DrawNPCOverhead(self, {
		alpha = alpha,
		text = "Донат",
		-- icon = XeninInventory.Config.NPCIcon,
		sin = true,
		textOffset = -20,
		iconMargin = 50,
		color = BATTLEPASS.Config.NPC.OutlineColor
		})
	cam.End3D2D()

	drawInfo(self, "Донат услуги", dist)
end
