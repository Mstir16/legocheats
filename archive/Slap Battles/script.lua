local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local KA = false
local radius = 20
local AR = false
local TP = false

local X = Material.Load({
	Title = "Slap Battles | m1kecorp©",
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
    
   pcall(function()
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
       
       if bestdistance > radius then
          player = nil 
       end
   end)
   return player
end

main.Toggle({
	Text = "Slap Stun Lock",
	Callback = function(Value)
	    KA = Value
	    
	    while task.wait() and KA do
	        pcall(function()
	            game:GetService("ReplicatedStorage"):WaitForChild("b"):FireServer(GetClosestPlayer().Character.Torso)
	        end)
	    end
	end,
	Enabled = KA
})

main.Slider({
	Text = "Player Detection Radius",
	Callback = function(Value)
		radius = Value
	end,
	Min = 0,
	Max = 30,
	Def = radius
})

main.Toggle({
	Text = "Anti Ragdoll",
	Callback = function(Value)
	    AR = Value
	    
	    while task.wait() and AR do
	       pcall(function()
	           if game.Players.LocalPlayer.Character.Ragdolled.Value == true then
	              repeat game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true task.wait() until game.Players.LocalPlayer.Character.Ragdolled.Value == false
	              task.wait()
	              game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
	           end
	       end)
	    end
	end,
	Enabled = AR
})
