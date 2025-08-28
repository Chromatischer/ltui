---Application framework
--- @meta

--- @class ltui.application
--- @field new fun(self: ltui.application, name: string): ltui.application
--- @field name fun(self: ltui.application): string
--- @field run fun(self: ltui.application)
--- @field exit fun(self: ltui.application)
--- @field quit fun(self: ltui.application)
--- @field insert fun(self: ltui.application, view: ltui.view)
--- @field remove fun(self: ltui.application, view: ltui.view)
--- @field getviewport fun(self: ltui.application): ltui.rect
--- @field resize fun(self: ltui.application)
local application = {}

return application
