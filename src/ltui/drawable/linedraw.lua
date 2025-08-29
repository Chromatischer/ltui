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
-- @file        linedraw.lua
--

-- load modules
---@type ltui.base.log
local log = require("ltui/base/log")
---@type ltui.drawable.drawtool
local drawtool = require("ltui/drawable/drawtool")

---@class ltui.drawable.linedraw : ltui.drawable.drawtool
---@field _start_x integer Starting x coordinate for line
---@field _start_y integer Starting y coordinate for line
---@field _drawing boolean Whether currently drawing a line
---Line drawing tool that extends drawtool for drawing lines
local linedraw = linedraw or drawtool()

-- new linedraw instance
---@param canvas ltui.drawable.canvas Target drawable canvas
---@return ltui.drawable.linedraw New linedraw instance
function linedraw:new(canvas)
	-- create instance from drawtool
	self = drawtool.new(self, canvas, "linedraw")

	-- init line drawing state
	self._start_x = nil
	self._start_y = nil
	self._drawing = false

	-- set default line character
	self._char = "-"

	-- done
	return self
end

-- begin line drawing at given coordinates
---@param x integer Starting X coordinate
---@param y integer Starting Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:begin(x, y)
	if not self:validate_coords(x, y) then
		log:print("linedraw:begin() - coordinates (%d, %d) out of bounds", x, y)
		return self
	end

	self._start_x = x
	self._start_y = y
	self._drawing = true

	-- mark starting point
	self._canvas:set_pixel(x, y, self._char, self._attr)

	return self
end

-- continue line drawing (preview line to current position)
---@param x integer Current X coordinate
---@param y integer Current Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:continue(x, y)
	if not self._drawing or not self._start_x or not self._start_y then
		return self
	end

	if not self:validate_coords(x, y) then
		return self
	end

	-- For continuous drawing, we might want to show a preview
	-- For now, just update the endpoint
	return self
end

-- finish line drawing to given coordinates
---@param x integer Final X coordinate
---@param y integer Final Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:finish(x, y)
	if not self._drawing or not self._start_x or not self._start_y then
		return self
	end

	if not self:validate_coords(x, y) then
		log:print("linedraw:finish() - coordinates (%d, %d) out of bounds", x, y)
		return self
	end

	-- draw the complete line
	self:draw_line(self._start_x, self._start_y, x, y)

	-- reset drawing state
	self._drawing = false
	self._start_x = nil
	self._start_y = nil

	return self
end

-- draw line between two points (direct line drawing)
---@param x1 integer Starting X coordinate
---@param y1 integer Starting Y coordinate
---@param x2 integer Ending X coordinate
---@param y2 integer Ending Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:draw_between(x1, y1, x2, y2)
	if not self:validate_coords(x1, y1) or not self:validate_coords(x2, y2) then
		log:print("linedraw:draw_between() - invalid coordinates")
		return self
	end

	return self:draw_line(x1, y1, x2, y2)
end

-- draw line using Bresenham's algorithm
---@param x1 integer Starting X coordinate
---@param y1 integer Starting Y coordinate
---@param x2 integer Ending X coordinate
---@param y2 integer Ending Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:draw_line(x1, y1, x2, y2)
	if not self._canvas then
		log:print("linedraw:draw_line() - no canvas set!")
		return self
	end

	-- use canvas's built-in line drawing
	self._canvas:draw_line(x1, y1, x2, y2, self._char, self._attr)

	return self
end

-- apply tool at single point (draws a point)
---@param x integer X coordinate
---@param y integer Y coordinate
---@return ltui.drawable.linedraw Self for chaining
function linedraw:apply(x, y)
	if not self:validate_coords(x, y) then
		return self
	end

	self._canvas:set_pixel(x, y, self._char, self._attr)
	return self
end

-- draw horizontal line
---@param x integer Starting X coordinate
---@param y integer Y coordinate
---@param length integer Line length
---@return ltui.drawable.linedraw Self for chaining
function linedraw:draw_horizontal(x, y, length)
	if length <= 0 then
		return self
	end

	return self:draw_between(x, y, x + length - 1, y)
end

-- draw vertical line
---@param x integer X coordinate
---@param y integer Starting Y coordinate
---@param length integer Line length
---@return ltui.drawable.linedraw Self for chaining
function linedraw:draw_vertical(x, y, length)
	if length <= 0 then
		return self
	end

	return self:draw_between(x, y, x, y + length - 1)
end

-- set line character (override parent to update default)
---@param char? string New line character
---@return string|ltui.drawable.linedraw Returns character if getting, or self if setting
function linedraw:char(char)
	if char then
		self._char = char
		return self
	end
	return self._char
end

-- check if currently drawing
---@return boolean True if line drawing is in progress
function linedraw:is_drawing()
	return self._drawing
end

-- get starting point if drawing
---@return integer?, integer? Starting X and Y coordinates if drawing, nil otherwise
function linedraw:start_point()
	if self._drawing then
		return self._start_x, self._start_y
	end
	return nil, nil
end

-- cancel current line drawing
---@return ltui.drawable.linedraw Self for chaining
function linedraw:cancel()
	self._drawing = false
	self._start_x = nil
	self._start_y = nil
	return self
end

-- clone linedraw tool
---@param new_canvas? ltui.drawable.canvas Optional new canvas for the cloned tool
---@return ltui.drawable.linedraw Cloned linedraw tool
function linedraw:clone(new_canvas)
	local cloned = linedraw:new(new_canvas or self._canvas)
	cloned:char(self._char)
	cloned:attr(self._attr)
	return cloned
end

-- tostring
---@return string String representation of the linedraw tool
function linedraw:__tostring()
	local status = self._drawing and " (drawing)" or ""
	return string.format("<linedraw char='%s'%s>", self._char, status)
end

-- return module
---@type ltui.drawable.linedraw
return linedraw

