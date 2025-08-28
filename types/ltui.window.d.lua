---Window container component
--- @meta

--- @class ltui.window : ltui.panel
--- Window container that provides a framed panel with optional title, border, and shadow.
--- Inherits all methods from ltui.panel which includes view selection, event handling, etc.
local window = {}

--- Create a new window instance
--- @param name string Window identifier name
--- @param bounds ltui.rect Window bounds (position and size)
--- @param title? string Optional window title text
--- @param shadow? boolean Optional shadow behind window
--- @return ltui.window
function window:new(name, bounds, title, shadow) end

--- Initialize window with frame, border, title and shadow
--- @param name string Window identifier name  
--- @param bounds ltui.rect Window bounds (position and size)
--- @param title? string Optional window title text
--- @param shadow? boolean Optional shadow behind window
--- @return ltui.window
function window:init(name, bounds, title, shadow) end

--- Get the window's frame panel (contains border and content)
--- @return ltui.panel The frame panel that holds all window components
function window:frame() end

--- Get the window's content panel (where child views are added)
--- @return ltui.panel The content panel for adding child views
function window:panel() end

--- Get the window's title label component
--- @return ltui.label? The title label, or nil if no title was set
function window:title() end

--- Get the window's shadow view component  
--- @return ltui.view? The shadow view, or nil if no shadow was set
function window:shadow() end

--- Get the window's border component
--- @return ltui.border The border component around the window
function window:border() end

--- Handle window events (keyboard navigation, etc.)
--- @param e ltui.event The event to handle
--- @return boolean? True if event was handled
function window:on_event(e) end

--- Handle window resize - updates frame, border, title, panel, and shadow bounds
function window:on_resize() end

return window