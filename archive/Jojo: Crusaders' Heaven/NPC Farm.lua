-- getgenv().NPCFarm = true
-- getgenv().NPCName = "DIO"
local speed = 200

if getgenv().Noclipping ~= nil then getgenv().Noclipping:Disconnect() end
local attacks = {"Barrage","Heavy Punch","M1"}
getgenv().Noclipping = nil

local function Tween(target)
    pcall(function()
        local info = TweenInfo.new((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / speed, Enum.EasingStyle.Linear)
        local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target})
        Debounce = true
        Tween:Play()
        Tween.Completed:Wait()
        Debounce = false
    end)
end

local function NPCTween(target)
    pcall(function()
        local info = TweenInfo.new((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / speed, Enum.EasingStyle.Linear)
        local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target + target.lookVector * -6})
        Debounce = true
        Tween:Play()
        Tween.Completed:Wait()
        Debounce = false
    end)
end

if Noclipping == nil and NPCFarm then
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

local function OnCD(moveName)
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.CD.Frame:GetChildren()) do
        if v.Name == "holder" and v:IsA("Frame") then
            if table.find(attacks,moveName) and moveName == v.attack.Text then
                return true
            end
        end
    end
    return false
end

while wait() do
    if NPCFarm then
        if game:GetService("Workspace").Enemies:FindFirstChild(NPCName) ~= nil then
            pcall(function()
                NPCTween(game:GetService("Workspace").Enemies:FindFirstChild(getgenv().NPCName).HumanoidRootPart.CFrame)
                repeat
                    local NPC = game:GetService("Workspace").Enemies:FindFirstChild(getgenv().NPCName)
                    
                    if NPC ~= nil then
                        coroutine.resume(coroutine.create(function()
                            while NPC ~= nil do
                                if NPC:FindFirstChild("HumanoidRootPart") ~= nil and NPCFarm and NPC.Humanoid.Health > 0 then
                                    NPCTween(NPC.HumanoidRootPart.CFrame)
                                    wait()
                                else
                                    return
                                end
                            end
                        end))
                    end
                
                    if not game.Players.LocalPlayer.Character:FindFirstChild("Stand") then
                        game:GetService("ReplicatedStorage").Stands.Summon:FireServer()
                        wait(2)
                    end
                    
                    if not OnCD("Barrage") and NPC ~= nil then
                        game:GetService("ReplicatedStorage").Stands.BarrageHold:FireServer(true)
                        repeat
                            local check = OnCD("Barrage")
                            wait()
                        until check == true or NPCFarm == false
                    end
                    
                    if not OnCD("Heavy Punch") and NPC ~= nil then
                        game:GetService("ReplicatedStorage").Stands.HeavyPunch:FireServer()
                        repeat
                            local check = OnCD("Heavy Punch")
                            wait()
                        until check == true or NPCFarm == false
                    end
                    
                    if not OnCD("M1") and NPC ~= nil then
                        repeat
                            local check = OnCD("M1")
                            if check == false then
                                game:GetService("ReplicatedStorage").Combat.Punch:FireServer()
                            end
                            wait()
                        until check == true or NPCFarm == false
                    end
                    wait()
                until NPCFarm == false
            end)
        end
    else
        return
    end
end
