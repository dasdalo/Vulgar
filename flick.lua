local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local Player=Players.LocalPlayer
local PlayerGui=Player:WaitForChild("PlayerGui")

local UI_NAME="VulgarUI"
local old=PlayerGui:FindFirstChild(UI_NAME)
if old then old:Destroy() end

local THEME={
    SidebarBG=Color3.fromRGB(15,15,15),
    WindowBG=Color3.fromRGB(20,20,20),
    ButtonBG=Color3.fromRGB(30,30,30),
    ButtonBG_Active=Color3.fromRGB(70,70,70),
    TextPrimary=Color3.fromRGB(255,255,255),
    TextSecondary=Color3.fromRGB(180,180,180),
    Divider=Color3.fromRGB(34,34,34),
    ToggleOff=Color3.fromRGB(50,50,50),
    ToggleOn=Color3.fromRGB(255,255,255),
}

local CATS={
    Combat={"Silent Aim","Trigger","Click Assist"},
    Blatant={"Speed","High Jump","Fast Break"},
    Render={"Outline Players","Highlight Items","Full Bright"},
    Utility={"Auto Heal","Chat Helper","Report Helper"},
    World={"Freecam Mode","Waypoint Lines"},
}

local function tween(o,i,p)
    local t=TweenService:Create(o,i,p) t:Play() return t
end

local function round(p,s,po,c,r)
    local f=Instance.new("Frame")
    f.Size=s if po then f.Position=po end f.BackgroundColor3=c f.BorderSizePixel=0 f.Parent=p
    local cr=Instance.new("UICorner") cr.CornerRadius=r or UDim.new(0,10) cr.Parent=f
    return f
end

local function drag(f,h)
    h=h or f local d=false local st local sp
    h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true st=i.Position sp=f.Position end end)
    h.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if d and i.UserInputType==Enum.UserInputType.MouseMovement then
            local dl=i.Position-st
            f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dl.X,sp.Y.Scale,sp.Y.Offset+dl.Y)
        end
    end)
end

local gui=Instance.new("ScreenGui")
gui.Name=UI_NAME gui.ResetOnSpawn=false gui.ZIndexBehavior=Enum.ZIndexBehavior.Global gui.DisplayOrder=9999 gui.Parent=PlayerGui

local sidebar=round(gui,UDim2.new(0,220,0,450),UDim2.new(0,20,0.5,-225),THEME.SidebarBG,UDim.new(0,12))
sidebar.BackgroundTransparency=1

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-40,0,40) title.Position=UDim2.new(0,20,0,12)
title.BackgroundTransparency=1 title.Font=Enum.Font.ArialBold title.Text="Vulgar"
title.TextSize=30 title.TextColor3=THEME.TextPrimary title.TextXAlignment=Enum.TextXAlignment.Left
title.TextTransparency=1 title.Parent=sidebar

local divider=Instance.new("Frame")
divider.Size=UDim2.new(1,-40,0,1) divider.Position=UDim2.new(0,20,0,54)
divider.BackgroundColor3=THEME.Divider divider.BackgroundTransparency=1 divider.BorderSizePixel=0 divider.Parent=sidebar

local catHolder=Instance.new("Frame")
catHolder.Size=UDim2.new(1,0,1,-90) catHolder.Position=UDim2.new(0,0,0,60)
catHolder.BackgroundTransparency=1 catHolder.Parent=sidebar

local lay=Instance.new("UIListLayout")
lay.Padding=UDim.new(0,8) lay.Parent=catHolder

local windows={} local catButtons={} local catStates={}
local openOrder={}
local W=260 local H=380 local SPACE=30

local function updatePositions()
    local x=260
    for _,cat in ipairs(openOrder) do
        if catStates[cat] then
            local w=windows[cat]
            w.Position=UDim2.new(0,x,0.5,-H/2)
            x=x+W+SPACE
        end
    end
end

local function toggleWindow(cat)
    catStates[cat]=not catStates[cat]

    if catStates[cat] then
        table.insert(openOrder,cat)
        local w=windows[cat]
        w.Visible=true w.BackgroundTransparency=1
        tween(w,TweenInfo.new(0.25,Enum.EasingStyle.Sine),{BackgroundTransparency=0})
        catButtons[cat].BackgroundColor3=THEME.ButtonBG_Active
    else
        local w=windows[cat]
        tween(w,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{BackgroundTransparency=1})
        task.delay(0.19,function() if not catStates[cat] then w.Visible=false end end)
        catButtons[cat].BackgroundColor3=THEME.ButtonBG
        for i,v in ipairs(openOrder) do if v==cat then table.remove(openOrder,i) break end end
    end

    updatePositions()
end

local featureStates={}

local function makeFeature(parent,cat,name)
    featureStates[cat]=featureStates[cat] or {}
    featureStates[cat][name]=false

    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,0,0,34) row.BackgroundTransparency=1 row.Parent=parent

    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-80,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Font=Enum.Font.Gotham lbl.Text=name
    lbl.TextSize=18 lbl.TextColor3=THEME.TextSecondary lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=row

    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,50,0,24) btn.Position=UDim2.new(1,-60,0.5,-12)
    btn.BackgroundColor3=THEME.ToggleOff btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.Text=""
    btn.Parent=row

    local cr=Instance.new("UICorner") cr.CornerRadius=UDim.new(1,0) cr.Parent=btn

    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,18,0,18) knob.Position=UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3=THEME.TextPrimary knob.BorderSizePixel=0 knob.Parent=btn

    local cr2=Instance.new("UICorner") cr2.CornerRadius=UDim.new(1,0) cr2.Parent=knob

    btn.MouseButton1Click:Connect(function()
        local s=not featureStates[cat][name]
        featureStates[cat][name]=s
        tween(knob,TweenInfo.new(0.15,Enum.EasingStyle.Sine),{
            Position=s and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
        })
        tween(btn,TweenInfo.new(0.15,Enum.EasingStyle.Sine),{
            BackgroundColor3=s and THEME.TextPrimary or THEME.ToggleOff
        })
        print("[VulgarUI]",cat,name,s)
    end)
end

for cat,features in pairs(CATS) do
    catStates[cat]=false

    local h=Instance.new("Frame")
    h.Size=UDim2.new(1,0,0,36) h.BackgroundTransparency=1 h.Parent=catHolder

    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,-40,1,0) b.Position=UDim2.new(0,20,0,0)
    b.BackgroundColor3=THEME.ButtonBG b.BorderSizePixel=0 b.AutoButtonColor=false b.Text=""
    b.Parent=h

    local cr=Instance.new("UICorner") cr.CornerRadius=UDim.new(0,8) cr.Parent=b

    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-20,1,0) lbl.Position=UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency=1 lbl.Font=Enum.Font.Gotham lbl.Text=cat
    lbl.TextSize=18 lbl.TextColor3=THEME.TextSecondary lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Parent=b

    catButtons[cat]=b

    local w=round(gui,UDim2.new(0,W,0,H),UDim2.new(0,260,0.5,-H/2),THEME.WindowBG,UDim.new(0,10))
    w.Visible=false w.BackgroundTransparency=1

    local head=Instance.new("Frame")
    head.Size=UDim2.new(1,0,0,36) head.BackgroundTransparency=1 head.Parent=w

    local hl=Instance.new("TextLabel")
    hl.Size=UDim2.new(1,-20,1,0) hl.Position=UDim2.new(0,14,0,0)
    hl.BackgroundTransparency=1 hl.Font=Enum.Font.GothamBold hl.Text=cat
    hl.TextSize=20 hl.TextColor3=THEME.TextPrimary hl.TextXAlignment=Enum.TextXAlignment.Left
    hl.Parent=head

    local sep=Instance.new("Frame")
    sep.Size=UDim2.new(1,-20,0,1) sep.Position=UDim2.new(0,10,0,34)
    sep.BackgroundColor3=THEME.Divider sep.BorderSizePixel=0 sep.Parent=w

    local scroll=Instance.new("ScrollingFrame")
    scroll.Size=UDim2.new(1,-10,1,-44) scroll.Position=UDim2.new(0,5,0,40)
    scroll.BackgroundTransparency=1 scroll.ScrollBarThickness=2
    scroll.ScrollBarImageColor3=THEME.Divider scroll.CanvasSize=UDim2.new(0,0,0,0)
    scroll.Parent=w

    local ll=Instance.new("UIListLayout")
    ll.Padding=UDim.new(0,8) ll.SortOrder=Enum.SortOrder.LayoutOrder ll.Parent=scroll

    ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize=UDim2.new(0,0,0,ll.AbsoluteContentSize.Y+15)
    end)

    for _,feat in ipairs(features) do makeFeature(scroll,cat,feat) end

    drag(w,head)
    windows[cat]=w

    b.MouseButton1Click:Connect(function() toggleWindow(cat) end)
end

tween(sidebar,TweenInfo.new(0.35,Enum.EasingStyle.Sine),{BackgroundTransparency=0})
tween(title,TweenInfo.new(0.45,Enum.EasingStyle.Sine),{TextTransparency=0})
tween(divider,TweenInfo.new(0.45,Enum.EasingStyle.Sine),{BackgroundTransparency=0})

local visible=true
UserInputService.InputBegan:Connect(function(i,p)
    if p then return end
    if i.KeyCode==Enum.KeyCode.RightShift then
        visible=not visible gui.Enabled=visible
    end
end)
