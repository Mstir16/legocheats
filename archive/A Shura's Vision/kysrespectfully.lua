--// VARS \\--
local plr = game.Players.LocalPlayer
local MinStam = 20
local AutoTreadmill = false
local AutoVanilla = false
local AutoBuyShake = false
local MoneyFarm = false
local AutoTreadFunc
local AutoMoneyFunc
local AutoVanillaFunc
local AutoBuyShakeFunc

--// LIB \\--
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "A Shura's Vision | m1kecorp ©",
	Style = 1,
	SizeX = 300,
	SizeY = 300,
	Theme = "Dark",
	ColorOverrides = {
    		MainFrame = Color3.fromRGB(31,31,31),
    }
})

local main = X.New({
	Title = "MAIN"
})

local A = main.Toggle({
	Text = "Money Farm",
	Callback = function(Value)
		MoneyFarm = Value
		
		if MoneyFarm then
		   task.spawn(function()
		       pcall(function()
		            AutoMoneyFunc()
		       end)
		   end)
		end
	end,
	Enabled = MoneyFarm
})


local E = main.Slider({
	Text = "Minimum Stamina",
	Callback = function(Value)
		MinStam = Value
	end,
	Min = 0,
	Max = plr.Stats.MaxStamina.Value,
	Def = MinStam
})

local B = main.Toggle({
	Text = "Auto Treadmill",
	Callback = function(Value)
		AutoTreadmill = Value
		
		if AutoTreadmill then
		   task.spawn(function()
		       pcall(function()
		            AutoTreadFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoTreadmill
})


local C = main.Toggle({
	Text = "Auto Vanilla Shakes",
	Callback = function(Value)
		AutoVanilla = Value
		
		if AutoVanilla then
		   task.spawn(function()
		       pcall(function()
		            AutoVanillaFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoVanilla
})


local D = main.Toggle({
	Text = "Auto Buy Vanilla Shakes",
	Callback = function(Value)
		AutoBuyShake = Value
		
		if AutoBuyShake then
		   task.spawn(function()
		       pcall(function()
		            AutoBuyShakeFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoBuyShake
})


AutoTreadFunc = function()
   local plr = game:GetService("Players").LocalPlayer

function GetClosestTreadmill()
    local collection = {}
    
    for i,v in pairs(game:GetService("Workspace").Treadmills:GetChildren()) do
        local distance = (plr.Character.HumanoidRootPart.Position - v:FindFirstChild("Conveyor").Position).magnitude
        table.insert(collection,#collection+1,distance) 
    end
    
    table.sort(collection)
    
    local closestDistance = collection[1]
    
    for i,v in pairs(game:GetService("Workspace").Treadmills:GetChildren()) do
        local distance = (plr.Character.HumanoidRootPart.Position - v:FindFirstChild("Conveyor").Position).magnitude
        
        if distance <= closestDistance then
            return v
        end
    end
end

function SimulateClick(button)
    pcall(function()
        local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
        for i,v in pairs(events) do
            for i,v in pairs(getconnections(button[v])) do
                v:Fire()
            end
        end
    end)
end

function ToggleRun()
    function run()
        game:GetService("Players").LocalPlayer.PlayerGui.Client.InputEvent:FireServer("StartRun")
        game:GetService("Players").LocalPlayer.PlayerGui.Client.InputEvent:FireServer("StartRun")
    end
    
    function stop()
        game:GetService("Players").LocalPlayer.PlayerGui.Client.InputEvent:FireServer("StopRun") 
    end
    
    if plr.Character:FindFirstChild("Humanoid").WalkSpeed > 16 then
        stop()
    else
        run()
    end
end

function StaminaStatus()
    local stamina = plr.Stats.Stamina.Value
    local maxstamina = plr.Stats.MaxStamina.Value

    if stamina <= MinStam then
        return "recharge"
    elseif stamina >= maxstamina then
        return "max"
    else
        return nil
    end
end

local treadmill = GetClosestTreadmill()
local TMCD = treadmill:FindFirstChild("Conveyor").ClickDetector

while AutoTreadmill and task.wait() do
    if plr.Character.HumanoidRootPart.Anchored == false and AutoTreadmill then
        if plr.Character.Humanoid.WalkSpeed ~= 16 then
            ToggleRun() 
        end
        
        plr.Character.HumanoidRootPart.CFrame = treadmill:FindFirstChild("Conveyor").CFrame
        task.wait(0.4)
        fireclickdetector(TMCD)
        task.wait(0.1)
    elseif plr.Character.HumanoidRootPart.Anchored == true and AutoTreadmill then
        if plr.Character.Humanoid.WalkSpeed ~= 16 then
            ToggleRun() 
        end
        
        if plr.PlayerGui.TreadGui.Enabled == true and AutoTreadmill then
            task.wait()
        else
            if plr.Character.Humanoid.WalkSpeed == 16 and StaminaStatus() == "max" and AutoTreadmill then
               ToggleRun()
               task.wait(1)
               repeat
                   local check = StaminaStatus()
                   task.wait()
               until check == "recharge" or AutoTreadmill ~= true
               
               ToggleRun()
               
               repeat
                   local check = StaminaStatus()
                   task.wait()
               until check == "max" or AutoTreadmill ~= true
            end
        end
    end
end 
end

AutoVanillaFunc = function()
    while AutoVanilla and task.wait() do
        local w = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Vanilla Protein Shake")
        if w and game:GetService("Players").LocalPlayer.Character ~= nil then
            w.Parent = game:GetService("Players").LocalPlayer.Character
            task.wait(0.5)
            w = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Vanilla Protein Shake")
            w:Activate()
        else
            continue
        end
        task.wait(30)
    end
end

AutoBuyShakeFunc = function()
    while AutoBuyShake and task.wait() do
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Purchaseables2["Protein Shake $75"].Head.CFrame
       fireclickdetector(game:GetService("Workspace").Purchaseables2["Protein Shake $75"].ClickDetector) 
    end
end

AutoMoneyFunc = function()
    local jobpart = game:GetService("Workspace").JobBoard.GetJob
	local jobCD = jobpart.ClickDetector
	local dropoff = game:GetService("Workspace").DropOffPoint
	local jobui = game:GetService("Players").LocalPlayer.PlayerGui.Jobs

	function Touch(part)
	   if firetouchinterest then
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,part,0)
		task.wait()
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,part,1)
	   end
	end

	while MoneyFarm and task.wait() do
	    if jobui.Enabled == true then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = dropoff.CFrame
		Touch(dropoff)
		task.wait(0.5)
	    else
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = jobpart.CFrame
		task.wait(0.4)
		fireclickdetector(jobCD)
		task.wait(0.1)
	    end 
	end
end
