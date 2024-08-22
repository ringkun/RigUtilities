local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local Options = script.Options
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}



local bodyName = {}
function InstaWeld(target, armor)
	--Add the skeleton names into the "bodyname" table
	for i,v in pairs(target:GetChildren()) do
		if v:IsA("BasePart") then
			if table.find(bodyName,v.Name) then
				warn("THERE IS A NAMING COLLISION FOR "..v.Name)
				return false
			end
			table.insert(bodyName,v.Name)
		end
	end
	local riggedModels = {}
	local target = target:Clone()
	target.Parent = workspace
	local accessoryFolder:Folder
	if not target:FindFirstChild("Accessory") then
		accessoryFolder = Instance.new("Folder")
		accessoryFolder.Name = "Accessory"
		accessoryFolder.Parent = target
	end
	-- Loop Through the Armor Part
	for _,m in pairs(armor:GetChildren()) do	
		local mparent = m.Parent
		m = m:Clone()
		if m:IsA("Model") then
			--Search for body part for loop
			local bodyPart = nil
			for i,v in pairs(m:GetChildren()) do
				if table.find(bodyName,v.Name) and v:IsA("BasePart") then
					bodyPart = v 
					break
				end
			end
			if bodyPart ~= nil then
				local modelcontainer = Instance.new("Model")
				modelcontainer.Name = bodyPart.Name
				modelcontainer.Parent = mparent
				m.Parent = modelcontainer
				for _,p in pairs(m:GetDescendants()) do
					if p:IsA("BasePart") and p ~= bodyPart then
						local weld = Instance.new("Weld")
						weld.Part0 = bodyPart
						weld.Part1 = p
						weld.C0 = bodyPart.CFrame:toObjectSpace(p.CFrame)
						weld.Parent = bodyPart
						p.Anchored = false
						p.CanCollide = false
					end
					if p:IsA("JointInstance") then
						p:Destroy()
					end
				end			
				modelcontainer.PrimaryPart = bodyPart
				m = modelcontainer
				local attach = target:FindFirstChild(bodyPart.Name)
				m.PrimaryPart = bodyPart
				bodyPart.CFrame = attach.CFrame
				local weld = Instance.new("Weld")
				weld.Part0 = attach
				weld.Part1 = bodyPart
				weld.C0 = attach.CFrame:Inverse()
				weld.C1 = bodyPart.CFrame:Inverse()
				weld.Parent = bodyPart
				m.Parent = accessoryFolder
				bodyPart.Parent = accessoryFolder
			else
				warn("Insta-Weld:Bodypart Missing")
			end
		elseif m:IsA("BasePart") and table.find(bodyName,m.Name) and target:FindFirstChild(m.Name) then
			local targetBodyPart = target:FindFirstChild(m.Name)
			targetBodyPart.Material = m.Material
			targetBodyPart.Transparency = m.Transparency
			targetBodyPart.Color = m.Color
		end
	end	
	SELE:Set({target})
end





local selectionTable = {}


function Action:Action()
	selectionTable = {}
	bodyName = {}
	local success = true
	local param = game:GetService("Selection"):Get()
	InstaWeld(param[1],param[2])

	SELE:Set(selectionTable)
	return success
end
return Action
