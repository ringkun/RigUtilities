local SELE = game:GetService("Selection")
local Action = {}
function Action:Action()
	local spacingText = script.Options.SpacingText.Value
	local startingNumber = script.Options.StartingNumber.Value
	if script.Options.PrefixEnumeration.Value then
		for i,target in pairs(SELE:Get())  do
			target.Name = i-1+startingNumber..spacingText..target.Name
		end
	else
		for i,target in pairs(SELE:Get())  do
			target.Name = target.Name ..spacingText..i-1+startingNumber
		end
	end
	return true
end
return Action