---2D point utilities
--- @meta

--- @class ltui.point : ltui.object  
--- Point class for coordinate management.
--- Already has comprehensive type annotations in source file.
local point = {}

--- Add delta coordinates to this point
--- @param dx number Delta X
--- @param dy number Delta Y  
--- @return ltui.point Self for chaining
function point:addxy(dx, dy) end

--- Add another point to this point
--- @param p ltui.point Point to add
--- @return ltui.point Self for chaining
function point:add(p) end

--- Subtract delta coordinates from this point
--- @param dx number Delta X
--- @param dy number Delta Y
--- @return ltui.point Self for chaining  
function point:subxy(dx, dy) end

--- Subtract another point from this point
--- @param p ltui.point Point to subtract
--- @return ltui.point Self for chaining
function point:sub(p) end

return point