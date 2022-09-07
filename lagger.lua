local t1 = tick()
local IsAltPresent = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function Teleport()
    repeat
        task.wait()
    until #Players:GetPlayers() < 3 or math.abs(tick() - t1) > 75 or IsAltPresent == true 
    teleported = false
        while not teleported do
        print("attempting to teleport")
        x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        if #x > 0 then
            local success, err = pcall(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
            end)
            if not success then
                warn(err)
            else
                teleported = true
            end
        end
        task.wait(2)
        end
end

getgenv().Rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child) -- calling function will not work here 
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
        teleported = false
        while not teleported do
        print("attempting to teleport")
        x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        if #x > 0 then
            local success, err = pcall(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
            end)
            if not success then
                warn(err)
            else
                teleported = true
            end
        end
        task.wait(2)
        end
    end
end)

for _, player in pairs(game.Players:GetPlayers()) do
    for _, alt in pairs(Alts) do 
        if game.Players.LocalPlayer.Name == alt then -- will insta teleport if this is not set in place

        elseif player.Name == tostring(alt)  then -- we don't want all of the alts to pool up in a server
            print("alt found: " .. alt .. ". attempting teleport")
            IsAltPresent = true
            Teleport()
        end
    end
end

local function GetPlatePosition()
    for i,v in pairs(Workspace.Plates:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text:split(" ")[3] == tostring(LocalPlayer.Name) then
            return(v.Parent.Parent.Position)
        end
    end
end

local OldPlatePosition = Vector3.new(-3180, 3.75, 1028)
local BlockPosition = Vector3.new(-3174, 6, 1026)
local PositionToPlace = BlockPosition - OldPlatePosition + GetPlatePosition()


local BlockToPlace = "Firepit" -- change this to whatever block you want, firepit is just the laggiest
local HeightToPlace = -20 -- hides the lagbomb so you can't get reported, change if you want for debugging/visibility


for i = 1, 5000 do 
    task.spawn(function()
        while true do wait()
            for i = 1, 3 do
            game:GetService("ReplicatedStorage").Send:InvokeServer("Place", BlockToPlace, CFrame.new(CFrame.new(PositionToPlace).x, HeightToPlace, CFrame.new(PositionToPlace).z))
            end
        end
    end)
end

Teleport() 
