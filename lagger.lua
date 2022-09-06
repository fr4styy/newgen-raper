local OldPlatePosition = Vector3.new(-3180, 3.75, 1028)
local BlockPosition = Vector3.new(-3174, 6, 1026)
local PositionToPlace = BlockPosition - OldPlatePosition + GetPlatePosition()
local function GetPlatePosition()
    for i,v in pairs(Workspace.Plates:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text:split(" ")[3] == tostring(Players.LocalPlayer) then
            return(v.Parent.Parent.Position)
        end
    end
end

local BlockToPlace = "Firepit" -- change this to whatever block you want, firepit is just the laggiest
local HeightToPlace = -20 -- hides the lagbomb so you can't get reported, change if you want for debugging/visibility

for i = 1, 5000 do
    task.spawn(function()
        while true do wait()
            for i = 1, 3 do
            game:GetService("ReplicatedStorage").Send:InvokeServer(ohString1, ohString2, CFrame.new(CFrame.new(PositionToPlace).x, HeightToPlace, CFrame.new(PositionToPlace).z))
            end
        end
    end)
end
