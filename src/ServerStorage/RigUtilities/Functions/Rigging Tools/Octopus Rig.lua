local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	local firstSelection = nil
	for i,target in pairs(SELE:Get())  do
		local bone = WT:GetBonePart(target)
		if i == 1 then
			if bone ~= nil then
				firstSelection = bone
			else
				warn("The Breadth Rigging has failed due to there being no bone part or basepart as first selection")
				return false
			end			
		else
			if bone then -- If there exist a bone to join
				if target:IsA("BasePart") then -- If basepart
					table.insert(selectionTable,RT:RigPartsOffSet(firstSelection,bone,target.CFrame*target.PivotOffset))					
				else -- If model
					table.insert(selectionTable,RT:RigPartsOffSet(firstSelection,bone,target.WorldPivot))			
				end				
				--SELE:Set(selectionTable)
			else
				warn("The Breadth Rigging has failed due to there being no bone part in one of your selection")
				return false
			end
		end
	end
	--SELE:Set(selectionTable)
	return true
end
return Action