--// VARS \\--
local plr = game.Players.LocalPlayer
local MinStam = 20
local MaxFatigue = 60
local AutoTreadmill = false
local AutoVanilla = false
local AutoBuyShake = false
local MoneyFarm = false
local AutoSleep = false
local AutoCST = false
local AutoTreadFunc
local AutoMoneyFunc
local AutoVanillaFunc
local AutoBuyShakeFunc
local AutoSleepFunc
local AutoCSTFunc

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


--// MAIN TAB \\--


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


local MinStamSlide = main.Slider({
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

local F = main.Toggle({
	Text = "Auto Combat Speed",
	Callback = function(Value)
		AutoCST = Value
		
		if AutoCST then
		   task.spawn(function()
		       pcall(function()
		            AutoCSTFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoCST
})

local MaxFatigueSlide = main.Slider({
	Text = "Maximum Fatigue",
	Callback = function(Value)
		MaxFatigue = Value
	end,
	Min = 0,
	Max = 100,
	Def = MaxFatigue
})

local C = main.Toggle({
	Text = "Auto Sleep",
	Callback = function(Value)
		AutoSleep = Value
		
		if AutoSleep then
		   task.spawn(function()
		       pcall(function()
		            AutoSleepFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoSleep
})

local D = main.Toggle({
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


local E = main.Toggle({
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

--\\ END OF MAIN TAB //--


--// Helpful Functions \\--

local function disableAll()
    F:SetState(false)
    E:SetState(false)
	D:SetState(false)
	B:SetState(false)
	A:SetState(false)
end

local function IsFatigueMax()
    local Fatigue = plr.Stats.Fatigue.Value
    
    if Fatigue >= MaxFatigue then
        disableAll()
        return true
    else
        return nil
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        IsFatigueMax()
    end
end))

local function GetClosestTreadmill()
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

local function SimulateClick(button)
    pcall(function()
        local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
        for i,v in pairs(events) do
            for i,v in pairs(getconnections(button[v])) do
                v:Fire()
            end
        end
    end)
end

local function ToggleRun()
    function run()
        plr.PlayerGui.Client.InputEvent:FireServer("StartRun")
        plr.PlayerGui.Client.InputEvent:FireServer("StartRun")
    end
    
    function stop()
        plr.PlayerGui.Client.InputEvent:FireServer("StopRun") 
    end
    
    if plr.Character:FindFirstChild("Humanoid").WalkSpeed > 16 then
        stop()
    else
        run()
    end
end

local function StaminaStatus()
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

local function Touch(part)
   if firetouchinterest then
	firetouchinterest(plr.Character.HumanoidRootPart,part,0)
	task.wait()
	firetouchinterest(plr.Character.HumanoidRootPart,part,1)
   end
end

local function GetABed()
    for i,v in pairs(workspace:GetChildren()) do
    	if v:FindFirstChild("Hospital Bed") then
    	    return v:FindFirstChild("Hospital Bed")
    	end
    end
end

--// Feature Functions \\--


AutoTreadFunc = function()
   local plr = plr

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
        local w = plr.Backpack:FindFirstChild("Vanilla Protein Shake")
        if w and plr.Character ~= nil then
            w.Parent = plr.Character
            task.wait(0.5)
            w = plr.Character:FindFirstChild("Vanilla Protein Shake")
            w:Activate()
        else
            continue
        end
        task.wait(30)
    end
end

AutoBuyShakeFunc = function()
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Purchaseables2["Protein Shake $80"].Head.CFrame
    task.wait(0.1)
	
    while AutoBuyShake and task.wait() do
       plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Purchaseables2["Protein Shake $80"].Head.CFrame
       task.wait()
       fireclickdetector(game:GetService("Workspace").Purchaseables2["Protein Shake $80"].ClickDetector) 
    end
end

AutoMoneyFunc = function()
    local jobpart = game:GetService("Workspace").JobBoard.GetJob
	local jobCD = jobpart.ClickDetector
	local dropoff = game:GetService("Workspace").DropOffPoint
	local jobui = plr.PlayerGui.Jobs

	while MoneyFarm and task.wait() do
	    if jobui.Enabled == true then
		plr.Character.HumanoidRootPart.CFrame = dropoff.CFrame
		Touch(dropoff)
		task.wait(0.5)
	    else
		plr.Character.HumanoidRootPart.CFrame = jobpart.CFrame
		task.wait(0.4)
		fireclickdetector(jobCD)
		task.wait(0.1)
	    end 
	end
end

AutoSleepFunc = function()
	while AutoSleep and task.wait() do
	    local Fatigue = plr.Stats.Fatigue.Value
	    
		if Fatigue >= MaxFatigue then
			if plr.Character.HumanoidRootPart.Anchored ~= true then
				disableAll()
				local bed = GetABed()
				plr.Character.HumanoidRootPart.CFrame = bed.ActivePart.CFrame
				task.wait(0.4)
				fireclickdetector(bed.ClickDetector)
				task.wait(10)
			end
	    end
	end
end

AutoCSTFunc = function()
    local CST = game:GetService("Workspace").Purchaseables2.NonChangeable["Combat Speed Training $70"]
    local CSTCD = CST.ClickDetector
    local CSTCF = CFrame.new(-3229.66016, -2071.5459, 1768.86389, -0.013615814, -9.55438679e-08, -0.999907315, 4.63641436e-09, 1, -9.56158601e-08, 0.999907315, -5.93787197e-09, -0.013615814)
    
    while AutoCST and task.wait() do
       local CSTUI = plr.PlayerGui:FindFirstChild("MinigameGui")
       local CSTCheck = plr.Backpack:FindFirstChild("Combat Speed Training")
       
       if CSTCheck == nil and CSTUI.Enabled ~= true or CSTCheck ~= nil and CSTUI.Enabled ~= true and AutoCST then
          if CSTCheck == nil then
	      plr.Character.HumanoidRootPart.CFrame = CSTCF
       	      task.wait(0.1)
              fireclickdetector(CSTCD,10)
          end
          task.wait()
          plr.Character.Humanoid:UnequipTools()
          pcall(function()
          if plr.Character:FindFirstChild("Combat Speed Training") == nil then
              plr.Backpack:FindFirstChild("Combat Speed Training").Parent = plr.Character
          end
          CSTCheck = plr.Character:FindFirstChild("Combat Speed Training")
          CSTCheck:Activate()
          task.wait(0.5)
          end)
          continue
       end
        
       if CSTUI.Enabled == true and AutoCST then
          plr.PlayerGui.Client.MinigameFunction:InvokeServer(Enum.KeyCode[CSTUI.KeyToPress.Text])
          CSTUI.Enabled = false
          task.wait(0.5)
       end
    end
end
