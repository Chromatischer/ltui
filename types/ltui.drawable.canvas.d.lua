---Drawable canvas component
--- @meta

--- @class ltui.drawable.canvas : ltui.panel
--- Drawable canvas is a panel that provides pixel/character-based drawing capabilities.
--- It maintains a drawing buffer and provides methods for drawing shapes and text.
local canvas = {}

--- Create a new drawable canvas instance
--- @param name string Canvas identifier name
--- @param bounds ltui.rect Canvas bounds (position and size)
--- @return ltui.drawable.canvas
function canvas:new(name, bounds) end

--- Initialize drawable canvas with drawing buffer
--- @param name string Canvas identifier name
--- @param bounds ltui.rect Canvas bounds (position and size)
--- @return ltui.drawable.canvas
function canvas:init(name, bounds) end

--- Clear the drawing buffer to background
--- @return ltui.drawable.canvas Self for chaining
function canvas:clear_buffer() end

--- Get or set background character
--- @param ch? string Background character to set
--- @return string|ltui.drawable.canvas Background character or self for chaining
function canvas:background_char(ch) end

--- Set pixel/character at given coordinates
--- @param x number X coordinate (1-based)
--- @param y number Y coordinate (1-based)  
--- @param char? string Character to draw (default "*")
--- @param attr? string|table Drawing attributes
--- @return ltui.drawable.canvas Self for chaining
function canvas:set_pixel(x, y, char, attr) end

--- Get pixel/character at given coordinates
--- @param x number X coordinate (1-based)
--- @param y number Y coordinate (1-based)
--- @return string?, string|table? Character and attributes, or nil if out of bounds
function canvas:get_pixel(x, y) end

--- Draw line from start to end coordinates
--- @param x1 number Start X coordinate
--- @param y1 number Start Y coordinate
--- @param x2 number End X coordinate
--- @param y2 number End Y coordinate
--- @param char? string Line character (default "*")
--- @param attr? string|table Drawing attributes
--- @return ltui.drawable.canvas Self for chaining
function canvas:draw_line(x1, y1, x2, y2, char, attr) end

--- Draw rectangle outline
--- @param x number Top-left X coordinate
--- @param y number Top-left Y coordinate
--- @param width number Rectangle width
--- @param height number Rectangle height
--- @param char? string Border character (default "*")
--- @param attr? string|table Drawing attributes
--- @return ltui.drawable.canvas Self for chaining
function canvas:draw_rect(x, y, width, height, char, attr) end

--- Fill rectangle with character
--- @param x number Top-left X coordinate
--- @param y number Top-left Y coordinate
--- @param width number Rectangle width
--- @param height number Rectangle height
--- @param char? string Fill character (default "*")
--- @param attr? string|table Drawing attributes
--- @return ltui.drawable.canvas Self for chaining
function canvas:fill_rect(x, y, width, height, char, attr) end

--- Draw text at position
--- @param x number Start X coordinate
--- @param y number Y coordinate
--- @param text string Text to draw
--- @param attr? string|table Text attributes
--- @return ltui.drawable.canvas Self for chaining
function canvas:draw_text(x, y, text, attr) end

--- Get bounds available for drawing
--- @return ltui.rect Drawing area bounds
function canvas:drawing_bounds() end

--- Render drawing buffer to canvas (called during draw)
--- @param transparent? boolean Whether to draw transparently
function canvas:on_draw(transparent) end

return canvas