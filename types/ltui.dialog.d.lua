---Dialog base component
--- @meta

--- @class ltui.dialog : ltui.window
--- Base dialog class that extends window with modal behavior.
--- Provides common dialog functionality like buttons and form handling.
local dialog = {}

--- Create a new dialog instance
--- @param name string Dialog identifier name
--- @param bounds ltui.rect Dialog bounds (position and size)
--- @param title? string Optional dialog title
--- @return ltui.dialog
function dialog:new(name, bounds, title) end

--- Initialize dialog with modal behavior
--- @param name string Dialog identifier name
--- @param bounds ltui.rect Dialog bounds (position and size) 
--- @param title? string Optional dialog title
--- @return ltui.dialog
function dialog:init(name, bounds, title) end

--- Show dialog modally and handle events
--- @return any Dialog result
function dialog:exec() end

--- Close dialog with result
--- @param result? any Optional result value
function dialog:close(result) end

--- Add button to dialog
--- @param button ltui.button Button component to add
--- @return ltui.dialog Self for chaining
function dialog:button_add(button) end

return dialog