---Border drawing component
--- @meta

--- @class ltui.border : ltui.view
--- Border component that draws decorative borders around content areas.
--- Provides corner styling and border character customization.
local border = {}

--- Create a new border instance
--- @param name string Border identifier name
--- @param bounds ltui.rect Border bounds (position and size)
--- @return ltui.border
function border:new(name, bounds) end

--- Initialize border component
--- @param name string Border identifier name  
--- @param bounds ltui.rect Border bounds (position and size)
--- @return ltui.border
function border:init(name, bounds) end

--- Get corner attribute styling
--- @return table Corner attribute configuration
function border:cornerattr() end

--- Set corner attributes for styling
--- @param attrs table Corner attribute settings
--- @return ltui.border Self for chaining
function border:cornerattr_set(attrs) end

--- Draw the border around the content area
--- @param transparent? boolean Whether to draw transparently
function border:on_draw(transparent) end

return border