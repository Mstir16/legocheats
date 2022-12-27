repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

--// Vars \\--
local ItemFarm
local ItemFarmFunc
local AutoRobATM
local AutoRobBank
local AutoRobBankFunc
local ServerHopLowFunc

--// LIB \\--
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "Ohio | m1kecorpÂ© & lofi",
	Style = 3,
	SizeX = 400,
	SizeY = 400,
	Theme = "Dark",
	ColorOverrides = {
    		MainFrame = Color3.fromRGB(0, 0, 0),
    		Minimise = Color3.fromRGB(214, 1, 1),
    		MinimiseAccent = Color3.fromRGB(5, 0, 0),
    		Maximise = Color3.fromRGB(25,255,0),
    		MaximiseAccent = Color3.fromRGB(0,255,110),
    		NavBar = Color3.fromRGB(255, 255, 255),
    		NavBarAccent = Color3.fromRGB(0, 0, 0),
    		NavBarInvert = Color3.fromRGB(235,235,235),
    		TitleBar = Color3.fromRGB(0, 0, 0),
    		TitleBarAccent = Color3.fromRGB(255, 255, 255),
    		Overlay = Color3.fromRGB(175,175,175),
    		Banner = Color3.fromRGB(0, 182, 232),
    		BannerAccent = Color3.fromRGB(255,255,255),
    		Content = Color3.fromRGB(82, 82, 82),
    		Button = Color3.fromRGB(65, 65, 65),
    		ButtonAccent = Color3.fromRGB(255, 255, 255),
    		ChipSet = Color3.fromRGB(235,235,235),
    		ChipSetAccent = Color3.fromRGB(75,75,75),
    		DataTable = Color3.fromRGB(235,235,235),
    		DataTableAccent = Color3.fromRGB(75,75,75),
    		Slider = Color3.fromRGB(65, 65, 65),
    		SliderAccent = Color3.fromRGB(255, 255, 255),
    		Toggle = Color3.fromRGB(255, 255, 255),
    		ToggleAccent = Color3.fromRGB(0, 0, 0),
    		Dropdown = Color3.fromRGB(75,75,75),
    		DropdownAccent = Color3.fromRGB(125,125,125),
    		ColorPicker = Color3.fromRGB(75,75,75),
    		ColorPickerAccent = Color3.fromRGB(235,235,235),
    		TextField = Color3.fromRGB(65, 65, 65),
    		TextFieldAccent = Color3.fromRGB(255,255,255),
    }
})

local main = X.New({
	Title = "MAIN"
})

local credits = X.New({
	Title = "CREDITS"
})

--// CREDITS \\--
credits.Button({
    Text = "made by m1ke & lofi",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ohio",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "m1kecorp on top (click for discord!)",
    Callback = function() setclipboard("https://discord.gg/y7H2qGmNKd") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ohio",
	Text = "Copied m1kecorp offical discord!",
}) end,
})

credits.Button({
    Text = "this game straight ass lmfao",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ohio",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "too ez made this in like 300 lines",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ohio",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "lofi is pro",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Ohio",
	Text = "Copied m1ke's discord!",
}) end,
})

local AutoItems = main.Toggle({
    Text = "Collect Items",
    Callback = function(v)
        ItemFarm = v
        
        if ItemFarm then
            pcall(function()
                ItemFarmFunc()
            end)
        end
    end
})

local AutoRobBank = main.Toggle({
    Text = "Auto Rob Bank",
    Callback = function(v)
        AutoRobBank = v
        
        if AutoRobBank then
            pcall(function()
                AutoRobBankFunc()
            end)
        end
    end
})

local AutoRobATM = main.Toggle({
    Text = "Auto Rob ATMS",
    Callback = function(v)
        AutoRobATM = v
        
        if AutoRobATM then
            pcall(function()
                AutoRobATMFunc()
            end)
        end
    end
})

local shopLowButton = main.Button({
    Text = "Serverhop to low server",
    Callback = function()
        pcall(function()
            ServerHopLowFunc()
        end)
    end,
})

function GetItems()
   local cache = {}
   
   for i,v in pairs(game:GetService("Workspace").Game.Entities.CashBundle:GetChildren()) do
       table.insert(cache,v)
   end
   
   for i,v in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
       table.insert(cache,v)
   end
   
   return cache
end

function Collect(item)
    if item:FindFirstChildOfClass("ClickDetector") then
        fireclickdetector(item:FindFirstChildOfClass("ClickDetector"))
    elseif item:FindFirstChildOfClass("Part") then
        local maincrap = item:FindFirstChildOfClass("Part")
        fireclickdetector(maincrap:FindFirstChildOfClass("ClickDetector"))
    end
end

ItemFarmFunc = function()
    while ItemFarm and task.wait() do
        local allitems = GetItems()
        
        for i,v in pairs(allitems) do
            if ItemFarm == false then break end
            pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildOfClass("Part").CFrame
                task.wait(0.5)
                Collect(v)
                task.wait(0.5)
            end)
            continue
        end
    end
end

AutoRobBankFunc = function()
    while AutoRobBank and task.wait() do
        local bankthing = game:GetService("Workspace").BankRobbery.BankCash
        if #bankthing.Cash:GetChildren() > 0 then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = bankthing.Main.CFrame
           task.wait()
           fireproximityprompt(game:GetService("Workspace").BankRobbery.BankCash.Main.Attachment.ProximityPrompt)
        end
    end
end

AutoRobATMFunc = function()
while AutoRobATM do task.wait()
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local vi = game:service'VirtualInputManager'
    for i,v in pairs(game:GetService("Workspace").Game.Props.ATM:GetChildren()) do
        if v:IsA("Model") and v.Name == "ATM" and v:GetAttribute("state") ~= "destroyed" then 
            task.spawn(function()
                while v:GetAttribute("state") ~= "destroyed" do
                    task.wait()
                    for i,v in pairs(game:GetService("Workspace").Game.Entities.CashBundle:GetChildren()) do
                        local mp = v:FindFirstChildOfClass("Part")
                        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - mp.Position).magnitude
                        
                        if distance <= 15 then
                            fireclickdetector(v:FindFirstChildOfClass("ClickDetector"))
                        end
                    end 
                end
            end)
            
            repeat task.wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame * CFrame.new(0,-7,0) * CFrame.Angles(math.rad(90),0,0)
                vi:SendMouseButtonEvent(500, 500, 0, true, game, 1)
                task.wait()
                vi:SendMouseButtonEvent(500, 500, 0, false, game, 1)
            until v:GetAttribute("state") == "destroyed" or AutoRobATM == false
            
            for i,v in pairs(game:GetService("Workspace").Game.Entities.CashBundle:GetChildren()) do
                local mp = v:FindFirstChildOfClass("Part")
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - mp.Position).magnitude
                
                if distance <= 15 then
                    fireclickdetector(v:FindFirstChildOfClass("ClickDetector"))
                end
            end
            task.wait()
        end
    end
end
end


ServerHopLowFunc = function()
    local servers = {}
    local serversplayers = {}
    local maxPlrs = nil
    local http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local req = http({Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)})
    local body = game.HttpService:JSONDecode(req.Body)
    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers then
                if maxPlrs == nil then maxPlrs = tonumber(v.maxPlayers)
                table.insert(servers, #servers+1, v)
            end 
        end
    end
    end
    
    if #servers == 0 then return end
    
    for i,v in pairs(servers) do
        table.insert(serversplayers,#serversplayers+1,tonumber(v.playing))
    end
    
    table.sort(serversplayers)
    
    for i,v in pairs(servers) do
       if v.playing == serversplayers[1] and v.id ~= game.JobId then
           servers = {v.id}
       elseif v.id == game.JobId then
           servers = {}
       end
    end
    
    if #servers == 0 then return end
    
    if #servers > 0 then
        game.TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
    end 
end
