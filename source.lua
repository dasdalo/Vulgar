-- Vulgar UI Library (CS2 Cheat Menu Style with Launcher)
-- Made by Grok with love <3
-- Usage: local Vulgar = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../vulgar.lua"))()

local Vulgar = {
    Theme = {
        Accent = Color3.fromRGB(0, 170, 255),
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 35),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180)
    }
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local function CreateInstance(class, props)
    local inst = Instance.new(class)
    for i,v in pairs(props or {}) do
        if i ~= "Parent" then
            inst[i] = v
        end
    end
    if props and props.Parent then
        inst.Parent = props.Parent
    end
    return inst
end

-- Launcher Function
function Vulgar:CreateLauncher(options)
    options = options or {}
    local Title = options.Title or "Vulgar Launcher"
    local OnLaunch = options.OnLaunch or function() end

    local ScreenGui = CreateInstance("ScreenGui", {
        Name = "VulgarLauncher",
        ResetOnSpawn = false,
        Parent = game.CoreGui
    })

    local LauncherMain = CreateInstance("Frame", {
        Size = UDim2.new(0, 300, 0, 200),
        Position = UDim2.new(0.5, -150, 0.5, -100),
        BackgroundColor3 = Vulgar.Theme.Background,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = ScreenGui
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = LauncherMain})
    CreateInstance("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
        },
        Rotation = 90,
        Parent = LauncherMain
    })

    local LauncherTitle = CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Vulgar.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Parent = LauncherMain
    })

    local StartButton = CreateInstance("TextButton", {
        Size = UDim2.new(0, 200, 0, 40),
        Position = UDim2.new(0.5, -100, 0.5, 20),
        BackgroundColor3 = Vulgar.Theme.Accent,
        Text = "Start",
        TextColor3 = Vulgar.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = LauncherMain
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = StartButton})

    StartButton.MouseButton1Click:Connect(function()
        TweenService:Create(LauncherMain, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        ScreenGui:Destroy()
        OnLaunch()
    end)

    -- Fade in animation
    LauncherMain.BackgroundTransparency = 1
    TweenService:Create(LauncherMain, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1}):Play()
end

-- Main Window
function Vulgar:Window(options)
    options = options or {}
    local Title = options.Title or "Vulgar"
    
    local ScreenGui = CreateInstance("ScreenGui", {
        Name = "VulgarUI",
        ResetOnSpawn = false,
        Parent = game.CoreGui
    })

    local Blur = Instance.new("BlurEffect")
    Blur.Size = 0
    Blur.Parent = game.Lighting
    TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 14}):Play()

    local Main = CreateInstance("Frame", {
        Name = "Main",
        Size = UDim2.new(0, 580, 0, 420),
        Position = UDim2.new(0.5, -290, 0.5, -210),
        BackgroundColor3 = Vulgar.Theme.Background,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = ScreenGui
    })

    local UICorner = CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Main})
    local UIGradient = CreateInstance("UIGradient", {
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
        },
        Rotation = 90,
        Parent = Main
    })

    local Stroke = CreateInstance("UIStroke", {
        Color = Vulgar.Theme.Accent,
        Thickness = 1.5,
        Transparency = 0.7,
        Parent = Main
    })

    local TopBar = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = Main
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TopBar})

    local TitleLabel = CreateInstance("TextLabel", {
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Parent = TopBar
    })

    local TabContainer = CreateInstance("Frame", {
        Size = UDim2.new(0, 140, 1, -50),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1,
        Parent = Main
    })

    local Content = CreateInstance("Frame", {
        Size = UDim2.new(1, -150, 1, -50),
        Position = UDim2.new(0, 145, 0, 45),
        BackgroundTransparency = 1,
        Parent = Main
    })

    local Dragging, DragStart, StartPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = Main.Position
        end
    end)

    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - DragStart
            Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        end
    end)

    -- Keybind to toggle UI visibility (RightShift)
    local visible = true
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.RightShift then
            visible = not visible
            if visible then
                TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.05}):Play()
                TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 14}):Play()
                Main.Visible = true
            else
                TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
                task.wait(0.3)
                Main.Visible = false
            end
        end
    end)

    local Tabs = {}
    local CurrentTab = nil

    function Tabs:CreateTab(name, icon)
        local TabButton = CreateInstance("TextButton", {
            Size = UDim2.new(1, -20, 0, 35),
            Position = UDim2.new(0, 10, 0, #Tabs * 40),
            BackgroundColor3 = Vulgar.Theme.Secondary,
            BackgroundTransparency = 0.5,
            Text = "",
            AutoButtonColor = false,
            Parent = TabContainer
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TabButton})

        local Icon = CreateInstance("ImageLabel", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 12, 0.5, -10),
            BackgroundTransparency = 1,
            Image = icon or "rbxassetid://7072717849",
            ImageColor3 = Vulgar.Theme.SubText,
            Parent = TabButton
        })

        local TabName = CreateInstance("TextLabel", {
            Size = UDim2.new(1, -50, 1, 0),
            Position = UDim2.new(0, 44, 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Vulgar.Theme.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = TabButton
        })

        local TabContent = CreateInstance("ScrollingFrame", {
            Size = UDim2.new(1, -20, 1, -20),
            Position = UDim2.new(0, 10, 0, 10),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Vulgar.Theme.Accent,
            CanvasSize = UDim2.new(0,0,0,0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = Content
        })

        local UIListLayout = CreateInstance("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = TabContent
        })

        local function Select()
            if CurrentTab then
                CurrentTab.Visible = false
                TweenService:Create(CurrentTab.Parent, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
                CurrentTab.Parent.BackgroundColor3 = Vulgar.Theme.Secondary
            end
            TabContent.Visible = true
            CurrentTab = TabContent
            TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.3}):Play()
            TabButton.BackgroundColor3 = Vulgar.Theme.Accent
            Icon.ImageColor3 = Color3.fromRGB(255,255,255)
            TabName.TextColor3 = Color3.fromRGB(255,255,255)
        end

        TabButton.MouseButton1Click:Connect(Select)

        TabButton.MouseEnter:Connect(function()
            if CurrentTab ~= TabContent then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if CurrentTab ~= TabContent then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
            end
        end)

        if #Tabs == 0 then Select() end

        local Tab = {}

        function Tab:Section(title)
            local Section = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Vulgar.Theme.Secondary,
                BackgroundTransparency = 0.6,
                Parent = TabContent
            })
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Section})

            local SectionTitle = CreateInstance("TextLabel", {
                Size = UDim2.new(1, -10, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = title,
                TextColor3 = Vulgar.Theme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Section
            })

            local SectionContent = CreateInstance("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = TabContent
            })
            local List = CreateInstance("UIListLayout", {
                Padding = UDim.new(0, 6),
                Parent = SectionContent
            })

            local Elements = {}

            function Elements:Toggle(text, callback)
                callback = callback or function() end
                local enabled = false

                local Toggle = CreateInstance("Frame", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Vulgar.Theme.Secondary,
                    BackgroundTransparency = 0.7,
                    Parent = SectionContent
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Toggle})

                local Label = CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Vulgar.Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Toggle
                })

                local Indicator = CreateInstance("Frame", {
                    Size = UDim2.new(0, 40, 0, 20),
                    Position = UDim2.new(1, -52, 0.5, -10),
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                    Parent = Toggle
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Indicator})

                local Circle = CreateInstance("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 4, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Parent = Indicator
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Circle})

                Toggle.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    TweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = enabled and Vulgar.Theme.Accent or Color3.fromRGB(50,50,50)}):Play()
                    TweenService:Create(Circle, TweenInfo.new(0.2), {Position = enabled and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 4, 0.5, -8)}):Play()
                    callback(enabled)
                end)
            end

            function Elements:Slider(text, min, max, callback)
                callback = callback or function() end
                local value = min

                local Slider = CreateInstance("Frame", {
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Vulgar.Theme.Secondary,
                    BackgroundTransparency = 0.7,
                    Parent = SectionContent
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Slider})

                local Label = CreateInstance("TextLabel", {
                    Size = UDim2.new(1, -100, 0, 20),
                    Position = UDim2.new(0, 12, 0, 6),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = Vulgar.Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = Slider
                })

                local ValueLabel = CreateInstance("TextLabel", {
                    Size = UDim2.new(0, 60, 0, 20),
                    Position = UDim2.new(1, -72, 0, 6),
                    BackgroundTransparency = 1,
                    Text = tostring(min),
                    TextColor3 = Vulgar.Theme.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    Parent = Slider
                })

                local Bar = CreateInstance("Frame", {
                    Size = UDim2.new(1, -24, 0, 8),
                    Position = UDim2.new(0, 12, 1, -16),
                    BackgroundColor3 = Color3.fromRGB(40,40,40),
                    Parent = Slider
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Bar})

                local Fill = CreateInstance("Frame", {
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = Vulgar.Theme.Accent,
                    Parent = Bar
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Fill})

                local Dragger = CreateInstance("TextButton", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, -8, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    Text = "",
                    Parent = Fill
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(1,0), Parent = Dragger})

                local dragging = false
                Dragger.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mouseX = input.Position.X
                        local barX = Bar.AbsolutePosition.X
                        local barWidth = Bar.AbsoluteSize.X
                        local relative = math.clamp((mouseX - barX) / barWidth, 0, 1)
                        value = math.floor(min + (max - min) * relative)
                        Fill.Size = UDim2.new(relative, 0, 1, 0)
                        Dragger.Position = UDim2.new(relative, -8, 0.5, -8)
                        ValueLabel.Text = tostring(value)
                        callback(value)
                    end
                end)
            end

            function Elements:Button(text, callback)
                local Button = CreateInstance("TextButton", {
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Vulgar.Theme.Accent,
                    BackgroundTransparency = 0.8,
                    Text = text,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    AutoButtonColor = false,
                    Parent = SectionContent
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = Button})

                Button.MouseButton1Click:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
                    task.wait(0.1)
                    TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0.8}):Play()
                    callback()
                end)
            end

            return Elements
        end

        table.insert(Tabs, TabButton)
        return Tab
    end

    -- Fade in main UI
    Main.BackgroundTransparency = 1
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.05}):Play()

    return Tabs
end

return Vulgar
