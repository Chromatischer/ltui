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
-- @file        canvas.lua
--

-- load modules
---@type ltui.base.log
local log = require("ltui/base/log")
---@type ltui.panel
local panel = require("ltui/panel")
---@type ltui.rect
local rect = require("ltui/rect")
---@type ltui.point
local point = require("ltui/point")
---@type ltui.canvas
local canvas_base = require("ltui/canvas")

---@class ltui.drawable.canvas : ltui.panel
---@field _drawing_buffer table Buffer to store drawing data before rendering
---@field _background_char string Default background character for clearing
---@field _draw_canvas ltui.canvas Internal canvas for drawing operations
---Drawable canvas component that extends panel with drawing capabilities
local drawable_canvas = drawable_canvas or panel()

-- init drawable canvas
---@param name string Canvas name
---@param bounds ltui.rect Canvas bounds
function drawable_canvas:init(name, bounds)
	-- init panel
	panel.init(self, name, bounds)

	-- mark as drawable canvas
	self:type_set("drawable_canvas")

	-- init drawing buffer - 2D array to store characters and attributes
	self._drawing_buffer = {}
	self._background_char = " "

	-- initialize buffer with background
	self:clear_buffer()

	-- create internal canvas for drawing
	self._draw_canvas = nil -- Will be set during on_draw
end

-- clear the drawing buffer
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:clear_buffer()
	local bounds = self:bounds()
	local width = bounds:width()
	local height = bounds:height()

	-- Initialize empty buffer - only store actual drawings, not background
	self._drawing_buffer = {}
	for y = 1, height do
		self._drawing_buffer[y] = {}
		-- Don't fill with background characters - leave empty
	end

	self:invalidate()
	return self
end

-- set background character
---@param ch? string New background character
---@return string|ltui.drawable.canvas Returns character if getting, or self if setting
function drawable_canvas:background_char(ch)
	if ch then
		self._background_char = ch
		return self
	end
	return self._background_char
end

-- set pixel (character) at given coordinates
---@param x integer X coordinate (1-based)
---@param y integer Y coordinate (1-based)
---@param char? string Character to draw
---@param attr? string|table Optional attributes
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:set_pixel(x, y, char, attr)
	local bounds = self:bounds()
	local width = bounds:width()
	local height = bounds:height()

	-- check bounds
	if x < 1 or x > width or y < 1 or y > height then
		return self
	end

	-- ensure buffer exists
	if not self._drawing_buffer[y] then
		self._drawing_buffer[y] = {}
	end

	-- set pixel data
	self._drawing_buffer[y][x] = {
		char = char or "*",
		attr = attr,
	}

	self:invalidate()
	return self
end

-- get pixel (character) at given coordinates
---@param x integer X coordinate (1-based)
---@param y integer Y coordinate (1-based)
---@return string?, string|table|nil Character and attributes at position
function drawable_canvas:get_pixel(x, y)
	local bounds = self:bounds()
	local width = bounds:width()
	local height = bounds:height()

	-- check bounds
	if x < 1 or x > width or y < 1 or y > height then
		return nil
	end

	if self._drawing_buffer[y] and self._drawing_buffer[y][x] then
		return self._drawing_buffer[y][x].char, self._drawing_buffer[y][x].attr
	end

	return self._background_char, nil
end

-- clear pixel (remove from buffer, effectively setting to background)
---@param x integer X coordinate (1-based)
---@param y integer Y coordinate (1-based)
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:clear_pixel(x, y)
	local bounds = self:bounds()
	local width = bounds:width()
	local height = bounds:height()

	-- check bounds
	if x < 1 or x > width or y < 1 or y > height then
		return self
	end

	-- clear pixel by removing it from buffer
	if self._drawing_buffer[y] then
		self._drawing_buffer[y][x] = nil
	end

	self:invalidate()
	return self
end

-- draw line from (x1,y1) to (x2,y2) using given character
---@param x1 integer Starting X coordinate
---@param y1 integer Starting Y coordinate
---@param x2 integer Ending X coordinate
---@param y2 integer Ending Y coordinate
---@param char? string Character to draw with
---@param attr? string|table Optional attributes
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:draw_line(x1, y1, x2, y2, char, attr)
	char = char or "*"

	-- Bresenham's line algorithm
	local dx = math.abs(x2 - x1)
	local dy = math.abs(y2 - y1)
	local sx = x1 < x2 and 1 or -1
	local sy = y1 < y2 and 1 or -1
	local err = dx - dy

	local x, y = x1, y1

	while true do
		self:set_pixel(x, y, char, attr)

		if x == x2 and y == y2 then
			break
		end

		local e2 = 2 * err
		if e2 > -dy then
			err = err - dy
			x = x + sx
		end
		if e2 < dx then
			err = err + dx
			y = y + sy
		end
	end

	return self
end

-- draw rectangle outline
---@param x integer Starting X coordinate
---@param y integer Starting Y coordinate
---@param width integer Rectangle width
---@param height integer Rectangle height
---@param char? string Character to draw with
---@param attr? string|table Optional attributes
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:draw_rect(x, y, width, height, char, attr)
	char = char or "*"

	-- top and bottom edges
	for i = 0, width - 1 do
		self:set_pixel(x + i, y, char, attr)
		self:set_pixel(x + i, y + height - 1, char, attr)
	end

	-- left and right edges
	for i = 0, height - 1 do
		self:set_pixel(x, y + i, char, attr)
		self:set_pixel(x + width - 1, y + i, char, attr)
	end

	return self
end

-- fill rectangle
---@param x integer Starting X coordinate
---@param y integer Starting Y coordinate
---@param width integer Rectangle width
---@param height integer Rectangle height
---@param char? string Character to fill with
---@param attr? string|table Optional attributes
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:fill_rect(x, y, width, height, char, attr)
	char = char or "*"

	for j = 0, height - 1 do
		for i = 0, width - 1 do
			self:set_pixel(x + i, y + j, char, attr)
		end
	end

	return self
end

-- draw text at position
---@param x integer Starting X coordinate
---@param y integer Y coordinate
---@param text string Text to draw
---@param attr? string|table Optional attributes
---@return ltui.drawable.canvas Self for chaining
function drawable_canvas:draw_text(x, y, text, attr)
	for i = 1, #text do
		local char = text:sub(i, i)
		self:set_pixel(x + i - 1, y, char, attr)
	end
	return self
end

-- get drawing canvas bounds (inner bounds for drawing)
---@return ltui.rect Rectangle representing drawable area
function drawable_canvas:drawing_bounds()
	local bounds = self:bounds()
	-- Return bounds adjusted for any borders/padding if needed
	return rect({ 1, 1, bounds:width(), bounds:height() })
end

-- on draw - render the drawing buffer to canvas
---@param transparent? boolean Whether to draw transparently
function drawable_canvas:on_draw(transparent)
	-- draw panel background first
	panel.on_draw(self, transparent)

	-- get canvas for drawing
	local canvas = self:canvas()
	if not canvas then
		return
	end

	-- render drawing buffer to canvas
	local bounds = self:bounds()
	local width = bounds:width()
	local height = bounds:height()

	for y = 1, height do
		if self._drawing_buffer[y] then
			for x = 1, width do
				local pixel = self._drawing_buffer[y][x]
				-- Only render pixels that contain actual drawing data
				if pixel and pixel.char and pixel.char ~= self._background_char then
					-- canvas uses 0-based coordinates, and move takes (x, y)
					canvas:move(x - 1, y - 1)
					if pixel.attr then
						canvas:attr(pixel.attr)
					end
					canvas:putchar(pixel.char)
					if pixel.attr then
						canvas:attr() -- reset attributes
					end
				end
			end
		end
	end
end

-- return module
---@type ltui.drawable.canvas
return drawable_canvas

