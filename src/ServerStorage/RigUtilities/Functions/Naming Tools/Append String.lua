local SELE = game:GetService("Selection")
local Action = {}
function Action:Action()
	local stringtext = script.Options.String.Value	
	local spacingText = script.Options.SpacingText.Value
	if script.Options.IsPrefix.Value then
		for i,target in pairs(SELE:Get())  do
			target.Name = stringtext..spacingText.. target.Name
		end
	else
		for i,target in pairs(SELE:Get())  do
			target.Name = target.Name .. spacingText.. stringtext
		end
	end
	return true
end
return Action