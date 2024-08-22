local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	for i,target in pairs(SELE:Get())  do

	end
	SELE:Set(selectionTable)
	return true
end
return Action