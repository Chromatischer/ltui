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
-- @file        label.lua
-- @brief       Label component for displaying text in a view.
--

-- load modules
---@type ltui.base.log
local log         = require("ltui/base/log")
---@type ltui.view
local view        = require("ltui/view")
---@type ltui.event
local event       = require("ltui/event")
---@type ltui.action
local action      = require("ltui/action")
---@type ltui.curses
local curses      = require("ltui/curses")
local luajit, bit = pcall(require, "bit")
if not luajit then
    bit = require("ltui/base/bit")
end

--- Label view for rendering a single or multi-line string.
--
-- The label supports:
-- - Setting text content via text_set
-- - Styling through textattr_set (e.g. "yellow onblue bold")
-- - Automatic width-aware splitting of multi-byte strings (using wcwidth)
-- - Background inheritance from parent views when no explicit text background is set
-- - Action hook ac_on_text_changed when the text changes
--
-- Example:
-- ```lua
-- local label = require("ltui/label"):new("greeting", ltui.rect{0, 0, 20, 1})
-- label:text_set("Hello, world!")
-- label:textattr_set("yellow onblue bold")
-- ```
---@class ltui.label : ltui.view
---@field _TEXT? string Internal text content of the label
---@field _TEXTATTR table<string, integer>|nil Cache of computed curses attributes by spec string
local label = label or view()

--- Initialize label.
---@param name string Label name
---@param bounds ltui.rect Label bounds (position and size)
---@param text? string Optional initial text content
function label:init(name, bounds, text)

    -- init view
    view.init(self, name, bounds)

    -- init text
    self:text_set(text)

    -- init text attribute
    self:textattr_set("black")
end

--- Draw the label onto its canvas.
---@param transparent boolean If true, do not draw the background
function label:on_draw(transparent)

    -- draw background
    view.on_draw(self, transparent)

    -- get the text attribute value
    local textattr = self:textattr_val()

    -- draw text string
    local str = self:text()
    if str and #str > 0 and textattr then
        self:canvas():attr(textattr):move(0, 0):putstrs(self:splitext(str))
    end
end

--- Get the label text.
---@return string text Current text content (empty string if unset)
function label:text()
    return self._TEXT or ""
end

--- Set the label text.
-- Triggers action ac_on_text_changed if the content actually changed, and
-- invalidates the view for redraw.
---@param text? string New text content (defaults to empty string)
---@return ltui.label self
function label:text_set(text)

    -- set text
    text = text or ""
    local changed = self._TEXT ~= text
    self._TEXT = text

    -- do action
    if changed then
        self:action_on(action.ac_on_text_changed)
    end
    self:invalidate()
    return self
end

--- Get the label text attribute specification string.
-- Example: "yellow onblue bold"
---@return string|nil attr Text attribute spec or nil if unset
function label:textattr()
    return self:attr("textattr")
end

--- Set the label text attribute specification string.
-- When no explicit background is included (no "on..."), the view background
-- is inherited when drawing.
---@param attr string Attribute specification (e.g. "yellow onblue bold")
---@return ltui.label self
function label:textattr_set(attr)
    return self:attr_set("textattr", attr)
end

--- Compute the current curses attribute value for the text.
-- This uses an internal cache to avoid re-calculating the attribute for the same
-- attribute specification string.
---@return integer|nil value Computed curses attribute value or nil if no spec
function label:textattr_val()

    -- get text attribute
    local textattr = self:textattr()
    if not textattr then
        return
    end

    -- no text background? use view's background
    if self:background() and not textattr:find("on") then
        textattr = textattr .. " on" .. self:background()
    end

    -- attempt to get the attribute value from the cache first
    self._TEXTATTR = self._TEXTATTR or {}
    local value = self._TEXTATTR[textattr]
    if value then
        return value
    end

    -- update the cache
    value = curses.calc_attr(textattr:split("%s+"))
    self._TEXTATTR[textattr] = value
    return value
end

--- Split text into lines that fit within the provided width.
-- - Respects newlines in the input text
-- - Handles UTF-8 multi-byte sequences and uses wcwidth for display width
--
---@param text string Input text
---@param width? integer Optional maximum line width (defaults to view:width())
---@return string[] lines Array of lines fitting within width
function label:splitext(text, width)

    -- get width
    width = width or self:width()

    -- split text first
    local result = {}
    local lines = text:split('\n', true)
    for idx = 1, #lines do
        local line = lines[idx]
        while #line > width do
            local size = 0
            for i = 1, #line do
                if bit.band(line:byte(i), 0xc0) ~= 0x80 then
                    size = size + line:wcwidth(i)
                    if size > width then
                        table.insert(result, line:sub(1, i - 1))
                        line = line:sub(i)
                        break
                    end
                end
            end
            if size <= width then
                break
            end
        end
        table.insert(result, line)
    end
    return result
end

-- return module
---@type ltui.label
return label
