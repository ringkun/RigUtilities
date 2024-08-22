local HoverOver = script.HoverOver
local TextS = game:GetService("TextService")
local HO = {}
function HO.HoverOver(HoverOverObject,text, scope)
	HoverOverObject.MouseEnter:Connect(function()
		HoverOver.Text = text
		HoverOver.Size = UDim2.new(1,0,1,0)
		local textBound = TextS:GetTextSize(HoverOver.Text, 14, Enum.Font.SourceSans, HoverOverObject.AbsoluteSize+Vector2.new(0,80))

		HoverOver.Size = UDim2.new(1,0,0,textBound.Y+2)
		HoverOver.Position = UDim2.new(0,0,0,HoverOverObject.AbsolutePosition.Y+26) 
		HoverOver.Visible = true
		HoverOver.Parent = scope
	end)
	HoverOverObject.MouseLeave:Connect(function()
		HoverOver.Visible = false
		HoverOver.Position = UDim2.new(1,0,1,0)
		HoverOver.Parent = script.Parent
	end)
end
return HO
