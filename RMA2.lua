
-- i got bored so i assigned multiple variables in one-line
--[[
credits:
	ideas:
		ab5ence
		cam1494
		alonelypersoninpain
		
	scripting:
		Me
		
まもるクンは呪われてしまった！　「Great Tribulation」

Poor true ternary and bitoperations
]]
if not game:IsLoaded()then game.Loaded:Wait()end
if _G.RMA2ENABLED then
	error'RMA2 is already running!'
	return
end
_G.RMA2ENABLED=true
local Main
if not pcall(function()Main=loadfile'rma_library.lua'()end)then
	local mama=game:HttpGet'https://raw.githubusercontent.com/FindFirstChild/theme/main/LibraryTest.lua'
	writefile('rma_library.lua',mama)
	Main=loadstring(mama)()
end
-- services
local Players=game:GetService'Players'
local UserInputService=game:GetService'UserInputService'
local TweenService=game:GetService'TweenService'
local RunService=game:GetService'RunService'
local Teams=game:GetService'Teams'
local ContentProvider=game:GetService'ContentProvider'
local CollectionService=game:GetService'CollectionService'
local ReplicatedStorage=game:GetService'ReplicatedStorage'
local MarketPlaceService=game:GetService'MarketplaceService'
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
local Tag,CurrentVersion=MG.VersionTag						,						'v1.3.4'
local Heartbeat=RunService.Heartbeat
local USRemote=ReplicatedStorage.UpdateSign
local AllBools={}
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
	PlayerRemoving:Fire(Player)
	PlayersTable[table.find(PlayersTable,Player.Name)or-1]=nil
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
local function RequestItem(Id)
	ReplicatedStorage.RequestGamepassTool:FireServer(tonumber(Id))
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
		HumanoidRootPart.CFrame,HumanoidRootPart.AssemblyLinearVelocity=JewellStand.CFrame,Vector3.zero
		fireproximityprompt(p)
		task.wait(.1)
	until not p.Enabled
	JewellStand.CanCollide,HumanoidRootPart.CFrame=true,OldCFrame
	return true
end
local function Notify(Message,Duration,Warn)
	if Warn then warn(Message)end
	if not Duration then Duration=5 end
	local Yheight=.05
	local NFrame=Create'Frame'{Parent=MG,BackgroundColor3=Color3.fromRGB(34,34,34),Name='NotificationFrame',Position=UDim2.new(.2,0,Yheight,0),Size=UDim2.new(.6,0,.06,0),Style=Enum.FrameStyle.Custom}
	local Notif=Create'TextLabel'{Parent=NFrame,AutomaticSize=Enum.AutomaticSize.None,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name='NotificationText',Position=UDim2.new(.05,0,.175,0),Size=UDim2.new(.9,0,.65,0),Font=Enum.Font.SourceSansSemibold,Text=Message,TextColor3=Color3.new(1,1,1),TextScaled=true,TextSize=14}
	local UISC=Create'UISizeConstraint'{Parent=Notif.Parent}
	local UIC=Create'UICorner'{Parent=Notif.Parent}
	local NSound=MG['Main Gui Core']:FindFirstChild'NotificationSound'
	for _,x in next,MG:GetChildren()do
		if x~=NFrame and x:IsA'Frame'and x.Name=='NotificationFrame'and x.Visible then
			Yheight=Yheight+.07
			NFrame.Position=UDim2.new(.2,0,Yheight,0)
			x.Destroying:Once(function()
				Yheight=Yheight-.07
				if not NFrame then return end
				NFrame.Position=UDim2.new(.2,0,Yheight,0)
			end)
		end
	end
	task.spawn(function()
		NSound:Play()
		NFrame:Destroy(task.wait(Duration-NSound.TimePosition))
	end)
end
--bools 
local HAHAHA={
	'IsAutoClaim',
	'IsAntiProx',
	'IsShowingDupeMenu',
	'IsShowingDesc',
	'IsAutoRespawn',
	'IsAntiBarrier',
	'IsMusicEnabled',
	'IsBypassLocal',
	'IsSnipingBooth',
	'IsWhitelisting',
	'IsASTOP',
	'IsAIS',
	'IsATS',
}
local function CALL()
	for _,x in next,HAHAHA do
		CreateBool(x)
	end
end
if isfile'RMA2CONFIG.lua'then
	pcall(function()
		local re=loadfile'RMA2CONFIG.lua'()
		if typeof(re)=='nil'then 
			CALL()
			AllBools=select(2,Main:GetTables())
			return 
		end
		AllBools=re
		for n,v in next,AllBools do
			AllBools[n]=CreateBool(n,v)
		end
	end)
else
	CALL()
	AllBools=select(2,Main:GetTables())
end

--guis
local Frame=Main:CreateFrame('Custom','hi')
Frame:CreateSub('credits:\nideas:\nab5ence,cam1492,alonelypersoninpain\nscript:\nkevinYMHGmlg#1822',UDim2.new(.6,0,.9,0),Vector2.new(0,.5),UDim2.new(1.05,0,.5,0),.9)
local MainIcon=Main:CreateIcon('ExploitButton','rbxassetid://10462982957',UDim2.new(0,20,.5,-80))
local KnightButton=Frame:CreateButton('Knight','Knight Panel',UDim2.new(.05,0,.75,0))
local MiscButton=Frame:CreateButton('Other','others',UDim2.new(.05,0,.65,0))
local LocalButton=Frame:CreateButton('Local','Localplayer',UDim2.new(.05,0,.55,0))
local BoothButton=Frame:CreateButton('Booth','Booth',UDim2.new(.05,0,.45,0))
local GuiDestroy=Frame:CreateButton('SelfDestruct','Destroy Gui',UDim2.new(.05,0,.85,0))
GuiDestroy.Gui.BackgroundColor3=Color3.fromRGB(150,64,27)
local MiscMenu=Main:CreateFrame('others','s')
local MiscReturn=MiscMenu:CreateButton('R','Return',UDim2.new(.05,0,.25,0))
local KnightMenu=Main:CreateFrame('Knight','knight panel')
local KnightReturn=KnightMenu:CreateButton('R','Return',UDim2.new(.05,0,.55,0))
local BoothMenu=Main:CreateFrame('Booth','game.service(\'WorkSpace\',game)[\'FilteringEnabled\']=not not Instance.new\'BoolValue\'.Value')
local SnipeMenu=Main:CreateFrame('AutoSnipe','hiyah')
local BoothReturn=BoothMenu:CreateButton('R','Return',UDim2.new(.05,0,.35,0))
local LocalMenu=Main:CreateFrame('Local','workspace.FilteringEnabled=false')
local LocalReturn=LocalMenu:CreateButton('R','Return',UDim2.new(.05,0,.35,0))
local TeleportMenu=MG.ContentMenuFrame:Clone()
Set(TeleportMenu){Name='TeleportationFrame',Parent=MG}
TeleportMenu.Heading.Text='teleportations'
TeleportMenu.Subheading.Text='HumanoidRootPart.CFrame=CFrame.new(pos)*CFrame.Angles(0,ori,0)'
local PBoothMenu=MG.BoothCustomisationFrame:Clone()
Set(PBoothMenu){Name='PortableFrame',Parent=MG}
PBoothMenu.Heading.Text='Portable Booth'
for _,x in next,PBoothMenu:GetChildren()do
	if not x:IsA'TextLabel'or x.Name~='Subheading'then continue end
	if x.Text=='Booth Description'then x.Text='Sign Description'continue end
	x.Text='Image ID (rbxassetid only, im lazy to convert it)'
end
PBoothMenu.BrowseImageButton.Visible=false
PBoothMenu.BrowseDescriptionButton.Visible=false
PBoothMenu.BlacklistButton:Destroy()
PBoothMenu.AbandonButton.Visible=false
local CKButton=KnightMenu:CreateButton('CK','Claim Knight',UDim2.new(.05,0,.35,0))
local RSButton=KnightMenu:CreateButton('RS','Request Sword',UDim2.new(.05,0,.45,0))
local TPButton=Frame:CreateButton('TP','Teleportations',UDim2.new(.05,0,.35,0))
local DButton=LocalMenu:CreateButton('D','DrawGui.lua',UDim2.new(.05,0,.25,0))
local SnipeButton=BoothMenu:CreateButton('Snipe','Auto Claim Booth..',UDim2.new(.05,0,.45,0))
local PortableButton=BoothMenu:CreateButton('B','portable booth',UDim2.new(.05,0,.55,0))
--linkers
Link(TeleportMenu.ReturnButton,Frame.Gui)
MainIcon:BindTo(Frame)
KnightReturn:BindTo(Frame)
MiscReturn:BindTo(Frame)
LocalReturn:BindTo(Frame)
BoothReturn:BindTo(Frame)
SnipeButton:BindTo(SnipeMenu)
MiscButton:BindTo(MiscMenu)
KnightButton:BindTo(KnightMenu)
KnightButton.OnClick(function()
	Notify('what\'s the point of using this without swords')
end)
LocalButton:BindTo(LocalMenu)
BoothButton:BindTo(BoothMenu)
Link(PortableButton.Gui,PBoothMenu)
Link(TPButton.Gui,TeleportMenu)
--//////////////////      CtC Stage 1B Theme: Extend Ash ~ Hourai Victim      //////////////////--
local Old
Old=hookmetamethod(game,"__namecall",function(Self,...)
    if Self==USRemote and getnamecallmethod()=='FireServer'then
        local Type,Id=...
        return Old(Self,Type,('https://www.roblox.com/asset-thumbnail/image?assetId=%s&width=10000&height=10000&format=png'):format(Id:match'%d+'))
    end
    return Old(Self,...)
end)
Notify('2 get started, click on the goofy icon thing on the left, oh! dont forget that this script might break if you change even a small detail in game.',6,true)
getconnections(M.KillButton.MouseButton1Click)[1]:Disable()
Set(Tag){TextSize=20,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(0,360,0,40),Position=UDim2.new(0,40,1,-50),Text='v.1.436 | '..CurrentVersion..' LOCAL MODIFIED.',TextScaled=false,TextWrapped=false,RichText=true}
local CI_UNKNOWN=M.KillButton.MouseButton1Click:Connect(function()
	M.Visible=false
	Notify('No.',3)
end)
local poop=false
GuiDestroy.OnClick(function()
	if poop then return end
	poop=true
	ClickSound()
	GuiDestroy.Gui.Text='o rlly? (5)'
	local CI
	CI=GuiDestroy.Gui.MouseButton1Click:Connect(function()
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
		MainIcon.Gui:Destroy()
		for _,x in next,Main.Frames do
			x:Destroy()
		end
		TeleportMenu:Destroy()
		for _,x in next,MG:GetChildren()do
			if table.find({'BlockM','DupeButton','Counter','ClearS'},x.Name)then
				x:Destroy()
			end
		end
	end,true)
	for i=5,0,-1 do
		GuiDestroy.Gui.Text=('are you sure? (%d)'):format(i)
		task.wait(1)
	end
	CI:Disconnect()
	poop=false
	GuiDestroy.Gui.Text='Destroy Gui'
end)
TeleportMenu.CloseButton.MouseButton1Click:Connect(function()
	ClickSound()
	TeleportMenu.Visible=false
end)
PBoothMenu.CloseButton.MouseButton1Click:Connect(function()
	ClickSound()
	PBoothMenu.Visible=false
end)
--MarketService:UserOwnsGamePassAsync(LocalPlayer.UserId, GamePassID)
--[[
17290248 stop
17291427 image
17291420 text
]]
local Gamepasses={
	[1]={17290248,nil}, --stop
	[3]={17291427,nil}, --img
	[2]={17291420,nil}, --text
}
for Count,Table in next,Gamepasses do
	local Id=Table[1]
	if MarketPlaceService:UserOwnsGamePassAsync(LocalPlayer.UserId,Id)then
		Table[2]=true
		continue
	end
	Table[2]=false
end
do
	local Desc=PBoothMenu.BoothDescriptionBox
	local Img=PBoothMenu.ImageIdBox
	PBoothMenu.UpdateButton.MouseButton1Click:Connect(function()
		local Character=LocalPlayer.Character
		if not Character then return end
		local ISign=Character:FindFirstChild'Image Sign'or LocalPlayer.Backpack:FindFirstChild'Image Sign'
		if not ISign then
			if Gamepasses[2][2]then
				Notify('you need an image sign')
				return
			end
			RequestItem(17291427)
			task.spawn(function()
				local Item=nil
				while not Item or Item.Name~='Image Sign'do
					Item=LocalPlayer.Backpack.ChildAdded:Wait()
				end
				ISign=Item
			end)
		end
		local TSign=Character:FindFirstChild'Text Sign'or LocalPlayer.Backpack:FindFirstChild'Text Sign'
		if not TSign then
			if Gamepasses[3][2]then
				Notify('you need a text sign')
				return
			end
			RequestItem(17291420)
			task.spawn(function()
				local Item=nil
				while not Item or Item.Name~='Text Sign'do
					Item=LocalPlayer.Backpack.ChildAdded:Wait()
				end
				return Item
			end)
		end
		USRemote:FireServer("Decal",("rbxassetid://%s"):format(Img.Text or'0')or'rbxassetid://0')
		USRemote:FireServer("Text",Desc.Text or'')
		for _,x in next,{ISign,TSign}do
			if x.Parent==Character then
				x.Parent=LocalPlayer.Backpack
			end
			x.Parent=Character
		end
		TSign.Grip=CFrame.new(0,-2,0,0,0,-1,0,1,0,1,0,0)
		TSign.Unequipped:Once(function()
			TSign.Grip=CFrame.new(0,0,0,0,0,-1,0,1,0,1,0,0)
		end)
	end)
end
local APButton=LocalMenu:CreateDK('AP',UDim2.new(.05,0,.65,0),'Anti Proximity: ',AllBools.IsAntiProx,
	function()
		local Character=LocalPlayer.Character
		if Character then
			local Humanoid=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
			if not Humanoid then return end
			task.wait(.1)
			Destroy(Humanoid,'ProximityPrompt')
		end
		local CI=LocalPlayer.CharacterAdded:Connect(function(Character)
			local Humanoid=Character:WaitForChild('HumanoidRootPart',1/0)
			task.wait(.1)
			Destroy(Humanoid,'ProximityPrompt')
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
	Searcher:GetPropertyChangedSignal'Text':Connect(function()
		local text=Searcher.Text:lower()
		if text==''then
			for _,d in next,PlayersTable do
				PlayerSelectionFrame[d.Name].Visible=true
			end
			return
		end
		for _,d in next,PlayersTable do
			local name,displayname=d.Name,d.DisplayName
			if name:lower():find(text,1,true)or displayname:lower():find(text,1,true)then
				PlayerSelectionFrame[d.Name].Visible=true
				continue
			end
			PlayerSelectionFrame[d.Name].Visible=false			
		end
	end)
	local function CreateTB(Player)
		local Xame=Player.Name
		local dn=Player.DisplayName
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
			HumanoidRootPart.AssemblyLinearVelocity,HumanoidRootPart.AssemblyAngularVelocity=Vector3.zero,Vector3.zero
			HumanoidRootPart.CFrame=THumanoidRootPart.CFrame
		end)
	end
	for _,x in next,PlayersTable do
		CreateTB(x)
	end
	PlayerAdded.Event:Connect(CreateTB)
	PlayerRemoving.Event:Connect(function(Player)
		Destroy(PlayerSelectionFrame,Player.Name)
	end)
	local function CreateIB(Xame,Id,Position,y)
		local ImageButton=Create'ImageButton'{Parent=PlaceSelectionFrame,Name=Xame,BorderSizePixel=0,Image='rbxassetid://1183324'..Id}
		--ContentProvider:PreloadAsync({ImageButton})
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
			HumanoidRootPart.AssemblyLinearVelocity,HumanoidRootPart.AssemblyAngularVelocity=Vector3.zero,Vector3.zero
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
local BButton=LocalMenu:CreateDK('B',UDim2.new(.05,0,.45,0),'bypass vip stuff: ',AllBools.IsBypassLocal,
	function()
		Notify('this is local only i meant most stuff are localized')
		local Part=workspace:FindFirstChild'GroupAccessPart'
		if not Part then Notify('Missing \'workspace\'.GroupAccessPart',3,true)end
		Set(Part){CanCollide=false,CanTouch=false,CanQuery=false}
		local Window=workspace['VIP Entrance']:FindFirstChild'Window'
		if not Window then Notify('Missing \'VIP Entrance\'.Window',3,true)return end
		local CI=Window.VIPProximityPrompt.Triggered:Connect(function()
			local p=game.Players.LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
			if not p then return end
			p.CFrame=CFrame.new(-5900,-51.49,23,-1,0,0,0,1,0,0,0,-1)
		end)
		local CII=Part.Changed:Connect(function()
			Set(Part){CanCollide=false,CanTouch=false,CanQuery=false}	
		end)
		return {CI,CII},Part
	end,
	function(Connections,P)
		for _,x in next,Connections do
			Destroy(x)
		end
		if P then
			Set(P){CanCollide=true,CanTouch=true,CanQuery=true}
		end
	end
)
do
	for i,x in next,{AllBools.IsASTOP,AllBools.IsAIS,AllBools.IsATS}do
		local Id,Value=Gamepasses[i][1],Gamepasses[i][2]
		local TBN,N='',''
		if i==1 then
			TBN,N='Auto Stop Sign: ','AS(explicitlol)'
		elseif i==2 then
			TBN,N='Auto Image Sign: ','AIS'
		elseif i==3 then
			TBN,N='Auto Text Sign: ','ATS'
		end
		local funnyButton=MiscMenu:CreateDK(N,UDim2.new(.05,0,.85-(.2*(i-1)),0),TBN,x,
			function()
				if not Value then
					MiscMenu.Gui[N].Value.ImageColor3=Color3.fromRGB(90,90,90)
					x.Value=false
					Notify('goofy ahh noob you dont own this gamepass',3)
					return
				end
				RequestItem(Id)
				local CI=LocalPlayer.CharacterAdded:Connect(function(Character)
					local Humanoid=Character:WaitForChild('Humanoid',3)or Character:FindFirstChildWhichIsA'Humanoid'
					if not Humanoid then return end
					RequestItem(Id)
				end)
				return CI
			end,
			function(Connection)
				if not Connection then return end
				Destroy(Connection)
			end
		)
	end
end
do
	local Delay=nil
	local ARButton=LocalMenu:CreateDK('AR',UDim2.new(.05,0,.85,0),'Auto Respawn: ',AllBools.IsAutoRespawn,
		function()
			--Notify('I don\'t recommend using this if you\'re trying to toolkill people, or reanimations/god')
			--Notify('now with delay',2)
			local Position,CI,CII
			local CameraCFrame
			local function CharCheck(Character)
				local Character=Character or LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				if not Character then 
					ReplicatedStorage.RequestRespawn:FireServer()
					return 
				end
				local Humanoid=Character:WaitForChild'Humanoid'
				local Root=Character:WaitForChild'HumanoidRootPart'
				if Position~=nil then
					repeat
						Root.CFrame=Position
						task.wait()
					until(Root.Position-Position.Position).Magnitude<5
					if CameraCFrame then
						Set(workspace.CurrentCamera){CFrame=CameraCFrame[1],Focus=CameraCFrame[2]}
						CameraCFrame=nil
					end
					Position=nil
				end
				local Destroying,Die
				local function yeahwhatever(Connection)
					if not AllBools.IsAutoRespawn.Value then
						Destroy(Connection)
						return
					end
					local Height=workspace.FallenPartsDestroyHeight
					if Height~=Height then Height=-400 end
					if Root and Root.Position.Y>Height then
						CameraCFrame={workspace.CurrentCamera.CFrame,workspace.CurrentCamera.Focus}
						Position=Root.CFrame
					end
					if not Delay then
						ReplicatedStorage.RequestRespawn:FireServer()
						return
					end
					Delay=math.abs(Delay)
					if Delay>999 then
						task.wait(2.9)
					else
						task.wait(Delay)
					end
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
			CI=LocalPlayer.CharacterAdded:Connect(CharCheck)
			return{CI,Position}
		end,
		function(Table)
			Destroy(Table[1])
			Table[2]=nil
		end
	)
	local DelayBox=Create'TextBox'{Text='',PlaceholderText='delay after death (sec)',TextScaled=true,PlaceholderColor3=Color3.new(.1,.1,.1),Position=UDim2.new(0,0,1,0),Size=UDim2.new(.5,0,1,0),TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.new(0,0,0),ClearTextOnFocus=false,BackgroundColor3=Color3.fromRGB(111,111,111),Parent=ARButton.Gui.Text}
	DelayBox.FocusLost:Connect(function()
		Delay=tonumber(DelayBox.Text)
		DelayBox.Text=tostring(Delay)
	end)
end
DButton.OnClick(function()
	--task.wait(Notify('this only work for swords, very buggy indeed.',4))
	task.wait(Notify('swords patched but i still want to keep this thing',4))
	local function TooComplex(p)
		local Mouse=UserInputService:GetMouseLocation()
		local Unit=CurrentCamera:ScreenPointToRay(Mouse.X,Mouse.Y-36)
		return workspace:Raycast(Unit.Origin,Unit.Direction*256,p)
	end
	LocalMenu.Gui.Visible=false
	Destroy(CoreGui,'IsDrawing')
	local Character=LocalPlayer.Character
	local Arm=Character:FindFirstChild'Right Arm'or Character:FindFirstChild'RightHand'
	local function SetCF(Position)
		return (Arm.CFrame*CFrame.new(0,-1,0,1,0,0,0,0,1,0,-1,0)):ToObjectSpace(Position):Inverse()
	end
	local Humanoid=Character:FindFirstChildWhichIsA"Humanoid"
	if Humanoid.RigType==Enum.HumanoidRigType.R15 then
		Notify('Why R15',3)
		task.wait(1.5)
		local Explosion=Create'Explosion'{BlastPressure=250000,BlastRadius=10,ExplosionType=Enum.ExplosionType.NoCraters,TimeScale=1,Position=Humanoid.RootPart.Position,Parent=Humanoid,DestroyJointRadiusPercent=1}
		--Humanoid.Health=0
		Explosion:Destroy(task.wait(1.6/Explosion.TimeScale))
		return
	end
	local Value=Create'BoolValue'{Parent=CoreGui,Name='IsDrawing',Value=true}
	local IsDrawing=Value.Value
	local IsUndoing,IsHolding,LockedWhileResetting=false,false,false
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
			v.Name=('v%d'):format(n)
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
	local Animator=Humanoid:FindFirstChild'Animator'
	local HAnimation=Create'Animation'{AnimationId='rbxassetid://182393478'} --Holding, not "that" animation.
	local Track=Animator:LoadAnimation(HAnimation)
	Track:Play(0)
	Track.Priority=Enum.AnimationPriority.Action
	Track:AdjustSpeed(0)
	local Placeholder=Create'Tool'{Name='equip me to disconnect',Parent=LocalPlayer.Backpack,ToolTip='OMG INSTANCE.NEW() HACK!!'}
	local Handle=Create'Part'{Parent=Placeholder,Name='Handle',Transparency=1,Size=Vector3.zero}
	local Orientation=CFrame.Angles(math.rad(-90),math.rad(0),math.rad(0))
	local Pointer=Create'Part'{Parent=workspace,Transparency=.6,BrickColor=BrickColor.new(1,0,0),CanQuery=false,CanTouch=false,Massless=true,Material='SmoothPlastic',Anchored=true,Size=Vector3.new(1,.8,4),CanCollide=false,CFrame=CFrame.identity*Orientation}
	CollectionService:AddTag(Pointer,'theepicfunnyparts')
	CollectionService:AddTag(Character,'theepicfunnyparts')
	LMouse.TargetFilter=Pointer
	task.wait(1)
	local CI,CII,CIII,CIV,CV
	local DI,DII=false,false
	local SWR={}
	local total=0
	for _,x in next,LocalPlayer.Backpack:GetChildren()do
		--if x:IsA'Tool'and x.Name=='ClassicSword'then
		if x:IsA'Tool'and x~=Placeholder then
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
		if x:IsA'Tool'and x~=Placeholder then
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
		if Child:IsA'Tool'and Child:FindFirstChild'Handle'and not table.find(SWR,Child)and Child~=Placeholder then
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
			Fuel.Text=('Swords: 0/%d'):format(total)
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
				local cout=table.find(SWR,Target.Instance.Parent)
				local temp=SWR[cout]
				SWR[cout]=SWR[n]
				SWR[n]=temp
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
		Fuel.Text=('lol: %d/%d'):format(n,total)
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
		--if not Tool:IsA'Tool'and Tool.Name~='ClassicSword'then return end
		if not Tool:IsA'Tool'then return end
		Tool.Parent=LocalPlayer.Character
	end,
}
RSButton.OnClick(function()RequestSword()if LocalPlayer.Team~=Knight then Notify('You dont have knight role')end end)
local SGButton=KnightMenu:CreateDK('Dupe',UDim2.new(.05,0,.65,0),'Show Dupe Gui',AllBools.IsShowingDupeMenu,
	function()
		--should rework this function later
		--Notify('Do i need to explain these icons? yes? no lol')
		if LocalPlayer.Team~=Knight then Notify('you\'re not knight')end
		local SideI=Main:CreateButtonOld('DupeButton','Dupe:\noff',UDim2.new(1,-20,.5,-80),Vector2.new(1,0))
		local Val=Create'BoolValue'{Parent=CoreGui,Name='dupe'}
		local SideII=Main:CreateIcon('ClearS','rbxassetid://12068313338',UDim2.new(1,-20,.5,-30),Vector2.new(1,0))
		local SideIII=Main:CreateIcon('BlockM','rbxassetid://12068313585',UDim2.new(1,-20,.5,20),Vector2.new(1,0))
		local SideIV=Main:CreateButtonOld('Counter','COUNT SWORD',UDim2.new(1,-20,.5,70),Vector2.new(1,0))
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
			SideIV.Gui.Text=('Items: %d'):format(Total.Value)
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
local Table={}
local SelectButtons={}
do
	local SOsub=SnipeMenu:CreateSub('sorry it ran out of budget',UDim2.new(.9,0,.075,0),Vector2.new(0,0),UDim2.new(-.303,0,-.11,0))
	local SOi=SnipeMenu:CreateSub('Ask Me Anything Booths',UDim2.new(.5,0,.075,0),Vector2.new(.5,0),UDim2.new(.5,0,.15,0),.5)
	local SOii=SnipeMenu:CreateSub('Rate My Avatar Booths',UDim2.new(.5,0,.075,0),Vector2.new(.5,0),UDim2.new(.5,0,.3,0),.5)
	local SOiii=SnipeMenu:CreateSub('Guessing Booths',UDim2.new(.5,0,.075,0),Vector2.new(.5,0),UDim2.new(.5,0,.45,0),.5)
	for x,y in next,Booths do
		Table[x]=y
	end
	for m,x in next,{SOi,SOii,SOiii}do
		for i=1,6 do
			local Button=Create'TextButton'{BackgroundColor3=Color3.fromRGB(90,90,90),Position=UDim2.new((i*.3)-.65,0,1,0),Name='hi',Text=('P%d'):format(i),Size=UDim2.new(.2,0,1,0),Parent=x}
			local VFTO=false
			local ID=(m-1)*6+i
			local Temp=Table[ID]
			table.insert(SelectButtons,Button)
			Button.MouseButton1Click:Connect(function()
				VFTO=not VFTO
				if VFTO then
					Table[ID]=nil
					if AllBools.IsWhitelisting.Value then
						Button.BackgroundColor3=Color3.fromRGB(90,90,90)
						return
					end
					Button.BackgroundColor3=Color3.fromRGB(178,235,53)
					return
				end
				Table[ID]=Temp
				if AllBools.IsWhitelisting.Value then
					Button.BackgroundColor3=Color3.fromRGB(178,235,53)
					return
				end
				Button.BackgroundColor3=Color3.fromRGB(90,90,90)
			end)
		end
	end
end
--[[
for anyone saying "omg u can just use getpropertychangedsignal if booth text = clik her to 
clem dis buth, no crap sherlock that's a bad practice considering the booth sometimes
unclaimed but still has image and/or text" in it
if you use infinite loops i will kill you
]]
local ACBSButton=SnipeMenu:CreateDK('BLWL',UDim2.new(.05,0,.7,0),'Whitelist mode: ',AllBools.IsWhitelisting,
	function()
		for _,x in next,SelectButtons do
			if x.BackgroundColor3==Color3.fromRGB(90,90,90)then
				x.BackgroundColor3=Color3.fromRGB(178,235,53)
				continue
			end
			x.BackgroundColor3=Color3.fromRGB(90,90,90)
		end
	end,
	function()
		for _,x in next,SelectButtons do
			if x.BackgroundColor3==Color3.fromRGB(178,235,53)then
				x.BackgroundColor3=Color3.fromRGB(90,90,90)
				continue
			end
			x.BackgroundColor3=Color3.fromRGB(178,235,53)
		end
	end
)
local ACBButton=SnipeMenu:CreateDK('AutoClaimBooth',UDim2.new(.05,0,.085,0),'Enable: ',AllBools.IsSnipingBooth,
	function()
		local HumanoidRootPart=LocalPlayer.Character:FindFirstChild'HumanoidRootPart'
		if not HumanoidRootPart then return end
		local Old,Old2=HumanoidRootPart.CFrame,HumanoidRootPart.CanCollide
		local function Dep(a)
			HumanoidRootPart.CFrame=a.CFrame-Vector3.new(0,15,0)
			HumanoidRootPart.CanCollide=false
			HumanoidRootPart.AssemblyLinearVelocity=Vector3.new(0,25,0)
		end
		local ListOfConnections={}
		local AlreadyRunning=false
		local AlreadyOwnBooth=false
		for _,x in next,workspace:GetChildren()do
			if x.Name~='Booth'and not x:IsA'Model'then continue end
			if(table.find(Booths,x)~=table.find(Table,x)and AllBools.IsWhitelisting)or(table.find(Booths,x)==table.find(Table,x)and not AllBools.IsWhitelisting)then 
				continue 
			end
			if AlreadyOwnBooth or AlreadyRunning then break end
			if AlreadyOwnBooth then break end
			task.spawn(function()
				local Banner=x:FindFirstChild'Banner'
				if not Banner then return end
				local ClickDetector=Banner:FindFirstChildWhichIsA'ClickDetector'
				if not ClickDetector then return end
				local Temp=x:GetAttribute'TenantUsername'
				local CI
				if Temp==''then 
					AlreadyRunning=true
					repeat
						if not AllBools.IsSnipingBooth.Value or AlreadyOwnBooth then 
							break 
						end
						Dep(Banner)
						task.wait(.1)
						fireclickdetector(ClickDetector)
					until x:GetAttribute'TenantUsername'~=''or not AllBools.IsSnipingBooth.Value
					if x:GetAttribute'TenantUsername'==LocalPlayer.Name then
						SnipeMenu.Gui.AutoClaimBooth.Value.ImageColor3=Color3.fromRGB(90,90,90)
						AllBools.IsSnipingBooth.Value=false
						Repos(HumanoidRootPart,Old,Old2)
						return
					end
					CI=x:GetAttributeChangedSignal'TenantUsername':Connect(function()
						local Temp=x:GetAttribute'TenantUsername'
						if Temp~=''then return end
						repeat
							task.wait(.1)
							fireclickdetector(ClickDetector)
						until x:GetAttribute'TenantUsername'~=''or not AllBools.IsSnipingBooth.Value
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
local EBButton=BoothMenu:CreateDK('Extra Banner',UDim2.new(.05,0,.85,0),'extra description: ',AllBools.IsShowingDesc,
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
			Set(Img){RichText=true,Text=('roblox.com/library/%s'):format(Icon.Image:match'%d+$'or''),AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.new(1,0,.5,0)}
			Icon:GetPropertyChangedSignal'Image':Connect(function()
				Img.Text=('roblox.com/library/%s'):format(Icon.Image:match'%d+$'or'')
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
					Notify(('Copied, ID: %s.'):format(ID),3)
					return
				end
				Notify('This booth has no image.')
			end)
			for _,x in next,{IBanner,TBanner,OBanner}do
				table.insert(ExtraBanners,x)
			end
			for _,x in next,{CI,CII,CIII}do
				table.insert(ListOfConnections,x)
			end
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
--[[
local DMButton=Frame:CreateDK('Music',UDim2.new(.05,0,.15,0),'music',IsMusicEnabled,
	function()
		do do end do do end end do end do end end
		Notify('function discontinued until re-newed',3)
		return
	end,
	function()
		MCI=false
		Destroy(Table[1])
		Tag.Text='v.1.436 | '..CurrentVersion..' LOCAL MODIFIED.'
	end
)
]]
local ABButton=BoothMenu:CreateDK('Anti Barrier',UDim2.new(.05,0,.65,0),'Anti Barrier: ',AllBools.IsAntiBarrier,
	function()
		for _,x in next,workspace:GetChildren()do
			SetBarrier(x)
		end
		local CI
		CI=workspace.ChildAdded:Connect(SetBarrier)
		return CI
	end,
	function(CI)
		Destroy(CI)
		for _,v in next,workspace:GetChildren()do
			SetBarrier(v,'blah blah blah')
		end
	end
)
local ACKButton=KnightMenu:CreateDK('ACK',UDim2.new(.05,0,.85,0),'Auto Claim Knight: ',AllBools.IsAutoClaim,
	function()
		if LocalPlayer.Team==Knight then
			KnightMenu.Gui.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
			AllBools.IsAutoClaim.Value=false
			Notify('you already have knight role, what do you expect.')
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
				until not Prox or not Prox.Enabled or not AllBools.IsAutoClaim.Value
				task.wait()
				JewellStand.CanCollide=true
				HumanoidRootPart.CFrame=OldCFrame
				KnightMenu.Gui.ACK.Value.ImageColor3=Color3.fromRGB(90,90,90)
				AllBools.IsAutoClaim.Value=false
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
				AllBools.IsAutoClaim.Value=false
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
	local Prox=JewellStand:FindFirstChild'ProximityPrompt'
	if Prox then
		if not Prox.Enabled then
			Notify('Knight is not available at the moment',1)
			return
		end
		a(Prox)
	end
end)
