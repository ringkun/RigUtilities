local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local selectionTable = {}

local originalToClone = {}
function extractBone(v)
	local cbone = nil
	local bone = nil -- Variable to store bone
	if v:IsA("Model") then --If model find the Bone Part
		bone = WT:GetBonePart(v)
		if bone then -- If it exist clone it
			cbone = bone:Clone()
		end
		if not bone then -- If not get it from boundary box
			cbone = WT:BonePartFromBoundaryBox(v)
		end
	elseif v:IsA("BasePart") then -- If just a part simply clone it
		cbone = v:Clone()
		bone = v
	end
	if not bone then -- If nothing terminate process
		return false
	else -- If bone exists apply this transformation
		originalToClone[bone] = cbone
		cbone.Name = v.Name
		cbone.Transparency = .8
		cbone.Material = Enum.Material.SmoothPlastic
		cbone.CanCollide = false
		cbone.Parent = workspace		
		--cbone:ClearAllChildren()
		--if v:IsA("Model") then
		--	WT:MakeBone(cbone,v)
		--else
			
		--end
		table.insert(selectionTable,cbone)
		return bone
	end
end
function Action:Action()
	selectionTable = {}
	originalToClone = {}
	for i,v in pairs(SELE:Get()) do
		extractBone(v)
	end
	local jointList = {}
	for i,cbone in pairs(selectionTable) do
		if cbone:IsA("BasePart") then
			for i,v:Motor6D in pairs(cbone:GetChildren()) do
				if v:IsA("Motor6D") then
					--print(cbone.Name)
					table.insert(jointList,v)
					v.Enabled = false
					v.Part0 = cbone
					--print(v.Part1.Name)
					v.Part1 = originalToClone[v.Part1]
				elseif v:IsA("Weld") then
					v:Destroy()
				end
			end
		end
	end	
	for i,joint in pairs(jointList) do
		--print(joint.Name)
		joint.Enabled = true
	end
	SELE:Set(selectionTable)
	return true
end

return Action
