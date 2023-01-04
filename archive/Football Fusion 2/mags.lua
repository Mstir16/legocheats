--[[

getgenv().MAGS = true
getgenv().MAGDISTANCE = 17

loadstring(game:HttpGet("https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Football%20Fusion%202/mags.lua"))()

]]--

if getgenv().MAGS == nil or getgenv().MAGDISTANCE == nil then return end

local MAGSCONNECTION

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

game.StarterGui:SetCore("SendNotification", {
    Title = "Script is patched!";
    Text = "Open sourced on github if you want to make one"
})

return

function GetBall()
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "Football" and v:IsA("Part") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= MAGDISTANCE then
            if v:FindFirstChild("Configuration") then
                if v.Configuration.Catchable.Value == true and v.Trail.Enabled == true then
                    return v
                end
            end
        end
    end
    return nil
end

function GetCatchBox(ball)
    local CBRight = (game.Players.LocalPlayer.Character.CatchRight.Position - ball.Position).Magnitude
    local CBLeft = (game.Players.LocalPlayer.Character.CatchLeft.Position - ball.Position).Magnitude
    
    if CBRight < CBLeft then
        return game.Players.LocalPlayer.Character.CatchRight
    elseif CBLeft < CBRight then
        return game.Players.LocalPlayer.Character.CatchLeft
    end
end


if MAGS == true then
MAGSCONNECTION = game:GetService("RunService").Heartbeat:Connect(function()
        pcall(function()
        task.wait()
        if MAGS == false then
            MAGSCONNECTION:Disconnect()
            return
        end
        
        local FB = GetBall()
        
        if FB ~= nil and MAGS == true then
            repeat
                local BP = FB:FindFirstChildOfClass("BodyPosition")
                
                if BP == nil then
                   local bodyp = Instance.new("BodyPosition")
    			   bodyp.Parent = FB
    			   bodyp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                end
                
                if game.Players.LocalPlayer.Character.Torso["Right Shoulder"].Part1 == nil and game.Players.LocalPlayer.Character.Torso["Left Shoulder"].Part1 == nil and FB.Trail.Enabled == true and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - FB.Position).Magnitude <= MAGDISTANCE then
                    local CBox = GetCatchBox(FB)
                    
                    FB.Position = CBox.Position
                    pcall(function()
                        BP.Position = CBox.Position
                    end)
                    task.wait()
                    FB.CFrame = CBox.CFrame
                    task.wait()
                end
                task.wait()
                
                if FB.Name == "Handle" then
                    BP.MaxForce = Vector3.new(0,0,0)
                end
            until FB.Name == "Handle" and FB.Parent.ClassName == "Tool" or FB.Parent ~= game:GetService("Workspace") or FB.Trail.Enabled == false or MAGS == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - FB.Position).Magnitude > MAGDISTANCE
            FB:FindFirstChildOfClass("BodyPosition"):Destroy()
            
            if MAGS == false then
                MAGSCONNECTION:Disconnect()
                return
            end
        end
        end)
    end)
end
