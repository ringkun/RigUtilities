local BONEPARTNAME = "BonePart"

local CS = game:GetService("CollectionService")
local WELD = {}
function WELD:Weld(p0:BasePart,p1:BasePart)
	local weld = Instance.new("Weld")
	weld.Part0 = p0
	weld.Part1 = p1
	weld.C0 = p0.CFrame:toObjectSpace(p1.CFrame)
	weld.Parent = p0
end

function WELD:AddBoneInfo(bone:Part,model:Model,rotJoint:BasePart)
	local adornee = bone:FindFirstChild("Adornee")
	if not adornee or not adornee:IsA("ObjectValue") then
		adornee = Instance.new("ObjectValue")
	end
	adornee.Value = model
	adornee.Name = "Adornee"
	adornee.Parent = bone
end
function WELD:BonePartFromBoundaryBox(model:Model,margin)
	margin = margin or .2
	local bone = Instance.new("Part")
	local orientation, size = model:GetBoundingBox()
	bone.CFrame = orientation
	bone.Size = size+Vector3.new(1,1,1)*margin
	bone.Name = model.Name
	WELD:MakeBone(bone,model)
	return bone
end
function WELD:BonePartFromPrimaryPart(model:Model, margin)
	if model.PrimaryPart == nil then
		return nil
	end
	margin = margin or .2
	local bone = model.PrimaryPart:Clone()
	bone:ClearAllChildren()
	bone.Size = bone.Size+Vector3.new(1,1,1)*margin
	bone.Name = model.Name
	WELD:MakeBone(bone,model)
	return bone
end

function WELD:IsBonePart(Bone)
	return CS:HasTag(Bone, BONEPARTNAME)
end
function WELD:Debone(Bone)
	CS:RemoveTag(Bone,BONEPARTNAME)
end
function WELD:WeldModelToBone(model:Model,bone:Part)
	for i,v in pairs(bone:GetChildren()) do
		if v:IsA("Weld") then
			v:Destroy()
		end
	end
	if WELD:IsBonePart(bone) then
		for _,p in pairs(model:GetDescendants()) do
			if p:IsA("BasePart") then
				WELD:Weld(bone,p)
			end
		end	
	end
end

function WELD:GetBonePart(model)
	if model:IsA("BasePart") then
		return model
	end
	for i,p in pairs(model:GetChildren()) do
		if p:IsA("Part") and CS:HasTag(p,BONEPARTNAME) then
			return p
		end
	end
	return nil
end

function WELD:MakeBone(bone:BasePart,Model:Model, Joint:BasePart)
	CS:AddTag(bone,BONEPARTNAME)
	bone:SetAttribute("IsNotModelBonePart", true)
	if Model ~= nil then
		bone:SetAttribute("IsNotModelBonePart", false)
		WELD:AddBoneInfo(bone,Model,Joint)
		bone.Transparency = 1
		bone.CanCollide = false
		bone.Material = Enum.Material.SmoothPlastic
		local mpp:BasePart = Model.PrimaryPart
		if mpp ~= nil then
			bone.Color = mpp.Color		
		end
	end
	return bone
end
return WELD
