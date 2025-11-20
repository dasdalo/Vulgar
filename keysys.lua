-- Vulgar Key System - Clean Fade Out
-- Key: vulgarkey5

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- CONFIG
local MainScriptUrl = "https://raw.githubusercontent.com/dasdalo/Vulgar/refs/heads/main/flick.lua"
local CorrectKey = "vulgarkey5"
local KeyLink = "https://discord.gg/yourserver"
local launcherTitle = "Vulgar"



local function createKeyUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VulgarKeySystem"
    screenGui.Parent = Players.LocalPlayer.PlayerGui
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 360)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -180)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 100)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = launcherTitle
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 1
    title.Font = Enum.Font.ArialBold
    title.TextSize = 70
    title.Parent = mainFrame

    -- Enter label
    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 400, 0, 50)
    keyLabel.Position = UDim2.new(0.5, -200, 0, 110)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = "Enter Key"
    keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyLabel.TextTransparency = 1
    keyLabel.Font = Enum.Font.Gotham
    keyLabel.TextSize = 28
    keyLabel.Parent = mainFrame

    -- TextBox
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0, 420, 0, 60)
    keyBox.Position = UDim2.new(0.5, -210, 0, 160)
    keyBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
    keyBox.BackgroundTransparency = 1
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    keyBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    keyBox.TextTransparency = 1
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 24
    keyBox.Parent = mainFrame

    Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,12)

    -- Buttons
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0,200,0,55)
    getKeyBtn.Position = UDim2.new(0.5,-210,1,-80)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    getKeyBtn.BackgroundTransparency = 1
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    getKeyBtn.TextTransparency = 1
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 26
    getKeyBtn.Parent = mainFrame

    Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0,12)

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0,200,0,55)
    submitBtn.Position = UDim2.new(0.5,10,1,-80)
    submitBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    submitBtn.BackgroundTransparency = 1
    submitBtn.Text = "Submit Key"
    submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
    submitBtn.TextTransparency = 1
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 26
    submitBtn.Parent = mainFrame

    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,12)


    -- Fade In
    local fadeIn = TweenInfo.new(1.3, Enum.EasingStyle.Sine)

    TweenService:Create(mainFrame, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(title, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(keyLabel, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(keyBox, fadeIn, {BackgroundTransparency = 0.7, TextTransparency = 0}):Play()
    TweenService:Create(getKeyBtn, fadeIn, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    TweenService:Create(submitBtn, fadeIn, {BackgroundTransparency = 0, TextTransparency = 0}):Play()


    -- CLICK: Get Key
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(KeyLink)
    end)


    -- CLICK: Submit Key
    submitBtn.MouseButton1Click:Connect(function()
        local input = keyBox.Text:gsub("%s+",""):lower()

        if input == CorrectKey:lower() then

            -- Load external script
            local ok, content = pcall(HttpService.GetAsync, HttpService, MainScriptUrl)
            if ok then loadstring(content)() end

            -- **FADE OUT UI — clean & smooth**
            local fadeOut = TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

            TweenService:Create(mainFrame, fadeOut, {BackgroundTransparency = 1}):Play()

            for _, v in mainFrame:GetChildren() do
                if v:IsA("GuiObject") then
                    local props = {}

                    if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                        props.TextTransparency = 1
                    end

                    if v:IsA("TextButton") or v:IsA("TextBox") or v:IsA("Frame") then
                        props.BackgroundTransparency = 1
                    end

                    TweenService:Create(v, fadeOut, props):Play()
                end
            end

            task.wait(1.4)
            screenGui:Destroy()

        else
            keyBox.Text = ""
        end
    end)
end

createKeyUI()
