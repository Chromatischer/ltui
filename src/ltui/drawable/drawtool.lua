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
-- @file        drawtool.lua
--

-- load modules
---@type ltui.base.log
local log = require("ltui/base/log")
---@type ltui.object
local object = require("ltui/object")

---@class ltui.drawable.drawtool : ltui.object
---@field _canvas ltui.drawable.canvas Target canvas for drawing
---@field _char string Default character to draw with
---@field _attr string|table Default drawing attributes
---@field _name string Tool name
---Base drawing tool that can be extended for specific drawing operations
local drawtool = drawtool or object()

-- new drawtool instance
---@param canvas ltui.drawable.canvas Target drawable canvas
---@param name string Tool name
---@return ltui.drawable.drawtool New drawtool instance
function drawtool:new(canvas, name)
	-- create instance
	self = self()

	-- save canvas and name
	self._canvas = canvas
	self._name = name or "drawtool"

	-- set default drawing properties
	self._char = "*"
	self._attr = nil

	assert(canvas, "cannot create drawtool without canvas!")

	-- done
	return self
end

-- get/set target canvas
---@param canvas? ltui.drawable.canvas New target canvas
---@return ltui.drawable.canvas|ltui.drawable.drawtool Returns canvas if getting, or self if setting
function drawtool:canvas(canvas)
	if canvas then
		self._canvas = canvas
		return self
	end
	return self._canvas
end

-- get/set drawing character
---@param char? string New drawing character
---@return string|ltui.drawable.drawtool Returns character if getting, or self if setting
function drawtool:char(char)
	if char then
		self._char = char
		return self
	end
	return self._char
end

-- get/set drawing attributes
---@param attr? string|table New drawing attributes
---@return string|table|ltui.drawable.drawtool Returns attributes if getting, or self if setting
function drawtool:attr(attr)
	if attr then
		self._attr = attr
		return self
	end
	return self._attr
end

-- get tool name
---@return string Tool name
function drawtool:name()
	return self._name
end

-- validate coordinates against canvas bounds
---@param x integer X coordinate
---@param y integer Y coordinate
---@return boolean True if coordinates are within canvas bounds
function drawtool:validate_coords(x, y)
	if not self._canvas then
		return false
	end

	local bounds = self._canvas:drawing_bounds()
	return x >= 1 and x <= bounds:width() and y >= 1 and y <= bounds:height()
end

-- apply tool at given coordinates (base implementation)
-- This should be overridden by derived tool classes
---@param x integer X coordinate
---@param y integer Y coordinate
---@param ... any Additional parameters for specific tools
---@return ltui.drawable.drawtool Self for chaining
function drawtool:apply(x, y, ...)
	if not self._canvas then
		log:print("drawtool:apply() - no canvas set!")
		return self
	end

	if not self:validate_coords(x, y) then
		log:print("drawtool:apply() - coordinates (%d, %d) out of bounds", x, y)
		return self
	end

	-- default implementation: set single pixel
	self._canvas:set_pixel(x, y, self._char, self._attr)

	return self
end

-- begin drawing operation (for tools that need state)
---@param x integer X coordinate
---@param y integer Y coordinate
---@return ltui.drawable.drawtool Self for chaining
function drawtool:begin(x, y)
	-- base implementation does nothing
	-- override in derived classes if needed
	return self
end

-- continue drawing operation (for tools that track movement)
---@param x integer X coordinate
---@param y integer Y coordinate
---@return ltui.drawable.drawtool Self for chaining
function drawtool:continue(x, y)
	-- base implementation applies tool at position
	return self:apply(x, y)
end

-- end drawing operation (for tools that need cleanup)
---@param x integer X coordinate
---@param y integer Y coordinate
---@return ltui.drawable.drawtool Self for chaining
function drawtool:finish(x, y)
	-- base implementation applies tool at position
	return self:apply(x, y)
end

-- draw using this tool between two points (useful for line-based tools)
---@param x1 integer Starting X coordinate
---@param y1 integer Starting Y coordinate
---@param x2 integer Ending X coordinate
---@param y2 integer Ending Y coordinate
---@return ltui.drawable.drawtool Self for chaining
function drawtool:draw_between(x1, y1, x2, y2)
	-- base implementation draws at start and end points
	self:apply(x1, y1)
	self:apply(x2, y2)
	return self
end

-- clone this tool with same settings but potentially different canvas
---@param new_canvas? ltui.drawable.canvas Optional new canvas for the cloned tool
---@return ltui.drawable.drawtool Cloned tool instance
function drawtool:clone(new_canvas)
	local cloned = drawtool:new(new_canvas or self._canvas, self._name)
	cloned:char(self._char)
	cloned:attr(self._attr)
	return cloned
end

-- tostring
---@return string String representation of the tool
function drawtool:__tostring()
	return string.format("<drawtool(%s) char='%s'>", self._name, self._char)
end

-- return module
---@type ltui.drawable.drawtool
return drawtool

