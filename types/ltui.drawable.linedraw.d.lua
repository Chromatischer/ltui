---Line drawing tool
--- @meta

--- @class ltui.drawable.linedraw : ltui.drawable.drawtool
--- Line drawing tool that extends drawtool for drawing lines using Bresenham's algorithm.
--- Supports interactive line drawing with begin/continue/finish workflow.
local linedraw = {}

--- Create a new line drawing tool instance
--- @param canvas ltui.drawable.canvas Target drawable canvas
--- @return ltui.drawable.linedraw
function linedraw:new(canvas) end

--- Begin line drawing at given coordinates
--- @param x number Starting X coordinate
--- @param y number Starting Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:begin(x, y) end

--- Continue line drawing (preview line to current position)
--- @param x number Current X coordinate
--- @param y number Current Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:continue(x, y) end

--- Finish line drawing to given coordinates
--- @param x number Final X coordinate
--- @param y number Final Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:finish(x, y) end

--- Draw line between two points directly
--- @param x1 number Start X coordinate
--- @param y1 number Start Y coordinate
--- @param x2 number End X coordinate
--- @param y2 number End Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:draw_between(x1, y1, x2, y2) end

--- Draw line using Bresenham's algorithm
--- @param x1 number Start X coordinate
--- @param y1 number Start Y coordinate
--- @param x2 number End X coordinate
--- @param y2 number End Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:draw_line(x1, y1, x2, y2) end

--- Apply tool at single point (draws a point)
--- @param x number X coordinate
--- @param y number Y coordinate
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:apply(x, y) end

--- Draw horizontal line
--- @param x number Starting X coordinate
--- @param y number Y coordinate
--- @param length number Line length
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:draw_horizontal(x, y, length) end

--- Draw vertical line
--- @param x number X coordinate
--- @param y number Starting Y coordinate
--- @param length number Line length
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:draw_vertical(x, y, length) end

--- Set line character (override parent to update default)
--- @param char? string Character to set
--- @return string|ltui.drawable.linedraw Character or self for chaining
function linedraw:char(char) end

--- Check if currently drawing a line
--- @return boolean True if drawing is in progress
function linedraw:is_drawing() end

--- Get starting point if currently drawing
--- @return number?, number? Start X and Y coordinates, or nil if not drawing
function linedraw:start_point() end

--- Cancel current line drawing
--- @return ltui.drawable.linedraw Self for chaining
function linedraw:cancel() end

--- Clone line drawing tool
--- @param new_canvas? ltui.drawable.canvas Optional new canvas target
--- @return ltui.drawable.linedraw Cloned tool
function linedraw:clone(new_canvas) end

return linedraw