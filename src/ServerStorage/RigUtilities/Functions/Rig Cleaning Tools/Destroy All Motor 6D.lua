local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local selectionTable = {}
function DestroyAllMotor6D(model)
	for i,v in pairs(model:GetDescendants()) do
		if v:IsA("Motor6D") then
			v:Destroy()
		end
	end
end
function Action:Action()
	for i,v in pairs(SELE:Get()) do
		DestroyAllMotor6D(v)
	end
	return true
end

return Action