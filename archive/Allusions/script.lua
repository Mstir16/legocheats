local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Allusions is shit <3", "Ocean")
local Features = Window:NewTab("Tool's")
local Allusions = Features:NewSection("m1kecorp 😪😪")
local vim = game:GetService("VirtualInputManager")
local humroot = game.Players.LocalPlayer.Character.HumanoidRootPart

task.spawn(function()
    local http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

    if http then
       function join()
            http(
                {
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["origin"] = "https://discord.com",
                    },
                    Body = game:GetService("HttpService"):JSONEncode(
                    {
                        ["args"] = {
                            ["code"] = "y7H2qGmNKd",
                        },
                        ["cmd"] = "INVITE_BROWSER",
                        ["nonce"] = "."
                    })
                })
        end
        
        join() 

        game.StarterGui:SetCore("SendNotification", {
        Title = "Brought to you by m1kecorp";
        Text = "Discord prompted and copied to clipboard"
        })
    end
end)

Allusions:NewButton("RareTool Pickup", "RareTool Pickup", function(state)
    tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(1, Enum.EasingStyle.Linear)
    tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(game:GetService("Workspace").Miscellaneous.RareTool.Position)})
    tween:Play()
    tween.Completed:Wait(1)
    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:FindFirstChild("ProximityPrompt") then
            fireproximityprompt(v.ProximityPrompt)
        end
    end
end)

Allusions:NewToggle("Auto Finance King (EQUIP)", "Auto Finance King (EQUIP)", function(state)
    getgenv().TP = state
    
    local function equipPrimary()
        pcall(function()
            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:FindFirstChild("Trigger") then
                    v.Parent = game.Players.LocalPlayer.Character
                    return true
                end
            end
            return false
        end)
    end
    
    while getgenv().TP == true do
        pcall(function()
            task.wait()
            for _,k in pairs(game:GetService("Workspace").Alive:GetChildren()) do
                if k.Name == "FinanceKing" then
                    repeat
                        equipPrimary()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.HumanoidRootPart.CFrame + k.HumanoidRootPart.CFrame.lookVector * -5
                        vim:SendMouseButtonEvent(500, 500, 0, true, game, 1)
                        task.wait()
                        vim:SendMouseButtonEvent(500, 500, 0, false, game, 1)
                        task.wait()
                        vim:SendKeyEvent(true, "E", false, game)
                        task.wait()
                        vim:SendKeyEvent(false, "E", false, game)
                        task.wait()
                        vim:SendKeyEvent(true, "R", false, game)
                        task.wait()
                        vim:SendKeyEvent(false, "R", false, game)
                        task.wait()
                    until k.Humanoid.Health <= 0
                end
            end
        end)
    end
end)

Allusions:NewToggle("Auto Minos Prime", "Auto Minos Prime", function(state)
    getgenv().TP = state
    while getgenv().TP == true do
        pcall(function()
            if game:GetService("Workspace").Miscellaneous:FindFirstChild("MinosTorch") ~= nil then
                local function GetTorchStand()
                    for i,v in pairs(game:GetService("Workspace").Miscellaneous:GetChildren()) do
                        if v.Name == "Stand" and v:FindFirstChild("ProximityPrompt") == nil then
                            local minotorch = game:GetService("Workspace").Miscellaneous:FindFirstChild("MinosTorch")
                            local distance = (minotorch.Position - v.Position).magnitude

                            if distance <= 7 then
                                return  game:GetService("Workspace").Miscellaneous:FindFirstChild("MinosTorch")
                            end
                        end
                    end
                end

                local function GetActivateStand()
                    for i,v in pairs(game:GetService("Workspace").Miscellaneous:GetChildren()) do
                        if v.Name == "Stand" and v:FindFirstChild("ProximityPrompt") ~= nil then
                            return v
                        end
                    end
                end

                local Torch = GetTorchStand()
                local SpawnStand = GetActivateStand()

                if Torch ~= nil and SpawnStand ~= nil then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Torch.CFrame
                    task.wait(0.5)
                    fireproximityprompt(Torch.ProximityPrompt)
                    task.wait(0.5)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SpawnStand.CFrame
                    task.wait(0.5)
                    fireproximityprompt(SpawnStand.ProximityPrompt)
                    task.wait(2)
                end
            end
        end)
    end
end)
