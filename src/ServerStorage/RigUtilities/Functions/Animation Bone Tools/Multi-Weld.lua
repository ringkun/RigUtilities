local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local Options = script.Options
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}

function weld(m:Model)
	if not m:IsA("Model") then
		if m:IsA("BasePart") then
			WT:MakeBone(m)
			return m
		end
		return nil
	end
	local bone = WT:GetBonePart(m)
	if bone then
		return m
	end
	if Options.BoneFromPrimaryPart.Value then
		bone = WT:BonePartFromPrimaryPart(m, Options.BoundaryBoxMargin.Value)
	else
		bone = WT:BonePartFromBoundaryBox(m, Options.BoundaryBoxMargin.Value)
	end
	local modelcontainer:Model = Instance.new("Model")
	bone.Parent = modelcontainer
	modelcontainer.Name = m.Name
	modelcontainer.PrimaryPart = m.PrimaryPart
	m.Parent = modelcontainer
	for _,p in pairs(m:GetDescendants()) do
		if p:IsA("BasePart") then
			WT:Weld(bone,p)
		end
	end			
	modelcontainer.WorldPivot = m:GetPivot()
	return modelcontainer
end
local selectionTable = {}
function CreateSkeleton(m)
	local par = m.Parent
	local welded = weld(m)
	table.insert(selectionTable,welded)
	welded.Parent = par
	return welded
end


function Action:Action()
	selectionTable = {}
	local success = true
	for i,v in pairs(game:GetService("Selection"):Get()) do
		if not CreateSkeleton(v) then
			success = false
		end

	end
	SELE:Set(selectionTable)
	return success
end
return Action
