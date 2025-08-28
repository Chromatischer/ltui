---Button interactive component
--- @meta

--- @class ltui.button : ltui.view
--- Button component for user interaction with click handling.
--- Supports text labels, styling, and action callbacks.
local button = {}

--- Create a new button instance
--- @param name string Button identifier name
--- @param bounds ltui.rect Button bounds (position and size)
--- @param text? string Optional button text
--- @return ltui.button
function button:new(name, bounds, text) end

--- Initialize button with text and actions
--- @param name string Button identifier name
--- @param bounds ltui.rect Button bounds (position and size)
--- @param text? string Optional button text  
--- @return ltui.button
function button:init(name, bounds, text) end

--- Set button text content
--- @param text string Button text to display
--- @return ltui.button Self for chaining
function button:text_set(text) end

--- Get current button text
--- @return string Current button text
function button:text() end

--- Handle button events (click, keyboard activation)
--- @param e ltui.event Event to handle
--- @return boolean? True if event was handled
function button:on_event(e) end

--- Draw button with current state styling
--- @param transparent? boolean Whether to draw transparently
function button:on_draw(transparent) end

return button