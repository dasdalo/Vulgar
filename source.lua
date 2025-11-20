local Vulgar={}
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local PL=game:GetService("Players")

local function C(c,p)
local o=Instance.new(c)
for i,v in pairs(p or{})do
if i~="Parent"then o[i]=v end
end
if p and p.Parent then o.Parent=p.Parent end
return o
end

local Blur=Instance.new("BlurEffect")
Blur.Size=0
Blur.Parent=game.Lighting

local NotifContainer=C("Frame",{Size=UDim2.new(0,300,0,0),Position=UDim2.new(1,-320,1,-20),BackgroundTransparency=1,Parent=game.CoreGui})
local NotifList=C("UIListLayout",{Padding=UDim.new(0,8),HorizontalAlignment=Enum.HorizontalAlignment.Right,VerticalAlignment=Enum.VerticalAlignment.Bottom,SortOrder=Enum.SortOrder.LayoutOrder,Parent=NotifContainer})

local function Notify(text,dur)
dur=dur or 4
local n=C("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=Color3.fromRGB(25,25,30),BackgroundTransparency=1,Parent=NotifContainer})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=n})
C("UIStroke",{Color=Color3.fromRGB(0,170,255),Transparency=0.7,Thickness=1.5,Parent=n})
local l=C("TextLabel",{Size=UDim2.new(1,-20,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=text,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBold,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left,Parent=n})
n.Size=UDim2.new(1,0,0,0)
TS:Create(n,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{Size=UDim2.new(1,0,0,50),BackgroundTransparency=0.05}):Play()
TS:Create(n.UIStroke,TweenInfo.new(0.4),{Transparency=0.3}):Play()
task.wait(dur)
TS:Create(n,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1}):Play()
TS:Create(n.UIStroke,TweenInfo.new(0.3),{Transparency=1}):Play()
task.wait(0.3)
n:Destroy()
end

function Vulgar:CreateLauncher(o)
o=o or{}
local t=o.Title or"Vulgar"
local func=o.OnLaunch or function()end

local sg=C("ScreenGui",{Name="VLauncher",ResetOnSpawn=false,Parent=game.CoreGui})
local mf=C("Frame",{Size=UDim2.new(0,420,0,540),Position=UDim2.new(0.5,-210,0.5,-270),BackgroundColor3=Color3.fromRGB(18,18,22),BackgroundTransparency=1,Parent=sg})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=mf})
C("UIGradient",{Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(40,40,50)),ColorSequenceKeypoint.new(1,Color3.fromRGB(12,12,16))},Rotation=135,Parent=mf})
local st=C("UIStroke",{Color=Color3.fromRGB(0,170,255),Thickness=2,Transparency=1,Parent=mf})

local title=C("TextLabel",{Size=UDim2.new(1,0,0,70),BackgroundTransparency=1,Text=t,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBlack,TextSize=36,Parent=mf})
local subtitle=C("TextLabel",{Size=UDim2.new(1,0,0,30),Position=UDim2.new(0,0,0,70),BackgroundTransparency=1,Text="Premium Cheat Interface",TextColor3=Color3.fromRGB(0,170,255),Font=Enum.Font.GothamBold,TextSize=16,Parent=mf})

local btn=C("TextButton",{Size=UDim2.new(0,280,0,60),Position=UDim2.new(0.5,-140,1,-120),BackgroundColor3=Color3.fromRGB(0,170,255),Text="LAUNCH",TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBlack,TextSize=20,AutoButtonColor=false,Parent=mf})
C("UICorner",{CornerRadius=UDim.new(0,10),Parent=btn})
C("UIStroke",{Color=Color3.fromRGB(0,100,200),Thickness=2,Parent=btn})

local glow=C("ImageLabel",{Size=UDim2.new(2,0,2,0),Position=UDim2.new(0.5,0,0.5,0),BackgroundTransparency=1,Image="rbxassetid://431637172",ImageColor3=Color3.fromRGB(0,170,255),ImageTransparency=0.9,Parent=mf})

btn.MouseEnter:Connect(function()
TS:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(0,200,255)}):Play()
TS:Create(glow,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0,true),{ImageTransparency=0.7}):Play()
end)
btn.MouseLeave:Connect(function()
TS:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(0,170,255)}):Play()
end)

mf.BackgroundTransparency=1
TS:Create(mf,TweenInfo.new(0.7,Enum.EasingStyle.Quint),{BackgroundTransparency=0}):Play()
TS:Create(st,TweenInfo.new(0.7),{Transparency=0.4}):Play()
TS:Create(glow,TweenInfo.new(1.2),{Rotation=360,ImageTransparency=0.95}):Play()

btn.MouseButton1Click:Connect(function()
TS:Create(btn,TweenInfo.new(0.15),{Size=UDim2.new(0,260,0,55)}):Play()
task.wait(0.15)
TS:Create(mf,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{Size=UDim2.new(0,0,0,0),BackgroundTransparency=1}):Play()
TS:Create(st,TweenInfo.new(0.4),{Transparency=1}):Play()
task.wait(0.4)
sg:Destroy()
func()
end)
end

function Vulgar:Window(o)
o=o or{}
local title=o.Title or"Vulgar"

local sg=C("ScreenGui",{Name="VulgarMain",ResetOnSpawn=false,Parent=game.CoreGui})
local main=C("Frame",{Size=UDim2.new(0,660,0,480),Position=UDim2.new(0.5,-330,0.5,-240),BackgroundColor3=Color3.fromRGB(18,18,22),BackgroundTransparency=1,ClipsDescendants=true,Parent=sg})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=main})
C("UIGradient",{Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(35,35,45)),ColorSequenceKeypoint.new(1,Color3.fromRGB(12,12,16))},Rotation=135,Parent=main})
local stroke=C("UIStroke",{Color=Color3.fromRGB(0,170,255),Thickness=2,Transparency=1,Parent=main})

local top=C("Frame",{Size=UDim2.new(1,0,0,44),BackgroundColor3=Color3.fromRGB(22,22,28),BackgroundTransparency=0.4,Parent=main})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=top})
local tit=C("TextLabel",{Size=UDim2.new(0,200,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=title,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBlack,TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=top})

local close=C("TextButton",{Size=UDim2.new(0,36,0,36),Position=UDim2.new(1,-46,0,4),BackgroundTransparency=1,Text="×",TextColor3=Color3.fromRGB(255,80,80),Font=Enum.Font.GothamBlack,TextSize=24,Parent=top})
close.MouseEnter:Connect(function()TS:Create(close,TweenInfo.new(0.2),{TextColor3=Color3.fromRGB(255,50,50)}):Play()end)
close.MouseLeave:Connect(function()TS:Create(close,TweenInfo.new(0.2),{TextColor3=Color3.fromRGB(255,80,80)}):Play()end)
close.MouseButton1Click:Connect(function()
TS:Create(main,TweenInfo.new(0.4,Enum.EasingStyle.Quint),{BackgroundTransparency=1,Size=UDim2.new(0,0,0,0)}):Play()
TS:Create(stroke,TweenInfo.new(0.4),{Transparency=1}):Play()
TS:Create(Blur,TweenInfo.new(0.4),{Size=0}):Play()
task.wait(0.4)
sg:Destroy()
end)

local tabs=C("Frame",{Size=UDim2.new(0,160,1,-54),Position=UDim2.new(0,0,0,54),BackgroundTransparency=1,Parent=main})
local content=C("Frame",{Size=UDim2.new(1,-170,1,-54),Position=UDim2.new(0,165,0,54),BackgroundTransparency=1,Parent=main})

local drag={}
top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag={true,i.Position,main.Position}end end)
top.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag[1]=false end end)
UIS.InputChanged:Connect(function(i)if drag[1]and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-drag[2];main.Position=UDim2.new(drag[3].X.Scale,drag[3].X.Offset+d.X,drag[3].Y.Scale,drag[3].Y.Offset+d.Y)end end)

local visible=true
UIS.InputBegan:Connect(function(i,p)
if not p and i.KeyCode==Enum.KeyCode.RightShift then
visible=not visible
if visible then
main.Visible=true
TS:Create(main,TweenInfo.new(0.35,Enum.EasingStyle.Quint),{BackgroundTransparency=0}):Play()
TS:Create(stroke,TweenInfo.new(0.35),{Transparency=0.4}):Play()
TS:Create(Blur,TweenInfo.new(0.35),{Size=16}):Play()
else
TS:Create(main,TweenInfo.new(0.35,Enum.EasingStyle.Quint),{BackgroundTransparency=1}):Play()
TS:Create(stroke,TweenInfo.new(0.35),{Transparency=1}):Play()
TS:Create(Blur,TweenInfo.new(0.35),{Size=0}):Play()
task.wait(0.35)
main.Visible=false
end
end
end)

local tablist={}
local cur

local function newtab(name,icon)
local btn=C("TextButton",{Size=UDim2.new(1,-20,0,42),Position=UDim2.new(0,10,0,#tablist*48),BackgroundColor3=Color3.fromRGB(28,28,34),BackgroundTransparency=0.5,Text="",AutoButtonColor=false,Parent=tabs})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=btn})
local ic=C("ImageLabel",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,14,0.5,-11),BackgroundTransparency=1,Image=icon or"rbxassetid://7072717849",ImageColor3=Color3.fromRGB(150,150,150),Parent=btn})
local tx=C("TextLabel",{Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,48,0,0),BackgroundTransparency=1,Text=name,TextColor3=Color3.fromRGB(180,180,180),Font=Enum.Font.GothamBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Parent=btn})

local cont=C("ScrollingFrame",{Size=UDim2.new(1,-20,1,-20),Position=UDim2.new(0,10,0,10),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=Color3.fromRGB(0,170,255),CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false,Parent=content})
C("UIListLayout",{Padding=UDim.new(0,10),Parent=cont})

local function sel()
if cur then cur.Visible=false cur.Parent.BackgroundTransparency=0.5 cur.Parent.BackgroundColor3=Color3.fromRGB(28,28,34)end
cont.Visible=true
cur=cont
TS:Create(btn,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{BackgroundTransparency=0.1}):Play()
btn.BackgroundColor3=Color3.fromRGB(0,170,255)
ic.ImageColor3=Color3.fromRGB(255,255,255)
tx.TextColor3=Color3.fromRGB(255,255,255)
end

btn.MouseButton1Click:Connect(sel)
btn.MouseEnter:Connect(function()if cur~=cont then TS:Create(btn,TweenInfo.new(0.2),{BackgroundTransparency=0.3}):Play()end end)
btn.MouseLeave:Connect(function()if cur~=cont then TS:Create(btn,TweenInfo.new(0.2),{BackgroundTransparency=0.5}):Play()end end)

if #tablist==0 then sel()end
table.insert(tablist,btn)

local tab={}
function tab:Section(n)
local sec=C("Frame",{Size=UDim2.new(1,0,0,36),BackgroundColor3=Color3.fromRGB(28,28,34),BackgroundTransparency=0.4,Parent=cont})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=sec})
local st=C("TextLabel",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=n,TextColor3=Color3.fromRGB(0,170,255),Font=Enum.Font.GothamBlack,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left,Parent=sec})

local col=C("Frame",{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y,Parent=cont})
C("UIListLayout",{Padding=UDim.new(0,8),Parent=col})

local el={}
function el:Toggle(txt,cb)
cb=cb or function()end
local v=false
local f=C("TextButton",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(30,30,38),BackgroundTransparency=0.6,Text="",AutoButtonColor=false,Parent=col})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=f})
local l=C("TextLabel",{Size=UDim2.new(1,-70,1,0),Position=UDim2.new(0,16,0,0),BackgroundTransparency=1,Text=txt,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
local ind=C("Frame",{Size=UDim2.new(0,46,0,24),Position=UDim2.new(1,-62,0.5,-12),BackgroundColor3=Color3.fromRGB(45,45,55),Parent=f})
C("UICorner",{CornerRadius=UDim.new(0,12),Parent=ind})
local cir=C("Frame",{Size=UDim2.new(0,20,0,20),Position=UDim2.new(0,3,0.5,-10),BackgroundColor3=Color3.fromRGB(255,255,255),Parent=ind})
C("UICorner",{CornerRadius=UDim.new(1,0),Parent=cir})
f.MouseButton1Click:Connect(function()
v=not v
TS:Create(ind,TweenInfo.new(0.25,Enum.EasingStyle.Quint),{BackgroundColor3=v and Color3.fromRGB(0,170,255)or Color3.fromRGB(45,45,55)}):Play()
TS:Create(cir,TweenInfo.new(0.25,Enum.EasingStyle.Quint),{Position=v and UDim2.new(1,-23,0.5,-10)or UDim2.new(0,3,0.5,-10)}):Play()
cb(v)
end)
end

function el:Slider(txt,min,max,cb)
cb=cb or function()end
local val=min
local s=C("Frame",{Size=UDim2.new(1,0,0,56),BackgroundColor3=Color3.fromRGB(30,30,38),BackgroundTransparency=0.6,Parent=col})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=s})
local l=C("TextLabel",{Size=UDim2.new(1,-100,0,24),Position=UDim2.new(0,16,0,6),BackgroundTransparency=1,Text=txt,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,Parent=s})
local vtxt=C("TextLabel",{Size=UDim2.new(0,60,0,24),Position=UDim2.new(1,-76,0,6),BackgroundTransparency=1,Text=tostring(min),TextColor3=Color3.fromRGB(0,170,255),Font=Enum.Font.GothamBold,TextSize=13,Parent=s})
local bar=C("Frame",{Size=UDim2.new(1,-32,0,10),Position=UDim2.new(0,16,1,-18),BackgroundColor3=Color3.fromRGB(40,40,50),Parent=s})
C("UICorner",{CornerRadius=UDim.new(0,5),Parent=bar})
local fill=C("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(0,170,255),Parent=bar})
C("UICorner",{CornerRadius=UDim.new(0,5),Parent=fill})
local drag=C("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0,-9,0.5,-9),BackgroundColor3=Color3.fromRGB(255,255,255),Text="",AutoButtonColor=false,Parent=fill})
C("UICorner",{CornerRadius=UDim.new(1,0),Parent=drag})
local dragging=false
drag.MouseButton1Down:Connect(function()dragging=true end)
UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
UIS.InputChanged:Connect(function(i)
if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
local rel=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
val=math.floor(min+(max-min)*rel)
fill.Size=UDim2.new(rel,0,1,0)
drag.Position=UDim2.new(rel,-9,0.5,-9)
vtxt.Text=tostring(val)
cb(val)
end
end)
end

function el:Button(txt,cb)
local b=C("TextButton",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(0,170,255),BackgroundTransparency=0.2,Text=txt,TextColor3=Color3.fromRGB(255,255,255),Font=Enum.Font.GothamBlack,TextSize=14,AutoButtonColor=false,Parent=col})
C("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
b.MouseButton1Click:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundTransparency=0.5}):Play()
task.wait(0.12)
TS:Create(b,TweenInfo.new(0.12),{BackgroundTransparency=0.2}):Play()
cb()
end)
end

return el
end
return tab
end

TS:Create(main,TweenInfo.new(0.6,Enum.EasingStyle.Quint),{BackgroundTransparency=0}):Play()
TS:Create(stroke,TweenInfo.new(0.6),{Transparency=0.4}):Play()
TS:Create(Blur,TweenInfo.new(0.6),{Size=16}):Play()

Notify("Vulgar successfully loaded!",5)
Notify("Press RightShift to toggle menu",5)

return {CreateTab=newtab}
end

return Vulgar
