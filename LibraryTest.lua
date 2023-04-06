local RMA={}
local Frames={}
local Players=game:GetService'Players'
local LocalPlayer=Players.LocalPlayer
local CoreGui=game.CoreGui
local LPG=LocalPlayer.PlayerGui
local MG=LPG:FindFirstChild'MainGui'or LPG:WaitForChild'MainGui'
RMA.AllBools={}
local function Create(Type)
	if type(Type)~='string'then error("Argument of Create must be a string",2)end return function(dat)dat=dat or{}local obj=Instance.new(Type)local parent,ctor for k,v in next,dat do if type(k)=='string'then if k=='Parent'then parent=v continue end obj[k]=v elseif type(k)=='number'then if type(v)~='userdata'then error("Bad entry in Create body: Numeric keys must be paired with children, got a: "..type(v),2)end v.Parent=obj elseif type(k)=='table'and k.__eventname then if type(v)~='function'then error("Bad entry in Create body: Key `[Create.E\'"..k.__eventname.."\']` must have a function value, got: "..tostring(v),2)end obj[k.__eventname]:Connect(v)elseif k==Create then if type(v)~='function'then error("Bad entry in Create body: Key `[Create]` should be paired with a constructor function, got: "..tostring(v),2)elseif ctor then error("Bad entry in Create body: Only one constructor function is allowed",2)end ctor=v else error("Bad entry ("..tostring(k).." => "..tostring(v)..") in Create body",2)end end if ctor then ctor(obj)end if parent then obj.Parent=parent end return obj end
end
RMA.Create=Create
function RMA:GetTables()
	return Frames,RMA.AllBools
end
function RMA.CreateBool(Xame,Value)
	local Bool=Create'BoolValue'{Parent=CoreGui,Name=Xame}
	if Value then
		Bool.Value=Value
	end
	RMA.AllBools[Xame]=Bool
	Bool:GetPropertyChangedSignal'Value':Connect(function()
		local str='local Conf={\n'
		for n,b in next,select(2,RMA:GetTables())do
			str..=('	%s=%s,\n'):format(n,tostring(b.Value))
		end
		str..='}\return Conf'
		writefile('RMA2CONFIG.lua',str)
	end)
	return Bool
end
local function ClickSound()
	task.spawn(function()
		local Sound=Create'Sound'{Parent=workspace,Volume=.5,SoundId='rbxassetid://869185498'}
		Sound:Play()
		Sound.Ended:Wait()
		Sound:Destroy()
	end)
end
RMA.ClickSound=ClickSound
local function Link(Button,Frame)
	Button.MouseButton1Click:Connect(function()
		ClickSound()
		Frame.Visible=not Frame.Visible
		if not Frame.Visible then return end
		for _,x in next,MG:GetChildren()do
			if x:IsA'Frame'and x.Name:match'Frame$'and x.Name~='NotificationFrame'and x~=Frame then 
				x.Visible=false
			end
		end
	end)
end
RMA.Link=Link
function RMA:CreateIcon(Xame,Xmage,Xosition,XnchorPoint)
	local Label=Create'ImageButton'{Parent=MG,Name=Xame,Size=UDim2.new(0,40,0,40),Position=Xosition,BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Image=Xmage,AnchorPoint=XnchorPoint or Vector2.new(0,0)}
	local UICorner=Create'UICorner'{CornerRadius=UDim.new(0,8),Parent=Label}
	local Icon={}
	function Icon:BindTo(Table)
		Link(Label,Table.Gui)
	end
	function Icon.OnClick(Func)
		Label.MouseButton1Click:Connect(Func)
	end
	Icon.Gui=Label
	return Icon
end
function RMA:CreateButtonOld(Xame,Xext,Xosition,XnchorPoint)
	local Button=Create'TextButton'{Parent=MG,Name=Xame,Text=Xext,Size=UDim2.new(0,40,0,40),Position=Xosition,BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Font=Enum.Font.SourceSansSemibold,TextScaled=true,AnchorPoint=XnchorPoint or Vector2.new(0,0)}
	Button.MouseButton1Click:Connect(ClickSound)
	local UICorner=Create'UICorner'{Parent=Button,CornerRadius=UDim.new(0,8)}
	local Buttons={}
	function Buttons:BindTo(Frame)
		Link(Button,Frame)
	end
	function Buttons.OnClick(Func)
		Button.MouseButton1Click:Connect(Func)
	end
	Buttons.Gui=Button
	return Buttons
end
function RMA:CreateFrame(Xame,Heading)
	local Label=Create'Frame'{Parent=MG,Name=Xame..'Frame',Size=UDim2.new(.4,0,.5,0),Position=UDim2.new(.3,0,.25,0),BackgroundColor3=Color3.fromRGB(34,34,34),BorderSizePixel=1,Style='Custom',Visible=false}
	local LHeading=Create'TextLabel'{Parent=Label,AutomaticSize=Enum.AutomaticSize.None,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name='Heading',Position=UDim2.new(0,0,.025,0),Size=UDim2.new(1,0,.1,0),Font=Enum.Font.SourceSansSemibold,LineHeight=1,RichText=false,Text=Heading,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center}
	local UICorner=Create'UICorner'{Parent=Label,CornerRadius=UDim.new(0,16)}
	local CloseButton=Create'ImageButton'{Parent=Label,Name='CloseButton',Size=UDim2.new(.1,0,.15,0),Image='rbxassetid://5198838744',Position=UDim2.new(.95,0,.1,0),AnchorPoint=Vector2.new(0,1),BackgroundTransparency=1}
	CloseButton.MouseButton1Click:Connect(function()
		ClickSound()
		Label.Visible=false
	end)
	table.insert(Frames,Label)
	local Panel={}
	function Panel:CreateButton(Xame,Xext,Xosition)
		local Button=Create'TextButton'{Parent=Label,AutoButtonColor=true,BackgroundColor3=Color3.fromRGB(90,90,90),Modal=false,Name=Xame..'Button',Position=Xosition,Size=UDim2.new(.5,0,.075,0),Style=Enum.ButtonStyle.Custom,Font=Enum.Font.SourceSansSemibold,LineHeight=1,Text=Xext,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextWrapped=true}
		local UICorner=Create'UICorner'{CornerRadius=UDim.new(0,8),Parent=Button}
		local Buttons={}
		function Buttons:BindTo(Table)
			local Frame=Table.Gui
			Link(Button,Frame)
		end
		function Buttons.OnClick(Func)
			Button.MouseButton1Click:Connect(Func)
		end
		Buttons.Gui=Button
		return Buttons
	end
	function Panel:CreateDK(Xame,Xosition,Xext,Bool,CodeOff,CodeOn)
		local Instances
		local Frame=Create'Frame'{Parent=Label,AutomaticSize=Enum.AutomaticSize.None,BackgroundTransparency=1,Name=Xame,Position=Xosition,Size=UDim2.new(.9,0,.075,0),Style=Enum.FrameStyle.Custom}
		local Value=Create'ImageButton'{Parent=Frame,AnchorPoint=Vector2.new(1,.5),BackgroundTransparency=1,Name='Value',Position=UDim2.new(1,0,.5,0),Size=UDim2.new(.1,40,1,40),Image='rbxassetid://1759563960',ImageColor3=Color3.fromRGB(90,90,90)}		
		local DKs={}
		local TextL=Create'TextLabel'{Parent=Frame,AutomaticSize=Enum.AutomaticSize.None,BackgroundTransparency=1,Name='Text',Size=UDim2.new(.9,0,1,0),Font=Enum.Font.SourceSansSemibold,Text=Xext,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14,TextXAlignment=Enum.TextXAlignment.Left}
		Value.MouseButton1Click:Connect(function()
			if Bool.Value then				
				Bool.Value=false
				Value.ImageColor3=Color3.fromRGB(90,90,90)
				CodeOn(Instances)
				return
			end
			Bool.Value=true
			Value.ImageColor3=Color3.new(1,1,1)
			Instances=CodeOff()
		end)
		DKs.Gui=Frame
		return DKs
	end
	function Panel:CreateSub(Xext,Xize,XnchorPoint,Xosition,XextTransparency)
		local Subheading=Create'TextLabel'{Parent=Label,BackgroundTransparency=1,Text=Xext,Size=Xize,AnchorPoint=XnchorPoint,Position=Xosition,Name='Subheading',Font=Enum.Font.SourceSansBold,TextColor3=Color3.new(1,1,1),TextScaled=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center}
		if XextTransparency then Subheading.TextTransparency=XextTransparency end
		return Subheading
	end
	Panel.Gui=Label
	return Panel
end
RMA.Frames=Frames
return RMA
