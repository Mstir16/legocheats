local arrows = {"Weird Arrow","Stand Arrow"}
local UIS = game:GetService("UserInputService")

function GetArrow()
    for i,v in pairs(arrows) do
        if game.Players.LocalPlayer.Backpack:FindFirstChild(v) then
            return {game.Players.LocalPlayer.Backpack:FindFirstChild(v),game:GetService("ReplicatedStorage").ItemEvent:FindFirstChild(v:gsub(" ",""))}
        end
    end
    return nil
end

UIS.InputBegan:Connect(function(input,chat)
    if chat then return end
    
    if input.KeyCode == Enum.KeyCode.L then
        if GetArrow() ~= nil then
            workspace.Pucci.Pucci:FireServer()
            wait(0.5)
            repeat wait(1) until game.Players.LocalPlayer.Character ~= nil
            local result = GetArrow()
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(result[1])
            wait(0.2)
            result[2]:FireServer()
            wait(7)
            game:GetService("ReplicatedStorage").Stands.Summon:FireServer()
        else
            return
        end
    end
end)
