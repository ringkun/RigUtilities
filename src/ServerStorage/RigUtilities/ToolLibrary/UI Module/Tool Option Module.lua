local TweenService = game:GetService("TweenService")

local PropTypeUIFolder = script["Property Type UI"]
local AllowedPropType = {
	["StringValue"] = {UIType = "String", Parser = function(input,default)
		return input or default or ""
		end},
	["IntValue"] = {UIType = "String", Parser = function(input, default)
		return math.round(tonumber(input)  or default)
	end},
	["NumberValue"] = {UIType = "String", Parser = function(input, default)
		return tonumber(input) or default
	end},
	["BoolValue"] = {UIType = "Bool", Parser = function(input)
			return input
		end
	}
	
}

local TOpt = {}
TOpt.__index = TOpt
--TOpt.Environment = {}
TOpt.ToolUI = nil
function TOpt.NewOptionUI(Tool:UIBase,module)
	local newOptions = {}
	setmetatable(newOptions,TOpt)
	newOptions.ToolUI = Tool
	local PropOptUI = script.PropertyOptions:Clone()
	PropOptUI.Parent = Tool
	local open:GuiButton = Tool.OpenOptions
	local options = module:FindFirstChild("Options")
	local optionCount = 0
	if options then
		optionCount = #options:GetChildren()
	end
	if options and optionCount > 0 then
		for i,prop in pairs(module.Options:GetChildren()) do
			newOptions:NewProp(prop)
		end
	else
		newOptions:NewProp(nil)
	end	
	local isOpen = false
	open.MouseButton1Down:Connect(function()
		if isOpen then
			local ShutAnim = TweenService:Create(Tool,TweenInfo.new(.1),{Size = UDim2.new(1,0,0,25)})
			ShutAnim:Play()
			ShutAnim.Completed:Wait()
			isOpen = false
		else
			local OpenAnim = TweenService:Create(Tool,TweenInfo.new(.1),{Size = UDim2.new(1,0,0,25+math.max(optionCount*24+5,25))})
			OpenAnim:Play()
			OpenAnim.Completed:Wait()
			isOpen = true
		end
	end)
	return newOptions
end



function TOpt:NewProp(Prop)
	if not Prop then
		PropTypeUIFolder.Nothing:Clone().Parent = self.ToolUI.PropertyOptions
		return
	end
	pcall(function()
		local propTable = AllowedPropType[Prop.ClassName]
		local propUI = PropTypeUIFolder:FindFirstChild(propTable.UIType):Clone()
		if propUI.Name =="String" then
			local Input:TextBox = propUI.Input
			Input.PlaceholderText = Prop.Value
			Input.Text =  propTable.Parser(Prop.Value)
			local default = Input.Text
			Input.FocusLost:Connect(function()
				local result = propTable.Parser(Input.Text,default)
				Input.Text =  result
				Prop.Value = result
			end)
		elseif propUI.Name == "Bool" then
			local Input:ImageButton = propUI.Input
			if Prop.Value then
				Input.ImageTransparency = 0
			else
				Input.ImageTransparency = 1
			end			
			Input.MouseButton1Click:Connect(function()
				Prop.Value = not Prop.Value
				if Prop.Value then
					Input.ImageTransparency = 0
				else
					Input.ImageTransparency = 1
				end			
			end)
		end
		propUI.PropertyName.Text = Prop.Name
		propUI.Name = Prop.Name
		propUI.Parent = self.ToolUI.PropertyOptions
		--table.insert(self.Environment,Prop)
	end)
end
return TOpt
