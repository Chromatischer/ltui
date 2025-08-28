--!A cross-platform terminal ui library based on Lua
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
-- @file        os.lua
--

-- load modules
---@type ltui.base.string
local string = require("ltui/base/string")

---@class ltui.base.os
---@field _HOST? string Cached host OS name
---@field isfile fun(filepath: string?): boolean
---@field raise fun(msg?: string, ...): nil
---@field run fun(cmd: string, ...): boolean|integer
---@field iorun fun(cmd: string, ...): string?
---@field host fun(): string?
---@field pbpaste fun(): string?
---@field pbcopy fun(data: string): nil
local os = os or {}

-- is file?
---@param filepath string? Path to check
---@return boolean True if file exists and is readable
function os.isfile(filepath)
    local file = filepath and io.open(filepath, 'r') or nil
    if file then
        file:close()
    end
    return file ~= nil
end

-- raise an exception and abort the current script
--
-- the parent function will capture it if we uses pcall or xpcall
--
---@param msg? string Error message format string
---@vararg any Arguments for format string
function os.raise(msg, ...)

    -- raise it
    if msg then
        error(string.tryformat(msg, ...))
    else
        error()
    end
end

-- run program
---@param cmd string Command format string
---@vararg any Arguments for format string  
---@return boolean|integer Exit code or success status
function os.run(cmd, ...)
    return os.execute(string.tryformat(cmd, ...))
end

-- run program and get io output
---@param cmd string Command format string
---@vararg any Arguments for format string
---@return string? Command output or nil if failed
function os.iorun(cmd, ...)
    local outs = nil
    local file = io.popen(string.tryformat(cmd, ...), "r")
    if file then
        outs = file:read("*a"):trim()
        file:close()
    end
    return outs
end

-- get host name
---@return string? Host OS name ("macosx", "windows", "linux") or nil if unknown
function os.host()
    if os._HOST == nil then
        if jit and jit.os then
            local hosts = {OSX = "macosx", Windows = "windows", Linux = "linux"}
            os._HOST = hosts[jit.os]
        elseif package.config:sub(1, 1) == '\\' then
            os._HOST = "windows"
        else
            local result = os.iorun("uname")
            if result then
                if result:lower():find("linux", 1, true) then
                    os._HOST = "linux"
                elseif result:lower():find("darwin", 1, true) then
                    os._HOST = "macosx"
                end
            end
        end
    end
    return os._HOST
end

-- read string data from pasteboard
---@return string? Clipboard content or nil if failed
function os.pbpaste()
    if os.host() == "macosx" then
        return os.iorun("pbpaste")
    elseif os.host() == "linux" then
        return os.iorun("xsel --clipboard --output")
    else
        -- TODO
    end
end

-- copy string data to pasteboard
---@param data string Data to copy to clipboard
function os.pbcopy(data)
    if os.host() == "macosx" then
        os.run("bash -c \"echo '" .. data .. "' | pbcopy\"")
    elseif os.host() == "linux" then
        os.run("bash -c \"echo '" .. data .. "' | xsel --clipboard --input\"")
    else
        -- TODO
    end
end

-- return module
---@type ltui.base.os
return os
