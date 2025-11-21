local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local KEY_SYSTEM_URL = 'https://raw.githubusercontent.com/dasdalo/Vulgar/refs/heads/main/keysys.lua'

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

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

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

    local barBG = Instance.new("Frame")
    barBG.Size = UDim2.new(0, 420, 0, 8)
    barBG.Position = UDim2.new(0.5, -210, 1, -70)
    barBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBG.BackgroundTransparency = 1
    barBG.BorderSizePixel = 0
    barBG.Parent = mainFrame

    Instance.new("UICorner", barBG).CornerRadius = UDim.new(1, 0)

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    bar.BackgroundTransparency = 1
    bar.BorderSizePixel = 0
    bar.Parent = barBG

    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    --------------------------------------------------------------------
    -- FADE IN ONLY
    --------------------------------------------------------------------
    local fadeIn = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(mainFrame, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(title, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(loadingText, fadeIn, {TextTransparency = 0}):Play()
    TweenService:Create(barBG, fadeIn, {BackgroundTransparency = 0}):Play()
    TweenService:Create(bar, fadeIn, {BackgroundTransparency = 0}):Play()

    wait(0.8)

    --------------------------------------------------------------------
    -- BAR LOAD + TEXT DOTS
    --------------------------------------------------------------------
    local loadTween = TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(bar, loadTween, {Size = UDim2.new(1, 0, 1, 0)}):Play()

    spawn(function()
        local dots = ""
        while bar.Size.X.Scale < 0.98 do
            dots = dots == "..." and "" or dots .. "."
            loadingText.Text = "Launching" .. dots
            wait(0.45)
        end

        wait(0.5)
        loadingText.Text = "Vulgar"

        wait(1.2)
        loadingText.Text = "Made by char"
    end)

    wait(9.5)

    loadingText.Text = "Finishing Launch..."
    local loadedContent = nil
    local shouldProceed = false

    local successUrl, scriptUrl = pcall(function()
        return loadstring(game:HttpGet(KEY_SYSTEM_URL))()
    end)

    local finalUrl = nil
    if successUrl and type(scriptUrl) == "string" and #scriptUrl > 4 then
        finalUrl = scriptUrl
    else
        loadingText.Text = "Vulgar"
        warn("Key system failed to return valid URL. Error/Result:", scriptUrl)
    end

    if finalUrl then
        loadingText.Text = "Launching script..."

        local success, content = pcall(HttpService.GetAsync, HttpService, finalUrl)
        if success and content and #content > 0 then
            loadedContent = content
            shouldProceed = true
        end
    end

    --------------------------------------------------------------------
    -- INSTANT FADE OUT (NO TWEEN)
    --------------------------------------------------------------------
    mainFrame.BackgroundTransparency = 1
    title.TextTransparency = 1
    loadingText.TextTransparency = 1
    barBG.BackgroundTransparency = 1
    bar.BackgroundTransparency = 1

    wait(0.1)

    if shouldProceed and loadedContent then
        local execSuccess, execResult = pcall(loadstring(loadedContent))
        if not execSuccess then
            warn("Script execution failed:", execResult)
        end
    end

    screenGui:Destroy()
end

createLauncherUI()
