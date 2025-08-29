---Base drawing tool
--- @meta

--- @class ltui.drawable.drawtool : ltui.object
--- Base drawing tool that can be extended for specific drawing operations.
--- Provides common functionality for drawing to a drawable canvas.
local drawtool = {}

--- Create a new drawing tool instance
--- @param canvas ltui.drawable.canvas Target drawable canvas
--- @param name? string Tool name identifier
--- @return ltui.drawable.drawtool
function drawtool:new(canvas, name) end

--- Get or set target canvas
--- @param canvas? ltui.drawable.canvas Canvas to set
--- @return ltui.drawable.canvas|ltui.drawable.drawtool Canvas or self for chaining
function drawtool:canvas(canvas) end

--- Get or set drawing character
--- @param char? string Character to set
--- @return string|ltui.drawable.drawtool Character or self for chaining
function drawtool:char(char) end

--- Get or set drawing attributes
--- @param attr? string|table Attributes to set
--- @return string|table|ltui.drawable.drawtool Attributes or self for chaining
function drawtool:attr(attr) end

--- Get tool name
--- @return string Tool name
function drawtool:name() end

--- Validate coordinates against canvas bounds
--- @param x number X coordinate to check
--- @param y number Y coordinate to check
--- @return boolean True if coordinates are valid
function drawtool:validate_coords(x, y) end

--- Apply tool at given coordinates (override in derived classes)
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param ... any Additional parameters
--- @return ltui.drawable.drawtool Self for chaining
function drawtool:apply(x, y, ...) end

--- Begin drawing operation (for stateful tools)
--- @param x number Starting X coordinate
--- @param y number Starting Y coordinate
--- @return ltui.drawable.drawtool Self for chaining
function drawtool:begin(x, y) end

--- Continue drawing operation (for tools that track movement)
--- @param x number Current X coordinate
--- @param y number Current Y coordinate
--- @return ltui.drawable.drawtool Self for chaining
function drawtool:continue(x, y) end

--- End drawing operation (for tools that need cleanup)
--- @param x number Final X coordinate
--- @param y number Final Y coordinate
--- @return ltui.drawable.drawtool Self for chaining
function drawtool:finish(x, y) end

--- Draw between two points (useful for line-based tools)
--- @param x1 number Start X coordinate
--- @param y1 number Start Y coordinate
--- @param x2 number End X coordinate
--- @param y2 number End Y coordinate
--- @return ltui.drawable.drawtool Self for chaining
function drawtool:draw_between(x1, y1, x2, y2) end

--- Clone this tool with same settings
--- @param new_canvas? ltui.drawable.canvas Optional new canvas target
--- @return ltui.drawable.drawtool Cloned tool
function drawtool:clone(new_canvas) end

return drawtool