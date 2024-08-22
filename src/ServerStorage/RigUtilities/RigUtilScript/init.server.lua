local Subtitle = os.date("%a %d")

--Sets up Global environment
--Possibility for vulnerabilities
local Global = require(script.Globals)

local CS = game:GetService("CollectionService")
local CH = game:GetService("ChangeHistoryService")
local SELE = game:GetService("Selection")
--local WT = require(script.Parent.Parent.ToolLibrary.WeldingTool)
-- 1. Add BonePart to every model based on boundary box
-- 2. Adjust BoneParts
-- 3. Reweld BoneParts
-- 4. Rig Parts through Depth or Bredth Welding




-- Create new 'DockWidgetPluginGuiInfo' object
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,  -- Widget will be initialized in floating panel
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	100,    -- Default width of the floating window
	300,    -- Default height of the floating window
	150,    -- Minimum width of the floating window (optional)
	150     -- Minimum height of the floating window (optional)
)

local toolbar = plugin:CreateToolbar("Rigging Utility Tool "..Subtitle)
local activateButton:PluginToolbarButton = toolbar:CreateButton("Activate", "Activate Button", "http://www.roblox.com/asset/?id=6034941708")
local buttonActive = false
-- Create new widget GUI
local AutoRigWidget:DockWidgetPluginGuiInfo = plugin:CreateDockWidgetPluginGui("RigUtilityWidget", widgetInfo)
AutoRigWidget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AutoRigWidget.Title = "RigUtility"
AutoRigWidget.Name = "RigUtility"
activateButton.Click:Connect(function()
	buttonActive = not buttonActive
	activateButton:SetActive(false)
	AutoRigWidget.Enabled = buttonActive
end)


local frame = script.WidgetUI
local selectionFunction = frame["Selection Functions"]
local SelectionActions = selectionFunction.SelectionActions
local category = selectionFunction.Category
local FC = require(script.FunctionCode)
for i,cat in pairs(script.Parent.Functions:GetChildren()) do
	local ccat = category:Clone()
	ccat.Text = cat.Name
	ccat.Parent = selectionFunction
	for i,f in pairs(cat:GetChildren()) do
		FC:new(f)
	end
end

frame.Parent = AutoRigWidget
SelectionActions.Visible = false
category.Visible = false