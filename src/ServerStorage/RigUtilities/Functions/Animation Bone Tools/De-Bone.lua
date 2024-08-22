local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local CS = game:GetService("CollectionService")
local Action = {}

function Action:Action()
	local selectionTable = {}
	for i,target in pairs(SELE:Get())  do
		if WT:IsBonePart(target) then
			WT:Debone(target)
		end			
		if script.Options.ApplyToDescendants.Value then
			for _,descendants in pairs(target:GetDescendants()) do
				if WT:IsBonePart(descendants) then
					WT:Debone(descendants)
				end			
			end
		end
	end
	SELE:Set(selectionTable)
	return true
end
return Action