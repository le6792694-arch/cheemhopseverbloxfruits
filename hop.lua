-- CHEEM HOP | Make by ducskibidi

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Xoá GUI cũ nếu có
if player.PlayerGui:FindFirstChild("CheemHop") then
	player.PlayerGui.CheemHop:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CheemHop"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,150)
main.Position = UDim2.new(0.5,-150,0.5,-75)
main.BackgroundColor3 = Color3.fromRGB(35,35,35)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.TextColor3 = Color3.fromRGB(0,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Text = "Cheem Hop | Make by ducskibidi"

local function createButton(text, yPos, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.Position = UDim2.new(0.05,0,0,yPos)
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Text = text
	
	btn.MouseButton1Click:Connect(callback)
end

-- 1️⃣ Hop random server
createButton("Hop Random Server", 50, function()
	TeleportService:Teleport(game.PlaceId)
end)

-- 2️⃣ Hop server ít người
createButton("Hop Low Player Server", 95, function()

	local placeId = game.PlaceId
	local servers = {}
	local cursor = ""

	repeat
		local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"..(cursor ~= "" and "&cursor="..cursor or "")
		local response = HttpService:JSONDecode(game:HttpGet(url))
		
		for _, server in pairs(response.data) do
			if server.playing < server.maxPlayers and server.playing > 0 then
				table.insert(servers, server)
			end
		end
		
		cursor = response.nextPageCursor
	until not cursor or #servers > 0

	if #servers > 0 then
		local chosen = servers[math.random(1,#servers)]
		TeleportService:TeleportToPlaceInstance(placeId, chosen.id, player)
	end
end)
-- SOCIAL GUI (đặt cạnh Cheem Hop)

local socialGui = Instance.new("ScreenGui")
socialGui.Name = "CheemSocial"
socialGui.Parent = player.PlayerGui
socialGui.ResetOnSpawn = false

local socialMain = Instance.new("Frame", socialGui)
socialMain.Size = UDim2.new(0,220,0,150)
socialMain.Position = UDim2.new(0.5,160,0.5,-75) -- nằm bên phải GUI cũ
socialMain.BackgroundColor3 = Color3.fromRGB(35,35,35)
socialMain.Active = true
socialMain.Draggable = true

local socialTitle = Instance.new("TextLabel", socialMain)
socialTitle.Size = UDim2.new(1,0,0,40)
socialTitle.BackgroundColor3 = Color3.fromRGB(20,20,20)
socialTitle.TextColor3 = Color3.fromRGB(255,200,0)
socialTitle.TextScaled = true
socialTitle.Font = Enum.Font.GothamBold
socialTitle.Text = "Support Me ❤️"

local function createSocialButton(text, yPos, link)
	local btn = Instance.new("TextButton", socialMain)
	btn.Size = UDim2.new(0.9,0,0,40)
	btn.Position = UDim2.new(0.05,0,0,yPos)
	btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Text = text
	
	btn.MouseButton1Click:Connect(function()
		setclipboard(link)
	end)
end

-- ĐỔI LINK CỦA BẠN VÀO ĐÂY
createSocialButton("Subscribe on YouTube", 50, "https://youtube.com/")
createSocialButton("Follow on TikTok", 95, "https://tiktok.com/")
