---Rectangle geometry utilities  
--- @meta

--- @class ltui.rect : ltui.object
--- Rectangle class for position and size management.
--- Already has comprehensive type annotations in source file.
local rect = {}

--- Create new rectangle from position and size
--- @param x number X position
--- @param y number Y position  
--- @param w number Width
--- @param h number Height
--- @return ltui.rect
function rect:new(x, y, w, h) end

--- Get rectangle size as point
--- @return ltui.point Size as point {width, height}
function rect:size() end

--- Get rectangle width
--- @return number Width value
function rect:width() end

--- Get rectangle height  
--- @return number Height value
function rect:height() end

--- Resize rectangle
--- @param w number New width
--- @param h number New height
--- @return ltui.rect Self for chaining
function rect:resize(w, h) end

--- Move rectangle by delta
--- @param dx number Delta X
--- @param dy number Delta Y
--- @return ltui.rect Self for chaining
function rect:move(dx, dy) end

--- Move rectangle to position
--- @param x number New X position
--- @param y number New Y position
--- @return ltui.rect Self for chaining
function rect:move2(x, y) end

--- Check if point is contained in rectangle
--- @param x number X coordinate
--- @param y number Y coordinate
--- @return boolean True if point is inside
function rect:contains(x, y) end

return rect