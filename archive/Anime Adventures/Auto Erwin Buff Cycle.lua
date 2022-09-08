--getgenv().erwinCycle = true

local units = game:GetService("Workspace")["_UNITS"]
local erwins
local buffs = {
    [1] = false,
    [2] = false,
    [3] = false,
}

if game.PlaceId == 8304191830 then return end

function buff(unit)
    pcall(function()
        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(unit)
    end)
end

function GetTotalErwins()
    local eDump = {}
    for i,v in pairs(units:GetChildren()) do
         if v.Name == "erwin" and v:FindFirstChild("_stats").player.Value == game.Players.LocalPlayer and v:FindFirstChild("_stats").upgrade.Value >= 3 then
            table.insert(eDump,v)
         end
    end
    return eDump
end

function GetBuffedUnit()
    for i,v in pairs(units:GetChildren()) do
        if v:FindFirstChild("_buffs") then
            if v:FindFirstChild("_buffs")["damage_buff"].Value == 1 then
                for i = 1,3 do
                    local theErwin = erwins[i]
                    local root = theErwin:FindFirstChild("HumanoidRootPart")
                    local distance = (v.HumanoidRootPart.Position - root.Position).magnitude
                    
                    if distance < 11 then
                        return v
                    end
                end
            end
        end
    end
    return nil
end

erwins = GetTotalErwins()

if #erwins ~= 3 then return end

while wait() do
    if buffs[1] == false and buffs[2] == false and buffs[3] == false and erwinCycle == true then
        for i = 1,3 do
            if erwinCycle == false then return end
            local theErwin = erwins[i]
            local buffBool = buffs[i]
            
            buff(theErwin)
            buffBool = true
            wait(0.5)
            local BuffedMan = GetBuffedUnit()
            if BuffedMan == nil then
                return print('RESTART ERWIN BUFF')
            end
            
            repeat
                local check
                pcall(function()
                    check = BuffedMan:FindFirstChild("_buffs")["damage_buff"].Value
                end)
                wait()
            until check ~= 1
        end
    elseif buffs[1] == true and buffs[2] == true and buffs[3] == true and erwinCycle == true then
        for i = 1,3 do 
            local buffBool = buffs[i]
            buffBool = false
        end
    elseif erwinCycle == false then
        return
    end
end
