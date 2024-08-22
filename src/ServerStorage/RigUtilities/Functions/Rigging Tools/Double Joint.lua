local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}

--Function will create a new joint between P0 and P1. The new joint will be offset by P1's offset.
function invisipart(joint:Motor6D)
	local pivotHandleScale = script.Options.PivotHandleScale.Value
	if pivotHandleScale <=0 then
		pivotHandleScale = 1
	end
	local doublejoint = Instance.new("Part")
	doublejoint.Transparency = 1
	doublejoint.Size = Vector3.new(1,1,1)*pivotHandleScale
	doublejoint.Name = "Pivot"..joint.Part1.Name
	-- Set the double joint to the position of P1's joint.
	doublejoint.CFrame = joint.Part1.CFrame*joint.C1
	doublejoint.Parent = joint.Part1
	local motor6d = Instance.new("Motor6D")
	motor6d.Name = "AnimatablePivot"
	motor6d.Parent = doublejoint
	--Create a non-destructive pivot joint.
	--motor6d.C0 = joint.C1
	--motor6d.C1 = joint.C1
	motor6d.Part0 = doublejoint
	motor6d.Part1 = joint.Part1
	--joint.Parent = doublejoint
	joint.Part1 = doublejoint
	return doublejoint, motor6d
end



function Action:Action()
	local selected = SELE:Get()
	
	if selected[1]:IsA("Motor6D") then
		for i,v in pairs(selected) do
			invisipart(v)
		end
		return true
	end
	
	local basebone:BasePart = WT:GetBonePart(selected[1])
	local target = selected[2]
	local targetbone = WT:GetBonePart(selected[2])
	if basebone and targetbone then
		for i,joint:Motor6D in basebone:GetJoints()  do
			if joint.Part0 == targetbone or joint.Part1 == targetbone then
				invisipart(joint)
				break
			end
		end
	else
		warn("The selection was not a basepart or lacked a bonepart. To add a bonepart to a model use the 'Add Boundry Box Bone'")
		return nil
	end
	return true
end

return Action


