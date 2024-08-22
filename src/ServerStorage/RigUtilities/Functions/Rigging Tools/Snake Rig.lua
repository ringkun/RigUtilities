local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	local lastBone = nil
	for i,target in pairs(SELE:Get())  do
		local bone = WT:GetBonePart(target)
		if not lastBone then
			if not bone then
				warn("First selection lacks a bone")
				return false
			end
			lastBone = bone
		else
			if bone then -- If there exist a bone to join
				if target:IsA("BasePart") then -- If basepart
					table.insert(selectionTable,RT:RigPartsOffSet(lastBone,bone,target.CFrame*target.PivotOffset))					
				else -- If model
					table.insert(selectionTable,RT:RigPartsOffSet(lastBone,bone,target.WorldPivot))			
				end
				lastBone = bone
				--SELE:Set(selectionTable)
			else
				warn("During depth rigging there is a model without a bone: "..target.Name)
				return false
			end
		end
	end
	--SELE:Set(selectionTable)
	return true
end
return Action