local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local TextS = game:GetService("TextService")
local TweenS = game:GetService("TweenService")
local frame = script.Parent.WidgetUI
local selectionFunction = frame["Selection Functions"]
local SelectionActions = selectionFunction.SelectionActions
local HOMod = require(script.Parent.Parent.ToolLibrary["UI Module"]["Hover Over Module"])
local TOMod = require(script.Parent.Parent.ToolLibrary["UI Module"]["Tool Option Module"]) 
local FC = {}
function FC:new(f)
	local actionModule = require(f)
	local cSA:GuiButton = SelectionActions:Clone()
	cSA.Name = f.Name
	cSA.Activate.Text = "   >" ..f.Name
	local status:Frame = cSA.Activate.Status
	local function LoadAnim()
		local status = status:Clone()
		status.Parent = cSA.Activate
		status.BackgroundTransparency = .2
		status.Size = UDim2.new(0,0,1,0)
		status.BackgroundColor3 = Color3.fromRGB(0, 209, 255)
		local anim1 = TweenS:Create(status,TweenInfo.new(.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(1,0,1,0)})
		anim1:Play()
		anim1.Completed:Wait()
		local anim2 = TweenS:Create(status,TweenInfo.new(.2,Enum.EasingStyle.Quad),{BackgroundTransparency = 1})
		anim2:Play()
		anim2.Completed:Wait()
		status.Size = UDim2.new(0,0,1,0)
		status:Destroy()
	end
	local function FailAnim()
		local status = status:Clone()
		status.Parent = cSA.Activate
		status.BackgroundColor3 = Color3.fromRGB(255, 0, 0)		
		status.BackgroundTransparency = 0
		status.Size = UDim2.new(1,0,1,0)
		local anim1 = TweenS:Create(status,TweenInfo.new(1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{BackgroundTransparency = 1})
		anim1:Play()
		anim1.Completed:Wait()
		status.Size = UDim2.new(0,0,1,0)
		status:Destroy()

	end
	cSA.Activate.MouseButton1Down:Connect(function()
		local complete = true
		complete = actionModule:Action()

		CH:SetWaypoint("RigTool "..f.Name .."Ran")
		if complete then
			LoadAnim()		
		else
			FailAnim()
		end
	end)
	
	HOMod.HoverOver(cSA.Activate,f.Description.Value,frame)
	TOMod.NewOptionUI(cSA,f)
	cSA.Parent = selectionFunction
	return nil
end
return FC
