--!A cross-platform terminal ui library based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
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
-- @file        drawable.lua
--
require("tests/load")

--  requires
local ltui        = require("ltui")
local application = ltui.application
local event       = ltui.event
local rect        = ltui.rect
local label       = ltui.label
local drawable_canvas = ltui.drawable.canvas
local linedraw    = ltui.drawable.linedraw

-- the demo application
local demo = application()

-- init demo
function demo:init()

    -- init name
    application.init(self, "drawable_demo")

    -- init background
    self:background_set("black")

    -- show desktop, menubar and statusbar
    self:insert(self:desktop())
    self:insert(self:menubar())
    self:insert(self:statusbar())

    -- init title
    self:menubar():title():text_set("Drawable Canvas Demo")

    -- add instruction label
    self:desktop():insert(label:new("instructions", rect {2, 1, 50, 3}, "Press 'q' to quit, 'c' to clear, 'l' to draw lines"):textattr_set("white"))

    -- create drawable canvas
    local canvas_bounds = rect {5, 5, 60, 20}
    self._canvas = drawable_canvas:new("canvas", canvas_bounds)
    self._canvas:background_char(".")
    self:desktop():insert(self._canvas)

    -- create line drawing tool
    self._line_tool = linedraw:new(self._canvas)
    self._line_tool:char("#")

    -- draw some initial content
    self:draw_demo_content()
end

-- draw demo content
function demo:draw_demo_content()
    local canvas = self._canvas
    local line_tool = self._line_tool

    -- clear canvas first
    canvas:clear_buffer()

    -- draw border
    local bounds = canvas:drawing_bounds()
    canvas:draw_rect(1, 1, bounds:width(), bounds:height(), "*")

    -- draw some lines
    line_tool:char("-")
    line_tool:draw_horizontal(5, 5, 20)
    
    line_tool:char("|")
    line_tool:draw_vertical(10, 3, 10)

    -- draw diagonal lines
    line_tool:char("\\")
    line_tool:draw_between(15, 8, 25, 15)
    
    line_tool:char("/")
    line_tool:draw_between(30, 8, 20, 15)

    -- draw text
    canvas:draw_text(5, 17, "Hello Drawable Canvas!", "white")

    -- draw some geometric shapes
    canvas:fill_rect(40, 10, 10, 5, "#", "red")
    canvas:draw_rect(40, 10, 10, 5, "+", "yellow")
end

-- on event
function demo:on_event(e)
    if application.on_event(self, e) then
        return true
    end
    
    if e.type == event.ev_keyboard then
        self:statusbar():info():text_set("Key: " .. (e.key_name or "unknown"))
        
        if e.key_name == "q" then
            self:quit()
        elseif e.key_name == "c" then
            -- clear canvas
            self._canvas:clear_buffer()
            self:statusbar():info():text_set("Canvas cleared")
        elseif e.key_name == "l" then
            -- redraw lines
            self:draw_demo_content()
            self:statusbar():info():text_set("Lines redrawn")
        elseif e.key_name == "r" then
            -- draw random lines
            self:draw_random_lines()
            self:statusbar():info():text_set("Random lines drawn")
        end
    end
end

-- draw random lines
function demo:draw_random_lines()
    local canvas = self._canvas
    local line_tool = self._line_tool
    local bounds = canvas:drawing_bounds()
    
    -- clear first
    canvas:clear_buffer()
    
    -- draw border
    canvas:draw_rect(1, 1, bounds:width(), bounds:height(), "*")
    
    -- draw some random lines
    math.randomseed(os.time())
    local chars = {"-", "|", "/", "\\", "+", "*", "#", "="}
    
    for i = 1, 8 do
        local x1 = math.random(2, bounds:width() - 1)
        local y1 = math.random(2, bounds:height() - 1)
        local x2 = math.random(2, bounds:width() - 1)
        local y2 = math.random(2, bounds:height() - 1)
        local char = chars[math.random(#chars)]
        
        line_tool:char(char)
        line_tool:draw_between(x1, y1, x2, y2)
    end
    
    canvas:draw_text(2, bounds:height() - 1, "Random lines! Press 'l' to restore demo", "white")
end

-- on resize
function demo:on_resize()
    application.on_resize(self)
end

-- run demo
demo:run()