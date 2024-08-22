local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	for i,target in pairs(SELE:Get())  do
		for _,d in pairs(target:GetDescendants()) do
			if d:IsA("Motor6D") then
				table.insert(selectionTable,d)
				RT:SetToDefaultPose(d)
			end
		end
	end
	SELE:Set(selectionTable)
	return true
end
return Action