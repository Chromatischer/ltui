---A cross-platform terminal ui library based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-2020, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        event.lua
--

-- load modules
---@type ltui.base.log
local log    = require("ltui/base/log")
---@type ltui.object
local object = require("ltui/object")

---@class ltui.event : ltui.object
---@field type number Event type (ev_keyboard, ev_mouse, etc.)
---@field command? string Command name for command events
---@field extra? any Extra data for events
---@field _init string[] Field initialization order: {"type", "command", "extra"}
---
---Event type constants:
---@field ev_keyboard number Keyboard event type (1)
---@field ev_mouse number Mouse event type (2)  
---@field ev_command number Command event type (3)
---@field ev_text number Text event type (4)
---@field ev_idle number Idle event type (5)
---@field ev_max number Maximum event type value (5)
---
---Command type constants:
---@field cm_quit string Quit command
---@field cm_exit string Exit command  
---@field cm_enter string Enter command
---@field cm_max number Maximum command type value
local event = event or object { _init = {"type", "command", "extra"} }

---Register event types as enumerated constants
---@param tag string Base name for the max value (e.g., "ev_max")
---@param ... string List of event type names to register
function event:register(tag, ...)
    local base = self[tag] or 0
    local enums = {...}
    local n = #enums
    for i = 1, n do
        self[enums[i]] = i + base
    end
    self[tag] = base + n
end

---Check if this is a keyboard event with specific key
---@param key_name string Key name to check for  
---@return boolean True if this is the specified keyboard event
function event:is_key(key_name)
    return self.type == event.ev_keyboard and self.key_name == key_name
end

---Check if this is a command event with specific command
---@param command string Command name to check for (e.g., "cm_quit")
---@return boolean True if this is the specified command event  
function event:is_command(command)
    return self.type == event.ev_command and self.command == command
end

---Debug print event information  
function event:dump()
    if self.type == event.ev_keyboard then
        log:print("event(key): %s %s ..", self.key_name, self.key_code)
    elseif self.type == event.ev_command then
        log:print("event(cmd): %s ..", self.command)
    else
        log:print("event(%s): ..", self.type)
    end
end

-- Register event types, event.ev_keyboard = 1, event.ev_mouse = 2, ... , event.ev_idle = 5, event.ev_max = 5
event:register("ev_max", "ev_keyboard", "ev_mouse", "ev_command", "ev_text", "ev_idle")

-- Register command event types (ev_command)
event:register("cm_max", "cm_quit", "cm_exit", "cm_enter")

---@class ltui.event.keyboard : ltui.event
---@field key_code number Key code value
---@field key_name string Key name (e.g., "Enter", "Escape")  
---@field key_meta boolean True if ALT key was pressed
---@field type number Event type (ev_keyboard)
event.keyboard = object {_init = { "key_code", "key_name", "key_meta" }, type = event.ev_keyboard}

---@class ltui.event.mouse : ltui.event
---@field btn_code number Mouse event code
---@field x number Mouse X coordinate
---@field y number Mouse Y coordinate
---@field btn_name string Button name and event type
---@field type number Event type (ev_mouse)
event.mouse = object {_init = { "btn_code", "x", "y", "btn_name" }, type = event.ev_mouse}

---@class ltui.event.command : ltui.event
---@field command string Command name (e.g., "cm_quit")
---@field extra? any Extra command data
---@field type number Event type (ev_command)
event.command = object {_init = { "command", "extra" }, type = event.ev_command}

---@class ltui.event.idle : ltui.event
---@field type number Event type (ev_idle)
event.idle = object {_init = {}, type = event.ev_idle}

---@type ltui.event
return event
