--// VARS \\--
local plr = game.Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local TreadX,TreadY
local TreadMode
local MinStam = 20
local MaxFatigue = 60
local AutoTreadmill = false
local AutoVanilla = false
local AutoBuyShake = false
local MoneyFarm = false
local AutoSleep = false
local AutoCST = false
local AutoBench = false
local AutoStrikeForce = false
local AutoTreadFunc
local AutoMoneyFunc
local AutoVanillaFunc
local AutoBuyShakeFunc
local AutoSleepFunc
local AutoCSTFunc
local AutoBenchFunc
local AutoStrikeForceFunc

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

local UIToggles = {}
local preenabled = {}

UIToggles["A"] = main.Toggle({
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

local TreadmillModeDD = main.Dropdown({
	Text = "Treadmill Mode (REQUIRED)",
	Callback = function(Value)
		TreadMode = Value
		
		if TreadMode == "Stamina" then
            TreadX,TreadY = 714,462
        elseif TreadMode == "Speed" then
            TreadX,TreadY = 1171,462
        end
	end,
	Options = {
		"Stamina",
		"Speed",
	},
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "Pick What Button to use on Treadmill"
			})
		end
	}
})

UIToggles["B"] = main.Toggle({
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

UIToggles["F"] = main.Toggle({
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

UIToggles["G"] = main.Toggle({
	Text = "Auto Benchpress",
	Callback = function(Value)
		AutoBench = Value
		
		if AutoBench then
		   task.spawn(function()
		       pcall(function()
		            AutoBenchFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoBench
})

UIToggles["H"] = main.Toggle({
	Text = "Auto Strike Force",
	Callback = function(Value)
		AutoStrikeForce = Value
		
		if AutoStrikeForce then
		   task.spawn(function()
		       pcall(function()
		            AutoStrikeForceFunc()
		       end)
		   end)
		end
	end,
	Enabled = AutoStrikeForce
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

UIToggles["D"] = main.Toggle({
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


UIToggles["E"] = main.Toggle({
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
    for i,v in pairs(UIToggles) do
        local currentState = v:GetState()
        local toggleletter = i
        
        if currentState == true then
            table.insert(preenabled,#preenabled+1,toggleletter) 
        end
        v:SetState(false)
    end
end

local function enableCached()
    for letter,toggle in pairs(UIToggles) do
        for i,v in pairs(preenabled) do
            if letter == v then
                toggle:SetState(true) 
            end
        end
    end
    preenabled = {}
end

local reenablefunc = nil

local function IsFatigueMax()
    local Fatigue = plr.Stats.Fatigue.Value
    
    if Fatigue >= MaxFatigue then
        disableAll()
        coroutine.resume(coroutine.create(function()
            if reenablefunc == nil then
                reenablefunc = true
                repeat 
                    task.wait() 
                    local FatigueCheck = plr.Stats.Fatigue.Value
                until FatigueCheck <= 0
                enableCached()
                task.wait(1)
                reenablefunc = nil
            end
        end))
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
    
    for i,v in pairs(workspace.Treadmills:GetChildren()) do
        local distance = (plr.Character.HumanoidRootPart.Position - v:FindFirstChild("Conveyor").Position).magnitude
        table.insert(collection,#collection+1,distance) 
    end
    
    table.sort(collection)
    
    local closestDistance = collection[1]
    
    for i,v in pairs(workspace.Treadmills:GetChildren()) do
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

local function GetBenchSeat()
    for i,v in pairs(workspace["Benchpress Seats"]:GetChildren()) do
        if v.Occupant == nil then
            return v 
        end
    end
end

local function GetItem(name)
   for i,v in pairs(workspace.Purchaseables2:GetDescendants()) do
       if v.Name:find(name) and v:IsA("Model") then
            return v 
       end
   end
end

local function GetClosestBag()
    local collection = {}
    
    for i,v in pairs(workspace.Live:GetChildren()) do
        if v.Name:find("Boxing Bag") then
            local distance = (plr.Character.HumanoidRootPart.Position - v:FindFirstChild("Torso").Position).magnitude
            table.insert(collection,#collection+1,distance)  
        end
    end
    
    table.sort(collection)
    
    local closestDistance = collection[1]
    
    for i,v in pairs(workspace.Live:GetChildren()) do
        if v.Name:find("Boxing Bag") then
            local distance = (plr.Character.HumanoidRootPart.Position - v:FindFirstChild("Torso").Position).magnitude
            
            if distance <= closestDistance then
                return v
            end
        end
    end
end

--// Feature Functions \\--


AutoTreadFunc = function()
   local plr = plr

    local treadmill = GetClosestTreadmill()
    local TMCD = treadmill:FindFirstChild("Conveyor").ClickDetector
    
    while AutoTreadmill and task.wait() do
        if plr.Character.HumanoidRootPart.Anchored == false and TreadX ~= nil and TreadY ~= nil and AutoTreadmill then
            if plr.Character.Humanoid.WalkSpeed ~= 16 then
                ToggleRun() 
            end
            
            plr.Character.HumanoidRootPart.CFrame = treadmill:FindFirstChild("Conveyor").CFrame
            task.wait(0.4)
            fireclickdetector(TMCD)
            task.wait(0.4)
            vim:SendMouseButtonEvent(TreadX,TreadY, 0, true, plr.PlayerGui.TreadGui, 1)
            task.wait()
            vim:SendMouseButtonEvent(TreadX,TreadY, 0, false, plr.PlayerGui.TreadGui, 1)
            task.wait(0.2)
        elseif plr.Character.HumanoidRootPart.Anchored == true and TreadX ~= nil and TreadY ~= nil and AutoTreadmill then
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
        local wasOn = nil
        
        if w and plr.Character ~= nil then
            if UIToggles["G"]:GetState() == true then
                UIToggles["G"]:SetState(false)
                wasOn = UIToggles["G"]
                task.wait(1)
                vim:SendKeyEvent(true, "L", false, game)
                repeat task.wait(1) until plr.PlayerGui:FindFirstChild("MinigameGui").Enabled == false
                task.wait(1)
            end
            
            w.Parent = plr.Character
            task.wait(0.5)
            w = plr.Character:FindFirstChild("Vanilla Protein Shake")
            w:Activate()
            task.wait(1.5)
            if wasOn ~= nil then
                wasOn:SetState(true)
                task.wait()
                wasOn = nil
            end
            task.wait(28.5)
            
        else
        end
    end
end

AutoBuyShakeFunc = function()
    local Shake = GetItem("Protein Shake")
	
    while AutoBuyShake and task.wait() do
       local distance = (plr.Character.HumanoidRootPart.Position - Shake.Head.Position).magnitude
       
       if distance > 7 then plr.Character.HumanoidRootPart.CFrame = Shake.Head.CFrame task.wait(0.2) continue end
       
       plr.Character.HumanoidRootPart.CFrame = Shake.Head.CFrame
       task.wait()
       fireclickdetector(Shake.ClickDetector,5)
    end
end

AutoMoneyFunc = function()
    local jobpart = workspace.JobBoard.GetJob
	local jobCD = jobpart.ClickDetector
	local dropoff = workspace.DropOffPoint
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
		    if plr.Character.Humanoid.SeatPart ~= nil then
		         plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		         task.wait(0.2)
		    end
		    
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
    local CST = workspace.Purchaseables2.NonChangeable["Combat Speed Training $70"]
    local CSTCD = CST.ClickDetector
    local CSTCF = CFrame.new(-3229.66016, -2071.5459, 1768.86389, -0.013615814, -9.55438679e-08, -0.999907315, 4.63641436e-09, 1, -9.56158601e-08, 0.999907315, -5.93787197e-09, -0.013615814)
    
    while AutoCST and task.wait() do
       local CSTUI = plr.PlayerGui:FindFirstChild("MinigameGui")
       local CSTCheck = plr.Backpack:FindFirstChild("Combat Speed Training")
       
       if CSTCheck == nil and CSTUI.Enabled ~= true or CSTCheck ~= nil and CSTUI.Enabled ~= true and AutoCST then
          if CSTCheck == nil then
	          local distance = (plr.Character.HumanoidRootPart.Position - CSTCF.Position).magnitude
       
              if distance > 10 then plr.Character.HumanoidRootPart.CFrame = CSTCF task.wait(0.2) continue end
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
	
AutoBenchFunc = function()
    	local Seat = GetBenchSeat()
	local BenchUI = plr.PlayerGui:FindFirstChild("MinigameGui")


	while AutoBench and task.wait() do
	    if BenchUI.Enabled == true and BenchUI.KeyToPress.TextTransparency == 0 and BenchUI.KeyToPress.TextColor3 == Color3.fromRGB(255,255,255) and AutoBench then
		if BenchUI.KeyToPress.TextColor3 == Color3.fromRGB(255,255,255) and BenchUI.KeyToPress.TextColor3 ~= Color3.fromRGB(255,0,0) then
		    task.wait(0.1)
		    vim:SendKeyEvent(true, BenchUI.KeyToPress.Text, false, game)
		    repeat task.wait(0.1) until BenchUI.KeyToPress.TextColor3 == Color3.fromRGB(255,255,255) or AutoBench == false
		    continue
		end
	    end

	    if StaminaStatus() == "recharge" and AutoBench then
		repeat task.wait() until StaminaStatus() == "max"
		continue
	    end

	    if Seat.Occupant == nil and AutoBench then
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(Seat.CFrame.X + math.random(0,1),Seat.CFrame.Y + math.random(1,3),Seat.CFrame.Z - math.random(0,1))
		continue
	    end
	end
end

AutoStrikeForceFunc = function()
    local BoxingBag = GetClosestBag()
    local LimbWeights = GetItem("Limb Weights")
    
    while task.wait() and AutoStrikeForce do
        local LimbWCheck = plr.Character:FindFirstChild("LimbWeights")
        
        if LimbWCheck and AutoStrikeForce then
            repeat
                if plr.Backpack:FindFirstChild("Fists") and not plr.Character:FindFirstChild("Fists") then
                   plr.Backpack.Fists.Parent = plr.Character
                   task.wait(0.5)
                end
                plr.Character.HumanoidRootPart.CFrame = BoxingBag.Torso.CFrame * CFrame.new(3,0,0) * CFrame.Angles(0,math.rad(90),0)
                task.wait()
                vim:SendMouseButtonEvent(0, 500, 0, true, game, 1)
    			task.wait()
    			vim:SendMouseButtonEvent(0, 500, 0, false, game, 1)
                task.wait()
            until AutoStrikeForce == false
        elseif not LimbWCheck and AutoStrikeForce then
            if plr.Backpack:FindFirstChild("Limb Weights") then
                local lw = plr.Backpack:FindFirstChild("Limb Weights")
                lw.Parent = plr.Character
                lw = plr.Character:FindFirstChild("Limb Weights")
                task.wait()
                lw:Activate()
                task.wait(0.1)
                plr.Character.Humanoid:UnequipTools()
                task.wait()
            else
                local distance = (plr.Character.HumanoidRootPart.Position - LimbWeights.Head.Position).magnitude
                       
                if distance > 7 then plr.Character.HumanoidRootPart.CFrame = LimbWeights.Head.CFrame task.wait(0.2) continue end
                
                plr.Character.HumanoidRootPart.CFrame = LimbWeights.Head.CFrame
               task.wait()
               fireclickdetector(LimbWeights.ClickDetector,5)
               task.wait(0.1)
            end
        end
    end
end
