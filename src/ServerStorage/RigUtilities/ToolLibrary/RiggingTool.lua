local RUTJOINTSTRINGPREFIX = "RUTJOINT"

local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")

local RIG = {}

-- Adds attribute which gives original pose information
function RIG:MakeDefaultPose(joint:Motor6D)
	joint:SetAttribute(RUTJOINTSTRINGPREFIX.."DefaultC0", joint.C0)
	joint:SetAttribute(RUTJOINTSTRINGPREFIX.."DefaultC1", joint.C1)
end

function RIG:SetToDefaultPose(joint:Motor6D)
	joint.C0 = joint:GetAttribute(RUTJOINTSTRINGPREFIX.."DefaultC0") or joint.C0
	joint.C1 = joint:GetAttribute(RUTJOINTSTRINGPREFIX.."DefaultC1") or joint.C1
end

function RIG:TransferJointPose(joint1:Motor6D, joint2:Motor6D)
	joint2.C0 = joint1.C0
	joint2.C1 = joint1.C1
end

--Normal parts rigging without offset
function RIG:RigParts(base:BasePart,target:BasePart, isBaseOriented:boolean)
	local joint:Motor6D = Instance.new("Motor6D")
	joint.Part0 = base
	joint.Part1 = target
	if isBaseOriented then
		joint.C1 = target.CFrame:ToObjectSpace(base.CFrame)
	else
		joint.C0 = base.CFrame:ToObjectSpace(target.CFrame)
	end
	joint.Name = base.Name.."->"..target.Name
	RIG:MakeDefaultPose(joint)
	joint.Parent = base
	return joint
end
-- Has no use
function RIG:RigWithJoints(base:BasePart,target:BasePart,rotjoint)
	local joint:Motor6D = Instance.new("Motor6D")
	joint.Part0 = base
	joint.Part1 = target
	joint.C1 = target.CFrame:ToObjectSpace(rotjoint.CFrame)
	joint.C0 = base.CFrame:ToObjectSpace(rotjoint.CFrame)
	joint.Name = base.Name.."->"..target.Name
	RIG:MakeDefaultPose(joint)
	joint.Parent = base
	return joint
end
-- Provides Offset info. Usually from the pivot position of the model
function RIG:RigPartsOffSet(base:BasePart, target:BasePart, offset:CFrame)
	local joint:Motor6D = Instance.new("Motor6D")
	joint.Part0 = base
	joint.Part1 = target
	joint.C0 = base.CFrame:ToObjectSpace(offset)
	joint.C1 = target.CFrame:ToObjectSpace(offset)
	joint.Name = base.Name.."->"..target.Name
	RIG:MakeDefaultPose(joint)
	joint.Parent = base
	return joint
end
return RIG
