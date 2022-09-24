--loadstring(game:HttpGet("https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Blox%20Fruits/script.lua"))()
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

pcall(function()
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
        v.Function() 
    end
end)

--// Lib Stuff \\--
local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/Forever4D/Lib/main/DiscordLib2.lua")()
local win = DiscordLib:Window("Mstir's Utilities: Blox Fruits")
local serv = win:Server("UI Version 1.0.0","http://www.roblox.com/asset/?id=6031075938")
local lvlf = serv:Channel("Leveling")
local itemf = serv:Channel("Fruit/etc")
local misc = serv:Channel("Misc")

--// Config \\--
local BFConfig = {
    EnemySelected = nil,
    TweenSpeed = 300,
    BusoBind = Enum.KeyCode.G,
    ObvBind = Enum.KeyCode.H,
    ObservationRad = 10,
    Serverhop = false,
    Features = {
        EnemyAutofarm = false,
        ChestFarm = false,
        ChestESP = false,
        FruitESP = false,
        FruitFarm = false,
        AutoQuest = false,
        InfEnergy = false,
        AutoSkills = false,
    },
    BoatConfig = {
        MaxSpeed = nil,
        Torque = nil,
    },
}

local function ReadConfig()
    local fileData = readfile("/Mstir Utilities/Blox_Fruits_"..game.Players.LocalPlayer.UserId..".json")
    local data = game:GetService("HttpService"):JSONDecode(fileData)
    
    for i,v in pairs(data) do
        if typeof(v) ~= "table" then
            BFConfig[i] = v
        else
            for i2,v2 in pairs(data[i]) do
                BFConfig[i][i2] = v2
            end
        end
    end
end

local function AppendConfig()
    local data = game:GetService("HttpService"):JSONEncode(BFConfig)
    writefile("/Mstir Utilities/Blox_Fruits_"..game.Players.LocalPlayer.UserId..".json",data)
end

local folder = isfolder("/Mstir Utilities")
local file = isfile("/Mstir Utilities/Blox_Fruits_"..game.Players.LocalPlayer.UserId..".json")

if not folder then
    makefolder("/Mstir Utilities") 
end

if not file then
    local data = game:GetService("HttpService"):JSONEncode(BFConfig)
    writefile("/Mstir Utilities/Blox_Fruits_"..game.Players.LocalPlayer.UserId..".json",data)
else
    ReadConfig()
end

--// Variables \\--

local EnemiesFolder = game:GetService("Workspace").Enemies
local NPCFolder = game:GetService("Workspace").NPCs
local IslandTPs = game:GetService("Workspace")["_WorldOrigin"].Locations
local plr = game.Players.LocalPlayer
local autoclick = true

game:GetService("UserInputService").InputBegan:Connect(function(input,chat)
    if chat then return end
    
    if input.KeyCode == Enum.KeyCode.U then
        autoclick = not autoclick
        print("AutoClicker Toggle: ",autoclick)
    end
end)

--// Functions \\--

local function Tween(target)
    pcall(function()
        local info = TweenInfo.new((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / BFConfig.TweenSpeed, Enum.EasingStyle.Linear)
        local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = target})
        Tween:Play()
        Tween.Completed:Wait()
    end)
end

local function NPCTween(target)
    --target + target.lookVector * -6
    pcall(function()
        local info = TweenInfo.new((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / BFConfig.TweenSpeed, Enum.EasingStyle.Linear)
        local Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = CFrame.new(target.Position + Vector3.new(0,10,0),target.Position)})
        Tween:Play()
        Tween.Completed:Wait()
    end)
end

local function GetAllEnemies()
    local edump = {}
    
    for i,v in pairs(workspace.Enemies:GetChildren()) do
        table.insert(edump,v)
    end
    
    return edump
end

local function DrawLibTxt(item)
    local camera = workspace.CurrentCamera
    local runservice = game:GetService("RunService")

    local drawTXT = Drawing.new("Text")
    drawTXT.Visible = false
    drawTXT.Center = true
    drawTXT.Outline = true
    drawTXT.Font = 1
    drawTXT.Color = Color3.fromRGB(255,255,255)
    drawTXT.Size = 13
    if string.find(item.Name, "Fruit") then
        drawTXT.Color = Color3.fromRGB(0, 136, 255)
        drawTXT.Size = 20
    end

    local BV = Instance.new("BoolValue",item)
    BV.Name = "MARKED"

    local touchDebounce = false

    local renderstepped
    renderstepped = runservice.RenderStepped:Connect(function()
        if item and BFConfig.Features.ChestESP or item and BFConfig.Features.FruitESP then
            local PosPart
            
            if item:IsA("Part") then
                PosPart = item
            else
                PosPart = item.Handle
            end
            
            PosPart.Touched:Connect(function(hit)
                if not touchDebounce and hit.Parent.Name == plr.Name then
                    touchDebounce = true
                    renderstepped:Disconnect()
                    pcall(function()
                        drawTXT:Remove()
                    end)
                end
            end)
            
            local drop_pos, drop_onscreen = camera:WorldToViewportPoint(PosPart.Position)

            if drop_onscreen then
                drawTXT.Position = Vector2.new(drop_pos.X, drop_pos.Y)
                drawTXT.Text = item.Name
                drawTXT.Visible = true
            else 
                drawTXT.Visible = false
            end
        else
            drawTXT.Visible = false
            drawTXT:Remove()
            if BV then
                BV:Destroy() 
            end
            renderstepped:Disconnect()
        end
    end)
end

local function GetPlayerBoat()
    for i,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
        if tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
            return v
        end
    end
end

--// LEVELIING TAB \\--

local sldr =
    lvlf:Slider(
    "Tween Speed",
    0,
    500,
    BFConfig.TweenSpeed,
    function(t)
        BFConfig.TweenSpeed = t
        AppendConfig()
    end
)

lvlf:Toggle(
    "Enemy Auto-Farm (AutoClick: U):",
    BFConfig.Features.EnemyAutofarm,
    function(bool)
        BFConfig.Features.EnemyAutofarm = bool
        AppendConfig()
    end
)

local EnemyPicker =
    lvlf:Dropdown(
    "Enemy Selector",
    {"click button","below to","refresh"},
    BFConfig.EnemySelected,
    function(bool)
        print(bool)
        BFConfig.EnemySelected = bool
        AppendConfig()
    end
)

lvlf:Button(
    "Refresh Enemy Picker DD",
    function()
        EnemyPicker:Clear()
        local added = {}
        
        for i,v in pairs(GetAllEnemies()) do
            if not table.find(added,v.Name) then
                EnemyPicker:Add(v.Name)
                table.insert(added,v.Name) 
            end
        end
    end
)

lvlf:Toggle(
    "Auto-Quest(WIP):",
    BFConfig.Features.AutoQuest,
    function(bool)
        BFConfig.Features.AutoQuest = bool
        AppendConfig()
    end
)

lvlf:Seperator()

lvlf:Toggle(
    "Auto Skills:",
    BFConfig.Features.AutoSkills,
    function(bool)
        BFConfig.Features.AutoSkills = bool
        AppendConfig()
    end
)

itemf:Toggle(
    "Chest Farm:",
    BFConfig.Features.ChestFarm,
    function(bool)
        BFConfig.Features.ChestFarm = bool
        AppendConfig()
    end
)

itemf:Toggle(
    "Chest ESP:",
    BFConfig.Features.ChestESP,
    function(bool)
        BFConfig.Features.ChestESP = bool
        AppendConfig()
    end
)

itemf:Seperator()

itemf:Toggle(
    "Fruit Farm:",
    BFConfig.Features.FruitFarm,
    function(bool)
        BFConfig.Features.FruitFarm = bool
        AppendConfig()
    end
)

itemf:Toggle(
    "Serverhop After Getting All Fruits:",
    BFConfig.Serverhop,
    function(bool)
        BFConfig.Serverhop = bool
        AppendConfig()
    end
)

itemf:Seperator()

itemf:Toggle(
    "Fruit ESP:",
    BFConfig.Features.FruitESP,
    function(bool)
        BFConfig.Features.FruitESP = bool
        AppendConfig()
    end
)

misc:Toggle(
    "Inf Energy:",
    BFConfig.Features.InfEnergy,
    function(bool)
        BFConfig.Features.InfEnergy = bool
        AppendConfig()
    end
)

misc:Bind(
    "Buso Haki Bind",
    BFConfig.BusoBind,
    function()
        pcall(function()
            game.Players.LocalPlayer.Character.Buso:Destroy()
        end)
        
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso");
        AppendConfig()
    end
)

misc:Bind(
    "Observation Haki Bind",
    BFConfig.ObvBind,
    function()
        pcall(function()
            game.Players.LocalPlayer.Character.Observation:Destroy()
        end)
        
        local kenhaki = getgenv().ken

        if kenhaki == nil then
            kenhaki = require(game:GetService("ReplicatedStorage").ObservationManager).new(game.Players.LocalPlayer);
            getgenv().ken = kenhaki
        end
        
        kenhaki:setActive(not kenhaki.active)
        if kenhaki.active == true then
            kenhaki.radius = 1000
            game.ReplicatedStorage.Remotes.CommE:FireServer("Ken",kenhaki.active);
        else
            kenhaki.radius = 0
            game.ReplicatedStorage.Remotes.CommE:FireServer("Ken",kenhaki.active);
        end
        
        AppendConfig()
    end
)

misc:Slider(
    "Observation Haki Radius",
    0,
    50,
    BFConfig.ObservationRad,
    function(t)
        BFConfig.ObservationRad = t
        AppendConfig()
    end
)

misc:Textbox(
    "Boat Max Speed",
    "Integer",
    true,
    function(t)
        local number = tonumber(t)
        
        if number ~= nil then
            BFConfig.BoatConfig.MaxSpeed = number
        end
    end
)

misc:Textbox(
    "Boat Torque",
    "Integer",
    true,
    function(t)
        local number = tonumber(t)
        
        if number ~= nil then
            BFConfig.BoatConfig.Torque = number
        end
    end
)

misc:Button(
    "Edit Boat Stats",
    function()
        local MyBoat = GetPlayerBoat()

        if MyBoat then
            for i,v in pairs(BFConfig.BoatConfig) do
                if v ~= nil then
                    print("Edited ",i," with the value: ",v)
                    MyBoat.VehicleSeat[i] = v
                end
            end
        end
    end
)


--// Scripts \\--

--// Chest Farm\\--
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.ChestFarm then
            for i,v in pairs(workspace:GetChildren()) do
                if string.find(v.Name,"Chest") and BFConfig.Features.ChestFarm then
                    local Chest = v
                    
                    Tween(Chest.CFrame)
                    wait(0.1)
                end
            end
        end
    end
end))

--// Inf Energy \\--

local InfEnergyConnection

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.InfEnergy and InfEnergyConnection == nil then
            local theVal = plr.Character.Energy.Value
            
            InfEnergyConnection = game:GetService("RunService").Heartbeat:Connect(function()
                plr.Character.Energy.Value = theVal
                wait() 
            end)
            
            while BFConfig.Features.InfEnergy do
               wait() 
            end
            
            InfEnergyConnection:Disconnect()
            InfEnergyConnection = nil
        end
    end
end))

--// Fruit Farm\\--
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.FruitFarm then
            for i,v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and string.find(v.Name,"Fruit") and BFConfig.Features.FruitFarm then
                    local Fruit = v
                    
                    Tween(Fruit.Handle.CFrame)
                    wait(0.1)
                    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:FindFirstChild("Fruit") and v:FindFirstChild("Keep") then
                            Fruit = v
                            Fruit.Parent = game.Players.LocalPlayer.Character
                        end
                    end
                    
                    Fruit = nil

                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:FindFirstChild("Fruit") and v:FindFirstChild("Keep") then
                            Fruit = v
                            print(Fruit.Name)
                        end
                    end
                    
                    if Fruit ~= nil then
                        Fruit:Activate()
                        wait(1.5)
                        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Option3.MouseButton1Click)) do
                            v.Function() 
                        end
                        wait(1)
                    end
                end
            end
            
            if workspace:FindFirstChildOfClass("Tool") then
                local tool = workspace:FindFirstChildOfClass("Tool")
                local toolName = tool.Name:split("Fruit")[1]
                toolName = toolName.."-"..toolName
                local handle = tool:FindFirstChild("Handle")
                
                if handle ~= nil then
                    Tween(handle.CFrame)
                    wait(0.1)
                    local Fruit = nil
                    
                    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:FindFirstChild("Fruit") and v:FindFirstChild("Keep") then
                            Fruit = v
                            Fruit.Parent = game.Players.LocalPlayer.Character
                        end
                    end

                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:FindFirstChild("Fruit") and v:FindFirstChild("Keep") then
                            Fruit = v
                            print(Fruit.Name)
                        end
                    end
                    
                    if Fruit ~= nil then
                        Fruit:Activate()
                        wait(1.5)
                        for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.Dialogue.Option3.MouseButton1Click)) do
                            v.Function() 
                        end
                        wait(1)
                    end
                end
            end
            
            if BFConfig.Serverhop == true and workspace:FindFirstChild("Fruit ") == nil and workspace:FindFirstChildOfClass("Tool") == nil then
                game:shutdown()
            end
        end
    end
end))

--// Fruit ESP\\--
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.FruitESP then
            for i,v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and string.find(v.Name,"Fruit") and v:FindFirstChild("MARKED") == nil and BFConfig.Features.FruitESP then
                    local Fruit = v
                    print('drawing')
                    DrawLibTxt(Fruit)
                end
            end
        end
    end
end))

--// Chest ESP\\--
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.ChestESP then
            for i,v in pairs(workspace:GetChildren()) do
                if string.find(v.Name,"Chest") and v:FindFirstChild("MARKED") == nil and BFConfig.Features.ChestESP then
                    local Chest = v
                    
                    DrawLibTxt(Chest)
                end
            end
        end
    end
end))

--// Enemy Autofarm \\--

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.EnemyAutofarm and BFConfig.EnemySelected ~= nil then
            local EnemyChar
            
            for i,v in pairs(GetAllEnemies()) do
                if v.Name == BFConfig.EnemySelected then
                    EnemyChar = v
                end
            end
            
            if EnemyChar == nil then continue end
            
            task.spawn(function()
                pcall(function()
                    while EnemyChar ~= nil do
                        if EnemyChar.Humanoid.Health > 0 and EnemyChar ~= nil and BFConfig.Features.EnemyAutofarm then
                            if plr.Backpack:FindFirstChild("Combat") then
                                plr.Backpack:FindFirstChild("Combat").Parent = plr.Character
                            end
                            
                            if autoclick == true then
                                local vim = game:GetService("VirtualInputManager")
                                vim:SendMouseButtonEvent(0, 500, 0, true, game, 1)
                            end
                        elseif BFConfig.Features.EnemyAutofarm == false then
                            break
                        else
                            break
                        end
                        wait()
                    end
                end)
            end)
            
            task.spawn(function()
                pcall(function()
                    while EnemyChar ~= nil do
                        if EnemyChar.Humanoid.Health > 0 and EnemyChar ~= nil and BFConfig.Features.EnemyAutofarm then
                            NPCTween(EnemyChar.HumanoidRootPart.CFrame)
                        elseif BFConfig.Features.EnemyAutofarm == false then
                            break
                        else
                            break
                        end
                        wait()
                    end
                end)
            end)
            
            repeat
                pcall(function()
                    if EnemyChar.Humanoid.Health <= 0 then
                        EnemyChar = nil 
                    end
                end)
                wait()
            until EnemyChar == nil or BFConfig.Features.EnemyAutofarm == false
        end
    end
end))

--// Auto Skills \\--

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if BFConfig.Features.AutoSkills then
            local Keys = {"Z","X","C","V"}
            local vim = game:GetService("VirtualInputManager")
            
            for _,Key in pairs(Keys) do
                if BFConfig.Features.AutoSkills then
                    vim:SendKeyEvent(true, Key, false, game)
                    wait()
                    vim:SendKeyEvent(false, Key, false, game)
                    wait()
                end
            end
        end
    end
end))
