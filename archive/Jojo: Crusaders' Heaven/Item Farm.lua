if getgenv().Noclipping ~= nil then getgenv().Noclipping:Disconnect() end
--// Settings \\--
--getgenv().ItemFarm = true
getgenv().Noclipping = nil
local speed = 200

--// Don't Touch below if retard \\--

local function Tween(target)
    local info = TweenInfo.new((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / speed, Enum.EasingStyle.Linear)
    local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target})
    Debounce = true
    Tween:Play()
    Tween.Completed:Wait()
    Debounce = false
end

if Noclipping == nil and ItemFarm then
local function NoclipLoop()
    if Clip == false and game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end
Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)
end

for i,v in pairs(game.Workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v:Destroy() 
    end
end

while wait() do
    if ItemFarm then
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if not ItemFarm then break end
                if v:FindFirstChild("SpawnedItem") and v:FindFirstChild("Handle") then
                    local Item = v
                    
                    Tween(CFrame.new(Item:FindFirstChild("Handle").CFrame.X,Item:FindFirstChild("Handle").CFrame.Y + 3,Item:FindFirstChild("Handle").CFrame.Z))
                    wait(0.5)
                    
                    repeat
                       pcall(function()
                            fireproximityprompt(Item:FindFirstChild("ProximityPrompt"))
                       end)
                       local check = Item:FindFirstChild("ProximityPrompt")
                       wait()
                    until check == nil
                    wait()
                end
            end
    else
        return
    end
end
