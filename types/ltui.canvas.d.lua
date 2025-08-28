---Canvas drawing utilities
--- @meta

--- @class ltui.canvas
--- Canvas component for low-level drawing operations.
--- Provides methods for drawing text, lines, and setting attributes.
local canvas = {}

--- Create a new canvas instance
--- @param bounds ltui.rect Canvas bounds (position and size)
--- @return ltui.canvas
function canvas:new(bounds) end

--- Set drawing attributes (color, style)
--- @param attr string|table Attribute specification
--- @return ltui.canvas Self for chaining
function canvas:attr(attr) end

--- Move cursor to position
--- @param x number X coordinate
--- @param y number Y coordinate
--- @return ltui.canvas Self for chaining
function canvas:move(x, y) end

--- Put single character at current position
--- @param ch string Character to draw
--- @return ltui.canvas Self for chaining
function canvas:putch(ch) end

--- Put string at current position
--- @param str string String to draw
--- @return ltui.canvas Self for chaining
function canvas:putstr(str) end

--- Put multiple strings (lines)
--- @param strs table Array of strings to draw
--- @return ltui.canvas Self for chaining
function canvas:putstrs(strs) end

--- Clear canvas area
--- @return ltui.canvas Self for chaining
function canvas:clear() end

return canvas