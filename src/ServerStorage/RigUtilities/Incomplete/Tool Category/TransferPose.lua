local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}


function propigate(target:Motor6D, targetSkeletonTable)
	if table.find(targetSkeletonTable,target) then
		return
	end
	print(#targetSkeletonTable, target.Part0.Name.."->"..target.Part1.Name)
	local JointTable = {}
	JointTable[target.Part1] = target
	table.insert(JointTable, target.Name)
	targetSkeletonTable[target.Part0] = JointTable
	--This will flag the joint as searched
	table.insert(targetSkeletonTable,target)
	for i,t in pairs(target.Part1:GetChildren())  do
		if t:IsA("Motor6D") then
			propigate(t , targetSkeletonTable)
		end
	end

end
function Action:Action()
	local selectionTable = {}
	local targetmodel:Model = SELE:Get()[1]
	local reposemodel:Model = SELE:Get()[2]
	--Get all joint information
	local targetSkeletonTable = {}
	if targetmodel.PrimaryPart then
		for i,target in pairs(targetmodel.PrimaryPart:GetChildren())  do
			if target:IsA("Motor6D") then
				propigate(target, targetSkeletonTable)
			end
		end
	end
	SELE:Set(selectionTable)
	return true
end
return Action