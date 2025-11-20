local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local scriptUrl = "https://raw.githubusercontent.com/dasdalo/Vulgar/refs/heads/main/keysys.lua"

local launcherTitle = "Vulgar"

local function createLauncherUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VulgarLoader"
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 9999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 400, 0, 100)
    title.Position = UDim2.new(0.5, -200, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = launcherTitle
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 1
    title.Font = Enum.Font.ArialBold
    title.TextSize = 70
    title.Parent = mainFrame

    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(0, 400, 0, 50)
    loadingText.Position = UDim2.new(0.5, -200, 0.5, -10)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Launching"
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.TextTransparency = 1
    loadingText.Font = Enum.Font.Gotham
    loadingText.TextSize = 26
    loadingText.Parent = mainFrame

    -- Loading bar background
    local barBG = Instance.new("Frame")
    barBG.Size = UDim2.new(0, 420, 0, 8)
    barBG.Position = UDim2.new(0.5, -210, 1, -70)
    barBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBG.BackgroundTransparency = 1
    barBG.BorderSizePixel = 0
    barBG.Parent = mainFrame

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = barBG

    -- Actual loading bar (smooth white fill)
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bar.BackgroundTransparency = 1
    bar.BorderSizePixel = 0
    bar.Parent = barBG

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    ----------------------------------------------------------------
    -- FADE IN (super smooth)
    ----------------------------------------------------------------
    local fadeIn = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(mainFrame, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(title, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(loadingText, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(barBG, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(bar, fadeIn, {BackgroundTransparency = 0}):Play()

    wait(0.8)

    ----------------------------------------------------------------
    -- SMOOTH LOADING BAR (6 seconds, Quad ease for buttery feel)
    ----------------------------------------------------------------
    local loadTween = TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(bar, loadTween, {Size = UDim2.new(1, 0, 1, 0)}):Play()

    -- Dots animation
    spawn(function()
        local dots = ""
        while bar.Size.X.Scale < 0.98 do
            dots = dots == "..." and "" or dots .. "."
            loadingText.Text = "Launching" .. dots
            wait(0.6)
        end
        loadingText.Text = "Launched"
    end)

    wait(6)

    ----------------------------------------------------------------
    -- Load & execute your script
    ----------------------------------------------------------------
    local success, content = pcall(HttpService.GetAsync, HttpService, scriptUrl)
    if success and content then
        loadstring(content)()
    else
        loadingText.Text = "Failed to load"
        wait(2)
    end

    wait(1.5)

    ----------------------------------------------------------------
    -- FADE OUT (chill 2.2 seconds)
    ----------------------------------------------------------------
    local fadeOut = TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
    TweenService:Create(mainFrame, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(loadingText, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(barBG, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(bar, fadeOut, {BackgroundTransparency = 1}):Play()

    wait(2.2)
    screenGui:Destroy()
end

createLauncherUI()
