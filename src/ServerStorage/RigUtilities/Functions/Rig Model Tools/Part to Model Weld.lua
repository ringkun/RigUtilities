local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local Options = script.Options
local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local Action = {}
local RT = require((script.Parent.Parent.Parent.ToolLibrary.RiggingTool))




function PartToModel(base:BasePart,model:Model, isWeld, inPlace,WeldToPP)
	if not base:IsA("BasePart") then
		warn("FIRST SELECTION IS NOT A BASE PART")
		return false
	end
	if WeldToPP then		
		-- If there is a primary part 
		if model.PrimaryPart ~= nil then
			for i,v in pairs(model:GetDescendants()) do
				if v:IsA("BasePart") then
					local weld = Instance.new("Weld")
					weld.Part0 = model.PrimaryPart
					weld.Part1 = v
					weld.C0 = weld.Part0.CFrame:toObjectSpace(weld.Part1.CFrame)
					weld.Parent = weld.Part0
				end
			end
			if not inPlace then
				model:PivotTo(base.CFrame)
			end
			local weld:JointInstance
			if isWeld then
				weld = Instance.new("Weld")
				weld.Part0 = base
				weld.Part1 = model.PrimaryPart
				weld.C0 = weld.Part0.CFrame:toObjectSpace(weld.Part1.CFrame)
			else
				weld = Instance.new("Motor6D")
				RT:RigPartsOffSet(base,model.PrimaryPart,model.WorldPivot)
			end
			weld.Parent = weld.Part0
		else
			warn("PRIMARYPART TO MODEL IS MISSING")
			return
		end
	else
		-- Cannot be animatable without primary part
		for i,v in pairs(model:GetDescendants()) do
			if v:IsA("BasePart") then
				local weld:JointInstance
				if isWeld then
					weld = Instance.new("Weld")
					weld.Part0 = base
					weld.Part1 = v
					weld.C0 = weld.Part0.CFrame:toObjectSpace(weld.Part1.CFrame)
					weld.Parent = weld.Part0
				--else
				--	weld = Instance.new("Motor6D")					
				end
			end
		end
	end
	if isWeld then
		local accessoryFolder = base.Parent:FindFirstChild("Accessories Folder")
		if not accessoryFolder then
			accessoryFolder = Instance.new("Folder")
			accessoryFolder.Name = "Accessories Folder"
			accessoryFolder.Parent = base.Parent
		end
		model.Parent = accessoryFolder

	else
		model.Parent = base.Parent			
	end
end


local selectionTable = {}


function Action:Action()
	selectionTable = {}
	local param = game:GetService("Selection"):Get()
	local success = pcall(function()
		PartToModel(param[1],param[2], Options.IsWeld.Value, Options.InPlace.Value, Options.WeldToPrimaryPart.Value)
	end)

	SELE:Set(selectionTable)
	return success
end
return Action
