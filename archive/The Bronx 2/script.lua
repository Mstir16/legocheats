repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

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

--// Vars \\--
local AutoJobFunc
local AutoJob
local ServerHopLowFunc
local HugeHeadFunc
local HugeHead
local BigHeadFunc
local BigHead
local MediumHeadFunc
local MediumHead
local SmallHeadFunc
local SmallHead
local NoClipToggled
local NoClipFunc

--// LIB \\--
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "Tha Bronx 2 | M1keCorp© & Lofi™",
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

local risky = X.New({
	Title = "RISKY"
})

local credits = X.New({
	Title = "CREDITS"
})

--// CREDITS \\--
credits.Button({
    Text = "made by m1ke & lofi",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Tha Bronx 2",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "m1kecorp on top (click for discord!)",
    Callback = function() setclipboard("https://discord.gg/y7H2qGmNKd") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Tha Bronx 2",
	Text = "Copied m1kecorp offical discord!",
}) end,
})

credits.Button({
    Text = "da hood ripoff",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Tha Bronx 2",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "infinite money xdddd",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Tha Bronx 2",
	Text = "Copied m1ke's discord!",
}) end,
})

credits.Button({
    Text = "lofi soloed this game",
    Callback = function() setclipboard("m1ke#3815") game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Tha Bronx 2",
	Text = "Copied m1ke's discord!",
}) end,
})

local AutoItems = main.Toggle({
    Text = "Auto Box Job",
    Callback = function(v)
        AutoJob = v
        
        if AutoJob then
            pcall(function()
                AutoJobFunc()
            end)
        end
    end
})

local NoClip = main.Toggle({
    Text = "Noclip",
    Callback = function(v)
        NoClipToggled = v
        

        pcall(function()
            NoClipFunc()
        end)
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

local hugehead = risky.Toggle({
    Text = "Huge Head Hitbox",
    Callback = function(v)
        HugeHead = v
        
        if HugeHead then
            pcall(function()
                HugeHeadFunc()
            end)
        end
    end
})

local bighead = risky.Toggle({
    Text = "Big Head Hitbox",
    Callback = function(v)
        BigHead = v
        
        if BigHead then
            pcall(function()
                BigHeadFunc()
            end)
        end
    end
})

local mediumhead = risky.Toggle({
    Text = "Medium Head Hitbox",
    Callback = function(v)
        MediumHead = v
        
        if MediumHead then
            pcall(function()
                MediumHeadFunc()
            end)
        end
    end
})

local smallhead = risky.Toggle({
    Text = "Small Head Hitbox",
    Callback = function(v)
        SmallHead = v
        
        if SmallHead then
            pcall(function()
                SmallHeadFunc()
            end)
        end
    end
})

local NoClipping

function NoClipOn()
    if NoClipToggled == false then NoClipping:Disconnect() NoClipping = nil end
    
    if game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

NoClipFunc = function()
    if NoClipping == nil then
        NoClipping = game.RunService.Stepped:Connect(NoClipOn)
    end
end

AutoJobFunc = function()
    while AutoJob and task.wait() do
        fireclickdetector(game:GetService("Workspace").MafiaMember.ClickDetector)
        task.wait(0.4)
        fireclickdetector(game.Workspace["Lower Garage Boxes"].ClickDetector)
        task.wait(0.4)
        repeat 
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game.Workspace.CarHB,0)
        task.wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game.Workspace.CarHB,1)
        until game.Players.LocalPlayer.Character:FindFirstChild("Box") == nil
        task.wait(0.5)
        fireclickdetector(game:GetService("Workspace").MafiaMember.ClickDetector)
        task.wait(0.5)
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

HugeHeadFunc = function()
    while HugeHead do task.wait()
            pcall(function()
        for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(200, 200, 200) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
    end)
    end
    for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(1, 1, 1) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
end

BigHeadFunc = function()
    while BigHead do task.wait()
            pcall(function()
        for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(50, 50, 50) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
    end)
    end
    for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(1, 1, 1) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
end

MediumHeadFunc = function()
    while MediumHead do task.wait()
            pcall(function()
        for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(15, 15, 15) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
    end)
    end
    for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(1, 1, 1) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
end

SmallHeadFunc = function()
    while SmallHead do task.wait()
            pcall(function()
        for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(5, 5, 5) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
    end)
    end
    for k,v in next, game:GetService('Players'):GetChildren() do 
        Head = v.Character:FindFirstChild('Head')
        if Head then 
                task.wait()
        Head.Size = Vector3.new(1, 1, 1) 
        game.Players.LocalPlayer.Character.Head.Size = Vector3.new(1, 1, 1)
        end
    end
end
