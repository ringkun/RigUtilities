-- Global Environment
_G.RigUtilityEnvironment = {
	PluginGlobal = script.Parent
}
local ToolLibrary = script.Parent.Parent.ToolLibrary
_G.RigUtilitiesTool = {
	HoverOver = require(ToolLibrary["UI Module"]["Hover Over Module"]),
	ToolOptionModule = require(ToolLibrary["UI Module"]["Tool Option Module"])
}

local GModule = {}

return GModule
