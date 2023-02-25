local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local KA = false
local KAD = 0
local FR = false
local AD = false
local ADD = 0
local direction = {"left","right","back"}

local X = Material.Load({
	Title = "Boxing [BETA] | m1kecorp©",
	Style = 1,
	SizeX = 300,
	SizeY = 300,
	Theme = "Dark",
	ColorOverrides = {
    		MainFrame = Color3.fromRGB(25,25,25),
    		Minimise = Color3.fromRGB(255,106,0),
    		MinimiseAccent = Color3.fromRGB(147,59,0),
    		Maximise = Color3.fromRGB(25,255,0),
    		MaximiseAccent = Color3.fromRGB(0,255,110),
    		NavBar = Color3.fromRGB(55,55,55),
    		NavBarAccent = Color3.fromRGB(255,255,255),
    		NavBarInvert = Color3.fromRGB(235,235,235),
    		TitleBar = Color3.fromRGB(35,35,35),
    		TitleBarAccent = Color3.fromRGB(255,255,255),
    		Overlay = Color3.fromRGB(175,175,175),
    		Banner = Color3.fromRGB(55,55,55),
    		BannerAccent = Color3.fromRGB(255,255,255),
    		Content = Color3.fromRGB(85,85,85),
    		Button = Color3.fromRGB(63, 63, 63),
    		ButtonAccent = Color3.fromRGB(205,205,205),
    		ChipSet = Color3.fromRGB(235,235,235),
    		ChipSetAccent = Color3.fromRGB(75,75,75),
    		DataTable = Color3.fromRGB(235,235,235),
    		DataTableAccent = Color3.fromRGB(75,75,75),
    		Slider = Color3.fromRGB(75, 75, 75),
    		SliderAccent = Color3.fromRGB(182, 182, 182),
    		Toggle = Color3.fromRGB(205,205,205),
    		ToggleAccent = Color3.fromRGB(26, 26, 26),
    		Dropdown = Color3.fromRGB(75,75,75),
    		DropdownAccent = Color3.fromRGB(125,125,125),
    		ColorPicker = Color3.fromRGB(75,75,75),
    		ColorPickerAccent = Color3.fromRGB(235,235,235),
    		TextField = Color3.fromRGB(255, 255, 255),
    		TextFieldAccent = Color3.fromRGB(255,255,255),
    }
})

local main = X.New({
	Title = "MAIN"
})

local function GetClosestPlayer()
   local bestdistance,player = nil,nil
    
   for i,v in pairs(game.Players:GetPlayers()) do
       if v == game.Players.LocalPlayer then continue end
       
       local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
       if bestdistance == nil and player == nil then
           bestdistance = distance
           player = v
       elseif bestdistance > distance then
           player = v
           bestdistance = distance
       end
   end
   
   if bestdistance > 20 then
      player = nil 
   end
   
   return player
end

main.Toggle({
	Text = "Kill Aura",
	Callback = function(Value)
	    KA = Value
	    
	    while task.wait(KAD) and KA do
	        if GetClosestPlayer() == nil then continue end
	        local args = {
                [1] = GetClosestPlayer(),
                [2] = GetClosestPlayer().Character.HumanoidRootPart.Position,
                [3] = false,
                [4] = "back"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerImpactRemote"):FireServer(unpack(args))
	    end
	end,
	Enabled = KA
})

main.Slider({
	Text = "Kill Aura Delay(decimal)",
	Callback = function(Value)
	    if Value ~= 10 then
	        Value = tonumber("0."..tostring(Value))
	    else
	        Value = 1
	    end
	
		KAD = Value
	end,
	Min = 0,
	Max = 10,
	Def = KAD
})

main.Toggle({
	Text = "Faster Stamina Regen",
	Callback = function(Value)
	   FR = Value
	    
	   while task.wait() and FR do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerStaminaRemote"):FireServer("block")
            task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerStaminaRemote"):FireServer("unblocking")
        end
	end,
	Enabled = FR
})


main.Toggle({
	Text = "Auto Dodge",
	Callback = function(Value)
	    AD = Value
	    
	    while task.wait(ADD) and AD do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerDodgeRemote"):FireServer(direction[math.random(1,#direction)])
	    end
	end,
	Enabled = AD
})

main.Slider({
	Text = "Auto Dodge Delay (decimal)",
	Callback = function(Value)
	    if Value ~= 10 then
	        Value = tonumber("0."..tostring(Value))
	    else
	        Value = 1
	    end
		ADD = Value
	end,
	Min = 0,
	Max = 10,
	Def = ADD
})
