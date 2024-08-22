local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}



function Action:Action()
	local selected = SELE:Get()
	local basebone = WT:GetBonePart(selected[1])
	local target = selected[2]
	local targetbone = WT:GetBonePart(selected[2])
	if basebone and targetbone then
		if selected[2]:IsA("BasePart") then
			RT:RigPartsOffSet(basebone,targetbone, target.CFrame*target.PivotOffset)
		elseif selected[2]:IsA("Model") then
			RT:RigPartsOffSet(basebone,targetbone, target.WorldPivot)
		end
	else
		warn("The selection was not a basepart or lacked a bonepart. To add a bonepart to a model use the 'Add Boundry Box Bone'")
		return nil
	end
	return true
end

return Action


