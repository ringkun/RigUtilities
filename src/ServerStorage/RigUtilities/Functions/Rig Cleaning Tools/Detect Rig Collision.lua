local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
--local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local selectionTable = {}
function DetectCollision(model)
	local m6dcollisioncache = {}
	local collisionTable = {}
	for i,v in pairs(model:GetDescendants()) do
		if v:IsA("Motor6D") then
			if not m6dcollisioncache[v.Part0] then
				m6dcollisioncache[v.Part0] = {}
			end
			if table.find(m6dcollisioncache[v.Part0],v.Part1) then
				warn("RIG COLLISION", v.Part0.Name,v.Part1.Name)
				table.insert(collisionTable, v)
			else
				table.insert(m6dcollisioncache[v.Part0], v.Part1)
			end
		end
	end
	game.Selection:Set(collisionTable)
end
function Action:Action()
	for i,v in pairs(SELE:Get()) do
		DetectCollision(v)
	end
	return true
end

return Action