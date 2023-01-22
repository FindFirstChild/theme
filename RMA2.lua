-- i got bored so i assigned multiple variables in one-line
--[[
credits:
	ideas:
		absence#5446
		cam1494
		night
		
	scripting:
		kevinYMHGmlg#1822 (me)
		
まもるクンは呪われてしまった！　「Great Tribulation」
]]
if not game:IsLoaded()then game.Loaded:Wait()end
if _G.RMA2ENABLED then
	error'RMA2 is already running!'
	return
end
_G.RMA2ENABLED=true
local Main=loadstring(game:HttpGet('https://raw.githubusercontent.com/kevinYMHGmlg/theme/main/LibraryBeta'))()
-- services
local Players=game:GetService'Players'
local UserInputService=game:GetService'UserInputService'
local TweenService=game:GetService'TweenService'
local RunService=game:GetService'RunService'
local Teams=game:GetService'Teams'
local ContentProvider=game:GetService'ContentProvider'
local CollectionService=game:GetService'CollectionService'
local ReplicatedStorage=game:GetService'ReplicatedStorage'
-- main functions
local function Set(Xnstance)
	return function(Parameters)
		for Parameter,Value in next,Parameters do
			if type(Parameter)=='number'then
				Value.Parent=Xnstance
				continue
			end
			Xnstance[Parameter]=Value
		end
	end
end
local Create=Main.Create
-- local
local LocalPlayer=Players.LocalPlayer
local CurrentCamera=workspace.CurrentCamera
local LMouse=LocalPlayer:GetMouse()
local CoreGui=game.CoreGui
local LPG=LocalPlayer.PlayerGui
local MG=LPG:FindFirstChild'MainGui'or LPG:WaitForChild'MainGui'
local M=LPG.ManagerGui.ServerSettingFrame
local Knight=Teams.Knight
local KC,UIT=Enum.KeyCode,Enum.UserInputType
local JewellStand=workspace:FindFirstChild'JewelleryStand'
local Tag,CurrentVersion=MG.VersionTag						,						'v1.1.9'
local Heartbeat=RunService.Heartbeat
local AllBools,Frames={},{}
local TableBooth={}
for _,x in next,workspace:GetChildren()do
	if x.Name=='Booth'and x:IsA'Model'then
		table.insert(TableBooth,x)
	end
end
local Parameter=RaycastParams.new{FilterType=Enum.RaycastFilterType.Whitelist,FilterDescendantsInstances={Booths}}
local Positions={Vector3.new(-42.5,3.26,-65.8),Vector3.new(-28.5,3.26,-65.8),Vector3.new(-14.5,3.26,-65.8),Vector3.new(-0.5,3.26,-65.8),Vector3.new(13.5,3.26,-65.8),Vector3.new(27.5,3.26,-65.8),Vector3.new(74.8,3.26,-27.9),Vector3.new(74.8,3.26,-13.9),Vector3.new(74.8,3.26,0),Vector3.new(74.8,3.26,14),Vector3.new(74.8,3.26,27),Vector3.new(74.8,3.26,41),Vector3.new(27.5,3.26,77.8),Vector3.new(13.5,3.26,77.8),Vector3.new(-0.5,3.26,77.8),Vector3.new(-14.5,3.26,77.8),Vector3.new(-28.5,3.26,77.8),Vector3.new(-42.5,3.26,77.8)}
local LookVector=Vector3.new(1,0,0)
local Temp={}
for _,i in next,Positions do
	local Raycast=workspace:Raycast(i,Vector3.new(0,-1,0),Parameter)
	if not Raycast then continue end
	local Model=Raycast.Instance.Parent
	table.insert(Temp,Model)
end
Booths=Temp
Temp=nil
local PlayerAdded=Create'BindableEvent'{Parent=CoreGui}
local PlayerRemoving=Create'BindableEvent'{Parent=CoreGui}
local PlayersTable={}
for _,x in next,Players:GetPlayers()do
	if x==LocalPlayer then continue end
	table.insert(PlayersTable,x)
end
local BI=Players.PlayerAdded:Connect(function(Player)
	table.insert(PlayersTable,Player)
	PlayerAdded:Fire(Player)
end)
local BII=Players.PlayerRemoving:Connect(function(Player)
	PlayersTable[table.find(PlayersTable,Player.Name)or-1]=nil
	PlayerRemoving:Fire(Player)
end)
--functions
local SetClip=toclipboard or setclipboard 
local IS=RunService:IsStudio()	
local function SetBarrier(a,b)
	if a.Name:match'^BarrierFor'and a:IsA'BasePart'then
		if b then
			Set(a){CanTouch=true,CastShadow=true,BrickColor=BrickColor.new(165,0,3)}
			return
		end 
		Set(a){CanTouch=false,CanQuery=true,CastShadow=false,Transparency=.95,BrickColor=BrickColor.new(200,200,200)}
	end
end
local function Loop(Directory,CaseSword,CaseHandle)
	for _,Item in next,Directory:GetChildren()do
		if Item:IsA'Tool'and Item.Name=='ClassicSword'then
			if CaseSword then CaseSword()end
			local Handle=Item:FindFirstChild'Handle'or Item:WaitForChild('Handle',1)
			if not Handle then Item:Destroy()return end
			if CaseHandle then CaseHandle(Item,Handle)end
		end
	end
end
local CreateBool=Main.CreateBool
local function Destroy(a,b,c)
	local d=a 
	if not b then 
		if d then 
			if typeof(d)=='RBXScriptConnection'then 
				d:Disconnect()
				return 
			end 
			d:Destroy()
		end 
		return 
	end 
	d=d:FindFirstChild(b)
	if c then 
		d=a:FindFirstChildWhichIsA(b)
	end 
	if d then
		d:Destroy()
		return 
	end
end
local ClickSound=Main.ClickSound
local Link=Main.Link
local function RequestSword()
	ReplicatedStorage.RequestTool:FireServer'ClassicSword'
end
local function a(p)
	local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
	if not HumanoidRootPart then
		Main.Notify('Missing HumanoidRootPart.',3)
		return
	end
	local OldCFrame=HumanoidRootPart.CFrame
	JewellStand.CanCollide,HumanoidRootPart.CFrame=false,JewellStand.CFrame
	repeat
		if not p.Enabled then
			break
		end
		HumanoidRootPart.CFrame,HumanoidRootPart.Velocity=JewellStand.CFrame,Vector3.new(0,0,0)
		fireproximityprompt(p)
		task.wait(.1)
	until not p.Enabled
	JewellStand.CanCollide,HumanoidRootPart.CFrame=true,OldCFrame
	return true
end
local function Notify(Message,Duration,Warn)
    task.spawn(function()
		if Warn then warn(Message)end
		if not Duration then Duration=5 end
		local NFrame=Create'Frame'{Parent=MG,BackgroundColor3=Color3.fromRGB(34,34,34),Name='NFrame',Position=UDim2.new(.2,0,.05,0),Size=UDim2.new(.6,0,.06,0),Style=Enum.FrameStyle.Custom}
		local Notif=Create'TextLabel'{Parent=NFrame,AutomaticSize=Enum.AutomaticSize.None,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name='NotificationText',Position=UDim2.new(.05,0,.175,0),Size=UDim2.new(.9,0,.65,0),Font=Enum.Font.SourceSansSemibold,Text=Message,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14}
		local UISC=Create'UISizeConstraint'{Parent=Notif.Parent}
		local UIC=Create'UICorner'{Parent=Notif.Parent}
		local NSound=MG['Main Gui Core']:FindFirstChild'NotificationSound'
		if NSound then
			NSound:Play()
			NFrame:Destroy(task.wait(Duration-NSound.TimePosition))
			return
		end
		warn'Notif Missing, creating a new one..'
		local NewNSound=Create'Sound'{SoundId='rbxassetid://4590662766',Volume=.5,Parent=MG['Main Gui Core']}
	end)
end
--bools 
local IsAutoClaim,IsAntiProx,IsShowingDupeMenu,IsShowingDesc=CreateBool'IACK',CreateBool'IAP',CreateBool'ISDM',CreateBool'ISD'
local IsAutoRespawn,IsAntiBarrier,IsMusicEnabled,IsBypassLocal=CreateBool'IAR',CreateBool'IAB',CreateBool'IME',CreateBool'IBL'
local IsSnipingBooth=CreateBool'ISB'
--guis
local Frame=Main.CreateFrame('Custom','hi')
Frame.CreateSub('credits:\nideas:\ncryniz#5446\ncam1494#7363\nscript:\nkevinYMHGmlg#1822',UDim2.new(.6,0,.9,0),Vector2.new(0,.5),UDim2.new(1.05,0,.5,0),.9)
local MainIcon=Main.CreateIcon('ExploitButton','rbxassetid://10462982957',UDim2.new(0,20,.5,-80))
local KnightButton=Frame.CreateButton('Knight','Knight Panel',UDim2.new(.05,0,.75,0))
local WorldButton=Frame.CreateButton('World','W o r l d',UDim2.new(.05,0,.65,0))
local LocalButton=Frame.CreateButton('Local','Localplayer',UDim2.new(.05,0,.55,0))
local BoothButton=Frame.CreateButton('Booth','Booth',UDim2.new(.05,0,.45,0))
local GuiDestroy=Frame.CreateButton('SelfDestruct','Disconnect Gui',UDim2.new(.05,0,.85,0))
GuiDestroy.Gui.BackgroundColor3=Color3.fromRGB(150,64,27)
local WorldMenu=Main.CreateFrame('others','s')
local WorldReturn=WorldMenu.CreateButton('R','Return',UDim2.new(.05,0,.85,0))
local KnightMenu=Main.CreateFrame('Knight','knight panel')
local KnightReturn=KnightMenu.CreateButton('R','Return',UDim2.new(.05,0,.55,0))
local BoothMenu=Main.CreateFrame('Booth','game.service(\'WorkSpace\',game)[\'FilteringEnabled\']=not not Instance.new\'BoolValue\'.Value')
local Snipings=BoothMenu.CreateButton('Snipe','Auto Claim Booth..',UDim2.new(.05,0,.45,0))
local SnipeBooth=Main.CreateFrame('AutoSnipe','hiyah')
local BoothReturn=BoothMenu.CreateButton('R','Return',UDim2.new(.05,0,.35,0))
local LocalMenu=Main.CreateFrame('Local','workspace.FilteringEnabled=false')
local LocalReturn=LocalMenu.CreateButton('R','Return',UDim2.new(.05,0,.35,0))
local TeleportMenu=MG.ContentMenuFrame:Clone()
Set(TeleportMenu){Parent=MG,Name='TeleportationFrame'}
table.insert(Frames,TeleportMenu)
TeleportMenu.Heading.Text='teleportations'
TeleportMenu.Subheading.Text='HumanoidRootPart.CFrame=CFrame.new(pos)*CFrame.Angles(0,ori,0)'
local CKButton=KnightMenu.CreateButton('CK','Claim Knight',UDim2.new(.05,0,.35,0))
local RSButton=KnightMenu.CreateButton('RS','Request Sword',UDim2.new(.05,0,.45,0))
local TPButton=Frame.CreateButton('TP','Teleportations',UDim2.new(.05,0,.35,0))
local DButton=LocalMenu.CreateButton('D','DrawGui.lua',UDim2.new(.05,0,.25,0))
--linkers
Link(TeleportMenu.ReturnButton,Frame.Gui)
MainIcon:BindTo(Frame)
KnightReturn:BindTo(Frame)
WorldReturn:BindTo(Frame)
LocalReturn:BindTo(Frame)
BoothReturn:BindTo(Frame)
WorldButton:BindTo(WorldMenu)
KnightButton:BindTo(KnightMenu)
LocalButton:BindTo(LocalMenu)
BoothButton:BindTo(BoothMenu)
Link(TPButton.Gui,TeleportMenu)
--//////////////////      CtC Stage 1B Theme: Extend Ash ~ Hourai Victim      //////////////////--
Notify('2 get started, click on the goofy icon thing on the left, oh! dont forget that this script might break if you change even a small detail in game.',6,true)
getconnections(M.KillButton.MouseButton1Click)[1]:Disable()
Set(Tag){TextSize=20,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(0,360,0,40),Position=UDim2.new(0,40,1,-50),Text='v.1.436 | '..CurrentVersion..' LOCAL MODIFIED.',TextScaled=false,TextWrapped=false,RichText=true}
local CI_UNKNOWN=M.KillButton.MouseButton1Click:Connect(function()
	M.Visible=false
	Notify('No.',3)
end)
GuiDestroy.OnClick(function()
	ClickSound()
	local CountDown=5
	GuiDestroy.Text='o rlly? ('..tostring(CountDown)..')'
	local CI=GuiDestroy.OnClick(function()
		_G.RMA2ENABLED=false
		CI_UNKNOWN:Disconnect()
		PlayerAdded:Destroy(PlayerRemoving:Destroy())
		BI:Disconnect(BII:Disconnect())
		getconnections(M.KillButton.MouseButton1Click)[1]:Enable()
		for _,x in next,AllBools do
			task.spawn(function()
				x.Value=false
				task.wait(.5)
				x:Destroy()
			end)
		end
		Main:Destroy()
		for _,x in next,Frames do
			if x then
				x:Destroy()
			end
		end
		local t={'BlockM','DupeButton','Counter','ClearS'}
		for _,x in next,MG:GetChildren()do
			if table.find(t,x.Name)then
				x:Destroy()
			end
		end
	end)
	for i=CountDown-1,0,-1 do
		CountDown,GuiDestroy.Text=i,'are you sure? ('..tostring(CountDown)..')'
		task.wait(1)
	end
	GuiDestroy.Text='Disconnect Gui'
	CI:Disconnect()
end)
TeleportMenu.CloseButton.MouseButton1Click:Connect(function()
	ClickSound()
	TeleportMenu.Visible=false
end)
local APButton=LocalMenu.CreateDK('AP',UDim2.new(.05,0,.65,0),'Anti Proximity: ',IsAntiProx,
	function()
		task.spawn(function()
			local Humanoid=LocalPlayer.Character:FindFirstChildOfClass'Humanoid'
			if not Humanoid then return end
			task.wait(.1)
			Destroy(Humanoid.RootPart,'ProximityPrompt')
		end)
		local CI=LocalPlayer.CharacterAdded:Connect(function(char)
			local Humanoid=char:FindFirstChildOfClass'Humanoid'or char:WaitForChild'Humanoid'
			task.wait(.1)
			Destroy(Humanoid.RootPart,'ProximityPrompt')
		end)
		return CI
	end,
	function(CI)
		CI:Disconnect()
	end
)
do
	Set(TeleportMenu){Size=UDim2.new(.8,0,.6,0),Position=UDim2.new(.5,0,.5,0),AnchorPoint=Vector2.new(.5,.5)}
	local PlaceSelectionFrame=TeleportMenu:FindFirstChild'ContentSelectionFrame'
	if not PlaceSelectionFrame then
		Notify('Weird, selection frame doesn\'t exist?',2)
		return
	end
	for _,x in next,PlaceSelectionFrame:GetChildren()do
		x:Destroy()
	end
	Set(PlaceSelectionFrame){Size=UDim2.new(.22,0,.5,0),Name='PlaceSelectionFrame'}
	local PlayerSelectionFrame=PlaceSelectionFrame:Clone()
	Set(PlayerSelectionFrame){Position=UDim2.new(.95,0,.4,0),Size=UDim2.new(.67,0,.4,0),AnchorPoint=Vector2.new(1,0),Name='PlayerSelectionFrame',CanvasSize=UDim2.new(0,0,0,2400)}
	PlayerSelectionFrame.Parent=PlaceSelectionFrame.Parent
	local UIListLayout=Create'UIListLayout'{Parent=PlayerSelectionFrame,Padding=UDim.new(0,8),HorizontalAlignment=Enum.HorizontalAlignment.Left,SortOrder=Enum.SortOrder.Name,VerticalAlignment=Enum.VerticalAlignment.Top,FillDirection=Enum.FillDirection.Vertical}
	local UIGridLayout=Create'UIGridLayout'{Parent=PlaceSelectionFrame,CellSize=UDim2.new(0,82,0,82),SortOrder=Enum.SortOrder.Name}
	local Searcher=Create'TextBox'{Parent=TeleportMenu,BackgroundColor3=Color3.fromRGB(61,61,61),AnchorPoint=Vector2.new(1,0),Position=UDim2.new(.95,0,.3,0),Size=UDim2.new(.67,0,.075,0),Font=Enum.Font.SourceSansBold,TextColor3=Color3.new(1,1,1),PlaceholderText='Find player by Name/DisplayName',TextScaled=true,TextWrapped=true,Name='FindSeacher',Text=''}
	local Count=0
	local function condition(frame,length,x)
		for i=1,#length do
			if x:lower():find(length,i,true)then
				frame.Visible=true
				break
			end
			frame.Visible=false
		end
	end
	Searcher:GetPropertyChangedSignal'Text':Connect(function()
		local text=Searcher.Text:lower()
		if text==''then
			for n,_ in next,PlayersTable do
				local UFrame=PlayerSelectionFrame[n]
				UFrame.Visible=true
			end
			return
		end
		for n,d in next,PlayersTable do
			local UFrame=PlayerSelectionFrame[n]
			condition(Frame,#text,n)
			condition(Frame,#text,d)
		end
	end)
	local function CreateTB(Player)
		local Xame=Player.Name
		local dn=Player.DisplayName
		PlayersTable[Xame]=dn
		if dn==''then dn=Xame end
		local TextButton=Create'TextButton'{Parent=PlayerSelectionFrame,Name=Xame,Size=UDim2.new(1,-10,0,40),BackgroundColor3=Color3.fromRGB(163,162,165),BackgroundTransparency=.9,TextColor3=Color3.new(1,1,1),TextScaled=true,Text=dn..' (@'..Xame..')'}
		TextButton.MouseButton1Click:Connect(function()
			local Character=LocalPlayer.Character
			local TCharacter=Player.Character
			if not Character or not TCharacter then 
				Notify('Missing character either on local or target',3)
				return 
			end
			local HumanoidRootPart,THumanoidRootPart=Character:FindFirstChild'HumanoidRootPart',TCharacter:FindFirstChild'HumanoidRootPart'
			if not HumanoidRootPart or not THumanoidRootPart then
				Notify('Missing HMR either on local or target.',3)
				return
			end
			task.spawn(function()
				for i=1,7 do
					HumanoidRootPart.Velocity=Vector3.new(0,0,0)
					task.wait()
				end
			end)
			HumanoidRootPart.CFrame=THumanoidRootPart.CFrame
		end)
	end
	for _,x in next,PlayersTable do
		CreateTB(x)
	end
	PlayerAdded.Event:Connect(function(Player)
		CreateTB(Player)
	end)
	PlayerRemoving.Event:Connect(function(Player)
		local Name=Player.Name
		Destroy(PlayerSelectionFrame,Name)
	end)
	local function CreateIB(Xame,Id,Position,y)
		local ImageButton=Create'ImageButton'{Parent=PlaceSelectionFrame,Name=Xame,BorderSizePixel=0,Image='rbxassetid://1183324'..Id}
		ContentProvider:PreloadAsync({ImageButton})
		ImageButton.MouseButton1Click:Connect(function()
			local Character=LocalPlayer.Character
			if not Character then 
				Notify('Missing character',3,true)
				return 
			end
			local HumanoidRootPart=Character:FindFirstChild'HumanoidRootPart'
			if not HumanoidRootPart then
				Notify('Missing HMR',3,true)
				return
			end
			task.spawn(function()
				for i=1,7 do
					HumanoidRootPart.Velocity=Vector3.new(0,0,0)
					task.wait()
				end
			end)
			HumanoidRootPart.CFrame=CFrame.new(Position)*CFrame.Angles(0,math.rad(y),0)
		end)
	end
	CreateIB('LoungeTop','2216',Vector3.new(-5893,100,38),90)
	CreateIB('Lounge','2446',Vector3.new(-5900,-53,21.25),180)
	CreateIB('TreeI','1126',Vector3.new(60.25,38,-65.25),112.5)
	CreateIB('TreeII','0849',Vector3.new(56.5,38.25,72.5),46)
	CreateIB('Stand','1321',Vector3.new(-241.74,5,-241.74),45)
	CreateIB('Rated','2032',Vector3.new(-71,19,-40.74),-105.303)
	CreateIB('Shop','1871',Vector3.new(-64.5,3,56.25),136)
	CreateIB('Spawn','1670',Vector3.new(-8,10,6),90)
	CreateIB('Stage','1495',Vector3.new(-85,43,6),-90)
end
local BButton=LocalMenu.CreateDK('B',UDim2.new(.05,0,.45,0),'bypass vip stuff: ',IsBypassLocal,
	function()
		Notify('this is local only i meant most stuff are localized')
		local CI,CII
		local Part=workspace:FindFirstChild'GroupAccessPart'
		if not Part then Notify('Missing \'workspace\'.GroupAccessPart',3,true)end
		Part.CanCollide,Part.CanTouch,Part.CanQuery=false,false,false
		local Window=workspace['VIP Entrance']:FindFirstChild'Window'
		if not Window then Notify('Missing \'VIP Entrance\'.Window',3,true)return end
		CI=Window.VIPProximityPrompt.Triggered:Connect(function()
			local p=game.Players.LocalPlayer.Character.HumanoidRootPart
			p.CFrame=CFrame.new(-5900,-51.49,23,-1,0,0,0,1,0,0,0,-1)
		end)
		return{CI,Part}
	end,
	function(Table)
		Destroy(Table[1])
		if Table[2]then
			Set(Table[2]){CanCollide=true,CanTouch=true,CanQuery=true}
		end
	end
)
local Delay=0.1
local ARButton=LocalMenu.CreateDK('AR',UDim2.new(.05,0,.85,0),'Auto Respawn: ',IsAutoRespawn,
	function()
		Notify('I don\'t recommend using this if you\'re trying to toolkill people, or reanimations/god')
		local Position,CI,CII
		local function CharCheck(Character)
			local Character=Character or LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			if not Character then return end
			local Humanoid=Character:WaitForChild'Humanoid'or Character:FindFirstChildOfClass'Humanoid'
			local Root=Character:WaitForChild'HumanoidRootPart'or Character:FindFirstChild'HumanoidRootPart'
			if not Humanoid or not Root then print('return')return end			
			if Position~=nil then
				Root.CFrame=Position
				Position=nil
			end
			local Destroying,Die
			local function yeahwhatever(Connection)
				if not IsAutoRespawn.Value then
					Destroy(Connection)
					return
				end
				local Height=workspace.FallenPartsDestroyHeight
				if Height~=Height then Height=-500 end
				if Root and Root.Position.Y>Height then
					Position=Root.CFrame
				end
				task.wait(Delay)
				ReplicatedStorage.RequestRespawn:FireServer()
			end
			Destroying=Character.ChildRemoved:Connect(function(Part)
				if Part~=Root and Part~=Humanoid then return end
				yeahwhatever(Destroying)
			end)
			Die=Humanoid.Died:Connect(function()
				yeahwhatever(Die)
			end)
		end
		CharCheck()
		CI=LocalPlayer.CharacterAdded:Connect(function(Character)
			CharCheck(Character)
		end)
		return{CI,Position}
	end,
	function(Table)
		Destroy(Table[1])
		Table[2]=nil
	end
)
DButton.OnClick(function()
	Notify('this only work for swords, very buggy indeed.',4)
	local function TooComplex(p)
		local Mouse=UserInputService:GetMouseLocation()
		local Unit=CurrentCamera:ScreenPointToRay(Mouse.X,Mouse.Y-36)
		return workspace:Raycast(Unit.Origin,Unit.Direction*256,p)
	end
	Destroy(CoreGui,'IsDrawing')
	local Value=Create'BoolValue'{Parent=CoreGui,Name='IsDrawing',Value=true}
	local IsDrawing=Value.Value
	local IsUndoing,IsHolding,LockedWhileResetting=false,false,false
	local Character=LocalPlayer.Character
	local Gui=Create'Frame'{Parent=MG,BackgroundTransparency=.5,BackgroundColor3=Color3.fromRGB(34,34,34),Name='DrawGui',Size=UDim2.new(.25,0,.3,0),Position=UDim2.new(0,0,1,0),AnchorPoint=Vector2.new(0,1)}
	local Wait=.055
	task.spawn(function()
		local u=Create'UICorner'{Parent=Gui;CornerRadius=UDim.new(0,16)}
		local g=MG
		g=g:FindFirstChild'ProfileFrame'or g:FindFirstChild'RatingFrame'or g:FindFirstChild'TutorialFrame'
		local h=g.Heading:Clone()
		h.Parent=Gui;h.Text='how2use(need swords)(keybinds messed up)'
		local n=1
		local function s(t,p)
			local v=h:Clone()
			v.Parent=Gui
			if n==1 then
				v.Position=UDim2.new(.05,0,.2,0)
			else
				v.Position=UDim2.new(.05,0,.2+(.075*p),0)
			end
			v.Size=UDim2.new(.9,0,.075,0)
			v.Text=t
			v.Name='v'..tostring(n)
			v.TextXAlignment=Enum.TextXAlignment.Left
			n=n+1
			return v
		end
		s('Rotations = R , T , Y')
		s('Undo = G',1)
		s('Unequip/Reset = Disconnect',2)
		s('Reset All Grips = H',3)
		s('Reset Orientation = J',4)
		s('Swords: 0/0',5)
		s('Change Mode = E',6)
		local d=s('Delay: ',7)
		d.Size=UDim2.new(.15,0,.075,0)
		local o=s('Rotation: ',8)
		o.Size=d.Size
	end)
	local Fuel=Gui.v6
	local Delay=Create'TextBox'{Parent=Gui,Name='delay',Font=Enum.Font.SourceSansSemibold,TextScaled=true,TextWrapped=true,Text='',AnchorPoint=Vector2.new(1,0),Position=UDim2.new(.95,0,.725,0),Size=UDim2.new(.75,0,.075,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=.7,TextColor3=Color3.new(1,1,1),PlaceholderText='delay here'}
	local rot=math.rad(-45)
	local Rotation=Delay:Clone()
	Set(Rotation){Parent=Delay.Parent,PlaceholderText='rotation here',Position=Delay.Position+UDim2.new(0,0,.075,0)}
	Rotation.FocusLost:Connect(function()
		local RotationOutput=tonumber(Rotation.Text)
		if RotationOutput then
			rot=math.rad(RotationOutput)
			return
		end
		rot=math.rad(-45)
		Rotation.Text='-45'
	end)
	Delay.FocusLost:Connect(function()
		Wait=tonumber(Delay.Text)or.055
		Delay.Text=tostring(Wait)
	end)
	local Arm=Character:FindFirstChild'Right Arm'or Character:FindFirstChild'RightHand'
	local function SetCF(Position)
		return (Arm.CFrame*CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)):ToObjectSpace(Position):Inverse()
	end
	local Humanoid=Character:FindFirstChildWhichIsA"Humanoid"
	local Animator=Humanoid:FindFirstChild'Animator'
	local HAnimation=Create'Animation'{AnimationId='rbxassetid://182393478'} --Holding, not "that" animation.
	local Track=Animator:LoadAnimation(HAnimation)
	Track:Play(0)
	Track.Priority=Enum.AnimationPriority.Action
	Track:AdjustSpeed(0)
	local Placeholder=Create'Tool'{Name='equip me to disconnect',Parent=LocalPlayer.Backpack,ToolTip='OMG INSTANCE.NEW() HACK!!'}
	local Handle=Create'Part'{Parent=Placeholder,Name='Handle',Transparency=1,Size=Vector3.new(0,0,0)}
	local Orientation=CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
	local Pointer=Create'Part'{Parent=workspace,Transparency=.6,BrickColor=BrickColor.new(1,0,0),CanQuery=false,CanTouch=false,Massless=true,Material='SmoothPlastic',Anchored=true,Size=Vector3.new(1,.8,4),CanCollide=false,CFrame=CFrame.new(0,0,0)*Orientation}
	CollectionService:AddTag(Pointer,'theepicfunnyparts')
	CollectionService:AddTag(Character,'theepicfunnyparts')
	LMouse.TargetFilter=Pointer
	task.wait(1)
	local CI,CII,CIII,CIV,CV
	local DI,DII=false,false
	local SWR={}
	local total=0
	for _,x in next,LocalPlayer.Backpack:GetChildren()do
		if x:IsA'Tool'and x.Name=='ClassicSword'then
			local handle=x:FindFirstChild'Handle'
			if handle then
				handle.Massless=true
				total=total+1
				table.insert(SWR,x)
				continue
			end
			x:Destroy()
		end
	end
	for _,x in next,Character:GetChildren()do
		if x:IsA'Tool'and x.Name=='ClassicSword'then
			local handle=x:FindFirstChild'Handle'
			if handle then
				handle.Massless=true
				total=total+1
				table.insert(SWR,x)
				x.Parent=LocalPlayer.Backpack
				continue
			end
			x:Destroy()
		end
	end
	LocalPlayer.Character.ChildAdded:Connect(function(Child)
		if Child:IsA'Tool'and Child.Name=='ClassicSword'and Child:FindFirstChild'Handle'and not table.find(SWR,Child)then
			table.insert(SWR,Child)
			total=total+1
			Child.Handle.Massless=true
			Child.Handle.CanQuery=true
		end
	end)
	local n=0
	local Mode=0
	local InputTable={
		[KC.R]=function()Orientation=Orientation*CFrame.Angles(rot,0,0)end,
		[KC.T]=function()Orientation=Orientation*CFrame.Angles(0,rot,0)end,
		[KC.Y]=function()Orientation=Orientation*CFrame.Angles(0,0,rot)end,
		[KC.J]=function()Orientation=CFrame.Angles(math.rad(-90),0,0)end,
		[KC.E]=function()
			if Mode==1 then
				Mode=0
				Set(Pointer){BrickColor=BrickColor.new(1,0,0),Size=Vector3.new(1,.8,4),Transparency=.6}
				return
			end
			Mode=1
			Set(Pointer){BrickColor=BrickColor.new(Color3.fromRGB(89,211,103)),Size=Vector3.new(1.2,1,4.2),Transparency=1}
		end,
		[KC.H]=function()
			n=0
			LockedWhileResetting=true
			local Grouped=Character:GetChildren()
			for c,x in next,Grouped do
				if table.find(SWR,x)then
					x.Grip,x.Parent=CFrame.new(0,0,-1.7,0,0,1,1,0,0,0,1,0),LocalPlayer.Backpack
					if #Grouped%c==0 then
						task.wait()
					end
				end
			end
			LockedWhileResetting=false
			Fuel.Text='Swords: 0/'..tostring(total)
		end,
		[KC.G]=function()
			IsUndoing=true
			while IsUndoing and n>0 and IsDrawing do
				local a=SWR[n]
				a.Parent=LocalPlayer.Backpack
				n=n-1
				task.wait(Wait)
			end
		end
	}
	local Target
	CII=UserInputService.InputBegan:Connect(function(input,input2)
		if input2 then return end
		if input.UserInputType==UIT.MouseButton1 then	
			if LockedWhileResetting then
				IsHolding=false
			end
			IsHolding=true
			CI=Heartbeat:Connect(function()
				if not IsDrawing or not IsHolding then 
					CI:Disconnect()
					return
				end
				if Mode==0 then
					if DI or n>=total then
						return
					end
					DI=true
					n=n+1 
					local a=SWR[n]	
					if a.Parent==Character then a.Parent=LocalPlayer.Backpack end
					Set(a){Grip=SetCF(CFrame.new(LMouse.Hit.Position)*Orientation),Parent=LocalPlayer.Character}
					task.wait(Wait)
					DI=false
					return
				end
				if DII or not Target then return end
				DII=true
				--might rework this part later
				local cout=SWR[table.find(SWR,Target.Instance.Parent)]
				SWR[table.find(SWR,Target.Instance.Parent)]=SWR[n]
				SWR[n]=cout
				n=n-1
				Set(Target.Instance.Parent){Grip=CFrame.new(0,0,-1.7,0,0,1,1,0,0,0,1,0),Parent=LocalPlayer.Backpack}
				task.wait(Wait)
				DII=false
			end)
		elseif input.UserInputType==UIT.Keyboard then
			pcall(InputTable[input.KeyCode])
		end
	end)
	CIII=UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType==UIT.MouseButton1 then 
			IsHolding=false
		elseif(input.UserInputType==UIT.Keyboard and input.KeyCode==KC.G)then
			IsUndoing=false
		end
	end)
	local function t()
		IsDrawing=false
		HAnimation:Destroy()
	end
	Character:GetPropertyChangedSignal'Parent':Connect(function()
		for DELAYBELOW=1,10 do
			if Character.Parent~=nil then
				return
			end
			task.wait(.1)
		end
		t()
	end)
	Character.ChildRemoved:Connect(function(Part)
		if Part~=Placeholder then return end
		t()
	end)
	Character.Humanoid.Died:Connect(t)
	Placeholder.Equipped:Connect(function()
		Placeholder:Destroy(HAnimation:Destroy(Track:Stop(task.wait(.25))))
		t()
	end)
	CIV=PlayerAdded.Event:Connect(function(Player)
		local CVI=Player.CharacterAdded:Connect(function(Character)
			CollectionService:AddTag(Character,'theepicfunnyparts')
		end)
		if not IsDrawing then
			Destroy(CVI)
			return
		end
	end)
	CV=RunService.RenderStepped:Connect(function()
		if not IsDrawing then
			Destroy(Value)
			Destroy(Gui)
			Destroy(Pointer)
			CV:Disconnect(CIV:Disconnect(CIII:Disconnect(CII:Disconnect())))
			return
		end
		Fuel.Text='Swords: '..tostring(n)..'/'..tostring(total)
		if Mode==0 then
			Pointer.CFrame=CFrame.new(LMouse.Hit.Position)*Orientation
			return
		end
		local Mouse=UserInputService:GetMouseLocation()
		local RaycastParam=RaycastParams.new(CollectionService:GetTagged'theepicfunnyparts',Enum.RaycastFilterType.Blacklist,true)
		Target=TooComplex(RaycastParam)
		if Target and table.find(SWR,Target.Instance.Parent)then
			Pointer.CFrame=Target.Instance.CFrame
			Pointer.Transparency=.6
			return
		end
		Target=nil
		Pointer.Transparency=1
	end)
end)
local InputTable={
	[1]=function(Tool)
		task.spawn(function()
			local Childrens=Tool.Handle:GetChildren()
			if #Childrens==0 then return end
			local Old=Tool.Parent
			Tool.Parent=LocalPlayer.Character
			task.wait()
			Destroy(Tool,'LocalScript',1)
			Destroy(Tool,'Script',1)
			for _,z in next,Childrens do
				if not z:IsA'Attachment'then
					z:Destroy()
				end
			end
			Tool.Parent=Old
		end)
		task.wait()
	end,
	[2]=function(Tool)
		task.spawn(function()					
			local Handle=Tool:FindFirstChild'Handle'
			if Handle then
				local Mesh=Handle:FindFirstChildWhichIsA'SpecialMesh'
				local Old=Tool.Parent
				if Mesh then
					Tool.Parent=LocalPlayer.Character
					task.wait()
					Mesh:Destroy()
				end
				Tool.Parent=Old
			end
		end)
		task.wait()
	end,
	[3]=function(Tool)
		if not Tool:IsA'Tool'and Tool.Name~='ClassicSword'then return end
		Tool.Parent=LocalPlayer.Character
	end,
}
RSButton.OnClick(function()RequestSword()if LocalPlayer.Team~=Knight then Notify('You dont have knight role')end end)
local SGButton=KnightMenu.CreateDK('Dupe',UDim2.new(.05,0,.65,0),'Show Dupe Gui',IsShowingDupeMenu,
	function()
		--should rework this function later
		--Notify('Do i need to explain these icons? yes? no lol')
		if LocalPlayer.Team~=Knight then Notify('you\'re not knight')end
		local SideI=Main.CreateButtonOld('DupeButton','Dupe:\noff',UDim2.new(1,-20,.5,-80),Vector2.new(1,0))
		local Val=Create'BoolValue'{Parent=CoreGui,Name='dupe'}
		local SideII=Main.CreateIcon('ClearS','rbxassetid://12068313338',UDim2.new(1,-20,.5,-30),Vector2.new(1,0))
		local SideIII=Main.CreateIcon('BlockM','rbxassetid://12068313585',UDim2.new(1,-20,.5,20),Vector2.new(1,0))
		local SideIV=Main.CreateButtonOld('Counter','COUNT SWORD',UDim2.new(1,-20,.5,70),Vector2.new(1,0))
		local function CheckTool(Directory,Input)
			Loop(Directory,nil,function(Item,Handle)Set(Handle){Massless=true,CanCollide=false,CanQuery=true,CanTouch=false}InputTable[Input](Item)end)
		end
		SideI.OnClick(function()
			Val.Value=not Val.Value
			if not Val.Value then
				SideI.Gui.Text='Dupe:\noff'
				return
			end
			SideI.Gui.Text='Dupe:\non'
			CheckTool(LocalPlayer.Backpack,3)
			local CI,CII
			CI=LocalPlayer.Backpack.ChildAdded:Connect(function(Tool)
				CheckTool(LocalPlayer.Backpack,3)
			end)
			CII=RunService.RenderStepped:Connect(function()
				if Val.Value then
					RequestSword()
					return
				end
				CI:Disconnect(CII:Disconnect())
			end)
		end)
		SideII.OnClick(function()
			CheckTool(LocalPlayer.Character,1)
			CheckTool(LocalPlayer.Backpack,1)
		end)
		SideIII.OnClick(function()
			CheckTool(LocalPlayer.Character,2)
			CheckTool(LocalPlayer.Backpack,2)
		end)
		local Total=Create'IntValue'{Parent=SideIV.Gui,Name='Amount'}
		SideIV.OnClick(function()
			Total.Value=0
			Loop(LocalPlayer.Character,function()Total.Value=Total.Value+1 end)
			Loop(LocalPlayer.Backpack,function()Total.Value=Total.Value+1 end)
			SideIV.Text='Items: '..tostring(Total.Value)
		end)
		return{Val,SideI,SideII,SideIII,SideIV}
	end,
	function(Table)
		Table[1].Value=false
		for i=2,5 do
			Destroy(Table[i].Gui)
		end
	end
)
local function Repos(a,b,c)
	a.CFrame=b
	a.CanCollide=c
end
--[[
for anyone saying "omg u can just use getpropertychangedsignal if booth text = clik her to 
clem dis buth, no crap sherlock that's a bad practice considering the booth sometimes
unclaimed but still has image and/or text" in it
if you use infinite loops i will kill you
]]
local ACBButton=SnipeBooth.CreateDK('Auto Claim Booth',UDim2.new(.05,0,.45,0),'Auto Claim Booth: ',IsSnipingBooth,
	function()
		local HumanoidRootPart=LocalPlayer.Character.HumanoidRootPart
		local Old,Old2=HumanoidRootPart.CFrame,HumanoidRootPart.CanCollide
		local function Dep(a)
			HumanoidRootPart.CFrame=a.CFrame-Vector3.new(0,15,0)
			HumanoidRootPart.CanCollide=false
			HumanoidRootPart.AssemblyLinearVelocity=Vector3.new(0,25,0)
		end
		local ListOfConnections={}
		--local AlreadyRunning=false
		local AlreadyOwnBooth=false
		for _,x in next,workspace:GetChildren()do
			if x.Name~='Booth'and not x:IsA'Model'then continue end
			if AlreadyOwnBooth then break end
			task.spawn(function()
				local Banner=x:FindFirstChild'Banner'
				if not Banner then return end
				local ClickDetector=Banner:FindFirstChildWhichIsA'ClickDetector'
				if not ClickDetector then return end
				local Temp=x:GetAttribute'TenantUsername'
				local CI
				if Temp==''then 
					repeat
						if not IsSnipingBooth.Value or AlreadyOwnBooth then break end
						Dep(Banner)
						task.wait(.1)
						fireclickdetector(ClickDetector)
					until x:GetAttribute'TenantUsername'~=''or not IsSnipingBooth.Value
					if x:GetAttribute'TenantUsername'==LocalPlayer.Name then
						Repos(HumanoidRootPart,Old,Old2)
						return
					end
					CI=x:GetAttributeChangedSignal'TenantUsername':Connect(function()
						local Temp=x:GetAttribute'TenantUsername'
						if Temp~=''then return end
						repeat
							task.wait(.1)
							fireclickdetector(ClickDetector)
						until x:GetAttribute'TenantUsername'~=''or not IsSnipingBooth.Value
						if x:GetAttribute'TenantUsername'==LocalPlayer.Name then
							CI:Disconnect()
						end
						Repos(HumanoidRootPart,Old,Old2)
					end)
					table.insert(ListOfConnections,CI)
				elseif Temp==LocalPlayer.Name then
					AlreadyOwnBooth=true
					Destroy(CI)
					Repos(HumanoidRootPart,Old,Old2)
				end
			end)
		end
		return{ListOfConnections,Old,Old2}
	end,
	function(Table)
		for _,x in next,Table[1]do
			x:Disconnect()
		end
		local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
		if HumanoidRootPart then
			Repos(HumanoidRootPart,Table[2],Table[3])
		end
	end
)
local EBButton=BoothMenu.CreateDK('Extra Banner',UDim2.new(.05,0,.85,0),'extra description: ',IsShowingDesc,
	function()
		local ExtraBanners,ListOfConnections={},{}
		for _,x in next,TableBooth do
			local Banner=x:FindFirstChild'Banner'
			if not Banner then
				Notify('a banner is missing',1,true)
				continue
			end
			local Icon=Banner.SurfaceGui.Frame:FindFirstChild'Icon'
			local Description=Banner.SurfaceGui.Frame:FindFirstChild'Description'
			if not Icon then
				Notify('an icon is missing',1,true)
				continue
			end
			if not Description then
				Notify('a description is missing',1,true)
				continue
			end
			local IBanner=Banner:Clone()
			Set(IBanner){Parent=Banner.Parent,CanCollide=false,Size=Vector3.new(3.8,2.8,.4),CFrame=Banner.CFrame:ToWorldSpace(CFrame.new(6.2,0,0,1,0,0,0,1,0,0,0,1)),Name='IBanner'}
			local Img=IBanner.SurfaceGui.Frame.Description
			for _,v in next,Img.Parent:GetChildren()do
				if v~=Img then
					v:Destroy()
				end
			end
			local TBanner=IBanner:Clone()
			local OBanner=TBanner:Clone()
			Destroy(OBanner,'ClickDetector')
			local ODesc=OBanner.SurfaceGui.Frame.Description
			Set(ODesc){Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0)}
			Set(OBanner){Parent=Banner.Parent,Size=Vector3.new(8.6,1.8,.4),Name='OBanner',CFrame=Banner.CFrame:ToWorldSpace(CFrame.new(0,1.8,0,1,0,0,0,1,0,0,0,1))}
			Set(TBanner){Parent=Banner.Parent,Size=Vector3.new(3.8,1.05,.4),Name='TBanner',CFrame=Banner.CFrame:ToWorldSpace(CFrame.new(6.2,-1.925,0,1,0,0,0,1,0,0,0,1))}
			TBanner.SurfaceGui.Frame.Description:Destroy()
			local Text=Create'TextBox'{Parent=TBanner.SurfaceGui.Frame,BackgroundTransparency=1,Size=UDim2.new(1,0,1,0),Font=Enum.Font.SourceSansBold,TextColor3=Color3.new(1,1,1),PlaceholderText='text should appear here (Ctrl+A copy)',TextScaled=true,TextWrapped=true,Name='Extra',Text=Description.Text,TextEditable=false,ClearTextOnFocus=false}
			Set(Img){RichText=true,Text='roblox.com/library/'..Icon.Image:match'%d+$',AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,.5,0)}
			Icon:GetPropertyChangedSignal'Image':Connect(function()
				Img.Text='roblox.com/library/'..Icon.Image:match'%d+$'
			end)
			local Temp=x:GetAttribute'TenantUsername'
			ODesc.Text=Temp
			if Temp==''then 
				ODesc.Text='No one'
			end
			local CI=x:GetAttributeChangedSignal'TenantUsername':Connect(function()
				local String=x:GetAttribute'TenantUsername'
				if String==''then 
					ODesc.Text='No one'
					return
				end
				ODesc.Text=String
			end)
			local CII=Description:GetPropertyChangedSignal'Text':Connect(function()
				local T=Description.Text
				if T~='Click here to rent this booth'and not T:match'^This booth is claimed by'then
					Text.Text=T
					return
				end
				Text.Text='text should appear here, or it contains bs (Ctrl+A copy)'
			end)
			local CD=Banner.ClickDetector
			local CIII=CD:GetPropertyChangedSignal'MaxActivationDistance':Connect(function()
				local MAD=CD.MaxActivationDistance
				IBanner.ClickDetector.MaxActivationDistance=MAD
				TBanner.ClickDetector.MaxActivationDistance=MAD
				--i think this is a little bit too long
			end)
			IBanner.ClickDetector.MouseClick:Connect(function()	
				local ID=Icon.Image:match'%d+$'
				if tonumber(ID)and tonumber(ID)>10 then
					SetClip(ID)
					Notify('Copied, ID: '..ID..'.',3)
					return
				end
				Notify('This booth has no image.')
			end)
			table.insert(ExtraBanners,IBanner)
			table.insert(ExtraBanners,TBanner)
			table.insert(ExtraBanners,OBanner)
			table.insert(ListOfConnections,CI)
			table.insert(ListOfConnections,CII)
			table.insert(ListOfConnections,CIII)
		end
		return{ListOfConnections,ExtraBanners}
	end,
	function(Table)
		for _,x in next,Table[1]do
			x:Disconnect()
		end
		for _,x in next,Table[2]do
			x:Destroy()
		end
	end
)
--EBButton.Text.Size=UDim2.new(.75,0,1,0)
local MCI=true
local DMButton=Frame.CreateDK('Music',UDim2.new(.05,0,.15,0),'music',IsMusicEnabled,
	function()
		do do end do do end end do end do end end
		Notify('function discontinued until re-newed',3)
		return
	end,
	function()
		--[[MCI=false
		Destroy(Table[1])
		Tag.Text='v.1.436 | '..CurrentVersion..' LOCAL MODIFIED.']]
	end
)
local ABButton=BoothMenu.CreateDK('Anti Barrier',UDim2.new(.05,0,.65,0),'Anti Barrier: ',IsAntiBarrier,
	function()
		for _,x in next,workspace:GetChildren()do
			SetBarrier(x)
		end
		local CI
		CI=workspace.ChildAdded:Connect(function(p)
			SetBarrier(p)
		end)
		return CI
	end,
	function(CI)
		Destroy(CI)
		for _,v in next,workspace:GetChildren()do
			SetBarrier(v,'blah blah blah')
		end
	end
)
local ACKButton=KnightMenu.CreateDK('ACK',UDim2.new(.05,0,.85,0),'Auto Claim Knight: ',IsAutoClaim,
	function()
		if LocalPlayer.Team==Knight then
			KnightMenu.Gui.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
			IsAutoClaim.Value=false
			Notify('you already have knight role, what do you expect.')
			return
		end
		if not JewellStand then
			Notify('There\'s no JewelleryStand, Knight Panel may not be working',5)
			return
		end
		local Prox=JewellStand:FindFirstChild'ProximityPrompt'
		if Prox.Enabled then
			local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
			if HumanoidRootPart then
				local OldCFrame=HumanoidRootPart.CFrame
				JewellStand.CanCollide=false
				HumanoidRootPart.CFrame=JewellStand.CFrame
				repeat
					HumanoidRootPart.CFrame=JewellStand.CFrame
					fireproximityprompt(Prox)
					task.wait()
				until not Prox or not Prox.Enabled or not IsAutoClaim.Value
				task.wait()
				JewellStand.CanCollide=true
				HumanoidRootPart.CFrame=OldCFrame
				KnightMenu.Gui.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
				IsAutoClaim.Value=false
				return
			end
			Notify('Missing HumanoidRootPart.',3)
			return
		end
		local CI
		CI=Prox:GetPropertyChangedSignal'Enabled':Connect(function()
			local Check=a(Prox)
			if Check then
				CI:Disconnect()
				KnightMenu.Gui.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
				IsAutoClaim.Value=false
			end
		end)
		return CI
	end,
	function(CI)
		Destroy(CI)
	end
)
CKButton.OnClick(function()
	ClickSound()
	if LocalPlayer.Team==Knight then
		Notify('you already have knight role, what do you expect.')
		return
	end
	if not JewellStand then
		Notify('There\'s no JewelleryStand, Knight Panel may not be working',5)
		return
	end
	local Prox=JewellStand:FindFirstChild'ProximityPrompt'
	if Prox then
		if not Prox.Enabled then
			Notify('Knight is not available at the moment',1)
			return
		end
		a(Prox)
	end
end)
