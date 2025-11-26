local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

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
    mainFrame.BackgroundTransparency = 0 
    mainFrame.Parent = screenGui

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 100)
    title.Position = UDim2.new(0, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = launcherTitle
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextTransparency = 0 
    title.Font = Enum.Font.ArialBold
    title.TextSize = 70
    title.Parent = mainFrame

    local keyLabel = Instance.new("TextLabel")
    keyLabel.Size = UDim2.new(0, 400, 0, 50)
    keyLabel.Position = UDim2.new(0.5, -200, 0, 110)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = "Enter Key"
    keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyLabel.TextTransparency = 0 
    keyLabel.Font = Enum.Font.Gotham
    keyLabel.TextSize = 28
    keyLabel.Parent = mainFrame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0, 420, 0, 60)
    keyBox.Position = UDim2.new(0.5, -210, 0, 160)
    keyBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
    keyBox.BackgroundTransparency = 0.7 
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255,255,255)
    keyBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    keyBox.TextTransparency = 0
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 24
    keyBox.Parent = mainFrame

    Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,12)

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0,200,0,55)
    getKeyBtn.Position = UDim2.new(0.5,-210,1,-80)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    getKeyBtn.BackgroundTransparency = 0 
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    getKeyBtn.TextTransparency = 0
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 26
    getKeyBtn.Parent = mainFrame

    Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0,12)

    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0,200,0,55)
    submitBtn.Position = UDim2.new(0.5,10,1,-80)
    submitBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    submitBtn.BackgroundTransparency = 0 
    submitBtn.Text = "Submit Key"
    submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
    submitBtn.TextTransparency = 0
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 26
    submitBtn.Parent = mainFrame

    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,12)


    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(KeyLink)
    end)

    local function runKeyCheck()
        local input = keyBox.Text:gsub("%s+",""):lower()
        if input == CorrectKey:lower() then
            keyBox.Text = "Key Accepted! Loading..."
            keyBox.TextColor3 = Color3.fromRGB(0, 255, 0)

            
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

            spawn(function()
                task.wait(1.4)
                local execSuccess, execResult = pcall(function()
                    return loadstring(game:HttpGet(MainScriptUrl))()
                end)

                if not execSuccess then
                    warn("errrrr: Failed to execute payload:", execResult)
                end

                screenGui:Destroy()
            end)

        else
            keyBox.Text = "Invalid Key"
            keyBox.TextColor3 = Color3.fromRGB(255, 0, 0)
            task.wait(1.5)
            keyBox.Text = ""
            keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end

    submitBtn.MouseButton1Click:Connect(runKeyCheck)
end

createKeyUI()
