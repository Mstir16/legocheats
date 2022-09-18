--[[
getgenv().CharismaAutoPaster = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Deepwoken/CharismaAutoPaster.lua"))()
]]--


while wait() do
    if CharismaAutoPaster then
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SimplePrompt") then
            local Prompt = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SimplePrompt").Prompt.Text
        
            local Lines = {
                "So, you doing anything on the weekend?",
                "You doing anything next week? Because I'd like to see you greMORE.",
                "So, what's keeping you busy these days?",
                "So, how's work?",
                "Some weather we're having, huh?",
                "Hey hivekin, can I bug you for a moment?",
                "Wow, this breeze is great, right?",
                "Sometimes I have really deep thoughts about life and stuff.",
                "Me-wow, is that the latest in Felinor fashion?",
                "You ever been to a Canor restaurant? The food's pretty howlright.",
            }
        
            for i,v in pairs(Lines) do
                if string.find(Prompt,v) then
                    setclipboard(v)
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Charisma Auto Paster",
                        Text = "Copied Phrase!",
                        Duration = 2,
                    })
                    wait(1)
                    break
                end
            end
            
            repeat
                local check = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SimplePrompt")
                wait()
            until check == nil
        end
    else
        return
    end
end
