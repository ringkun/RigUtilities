local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local Options = script.Options
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}



local selectionTable = {}

function findImmediateModelDescendant(part:Part, model)
	local search = part.Parent
	while search ~= nil and not (search:IsA("BasePart") or search:IsA("Model")) do
		if search == model then
			break
		end
		search = search.Parent
	end
	return search
end
function Action:Action()
	local GarbageTable = {}
	local ParentTable = {}
	local success = true
	local perservejoints = script.Options.PerserveJointsAndWelds.Value
	for i,selection in pairs(game:GetService("Selection"):Get()) do
		for i,v in pairs(selection:GetDescendants()) do
			if v~= nil and v.Parent ~= nil then
				if v:IsA("Humanoid")  then
					v:Destroy()
				else
					if v:IsA("BasePart") or v:IsA("Model") then
						if v ~= selection then
							local search = findImmediateModelDescendant(v, selection)
							v.Parent = search
						end
					else
						if not (perservejoints and v:IsA("JointInstance")) then							
							table.insert(GarbageTable,v)
						end
					end
				end
			end
		end
		for i,v in pairs(GarbageTable) do
			if v ~= nil then
				v:Destroy()
			end
		end
	end
	return success
end
return Action
