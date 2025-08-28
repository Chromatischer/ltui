---Text label component
--- @meta

--- @class ltui.label : ltui.view
--- Label component for displaying text with formatting and styling.
--- Supports text attributes, alignment, and text manipulation.
local label = {}

--- Create a new label instance
--- @param name string Label identifier name
--- @param bounds ltui.rect Label bounds (position and size)
--- @param text? string Optional initial text content
--- @return ltui.label
function label:new(name, bounds, text) end

--- Initialize label with text content
--- @param name string Label identifier name
--- @param bounds ltui.rect Label bounds (position and size)  
--- @param text? string Optional initial text content
--- @return ltui.label
function label:init(name, bounds, text) end

--- Set the label text content
--- @param text string Text to display
--- @return ltui.label Self for chaining
function label:text_set(text) end

--- Get the current text content
--- @return string Current text content
function label:text() end

--- Set text display attributes (color, style)
--- @param attr string|table Text attribute specification
--- @return ltui.label Self for chaining
function label:textattr_set(attr) end

--- Get current text attributes
--- @return table Current text attribute settings
function label:textattr() end

--- Get text attribute value for rendering
--- @return number Computed text attribute value
function label:textattr_val() end

--- Split text into lines for display
--- @param text string Text to split
--- @return table Array of text lines
function label:splitext(text) end

--- Draw the label with text content
--- @param transparent? boolean Whether to draw transparently
function label:on_draw(transparent) end

return label