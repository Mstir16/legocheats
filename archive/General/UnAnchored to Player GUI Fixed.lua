if not _G.ini then
_G.ini = true

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://216917652"
sound.Parent = game:GetService("SoundService")
sound:Play()

teleport = false

wait()
game.StarterGui:SetCore("SendNotification", {
Title = "Unanchored To Player"; -- the title (ofc)
Text = "GUI Loaded - F to Hide/Show"; -- what the text says (ofc)
Duration = 5; -- how long the notification should in secounds
})

print "================UNANCHORED TO PLAYER LOADED================"
print "================ORIGINALLY MADE BY TomQ#6764================"
print "================FIXED BY Lomares#3815================"
print "================CREDITS TO INFINITE YIELD FOR TPUA COMMAND================"


local heartbeat = game:GetService("RunService").Heartbeat
spawn(function()
    while true do heartbeat:Wait()
            game.Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
            sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.pow(math.huge,math.huge)*math.huge)
            game:GetService("RunService").Stepped:wait()
end
end)

local Imput = game:GetService("UserInputService")
local Plr = game.Players.LocalPlayer
local Mouse = Plr:GetMouse()

local parts = {}

function add(part)
 if part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
  table.insert(parts,part)
 end
end

for _,v in pairs(workspace:GetDescendants()) do
 add(v)
end

workspace.DescendantAdded:Connect(function(part)
 if part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
     add(part)
 end
end)

function To(position)
local Chr = Plr.Character
local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://3398620867"
sound2.Parent = game:GetService("SoundService")
if Chr ~= nil then
if teleport == false then
for index, part in pairs(game:GetDescendants()) do
if part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then --// Checks Part Properties
    part.CFrame = CFrame.new(position) --TP Part To Mouse
    sound2:Play()

    if spam == true and part:FindFirstChild("BodyGyro") == nil then
    local bodyPos = Instance.new("BodyPosition")
    bodyPos.Position = part.Position
    bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyPos.P = 1e6
    bodyPos.Parent = part
    end
end
end
else

    Chr:MoveTo(position)
end
end
end





Imput.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and Imput:IsKeyDown(Enum.KeyCode.LeftControl) then
       To(Mouse.Hit.p)
   end
end)







-- key that opens/closes the ui
local toggle_key = Enum.KeyCode.F

local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

-- ui functions
fade = function(obj, len, props)
	ts:Create(obj, TweenInfo.new(len, Enum.EasingStyle.Sine), props):Play()
end

-- shorthand variables
local u2, c3 = UDim2.new, Color3.fromRGB
local u2f, c3w = u2(1, 0, 1, 0), c3(255, 255, 255)

-- ui init
local g = Instance.new("ScreenGui", game.CoreGui)
local f = Instance.new("Frame", g)
local t = Instance.new("TextLabel", f)
local c = Instance.new("ScrollingFrame", f)

-- core ui styling
local padding = Instance.new("UIPadding", f)
local maxsize = Instance.new("UISizeConstraint", f)
local textsize = Instance.new("UITextSizeConstraint", t)
local listcons = Instance.new("UIListLayout", c)

padding.PaddingBottom = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.PaddingTop = UDim.new(0, 0)

maxsize.MaxSize = Vector2.new(275, 450)
maxsize.MinSize = Vector2.new(200, 0)
textsize.MaxTextSize = 16
listcons.Padding = UDim.new(0, 3)

-- ui instance properties
g.Name = "unanchor_ui"
g.ResetOnSpawn = false
f.Name = "main"
t.Name = "header"

f.Size = u2(0.165, 0, 0.6, 0)
f.BorderSizePixel = 0
f.BackgroundTransparency = 0.3
f.Position = u2(1, -215, 0.5, -150)
f.BackgroundColor3 = c3()
f.AnchorPoint = Vector2.new(1, 0.5)
f.Position = u2(1, -15, 0.5, 0)

t.Size = u2(1, 0, 0.1, 0)
t.BackgroundTransparency = 1
t.TextColor3 = c3w
t.Font = Enum.Font.GothamBold
t.TextScaled = true
t.TextXAlignment = Enum.TextXAlignment.Center
t.Text = "(FIXED) UNANCHORED TO PLAYER BY Lomares#3815"

c.Name = "playerlist"
c.Position = u2(0, 0, 0.1, 0)
c.Size = u2(1, 0, 0.45, 0)
c.BackgroundTransparency = 1
c.BorderSizePixel = 0
c.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
c.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
c.ScrollingDirection = Enum.ScrollingDirection.Y
c.ScrollBarThickness = 5
c.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

-- playerlist entry ui template
local temp = Instance.new("Frame", f)
temp.Name = "temp"
temp.Visible = false
temp.Size = u2(1, -5, 0, 27)
temp.BackgroundTransparency = 0.5
temp.BorderSizePixel = 0
temp.ClipsDescendants = true
temp.BackgroundColor3 = c3()

local tpad = Instance.new("UIPadding", temp)
tpad.PaddingLeft = UDim.new(0, 5)
tpad.PaddingRight = UDim.new(0, 5)

local tb = Instance.new("TextButton", temp)
tb.Name = "button"
tb.BackgroundTransparency = 1
tb.ZIndex = 5
tb.BorderSizePixel = 0
tb.Text = ""
tb.Size = u2(1, 10, 1, 0)
tb.Position = u2(0, -5, 0, 0)

local tcl = Instance.new("TextLabel", temp)
tcl.Name = "username"
tcl.BackgroundTransparency = 1
tcl.BorderSizePixel = 0
tcl.Size = u2f
tcl.TextColor3 = c3w
tcl.TextXAlignment = Enum.TextXAlignment.Left
tcl.TextScaled = true
tcl.Size = u2(0.6, 0, 1, 0)
tcl.Font = Enum.Font.Gotham

local tcls = Instance.new("UITextSizeConstraint", tcl)
tcls.MaxTextSize = 14

local thumb = Instance.new("ImageLabel", temp)
thumb.Name = "thumb"
thumb.Size = u2(0.35, 0, 0.35, 0)
thumb.SizeConstraint = Enum.SizeConstraint.RelativeXX
thumb.Position = u2(1, 0, 0, -15)
thumb.AnchorPoint = Vector2.new(1, 0)
thumb.BackgroundTransparency = 1
thumb.BorderSizePixel = 0

-- settings ui
local sh = Instance.new("TextLabel", f)
sh.Name = "settings_header"
sh.Size = u2(1, 0, 0.1, 0)
sh.Position = u2(0, 0, 0.55, 0)
sh.BackgroundTransparency = 1
sh.BorderSizePixel = 0
sh.ZIndex = 3
sh.TextColor3 = c3w
sh.Font = Enum.Font.GothamBold
sh.TextScaled = true
sh.TextXAlignment = Enum.TextXAlignment.Center
sh.Text = "SETTINGS"

local shs = Instance.new("UITextSizeConstraint", sh)
shs.MaxTextSize = 16

local items = Instance.new("ScrollingFrame", f)
items.Name = "items"
items.Size = u2(1, 0, 0.35, 0)
items.Position = u2(0, 0, 0.65, 0)
items.BackgroundTransparency = 1
items.BorderSizePixel = 0
items.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
items.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
items.ScrollingDirection = Enum.ScrollingDirection.Y
items.ScrollBarThickness = 5
items.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local itemll = Instance.new("UIListLayout", items)
itemll.Padding = UDim.new(0, 3)

createSetting = function(name)
	local setting = Instance.new("Frame", items)
	setting.Size = u2(1, -5, 0, 27)
	setting.BackgroundColor3 = c3()
	setting.BackgroundTransparency = 0.5
	setting.BorderSizePixel = 0
	
	local spad = tpad:Clone()
	spad.Parent = setting
	
	local slab = tcl:Clone()
	slab.Name = "label"
	slab.Parent = setting
	slab.Size = u2(1, 0, 1, 0)
	slab.Text = name
	
	local stbt = tb:Clone()
	stbt.Parent = setting
	
	stbt.MouseEnter:connect(function()
		fade(setting, 0.25, {BackgroundTransparency = 0.8})
	end)
	
	stbt.MouseLeave:connect(function()
		fade(setting, 0.25, {BackgroundTransparency = 0.5})
	end)
	
	items.CanvasSize = u2(0, 0, 0, itemll.AbsoluteContentSize.Y)
	
	return stbt
end


-- settings & functionality



    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://179235828"
    sound.Parent = game:GetService("SoundService")


spam = false
local spamblocks = createSetting("Part Spam")
spamblocks.MouseButton1Down:connect(function()
spam = not spam
    if spam then
        fade(spamblocks.Parent.label, 0.25, {TextColor3 = c3(52, 189, 98)})
        sound:Play()

        function SpamUA()
            local players = game.Players:GetPlayers()
            for i,v in pairs(players) do
            	local Forces = {}
            	for _,part in pairs(parts) do
            	    if part == nil then continue end
            	    
            		if v.Character:FindFirstChild('Head') and v.Name == Target then
            			for i,c in pairs(part:GetChildren()) do
            				if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
            					c:Destroy()
            				end
            			end
            			local ForceInstance = Instance.new("BodyPosition")
            			local GyroInstance = Instance.new("BodyGyro")
            			GyroInstance.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            			ForceInstance.Parent = part
            			ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            			table.insert(Forces, ForceInstance)
            			table.insert(Forces, GyroInstance)
            		end
            	end
            	for i,c in pairs(Forces) do
            	    if c:IsA("BodyPosition") then
            		    c.Position = v.Character.Head.Position
            		else
            		    c.CFrame = v.Character.Head.CFrame * CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
            		end
            	end
            end
        end

        repeat
            SpamUA()
            wait()
        until spam == false
    else
       fade(spamblocks.Parent.label, 0.25, {TextColor3 = c3w})
       sound:Play()
    end
end)

viewT = false
local VT = createSetting("View Target")
VT.MouseButton1Down:connect(function()
viewT = not viewT
    if viewT then
        fade(VT.Parent.label, 0.25, {TextColor3 = c3(52, 189, 98)})
        sound:Play()

        local v = game.Players:FindFirstChild(getgenv().Target)

        if viewDied then
			viewDied:Disconnect()
			viewChanged:Disconnect()
		end
		viewing = v
		workspace.CurrentCamera.CameraSubject = viewing.Character
		local function viewDiedFunc()
			repeat wait() until v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil
			workspace.CurrentCamera.CameraSubject = viewing.Character
		end
		viewDied = v.CharacterAdded:Connect(viewDiedFunc)
		local function viewChangedFunc()
			workspace.CurrentCamera.CameraSubject = viewing.Character
		end
		viewChanged = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
    else
       fade(VT.Parent.label, 0.25, {TextColor3 = c3w})
       sound:Play()
       
       if viewing ~= nil then
    		viewing = nil
    	end
    	if viewDied then
    		viewDied:Disconnect()
    		viewChanged:Disconnect()
    	end
    	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
    end
end)

createSetting("Reset").MouseButton1Down:connect(function()
    sound:Play()
	game.Players.LocalPlayer.Character:BreakJoints()
end)


highlight = false
local highlights = createSetting("Highlight Unanchored")
highlights.MouseButton1Down:connect(function()
highlight = not highlight
    if highlight then
        fade(highlights.Parent.label, 0.25, {TextColor3 = c3(52, 189, 98)})
        sound:Play()
        print "UTP: Unanchored Highlighted"
        for _,part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
            local selectionBox = Instance.new("SelectionBox")
            selectionBox.Adornee = part
            selectionBox.Color3 = Color3.new(1,0,0)
            selectionBox.Parent = part
        end
        end
    else
        fade(highlights.Parent.label, 0.25, {TextColor3 = c3w})
        sound:Play()
        print "UTP: Unanchored Un-Highlighted"
        for _,part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
            if part:FindFirstChild("SelectionBox") then
            part.SelectionBox:Destroy()
            end
        end
end
end
end)

createSetting("Count Unanchored Parts").MouseButton1Down:connect(function()
    sound:Play()
    b = 0
    for index, part in pairs(game.workspace:GetDescendants()) do
    if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
        b = b + 1
    end
    end
    print ("All parts checked, found", b ,"that are unanchored")
end)

createEntry = function(name, id)
	local entry = temp:Clone()
	entry.Parent = c
	entry.username.Text = name
	entry.thumb.Image = game:GetService("Players"):GetUserThumbnailAsync(id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	entry.Visible = true
	entry.LayoutOrder = #c:GetChildren()
	entry.Name = name

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3398620867"
    sound.Parent = game:GetService("SoundService")
	-- handle clicking for player
	entry.button.MouseButton1Down:connect(function()
		getgenv().Target = name
        sound:Play()
        game.StarterGui:SetCore("SendNotification", {
        Title = "Unanchored To Player"; -- the title (ofc)
        Text = "New Target: "..name; -- what the text says (ofc)
        Duration = 5; -- how long the notification should in secounds
        })
	end)
	
	entry.button.MouseEnter:connect(function()
		fade(entry, 0.25, {BackgroundTransparency = 0.8})
	end)
	
	entry.button.MouseLeave:connect(function()
		fade(entry, 0.25, {BackgroundTransparency = 0.5})
	end)
end

deleteEntry = function(name)
	for _,v in pairs(c:GetChildren()) do
		if v.Name == name then
			v:Destroy()
		end
	end
end

-- create entry for client
createEntry(game.Players.LocalPlayer.Name, game.Players.LocalPlayer.UserId)

-- create entries for all other players
for _,v in pairs(game.Players:GetPlayers()) do
	if v ~= game.Players.LocalPlayer then
		createEntry(v.Name, v.UserId)
	end
end

listcons:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
	c.CanvasSize = u2(0, 0, 0, listcons.AbsoluteContentSize.Y)
end)

itemll:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function()
	items.CanvasSize = u2(0, 0, 0, itemll.AbsoluteContentSize.Y)
end)

uis.InputBegan:connect(function(input, gpe)
	if not gpe then
		if input.KeyCode == toggle_key then
			g.Enabled = not g.Enabled
		end
	end
end)

-- dragging code, ripped from https://devforum.roblox.com/t/draggable-property-is-hidden-on-gui-objects/107689/5
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	f.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

f.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = f.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

f.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

uis.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

game.Players.PlayerAdded:connect(function(plr)
	createEntry(plr.Name, plr.UserId)
end)

game.Players.PlayerRemoving:connect(function(plr)
	deleteEntry(plr.Name)
end)
else
print "================ALREADY LOADED================"

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://2130284653"
    sound.Parent = game:GetService("SoundService")
sound:Play()

game.StarterGui:SetCore("SendNotification", {
Title = "Already Loaded"; -- the title (ofc)
Text = "GUI Already Loaded"; -- what the text says (ofc)
Duration = 5; -- how long the notification should in secounds
})
end

