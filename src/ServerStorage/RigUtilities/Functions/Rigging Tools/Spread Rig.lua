local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	local base = nil
	for i,target in pairs(SELE:Get())  do
		local bone = WT:GetBonePart(target)
		if i%script.Options.Spread.Value == 1 then
			--If in stride, set base value to current bone, otherwise if bone doesn't exist skip it
			if bone ~= nil then
				base = bone
			else
				base = nil
				warn("MISSING BONE IN MODEL, USE MULTIWELD TOOL ON MODEL: "..target.Name)
				return false
			end
		else
			-- If there already exist a bone
			if bone ~= nil then
				if base ~= nil then
					print("Making joints for ", i%script.Options.Stride.Value, base.Name,bone.Name)
					if target:IsA("BasePart") then -- If basepart
						table.insert(selectionTable,RT:RigPartsOffSet(base,bone,target.CFrame*target.PivotOffset))					
					else -- If model
						table.insert(selectionTable,RT:RigPartsOffSet(base,bone,target.WorldPivot))			
					end				
					--SELE:Set(selectionTable)
				end
			else
				warn("There is a missing Bone in one of your selections")
				return false
			end
		end
	end
	--SELE:Set(selectionTable)
	return true
end
return Action