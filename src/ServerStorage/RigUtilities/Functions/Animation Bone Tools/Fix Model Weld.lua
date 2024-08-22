local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
function FixWeld(Model:Model)
	if Model:IsA("Model") then
		local Bone = WT:GetBonePart(Model)
		if not Bone then -- If Bone doesn't exist
			warn("Model "..Model.Name.." lacks a BonePart as its nearest child")
			return false
		else
			for i,v in pairs(Bone:GetChildren()) do
				if v:IsA("Weld") then
					v:Destroy()
				end
			end
			WT:MakeBone(Bone,Model)
			WT:WeldModelToBone(Model,Bone)
		end
	end
	return true
end

function Action:Action()
	local success = true	
	for i,m in pairs(game:GetService("Selection"):Get()) do
		local res = FixWeld(m)
		if not res then
			success = false
		end
	end
	return success
end
return Action