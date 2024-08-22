local SELE = game:GetService("Selection")
local WT = require(script.Parent.Parent.Parent.ToolLibrary.WeldingTool)
local RT = require(script.Parent.Parent.Parent.ToolLibrary.RiggingTool)
local Action = {}
function Action:Action()
	local selectionTable = {}
	local rig = SELE:Get()[1]
	local root = SELE:Get()[2]
	if rig:IsA("Model") and root:IsA("BasePart") then
		root.Anchored = false
		local croot = root:Clone()
		croot:ClearAllChildren()
		croot.Name = rig.Name..".Root"
		croot.Anchored = true
		croot.Transparency = 1
		croot.Size = root.Size*.9
		croot.Parent = rig
		croot.RootPriority = script.Options.RootPriority.Value
		RT:RigParts(croot,root)
		rig.PrimaryPart = croot
	end
	
	SELE:Set(selectionTable)
	return true
end
return Action