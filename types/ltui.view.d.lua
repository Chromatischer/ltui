---Base view component
--- @meta

--- @class ltui.view
--- @field new fun(self: ltui.view, name: string, rect: ltui.rect): ltui.view
--- @field name fun(self: ltui.view): string
--- @field text fun(self: ltui.view, text: string): ltui.view
--- @field gettext fun(self: ltui.view): string
--- @field rect fun(self: ltui.view): ltui.rect
--- @field bounds fun(self: ltui.view): ltui.rect
--- @field state fun(self: ltui.view): table
--- @field action fun(self: ltui.view, action: ltui.action): ltui.view
--- @field visible fun(self: ltui.view, visible: boolean): ltui.view
--- @field show fun(self: ltui.view)
--- @field hide fun(self: ltui.view)
--- @field draw fun(self: ltui.view, canvas: ltui.canvas)
local view = {}

return view
