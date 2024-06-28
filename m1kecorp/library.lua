game.Players.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
end)

local Library = {}

function Library:Window(winName,mainColor,hideBind)
    winName = winName or "brought to you by m1kecorp"
    mainColor = mainColor or Color3.fromRGB(104, 186, 227)
    hideBind = hideBind or Enum.KeyCode.RightAlt

    if _G.Library ~= nil then _G.Library:Destroy() end
    
    _G.UISettings = {
        UIBind = hideBind,
        UIConfig = {},
        ElementCache = {},
    }

    local function Tween(which,gui,UDimStuff,time)
        task.spawn(function()
            pcall(function()
                if which == "size" then
                    gui:TweenSize(UDimStuff,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,time)
                elseif which == "pos" then
                    gui:TweenPosition(UDimStuff,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,time)
                else
                    local TweenService = game:GetService("TweenService")
                    TweenService:Create(
                            gui,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        UDimStuff
                    ):Play()
                end
            end)
        end)
    end

    local function UpdateFrameSize(scrollframe,listlayout)
        local cS = listlayout.AbsoluteContentSize

        game.TweenService:Create(scrollframe, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
        }):Play()
    end

    local function hidebindConfig()
        local uis = game:GetService("UserInputService")
        uis.InputBegan:Connect(function(input,chat)
            if chat then return end

            if input.KeyCode == hideBind then
                Tabs.ToggleVisiblity()
            end	
        end)
    end

    local function dragify(Frame)
    dragToggle = nil
    dragSpeed = .25 -- You can edit this.
    dragInput = nil
    dragStart = nil
    dragPos = nil
    
    function updateInput(input)
    Delta = input.Position - dragStart
    Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
    end
    
    Frame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
    dragToggle = true
    dragStart = input.Position
    startPos = Frame.Position
    input.Changed:Connect(function()
    if (input.UserInputState == Enum.UserInputState.End) then
    dragToggle = false
    end
    end)
    end
    end)
    
    Frame.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    dragInput = input
    end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
    if (input == dragInput and dragToggle) then
    updateInput(input)
    end
    end)
    end

    local function Ripple(obj)
        task.spawn(
            function()
                local Mouse = game.Players.LocalPlayer:GetMouse()
                local Circle = Instance.new("ImageLabel")
                Circle.Name = "Circle"
                Circle.Parent = obj
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 1.000
                Circle.ZIndex = 10
                Circle.Image = "rbxassetid://266543268"
                Circle.ImageColor3 = Color3.fromRGB(211, 211, 211)
                Circle.ImageTransparency = 0.6
                local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
                Circle.Position = UDim2.new(0, NewX, 0, NewY)
                local Size = 0
                if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
                    Size = obj.AbsoluteSize.X * 1
                elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
                    Size = obj.AbsoluteSize.Y * 1
                elseif obj.AbsoluteSize.X == obj.AbsoluteSize.Y then
                    Size = obj.AbsoluteSize.X * 1
                end
                Circle:TweenSizeAndPosition(
                    UDim2.new(0, Size, 0, Size),
                    UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
                    "Out",
                    "Quad",
                    0.2,
                    false
                )
                for i = 1, 15 do
                    Circle.ImageTransparency = Circle.ImageTransparency + 0.05
                    wait()
                end
                Circle:Destroy()
            end
        )
    end

    local FirstTab = false
    local UI = Instance.new("ScreenGui")
    local BG = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local elementFrame = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local GlowFrame = Instance.new("ImageLabel")
    local GlowCorner = Instance.new("UICorner")
    local Color = Instance.new("UIStroke")
    local Color_3 = Instance.new("TextLabel")
    local stroke = Instance.new("Frame")
    local Color_4 = Instance.new("UIStroke")
    local GlowFrame_2 = Instance.new("ImageLabel")
    local GlowCorner_2 = Instance.new("UICorner")
    local tabH = Instance.new("ScrollingFrame")
    local UIListLayout_3 = Instance.new("UIListLayout")
    local seperator = Instance.new("Frame")

    function randomString()
    	local length = math.random(10,20)
    	local array = {}
    	for i = 1, length do
    		array[i] = string.char(math.random(32, 126))
    	end
    	return table.concat(array)
    end

    PARENT = nil
    if get_hidden_gui or gethui then
    	local hiddenUI = get_hidden_gui or gethui
    	local Main = Instance.new("ScreenGui")
    	Main.Name = randomString()
    	Main.Parent = hiddenUI()
    	PARENT = Main
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
    	local Main = Instance.new("ScreenGui")
    	Main.Name = randomString()
    	syn.protect_gui(Main)
    	Main.Parent = COREGUI
    	PARENT = Main
    elseif COREGUI:FindFirstChild('RobloxGui') then
    	PARENT = COREGUI.RobloxGui
    else
    	local Main = Instance.new("ScreenGui")
    	Main.Name = randomString()
    	Main.Parent = COREGUI
    	PARENT = Main
    end

    UI.Name = "UI"
    UI.Parent = PARENT
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UI.ResetOnSpawn = false
    _G.Library = PARENT

    BG.Name = "BG"
    BG.Parent = UI
    BG.BackgroundColor3 = Color3.fromRGB(27,27,27)
    BG.ClipsDescendants = true
    BG.Position = UDim2.new(0.380143136, 0, 0.367031574, 0)
    BG.Size = UDim2.new(0, 656, 0, 387)

    UICorner.Parent = BG

    elementFrame.Name = "elementFrame"
    elementFrame.Parent = BG
    elementFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
    elementFrame.Position = UDim2.new(0.298690677, 0, 0.148893297, 0)
    elementFrame.Size = UDim2.new(0, 446, 0, 309)

    UICorner_2.Parent = elementFrame

    GlowFrame.Name = "GlowTab"
    GlowFrame.Parent = elementFrame
    GlowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GlowFrame.BackgroundTransparency = 1.000
    GlowFrame.BorderSizePixel = 0
    GlowFrame.Position = UDim2.new(0, -15, 0, -15)
    GlowFrame.Size = UDim2.new(1, 30, 1, 30)
    GlowFrame.ZIndex = 0
    GlowFrame.Image = "rbxassetid://4996891970"
    GlowFrame.ImageColor3 = mainColor
    GlowFrame.ScaleType = Enum.ScaleType.Slice
    GlowFrame.SliceCenter = Rect.new(20, 20, 280, 280)
    GlowFrame.ImageTransparency = 0

    GlowCorner.Parent = GlowFrame

    Color.Color = mainColor
    Color.Name = "Color"
    Color.Parent = elementFrame
    Color.Thickness = 2
    Color.Transparency = 0.699999988079071

    Color_3.Name = "Color"
    Color_3.Parent = BG
    Color_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Color_3.BackgroundTransparency = 1.000
    Color_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Color_3.Position = UDim2.new(0.0326434411, 0, 0.0310933907, 0)
    Color_3.Size = UDim2.new(0, 630, 0, 27)
    Color_3.Font = Enum.Font.Gotham
    Color_3.Text = winName
    Color_3.TextColor3 = mainColor
    Color_3.TextScaled = true
    Color_3.TextSize = 14.000
    Color_3.TextWrapped = true

    stroke.Name = "stroke"
    stroke.Parent = BG
    stroke.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    stroke.Position = UDim2.new(0.0478682891, 0, 0.122643776, 0)
    stroke.Size = UDim2.new(0, 611, 0, 0)

    Color_4.Color = mainColor
    Color_4.Name = "Color"
    Color_4.Parent = stroke
    Color_4.Thickness = 0.699999988079071

    tabH.Name = "tabH"
    tabH.Parent = BG
    tabH.Active = true
    tabH.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabH.BackgroundTransparency = 1.000
    tabH.Position = UDim2.new(-0.000775280409, 0, 0.152454779, 0)
    tabH.Size = UDim2.new(0, 195, 0, 300)
    tabH.ScrollBarThickness = 2

    UIListLayout_3.Parent = tabH
    UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_3.Padding = UDim.new(0, 9)

    tabH.ChildAdded:Connect(function()
        UpdateFrameSize(tabH,UIListLayout_3)
    end)
    
    tabH.ChildRemoved:Connect(function()
        UpdateFrameSize(tabH,UIListLayout_3)
    end)

    seperator.Name = "seperator"
    seperator.Parent = tabH
    seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    seperator.BackgroundTransparency = 1.000
    seperator.Size = UDim2.new(0, 167, 0, 7)
    
    local Tabs = {}

    function Tabs.ToggleVisiblity()
        task.spawn(function()
            UI.Enabled = not UI.Enabled
        end)
    end

    function Tabs.Notify(config)
        local title = config.Title
        local text = config.Text

        task.spawn(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = text
            })
        end)
    end

    function Tabs.PromptDiscord(discCode)
        task.spawn(function()
            local http
        
            pcall(function()
                http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
            end)
        
            if http then
               local function join()
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
                                    ["code"] = discCode,
                                },
                                ["cmd"] = "INVITE_BROWSER",
                                ["nonce"] = "."
                            })
                        })
                end
                
                join() 
            end
        end)
    end

    function Tabs.Destroy()
        task.spawn(function()
            UI:Destroy()
        end)
    end

    function Tabs:Tab(tabName)
        local tabButton = Instance.new("Frame")
        local GlowTab = Instance.new("ImageLabel")
        local button = Instance.new("TextButton")
        local UICorner_22 = Instance.new("UICorner")
        local Color_5 = Instance.new("UIStroke")
        local UICorner_23 = Instance.new("UICorner")
        local TabFrame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")

        tabButton.Name = "tabButton"
        tabButton.Parent = tabH
        tabButton.BackgroundColor3 = mainColor
        tabButton.BackgroundTransparency = 1.000
        tabButton.Position = UDim2.new(0, 0, -0.0152113764, 0)
        tabButton.Size = UDim2.new(0, 167, 0, 24)

        GlowTab.Name = "GlowTab"
        GlowTab.Parent = tabButton
        GlowTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GlowTab.BackgroundTransparency = 1.000
        GlowTab.BorderSizePixel = 0
        GlowTab.Position = UDim2.new(0, -15, 0, -15)
        GlowTab.Size = UDim2.new(1, 30, 1, 30)
        GlowTab.ZIndex = 0
        GlowTab.Image = "rbxassetid://4996891970"
        GlowTab.ImageColor3 = mainColor
        GlowTab.ScaleType = Enum.ScaleType.Slice
        GlowTab.SliceCenter = Rect.new(20, 20, 280, 280)
        GlowTab.ImageTransparency = 1

        button.Name = "button"
        button.Parent = tabButton
        button.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
        button.BackgroundTransparency = 1.000
        button.Position = UDim2.new(0, 0, -0.0138549805, 0)
        button.Size = UDim2.new(0, 167, 0, 24)
        button.Font = Enum.Font.Gotham
        button.Text = tabName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextScaled = false
        button.TextSize = 14.000
        button.TextWrapped = true

        UICorner_22.Parent = button

        Color_5.Color = mainColor
        Color_5.Name = "Color"
        Color_5.Parent = tabButton
        Color_5.Thickness = 2
        Color_5.Transparency = 1

        UICorner_23.Parent = tabButton

        TabFrame.Name = "TabFrame"
        TabFrame.Parent = elementFrame
        TabFrame.Active = true
        TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabFrame.BackgroundTransparency = 1.000
        TabFrame.Position = UDim2.new(0.0134529145, 0, 0.0377753302, 0)
        TabFrame.Size = UDim2.new(0, 440, 0, 289)
        TabFrame.ScrollBarThickness = 5
        TabFrame.Visible = false

    
        UIListLayout.Parent = TabFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        if not FirstTab then
            FirstTab = true
            Color_5.Transparency = 0.2
            TabFrame.Visible = true
            GlowTab.ImageTransparency = 0
            tabButton.BackgroundTransparency = 0
        end

        UpdateFrameSize(TabFrame,UIListLayout)

        TabFrame.ChildAdded:Connect(function()
            UpdateFrameSize(TabFrame,UIListLayout)
        end)

        TabFrame.ChildRemoved:Connect(function()
            UpdateFrameSize(TabFrame,UIListLayout)
        end)

        button.MouseButton1Click:Connect(function()
            if TabFrame.Visible == true then return end

            for _,v in pairs(tabH:GetChildren()) do
                if v:IsA("Frame") and v.Name ~= "seperator" then
                    pcall(function()
                        local stroke = v:FindFirstChildOfClass("UIStroke")
                        task.spawn(function()
                            Tween("Transparency",stroke,{Transparency = 1},.3)
                            Tween("ImageTransparency",v.GlowTab,{ImageTransparency = 1},.3)
                            Tween("BackgroundTransparency",v,{BackgroundTransparency = 1},.3)
                        end)
                    end)
                end
            end

            for _,v in pairs(elementFrame:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end

            Tween("Transparency",Color_5,{Transparency = 0.2},.3)
            Tween("ImageTransparency",GlowTab,{ImageTransparency = 0},.3)
            Tween("BackgroundTransparency",tabButton,{BackgroundTransparency = 0},.3)
            TabFrame.Visible = true
        end)

        local Elements = {}

        function Elements:Button(buttonName,callback)
            buttonName = buttonName or "Button"
            callback = callback or function () end

            local Button = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = TabFrame
            Button.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Button.ClipsDescendants = true
            Button.Size = UDim2.new(0, 424, 0, 24)
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextScaled = false
            Button.TextSize = 14.000
            Button.TextWrapped = true
            Button.Text = buttonName
        
            UICorner_3.Parent = Button

            Button.MouseButton1Click:Connect(function()
                Ripple(Button)
                pcall(callback)
            end)

            UpdateFrameSize(TabFrame,UIListLayout)
        end

        function Elements:Toggle(toggleName,currentState,callback)
            toggleName = toggleName or "Toggle"
            currentState = currentState or false
            callback = callback or function () end

            local Toggle = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local name = Instance.new("TextLabel")
            local ToggleBG = Instance.new("Frame")
            local UICorner_5 = Instance.new("UICorner")
            local Ball = Instance.new("Frame")
            local UICorner_6 = Instance.new("UICorner")
            local hitbox = Instance.new("TextButton")
            local UICorner_7 = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = TabFrame
            Toggle.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Toggle.ClipsDescendants = true
            Toggle.Size = UDim2.new(0, 424, 0, 24)

            UICorner_4.Parent = Toggle

            name.Name = "name"
            name.Parent = Toggle
            name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            name.BackgroundTransparency = 1.000
            name.Position = UDim2.new(0.0154420389, 0, 0, 0)
            name.Size = UDim2.new(0, 246, 0, 24)
            name.Font = Enum.Font.Gotham
            name.Text = toggleName..":"
            name.TextColor3 = Color3.fromRGB(255, 255, 255)
            name.TextScaled = false
            name.TextSize = 14.000
            name.TextWrapped = true
            name.TextXAlignment = Enum.TextXAlignment.Left

            ToggleBG.Name = "ToggleBG"
            ToggleBG.Parent = Toggle
            ToggleBG.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            ToggleBG.Position = UDim2.new(0.883972287, 0, 0.125, 0)
            ToggleBG.Size = UDim2.new(0, 41, 0, 18)

            UICorner_5.Parent = ToggleBG

            Ball.Name = "Ball"
            Ball.Parent = ToggleBG
            Ball.BackgroundColor3 = Color3.fromRGB(67, 67, 67)
            Ball.Position = UDim2.new(-0.00882184505, 0, 0, 0)
            Ball.Size = UDim2.new(0, 18, 0, 18)

            UICorner_6.CornerRadius = UDim.new(16, 16)
            UICorner_6.Parent = Ball

            hitbox.Name = "hitbox"
            hitbox.Parent = Toggle
            hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            hitbox.BackgroundTransparency = 0.990
            hitbox.Size = UDim2.new(0, 424, 0, 24)
            hitbox.Font = Enum.Font.Gotham
            hitbox.Text = ""
            hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
            hitbox.TextSize = 14.000

            UICorner_7.Parent = hitbox

            local state = currentState
            local toggleDebounce = false

            if state then
                task.spawn(function()
                    toggleDebounce = true
                    Tween("pos",Ball,UDim2.new(0.552, 0,0, 0),.3)
                    Tween("BackgroundColor",Ball,{BackgroundColor3 = mainColor},.3)
                    task.wait(.3)
                    toggleDebounce = false
                end)
            end

            pcall(callback,state)

            local function ToggleOn()
                Ripple(Toggle)
                state = true
                task.spawn(function()
                    toggleDebounce = true
                    Tween("pos",Ball,UDim2.new(0.552, 0,0, 0),.3)
                    task.delay(0.01,function()
                        repeat task.wait() until Ball.BackgroundColor3 ~= nil
                        Tween("BackgroundColor",Ball,{BackgroundColor3 = mainColor},.3)
                    end)
                    task.wait(.3)
                    toggleDebounce = false
                end)

                pcall(callback,state)
            end

            local function ToggleOff()
                Ripple(Toggle)
                state = false

                task.spawn(function()
                    toggleDebounce = true
                    Tween("pos",Ball,UDim2.new(-0.00882184505, 0, 0, 0),.3)
                    Tween("BackgroundColor",Ball,{BackgroundColor3 = Color3.fromRGB(67, 67, 67)},.3)
                    task.wait(.3)
                    toggleDebounce = false
                end)

                pcall(callback,state)
            end

            hitbox.MouseButton1Click:Connect(function()
                if toggleDebounce then return end
                if state then
                    ToggleOff()
                    return
                end

                ToggleOn()
            end)

            local toggleFunc = {}

            function toggleFunc:GetState()
                return state
            end

            function toggleFunc:SetState(desiredState)
                if desiredState then
                    ToggleOn()
                else
                    ToggleOff()
                end
            end
            
            function toggleFunc:LoadConfig(data)
                if data.Name == toggleName and data.Type == "Toggle" then
                    print("HAHA LOAD GO BRRR",data.Value)
                    toggleFunc:SetState(data.Value)
                end
            end
            
            local info = {Name = toggleName,Type ="Toggle",Value = state,Element = toggleFunc}
            
            function toggleFunc:SaveConfig()
               for i,v in pairs(_G.UISettings.ElementCache) do
                  if v.Name == info.Name and v.Type == info.Type then
                      v["Value"] = state
                  end
               end
            end
            
            table.insert(_G.UISettings.ElementCache,info)
            
            UpdateFrameSize(TabFrame,UIListLayout)

            return toggleFunc
        end

        function Elements:Slider(sliderName,config,callback)
            sliderName = sliderName or "Slider"
            local def = tonumber(config.def) or 50
            local min = tonumber(config.min) or 0
            local max = tonumber(config.max) or 100
            callback = callback or function() end

            local Slider = Instance.new("Frame")
            local UICorner_8 = Instance.new("UICorner")
            local name_2 = Instance.new("TextLabel")
            local SliderBG = Instance.new("Frame")
            local SliderBGButton = Instance.new("TextButton")
            local UICorner_9 = Instance.new("UICorner")
            local Color_2 = Instance.new("Frame")
            local UICorner_10 = Instance.new("UICorner")
            local amount = Instance.new("TextLabel")

            Slider.Name = "Slider"
            Slider.Parent = TabFrame
            Slider.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Slider.ClipsDescendants = true
            Slider.Size = UDim2.new(0, 424, 0, 24)

            UICorner_8.Parent = Slider

            name_2.Name = "name"
            name_2.Parent = Slider
            name_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            name_2.BackgroundTransparency = 1.000
            name_2.Position = UDim2.new(0.0154420389, 0, 0, 0)
            name_2.Size = UDim2.new(0, 150, 0, 24)
            name_2.Font = Enum.Font.Gotham
            name_2.Text = sliderName..":"
            name_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            name_2.TextScaled = false
            name_2.TextSize = 14.000
            name_2.TextWrapped = true
            name_2.TextXAlignment = Enum.TextXAlignment.Left

            SliderBG.Name = "SliderBG"
            SliderBG.Parent = Slider
            SliderBG.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            SliderBG.Position = UDim2.new(0.537450969, 0, 0.25, 0)
            SliderBG.Size = UDim2.new(0, 187, 0, 14)
            SliderBG.ClipsDescendants = true

            SliderBGButton.Name = "SliderBG"
            SliderBGButton.Parent = Slider
            SliderBGButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            SliderBGButton.Position = UDim2.new(0.537450969, 0, 0.25, 0)
            SliderBGButton.Size = UDim2.new(0, 187, 0, 14)
            SliderBGButton.BackgroundTransparency = 0.99
            SliderBGButton.Text = ""

            UICorner_9.Parent = SliderBG

            Color_2.Name = "Color"
            Color_2.Parent = SliderBG
            Color_2.BackgroundColor3 = mainColor
            Color_2.Size = UDim2.new(0, 187, 0, 18)

            UICorner_10.CornerRadius = UDim.new(16, 16)
            UICorner_10.Parent = Color_2

            amount.Name = "amount"
            amount.Parent = Slider
            amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            amount.BackgroundTransparency = 1.000
            amount.Position = UDim2.new(0.370521128, 0, 0.125, 0)
            amount.Size = UDim2.new(0, 68, 0, 21)
            amount.Font = Enum.Font.Gotham
            amount.Text = "56"
            amount.TextColor3 = Color3.fromRGB(255, 255, 255)
            amount.TextScaled = false
            amount.TextSize = 14.000
            amount.TextWrapped = true

            if def > max then 
                def = max
            elseif min < 0 then
                min = 0
            end

            local SliderDef = math.clamp(def, min, max)
            local DefaultScale =  (SliderDef - min) / (max - min)
            local mouse = game.Players.LocalPlayer:GetMouse()
            local uis = game:GetService("UserInputService")
            local SValue;
            local SB = SliderBGButton
            local SV = amount
            local SF = Color_2
            local NormalSizeX = 187
            local NormalSizeY = 14

            SF.Size = UDim2.fromScale(DefaultScale,1)
            SV.Text = tostring(def)
            Value = def
            pcall(callback,Value)

            SB.MouseButton1Down:Connect(function()
                SValue = math.floor((((tonumber(max) - tonumber(min)) / NormalSizeX) * SF.AbsoluteSize.X) + tonumber(min)) or 0
            
            
                SF.Size = UDim2.new(0, math.clamp(mouse.X - SF.AbsolutePosition.X, 0, NormalSizeX), 0, NormalSizeY)
                moveconnection = mouse.Move:Connect(function()
                    SValue = math.floor((((tonumber(max) - tonumber(min)) / NormalSizeX) * SF.AbsoluteSize.X) + tonumber(min))
                    SV.Text = SValue
            
                    pcall(callback,SValue)
            
                    SF.Size = UDim2.new(0, math.clamp(mouse.X - SF.AbsolutePosition.X, 0, NormalSizeX), 0,NormalSizeY)
                end)
            
                releaseconnection = uis.InputEnded:Connect(function(Mouse)
                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        SValue = math.floor((((tonumber(max) - tonumber(min)) / NormalSizeX) * SF.AbsoluteSize.X) + tonumber(min))
            
                        pcall(callback,SValue)
            
                        SF.Size = UDim2.new(0, math.clamp(mouse.X - SF.AbsolutePosition.X, 0, NormalSizeX), 0, NormalSizeY)
                        moveconnection:Disconnect()
                        releaseconnection:Disconnect()
                    end
                end)
            end)

            local sliderFunc = {}

            function sliderFunc:GetValue()
                return Value
            end

            function sliderFunc:SetValue(desiredValue)
                if tonumber(desiredValue) and desiredValue <= max and desiredValue >= min then
                    local SliderDef = math.clamp(tonumber(desiredValue), min, max)
                    local DefaultScale =  (SliderDef - min) / (max - min)
                    Tween("size",SF,UDim2.fromScale(DefaultScale,1),.3)
                    SV.Text = tostring(desiredValue)
                    Value = desiredValue
                    pcall(callback,Value)
                end
            end

            function sliderFunc:LoadConfig(data)
                if data.Name == sliderName and data.Type == "Slider" then
                    sliderFunc:SetValue(data.Value)
                end
            end
            
            local info = {Name = sliderName,Type ="Slider",Value = SValue,Element = sliderFunc}
            
            function sliderFunc:SaveConfig()
               for i,v in pairs(_G.UISettings.ElementCache) do
                  if v.Name == info.Name and v.Type == info.Type then
                      v["Value"] = SValue or def
                  end
               end
            end
            
            table.insert(_G.UISettings.ElementCache,info)
            
            UpdateFrameSize(TabFrame,UIListLayout)
            
            return sliderFunc
        end

        function Elements:Label(text)
            text = text or ""

            local Label = Instance.new("TextLabel")
            local UICorner_11 = Instance.new("UICorner")

            Label.Name = "Label"
            Label.Parent = TabFrame
            Label.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Label.Size = UDim2.new(0, 424, 0, 24)
            Label.Font = Enum.Font.Gotham
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextScaled = false
            Label.TextSize = 14.000
            Label.TextWrapped = true
            Label.Text = text

            UICorner_11.Parent = Label

            local labelFunc = {}

            function labelFunc:SetText(txt)
                if typeof(txt) == "string" then
                    Label.Text = txt
                end
            end

            function labelFunc:GetText()
                return Label.Text
            end

            UpdateFrameSize(TabFrame,UIListLayout)

            return labelFunc
        end

        function Elements:Textbox(textboxName,callback)
            local Textbox = Instance.new("Frame")
            local UICorner_12 = Instance.new("UICorner")
            local name_3 = Instance.new("TextLabel")
            local box = Instance.new("Frame")
            local UICorner_13 = Instance.new("UICorner")
            local input = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = TabFrame
            Textbox.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(0, 424, 0, 24)

            UICorner_12.Parent = Textbox

            name_3.Name = "name"
            name_3.Parent = Textbox
            name_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            name_3.BackgroundTransparency = 1.000
            name_3.Position = UDim2.new(0.0154420389, 0, 0, 0)
            name_3.Size = UDim2.new(0, 194, 0, 24)
            name_3.Font = Enum.Font.Gotham
            name_3.Text = textboxName..":"
            name_3.TextColor3 = Color3.fromRGB(255, 255, 255)
            name_3.TextScaled = false
            name_3.TextSize = 14.000
            name_3.TextWrapped = true
            name_3.TextXAlignment = Enum.TextXAlignment.Left

            box.Name = "box"
            box.Parent = Textbox
            box.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            box.BorderColor3 = Color3.fromRGB(27, 42, 53)
            box.Position = UDim2.new(0.537450969, 0, 0.125, 0)
            box.Size = UDim2.new(0, 187, 0, 18)

            UICorner_13.Parent = box

            input.Name = "input"
            input.Parent = box
            input.BackgroundColor3 = Color3.fromRGB(37,37,37)
            input.BackgroundTransparency = 1.000
            input.BorderSizePixel = 0
            input.Size = UDim2.new(0, 187, 0, 18)
            input.Font = Enum.Font.Gotham
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.TextScaled = false
            input.TextSize = 14.000
            input.TextWrapped = true

            input.FocusLost:Connect(function()
                local myText = input.Text
                pcall(callback,myText)
            end)

            local textboxFunc = {}

            function textboxFunc:GetText()
                local myText = input.Text
                return myText
            end

            function textboxFunc:SetText(txt)
                if typeof(txt) == "string" then
                    input.Text = txt
                    local myText = input.Text
                    pcall(callback,myText)
                end
            end
            
            function textboxFunc:LoadConfig(data)
                if data.Name == textboxName and data.Type == "Textbox" then
                    textboxFunc:SetText(data.Value)
                end
            end

            local info = {Name = textboxName,Type ="Textbox",Value = input.Text,Element = textboxFunc}
            
            function textboxFunc:SaveConfig()
               for i,v in pairs(_G.UISettings.ElementCache) do
                  if v.Name == info.Name and v.Type == info.Type then
                      v["Value"] = input.Text
                  end
               end
            end
            
            table.insert(_G.UISettings.ElementCache,info)
            
            UpdateFrameSize(TabFrame,UIListLayout)

            return textboxFunc
        end

        function Elements:Bind(bindName,keycode,callback)
            bindName = bindName or "Bind"
            keycode = keycode or Enum.KeyCode.E
            callback = callback or function () end

            local keyName = tostring(keycode):split(".")[3]

            local Keybind = Instance.new("Frame")
            local UICorner_15 = Instance.new("UICorner")
            local name_4 = Instance.new("TextLabel")
            local ToggleBG_2 = Instance.new("Frame")
            local UICorner_16 = Instance.new("UICorner")
            local key = Instance.new("TextLabel")
            local hitbox_3 = Instance.new("TextButton")
            local UICorner_17 = Instance.new("UICorner")

            Keybind.Name = "Keybind"
            Keybind.Parent = TabFrame
            Keybind.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Keybind.ClipsDescendants = true
            Keybind.Size = UDim2.new(0, 424, 0, 24)

            UICorner_15.Parent = Keybind

            name_4.Name = "name"
            name_4.Parent = Keybind
            name_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            name_4.BackgroundTransparency = 1.000
            name_4.Position = UDim2.new(0.0154420389, 0, 0, 0)
            name_4.Size = UDim2.new(0, 246, 0, 24)
            name_4.Font = Enum.Font.Gotham
            name_4.Text = bindName..":"
            name_4.TextColor3 = Color3.fromRGB(255, 255, 255)
            name_4.TextScaled = false
            name_4.TextSize = 14.000
            name_4.TextWrapped = true
            name_4.TextXAlignment = Enum.TextXAlignment.Left

            ToggleBG_2.Name = "ToggleBG"
            ToggleBG_2.Parent = Keybind
            ToggleBG_2.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            ToggleBG_2.Position = UDim2.new(0.728031218, 0, 0.125, 0)
            ToggleBG_2.Size = UDim2.new(0, 106, 0, 18)

            UICorner_16.Parent = ToggleBG_2

            key.Name = "key"
            key.Parent = ToggleBG_2
            key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            key.BackgroundTransparency = 1.000
            key.Position = UDim2.new(-0.00994582381, 0, 0, 0)
            key.Size = UDim2.new(0, 106, 0, 18)
            key.Font = Enum.Font.Gotham
            key.Text = keyName
            key.TextColor3 = Color3.fromRGB(255, 255, 255)
            key.TextScaled = false
            key.TextSize = 14.000
            key.TextWrapped = true

            hitbox_3.Name = "hitbox"
            hitbox_3.Parent = Keybind
            hitbox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            hitbox_3.BackgroundTransparency = 0.990
            hitbox_3.Size = UDim2.new(0, 424, 0, 24)
            hitbox_3.Font = Enum.Font.Gotham
            hitbox_3.Text = ""
            hitbox_3.TextColor3 = Color3.fromRGB(0, 0, 0)
            hitbox_3.TextSize = 14.000

            UICorner_17.Parent = hitbox_3

            local WhitelistedType = {
                [Enum.UserInputType.MouseButton1] = "Mouse1";
                [Enum.UserInputType.MouseButton2] = "Mouse2";
                [Enum.UserInputType.MouseButton3] = "Mouse3";
            };
            local UIS = game:GetService("UserInputService")
            local Binding = false

            hitbox_3.MouseButton1Click:Connect(function()
                local Connection;
                Binding = true
            
                key.Text = ". . .";
            
                Connection = UIS.InputBegan:Connect(function(i,chat)
                    if chat then return end
                    
                    if UI == nil or UI.Parent == nil then
                        Connection:Disconnect()
                        return
                    end

                    if WhitelistedType[i.UserInputType] then
                        key.Text = WhitelistedType[i.UserInputType];
                        keycode = i.UserInputType
                    elseif i.KeyCode ~= Enum.KeyCode.Unknown then
                        keycode = i.KeyCode
                        keyName = tostring(keycode):split(".")[3]
                        key.Text = keyName;
                    else
                        warn("Exception: " .. i.UserInputType .. " " .. i.KeyCode);
                    end;
            

                    Connection:Disconnect();
                end)
            end)

            local Connection2;

            Connection2 = UIS.InputBegan:Connect(function(i,chat)
                if chat then return end
                
                if UI == nil or UI.Parent == nil then
                    Connection2:Disconnect()
                    return
                end
                
                if Binding then
                    Binding = false
                    return;
                end
            
                if (keycode == i.UserInputType or keycode == i.KeyCode) then
                    pcall(callback,keycode)
                end;
            end);

            local bindFunc = {}

            function bindFunc:GetBind()
                return keycode
            end

            function bindFunc:SetBind(EnumK)
                if tostring(EnumK):find("Enum.KeyCode.") then
                    keycode = EnumK
                    keyName = tostring(keycode):split(".")[3]
                    key.Text = keyName
                end
            end
            
            function bindFunc:LoadConfig(data)
                if data.Name == bindName and data.Type == "Bind" then
                    bindFunc:SetBind(data.Value)
                end
            end

            local info = {Name = bindName,Type ="Bind",Value = keycode,Element = bindFunc}
            
            function bindFunc:SaveConfig(data)
               for i,v in pairs(_G.UISettings.ElementCache) do
                  if v.Name == info.Name and v.Type == info.Type then
                      v["Value"] = Enum.KeyCode[key.Text]
                  end
               end
            end

            table.insert(_G.UISettings.ElementCache,info)
            
            UpdateFrameSize(TabFrame,UIListLayout)

            return bindFunc
        end

        function Elements:Dropdown(dropName,list,callback)
            dropName = dropName or "Dropdown"
            list = list or {}
            callback = callback or function () end

            local Dropdown = Instance.new("Frame")
            local UICorner_18 = Instance.new("UICorner")
            local name_5 = Instance.new("TextLabel")
            local hitbox_4 = Instance.new("TextButton")
            local UICorner_19 = Instance.new("UICorner")
            local DropdownList = Instance.new("ScrollingFrame")
            local UIListLayout_2 = Instance.new("UIListLayout")
            local UICorner_20 = Instance.new("UICorner")
            local ImageLabel = Instance.new("ImageLabel")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = TabFrame
            Dropdown.BackgroundColor3 = Color3.fromRGB(37,37,37)
            Dropdown.Size = UDim2.new(0, 424, 0, 24)
            Dropdown.ClipsDescendants = true

            UICorner_18.Parent = Dropdown

            name_5.Name = "name"
            name_5.Parent = Dropdown
            name_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            name_5.BackgroundTransparency = 1.000
            name_5.Position = UDim2.new(0.0154420389, 0, 0, 0)
            name_5.Size = UDim2.new(0, 246, 0, 24)
            name_5.Font = Enum.Font.Gotham
            name_5.Text = dropName..":"
            name_5.TextColor3 = Color3.fromRGB(255, 255, 255)
            name_5.TextScaled = false
            name_5.TextSize = 14.000
            name_5.TextWrapped = true
            name_5.TextXAlignment = Enum.TextXAlignment.Left

            hitbox_4.Name = "hitbox"
            hitbox_4.Parent = Dropdown
            hitbox_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            hitbox_4.BackgroundTransparency = 0.990
            hitbox_4.Size = UDim2.new(0, 424, 0, 24)
            hitbox_4.Font = Enum.Font.Gotham
            hitbox_4.Text = ""
            hitbox_4.TextColor3 = Color3.fromRGB(0, 0, 0)
            hitbox_4.TextSize = 14.000

            UICorner_19.Parent = hitbox_4

            DropdownList.Name = "DropdownList"
            DropdownList.Parent = TabFrame
            DropdownList.Active = true
            DropdownList.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            DropdownList.Position = UDim2.new(0, 0, 0.975056946, 0)
            DropdownList.Size = UDim2.new(0, 424, 0, 0)
            DropdownList.ScrollBarImageTransparency = 1
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.ZIndex = true

            UIListLayout_2.Parent = DropdownList
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

            UpdateFrameSize(DropdownList,UIListLayout_2)

            DropdownList.ChildAdded:Connect(function()
                UpdateFrameSize(DropdownList,UIListLayout_2)
            end)

            DropdownList.ChildRemoved:Connect(function()
                UpdateFrameSize(DropdownList,UIListLayout_2)
            end)

            DropdownList:GetPropertyChangedSignal("Size"):Connect(function()
                UpdateFrameSize(TabFrame,UIListLayout)
            end)
            
            UICorner_20.CornerRadius = UDim.new(0, 16)
            UICorner_20.Parent = DropdownList

            ImageLabel.Parent = Dropdown
            ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel.BackgroundTransparency = 1.000
            ImageLabel.Position = UDim2.new(0.9, 0, 0, 0)
            ImageLabel.Size = UDim2.new(0, 25, 0, 25)
            ImageLabel.Image = "rbxassetid://3926305904"
            ImageLabel.ImageRectOffset = Vector2.new(44, 404)
            ImageLabel.ImageRectSize = Vector2.new(36, 36)
            ImageLabel.ZIndex = 2

            local opened = false
            local dropDebounce = false

            local function ToggleDropdown()
                if dropDebounce then return end

                Ripple(Dropdown)

                if not opened then
                    task.spawn(function()
                        dropDebounce = true
                        DropdownList.Visible = true
                        Tween("size",DropdownList,UDim2.new(0, 424,0, 98),.15)
                        Tween("rotation",ImageLabel,{Rotation = 180},.3)
                        task.wait(.3)
                        DropdownList.ScrollBarImageTransparency = 0
                        opened = true
                        dropDebounce = false
                        UpdateFrameSize(TabFrame,UIListLayout)
                    end)
                elseif opened then
                    task.spawn(function()
                        dropDebounce = true
                        DropdownList.ScrollBarImageTransparency = 1
                        DropdownList.CanvasPosition = Vector2.new(0,0)
                        Tween("size",DropdownList,UDim2.new(0, 424, 0, 0),.15)
                        Tween("rotation",ImageLabel,{Rotation = 0},.3)
                        task.wait(.3)
                        DropdownList.Visible = false
                        opened = false
                        dropDebounce = false
                        UpdateFrameSize(TabFrame,UIListLayout)
                    end)
                end
            end

            local function CreateItem(newItem,index)
                if typeof(newItem) == "Instance" then
                    newItem = newItem.Name
                end

                local item = Instance.new("TextButton")
                local UICorner_21 = Instance.new("UICorner")

                item.Name = "item"
                item.Parent = DropdownList
                item.BackgroundColor3 = Color3.fromRGB(37,37,37)
                item.ClipsDescendants = true
                item.Size = UDim2.new(0, 410, 0, 24)
                item.Font = Enum.Font.Gotham
                item.TextColor3 = Color3.fromRGB(255, 255, 255)
                item.TextScaled = false
                item.TextSize = 14.000
                item.TextWrapped = true
                item.Text = tostring(newItem)

                UICorner_21.Parent = item

                item.MouseButton1Click:Connect(function()
                    name_5.Text = dropName..": "..item.Text
                    pcall(callback,item.Text,index)
                    ToggleDropdown()
                end)
            end


            local function AddItems(listTB)
                local InstanceTable = {}
                local CurrentList = listTB

                for i,v in pairs(listTB) do
                    CreateItem(v,i)
                    if typeof(v) == "Instance" then
                        table.insert(InstanceTable,i,v)
                    end
                end

                if #InstanceTable > 0 then
                    return CurrentList,InstanceTable
                end

                return CurrentList
            end

            local function RemoveAllItems()
                for i,v in pairs(DropdownList:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
            end

            local CurrentList,InstanceTable = AddItems(list)

            hitbox_4.MouseButton1Click:Connect(function()
                ToggleDropdown()
            end)

            local dropdownFunc = {}

            function dropdownFunc:SetOptions(newList)
                RemoveAllItems()
                CurrentList,InstanceTable = AddItems(newList)
            end

            function dropdownFunc:SetChoice(ch)
                if table.find(CurrentList,ch) then
		    local index = table.find(CurrentList,ch)
                    name_5.Text = dropName..": "..ch
                    pcall(callback,ch,index)
                end
            end

	    function dropdownFunc:GetChoice()
		local DDChoice = name_5.Text:split(" ")[2]
		
		if DDChoice ~= nil then
		    return DDChoice
		else
		    return ""
		end
            end

            function dropdownFunc:GetOptions()
                return CurrentList,InstanceTable
            end

	    function dropdownFunc:LoadConfig(data)
                if data.Name == dropName and data.Type == "Dropdown" then
                    dropName:SetChoice(data.Value)
                end
            end

            local info = {Name = dropName,Type ="Dropdown",Value = dropdownFunc:GetChoice(),Element = dropdownFunc}
            
            function dropdownFunc:SaveConfig(data)
               for i,v in pairs(_G.UISettings.ElementCache) do
                  if v.Name == info.Name and v.Type == info.Type then
                      v["Value"] = dropdownFunc:GetChoice()
                  end
               end
            end

            UpdateFrameSize(TabFrame,UIListLayout)

            return dropdownFunc
        end

        return Elements
    end

    dragify(BG)
    
    return Tabs
end

return Library
