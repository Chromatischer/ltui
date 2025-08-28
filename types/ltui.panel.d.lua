---Panel container component
--- @meta

--- @class ltui.panel : ltui.view  
--- Panel is a container view that can hold and manage multiple child views.
--- Provides selection, navigation, and layout management for child components.
local panel = {}

--- Create a new panel instance
--- @param name string Panel identifier name
--- @param bounds ltui.rect Panel bounds (position and size)
--- @return ltui.panel
function panel:new(name, bounds) end

--- Initialize panel with child view management
--- @param name string Panel identifier name
--- @param bounds ltui.rect Panel bounds (position and size) 
--- @return ltui.panel
function panel:init(name, bounds) end

--- Get iterator over all child views
--- @return fun(): ltui.view Iterator function for child views
function panel:views() end

--- Get number of child views
--- @return number Count of child views
function panel:count() end

--- Check if panel has no child views
--- @return boolean True if panel is empty
function panel:empty() end

--- Get the first child view
--- @return ltui.view? First child view, or nil if empty
function panel:first() end

--- Get the last child view  
--- @return ltui.view? Last child view, or nil if empty
function panel:last() end

--- Get the next view after the given view
--- @param v ltui.view Reference view
--- @return ltui.view? Next view, or nil if none
function panel:next(v) end

--- Get the previous view before the given view
--- @param v ltui.view Reference view
--- @return ltui.view? Previous view, or nil if none
function panel:prev(v) end

--- Get the currently selected child view
--- @return ltui.view? Currently selected view, or nil if none selected
function panel:current() end

--- Get child view by name
--- @param name string View name to find
--- @return ltui.view? Found view, or nil if not found
function panel:view(name) end

--- Center a child view within panel bounds
--- @param v ltui.view View to center
--- @param opt? table Options with centerx/centery boolean flags
--- @return ltui.panel Self for chaining
function panel:center(v, opt) end

--- Insert a child view into the panel
--- @param v ltui.view View to insert
--- @param opt? table Options for insertion (centerx, centery, etc.)
--- @return ltui.panel Self for chaining  
function panel:insert(v, opt) end

--- Remove a child view from the panel
--- @param v ltui.view View to remove
--- @param opt? table Options for removal
--- @return ltui.panel Self for chaining
function panel:remove(v, opt) end

--- Clear all child views from the panel
--- @return ltui.panel Self for chaining
function panel:clear() end

--- Select a specific child view
--- @param v ltui.view? View to select, or nil to deselect all
--- @return ltui.panel Self for chaining
function panel:select(v) end

--- Select the next selectable child view
--- @param start? ltui.view Starting view for search
--- @param reset? boolean Whether to reset to first if none found
--- @return boolean True if selection changed
function panel:select_next(start, reset) end

--- Select the previous selectable child view
--- @param start? ltui.view Starting view for search  
--- @param reset? boolean Whether to reset to last if none found
--- @return boolean True if selection changed
function panel:select_prev(start, reset) end

--- Handle panel events (keyboard navigation between children)
--- @param e ltui.event Event to handle
--- @return boolean? True if event was handled
function panel:on_event(e) end

--- Set panel state (focused, selected, etc.) and propagate to current child
--- @param name string State name
--- @param enable boolean Whether to enable or disable the state
--- @return ltui.panel Self for chaining
function panel:state_set(name, enable) end

--- Draw the panel and all child views
--- @param transparent? boolean Whether to draw transparently
function panel:on_draw(transparent) end

--- Handle panel resize - updates all child view bounds
function panel:on_resize() end

--- Refresh the panel display
function panel:on_refresh() end

--- Get debug representation of panel and children
--- @return string Debug string
function panel:dump() end

return panel