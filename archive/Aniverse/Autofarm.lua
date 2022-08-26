-- getgenv().Config = {
--     Gamemode = "Adventure",
--     Area = "Shell Island",
--     Stage = 1,
--     Difficulty = "Normal",
--     WhenFinished = "Replay",
-- }

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil
local MapInfo = {
    Adventure = {},
    Trial = {},
    Infinite = {},
}

local Difficulties = {"Normal","Hard","Insane"}

function GetAreas(MainGame)
    if MainGame then
        local MainData = game:GetService("ReplicatedStorage").GameInfo.PlayInfo
        local SupportedAreas = {"Adventure","Trial","Infinite"}
        
        for i,v in pairs(MainData:GetChildren()) do
            if v:IsA("Folder") then
                if table.find(SupportedAreas,v.Name) then
                    local modeTable = MapInfo[v.Name]
                    
                    for _,map in pairs(v:GetChildren()) do
                        if map:IsA("Folder") then
                            table.insert(modeTable,#modeTable+1,map)
                        end
                    end
                end
            end
        end
    end
end

function GetTable(table,name)
    for i,v in pairs(table) do
        if v.Name == name then
            return v 
        end
    end
end

function GetEnemy()
    for i,v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("Enemy") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    return nil
end

local speed = 100

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

function AutoAttack()
    local vim = game:GetService("VirtualInputManager")
    local SkillKeys = {"One","Two","Three"}
    
    for i,v in pairs(SkillKeys) do
        vim:SendKeyEvent(true, v, false, game)    
        wait(0.1)
    end
    
    vim:SendMouseButtonEvent(0,500, 0, true, game, 1)
    wait(0.5)

end

while wait() do
    pcall(function()
        local MainGame = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
        local Mission = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainGui")

        if MainGame then
            GetAreas(MainGame)
            
            local GMtable = MapInfo[Config.Gamemode]
            local Location = GetTable(GMtable,Config.Area)

            if Location ~= nil then
                local args = {}
                
                if Config.Gamemode == "Adventure" then
                    local stageName = "Stage "..Config.Stage
                    if Location:FindFirstChild(stageName) == nil then return print("That Stage doesn't exist") end
                    if table.find(Difficulties,Config.Difficulty) == nil then return print("Wrong Difficulty, Check Spelling or if it exists") end
                    args[1] = Config.Gamemode
                    args[2] = Config.Area
                    args[3] = Config.Stage
                    args[4] = Config.Difficulty
                end
                
                game:GetService("ReplicatedStorage").Remotes.SoloPlay:FireServer(unpack(args))
                return print("queued, if it doesn't hop in 10 seconds retry")
            end
        elseif Mission then
            local ClearBox = Mission:FindFirstChild("SClearBox")
            local FailBox = Mission:FindFirstChild("SFailedBox")
            local TalkBox = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.TalkBox
            
            if TalkBox.Visible == true then
                repeat
                    local TalkBoxVis = TalkBox.Visible
                    wait(0.1)
                    if TalkBoxVis == true then
                        game:GetService("ReplicatedStorage").GameStorage.Remotes.TalkEvent:FireServer("Skip")
                    end
                until TalkBoxVis == false
            end

            if ClearBox.Visible == true or FailBox.Visible == true then
                local Option = Config.WhenFinished
                
                if Option == "Replay" then
                    game:GetService("ReplicatedStorage").GameStorage.Remotes.StageEvents:FireServer("Replay")
                end
            end

            if game:GetService("ReplicatedStorage").LocalStorage.StageState.Value == "Combat" and ClearBox.Visible == false and FailBox.Visible == false then
                repeat
                    local Enemy = GetEnemy()
                    if Enemy ~= nil then
                        coroutine.resume(coroutine.create(function()
                            while Enemy.Humanoid ~= nil and Enemy.Humanoid.Health > 0 do
                                AutoAttack()
                                wait()
                            end
                        end))
                        
                        while Enemy.Humanoid ~= nil and Enemy.Humanoid.Health > 0 do
                            if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid.Health > 0 then
                                NPCTween(Enemy.HumanoidRootPart.CFrame)
                                wait()
                            end
                            wait()
                        end
                    end
                    
                    wait()
                until Enemy == nil and ClearBox.Visible == true or ClearBox.Visible == true or FailBox.Visible == false
            end
        end
    end)
end
