workspace.FallenPartsDestroyHeight = 0/0
SpecialName="gay"
-- workspace.FallenPartsDestroyHeight = -99999
local localPlayer = game:GetService("Players").LocalPlayer
local character = localPlayer.Character
local tools = {}
local getRandomPlayer = function()
	local cPlayers = game:GetService("Players"):GetPlayers()
	table.remove(cPlayers, table.find(cPlayers, localPlayer))
	return cPlayers[math.random(#cPlayers)]
end
for _, object in pairs(localPlayer.Backpack:GetChildren()) do
	if object:FindFirstChild("Handle") then
		table.insert(tools, object)
	-- 	local bodyForce = Instance.new("BodyForce")
	-- bodyForce.Force = Vector3.new(0, object.Handle:GetMass() * workspace.Gravity, 0)
	-- bodyForce.Parent = object.Handle

	end
end
character.Archivable = true
character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
local fakeCharacter = character:Clone()
fakeCharacter.Parent = game.ReplicatedStorage
for _, tool in pairs(tools) do
	tool.Parent = character
end
replicatesignal(localPlayer.ConnectDiedSignalBackend)
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Tool replication v11[BETA RELEASE]",
	Text = "therealvan45 modified it. Credits to original script creator",
	Duration = game:GetService("Players").RespawnTime
})
antidrop=true
if antidrop==true then
	--Anti tool drop is not mine at all
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local LocalPlayer = Players.LocalPlayer
	local StarterGui = game:GetService("StarterGui")

	if not getgenv().Network then
		getgenv().Network = {
			BaseParts = {};
			Velocity = Vector3.new(0,999,0);
			Output = {
				Enabled = true;
				Prefix = "[NETWORK] ";
				Send = function(Type,Output,BypassOutput)
					if typeof(Type) == "function" and (Type == print or Type == warn or Type == error) and typeof(Output) == "string" then
						if Network["Output"].Enabled == true or BypassOutput then
							Type(Network["Output"].Prefix..Output)
						end
					end
				end;
			};
		}
		Network.Output.Send(print,": Network Loaded.")
	end

	local hats = {}

	for _,h in pairs(LocalPlayer.Character:GetChildren()) do
		if h:IsA("Tool") or h:IsA("HopperBin") then
			local hd = h.Handle
			table.insert(Network.BaseParts, hd)
			table.insert(hats, hd)
		end
	end

	Network["PartOwnership"] = {}
	Network["PartOwnership"]["Enabled"] = false
	Network["PartOwnership"]["Enable"] = coroutine.create(function()
		if not Network["PartOwnership"]["Enabled"] then
			Network["PartOwnership"]["Enabled"] = true
			Network["PartOwnership"]["Connection"] = RunService.Heartbeat:Connect(function()
				sethiddenproperty(LocalPlayer,"SimulationRadius",1/0)
				for _,Part in pairs(Network.BaseParts) do
					if Part:IsDescendantOf(workspace) then
						coroutine.wrap(function()
							Part.Velocity = Network.Velocity + Vector3.new(0,math.cos(tick()*10)/100,0)
						end)()
					end
				end
			end)
			Network.Output.Send(print,"PartOwnership enabled.")
		else
			Network.Output.Send(warn,"PartOwnership already enabled.")
		end
	end)

	coroutine.resume(Network["PartOwnership"]["Enable"])
end
task.wait(game:GetService("Players").RespawnTime + 0.2)
replicatesignal(localPlayer.Kill)
task.wait(localPlayer:GetNetworkPing() * 2)
for _, tool in pairs(tools) do
	tool.Parent = localPlayer.Backpack
end
task.wait(localPlayer:GetNetworkPing() * 2)
for _, tool in pairs(tools) do
	tool.Parent = character
end
local step = game:GetService("RunService").PostSimulation:Connect(function()
	for _, object in pairs(fakeCharacter:GetDescendants()) do
		if object:IsA("BasePart") or object:IsA("MeshPart") then
			--  object.Transparency = 0.5
			-- object.CanCollide = false
		end
	end
	for _, object in pairs(character:GetDescendants()) do
		if object:IsA("BasePart") or object:IsA("MeshPart") then
			-- object.CanCollide = false
		end
	end
end)
local c; c = game:GetService("RunService").PostSimulation:Connect(function()
	-- localPlayer.SimulationRadius = math.huge -- useless
for i,v in pairs(character:GetChildren()) do

	 if v:IsA("Humanoid") then
    v.MaxHealth = math.huge
    v.Health = math.huge
	end
	end
	local allChildren = {}
	local added = {}
	local function addPart(part)
		if part and part.Parent and part.Transparency < 1 and not added[part] then
			table.insert(allChildren, part)
			added[part] = true
		end
	end
	local allChildren = {}
	local added = {}
	local function addPart(part)
		if part and part.Parent and part.Transparency < 1 and not added[part] then
			table.insert(allChildren, part)
			added[part] = true
		end
	end
	-- Add main body parts if visible
	if fakeCharacter:FindFirstChild("RightLowerLeg") then
		addPart(fakeCharacter["RightLowerLeg"])
	end
	if fakeCharacter:FindFirstChild("LeftLowerLeg") then
		addPart(fakeCharacter["LeftLowerLeg"])
	end
	if fakeCharacter:FindFirstChild("LowerTorso") then
		addPart(fakeCharacter["LowerTorso"])
	end
	if fakeCharacter:FindFirstChild("RightLowerArm") then
		addPart(fakeCharacter["RightLowerArm"])
	end
	if fakeCharacter:FindFirstChild("LeftLowerArm") then
		addPart(fakeCharacter["LeftLowerArm"])
	end
	if fakeCharacter:FindFirstChild("Head") then
		addPart(fakeCharacter["Head"])
	end
	-- Add from "gay" objects directly under fakeCharacter
	for _, obj in pairs(fakeCharacter:GetChildren()) do
		if obj.Name == SpecialName then
			if obj:IsA("BasePart") or obj:IsA("MeshPart") then
				addPart(obj)
			end
			for _, descendant in pairs(obj:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
					addPart(descendant)
				end
				if descendant:IsA("Instance") then --you can change the instance
					for useless,kakashkas in pairs(descendant:GetDescendants()) do
						if kakashkas:IsA("BasePart") or kakashkas:IsA("MeshPart") then
							addPart(kakashkas)
						end
					end
				end
			end
		end
	end
	-- Also search for "gay" models inside character's limbs
	local limbs = {"LeftLowerArm", "RightLowerArm", "Head", "LowerTorso", "LeftLowerLeg", "RightLowerLeg"}
	for _, limbName in pairs(limbs) do
		local limb = fakeCharacter:FindFirstChild(limbName)
		if limb then
			for _, obj in pairs(limb:GetChildren()) do
				if obj.Name == SpecialName then
					if obj:IsA("BasePart") or obj:IsA("MeshPart") then
						addPart(obj)
					end
					for _, descendant in pairs(obj:GetDescendants()) do
						if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
							addPart(descendant)
						end
						if descendant:IsA("Instance") then --you can change the instance
							for useless,kakashkas in pairs(descendant:GetDescendants()) do
								if kakashkas:IsA("BasePart") or kakashkas:IsA("MeshPart") then
									addPart(kakashkas)
								end
							end
						end
					end
				end
			end
		end
	end
	for index, tool in ipairs(tools) do
		if not tool:FindFirstChild("Handle") then
			continue
		end
		if allChildren[index] then
			tool.Handle.CFrame = allChildren[index].CFrame
			tool.Handle.CanCollide = false
			-- tool.Handle.CanTouch = false
			tool.Handle.Massless=true
			-- tool.Handle.Velocity = Vector3.one * 30
            --  tool.Handle.AssemblyLinearVelocity = Vector3.new(0,100,0)
			-- Inside your Heartbeat loop
		-- tool.Handle.AssemblyLinearVelocity = Vector3.zero
		-- tool.Handle.AssemblyAngularVelocity = Vector3.zero
			--tool.Handle.AssemblyLinearVelocity = Vector3.new(0,50,0)
			-- tool.Handle.AssemblyLinearVelocity = Vector3.new(0, 0.05, 0)
		end
	end
end)
fakeCharacter.Parent = workspace
character.Parent = fakeCharacter
for i,v in pairs(fakeCharacter:GetChildren()) do

	 if v:IsA("Humanoid") then
    v.Died:Connect(function()
	character.Parent = workspace
	localPlayer.Character = character
	step:Disconnect()
	c:Disconnect()
	for _, tool in pairs(tools) do
		tool:Destroy()
	end
	task.wait()
	fakeCharacter:Destroy()
	workspace.CurrentCamera.CameraSubject = character
	replicatesignal(localPlayer.ConnectDiedSignalBackend)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "tf",
		Text = "please wait respawning",
		Duration = game:GetService("Players").RespawnTime
	})
	end)
	end
	end
localPlayer.Character = fakeCharacter
workspace.CurrentCamera.CameraSubject = fakeCharacter
fakeCharacter.Animate.Disabled = true
task.wait(0.1)
fakeCharacter.Animate.Disabled = false
script=Instance.new("LocalScript")
--Paste here your r15 script that you want to replicate!
