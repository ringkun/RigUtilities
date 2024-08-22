local UIM = {}
for i,mod in pairs(script:GetChildren()) do
	if mod:IsA("ModuleScript") then
		local modtable = require(mod)
		setmetatable(UIM,modtable)
	end
end
return UIM
