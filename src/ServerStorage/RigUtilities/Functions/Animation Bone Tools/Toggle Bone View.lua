local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local stateVisible = false
local visibility = script.Options.BoneVisibility
function Action:Action()
	stateVisible = not stateVisible
	for i,v:BasePart in pairs(CS:GetTagged("BonePart")) do
		if v:IsA("BasePart") and not v:GetAttribute("IsNotModelBonePart") then
			if stateVisible then
				v.Transparency = visibility.Value
			else
				v.Transparency = 1
			end
		end
	end
	return true
end
return Action