--[[
made by sweety#3848 (sponsored by m1kecorp XD)

discord.gg/m1kecorp or https://discord.gg/y7H2qGmNKd
]]-- 

-- Animations for auto parry :) (add what u want to parry) *it's not an ignore list*
local hehe = {
    "rbxassetid://6241709963",
    "rbxassetid://4954439454",
    "rbxassetid://4954439686",
    "rbxassetid://4954439454"
}

local auto_parry_boolean_hehe_lol_skull = false

-- Auto Parry stuff :)

-- This function checks if there is any player within a range of 13 studs from the local player's character.
local function is_any_player_within_range()
    local my_root = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            local distance = (player.Character.HumanoidRootPart.Position - my_root.Position).Magnitude
            if distance <= 13 then
                return true
            end
        end
    end
    -- Return false if no player is within range.
    return false
end

-- This function checks if there is any sound playing that is in the list 'hehe' and is not from the local player's character.
local function is_any_sound_playing()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        for _, descendant in pairs(player.Character.HumanoidRootPart:GetDescendants()) do
            if descendant:IsA("Sound") and descendant.IsPlaying and table.find(hehe, descendant.SoundId) and player ~= game:GetService("Players").LocalPlayer then
                return true
            end
        end
    end
    -- Return false if no sound is playing.
    return false
end

-- This function parries if there is any sound playing and if there is any player within range.
local function parry_if_sound_playing()
    if is_any_sound_playing() and is_any_player_within_range() then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
        task.wait(0.005)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
        task.wait(0.005)
    end
end

while task.wait() and auto_parry_boolean_hehe_lol_skull do
    parry_if_sound_playing()
end
