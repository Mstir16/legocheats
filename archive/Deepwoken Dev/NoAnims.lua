--[[
made by sweety#3848 (sponsored by m1kecorp XD)

discord.gg/m1kecorp or https://discord.gg/y7H2qGmNKd
]]--

-- This function stops all playing animations on the local player's character.
local function stop_animations()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoid then
        -- Loop and stop all playing animations.
        while task.wait() and getgenv().no_anims == true do
            local playingAnimations = humanoid:GetPlayingAnimationTracks()
            if #playingAnimations > 0 then
                for _, track in pairs(playingAnimations) do
                    track:Stop()
                end
            end
        end
    else
        print("no humanoid :) ")
    end
end

stop_animations()
