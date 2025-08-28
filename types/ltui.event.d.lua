---Event handling system
--- @meta

--- @class ltui.event : ltui.object
--- Event class for handling keyboard, mouse, and command events.
--- Already has comprehensive type annotations in source file.
local event = {}

--- Check if this is a keyboard event with specific key
--- @param key_name string Key name to check
--- @return boolean True if matches
function event:is_key(key_name) end

--- Check if this is a command event with specific command
--- @param command string Command name to check
--- @return boolean True if matches  
function event:is_command(command) end

return event