local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local selectionTable = {}
function extractBoundaryBox(model:Model)
	if model:IsA(model) then
		local cfr, size = model:GetBoundingBox()
		local bone:Part = Instance.new("Part")
		bone.CFrame = cfr
		bone.Size = size
		bone.Name = model.Name
		bone.Parent = workspace
		bone.Transparency = .8
		CS:AddTag(bone,"BonePart")
		bone = WT:MakeBone(bone,model,nil)
		table.insert(selectionTable,bone)
	end
end
function extractPrimaryPart(model:Model)
	if model:IsA(model) then
		if model.PrimaryPart ~= nil then
			local bone:Part = model.PrimaryPart:Clone()
			bone.Name = model.Name
			bone.Parent = workspace
			bone.Transparency = .8
			CS:AddTag(bone,"BonePart")
			bone = WT:MakeBone(bone,model,nil)
			table.insert(selectionTable,bone)
		else
			warn("THE MODEL LACKS A PRIMARYPART")
		end
	end
	return false
end
function Action:Action()
	--print(script.Options.BoneFromPrimaryPart.Value)
	if script.Options.BoneFromPrimaryPart.Value then
		for i,v in pairs(SELE:Get()) do
			if not extractPrimaryPart(v) then
				return false
			end
		end
	else
		for i,v in pairs(SELE:Get()) do
			extractBoundaryBox(v)
		end
	end

	SELE:Set(selectionTable)
	return true
end

return Action