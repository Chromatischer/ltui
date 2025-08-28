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
-- @file        point.lua
--

-- load modules
---@type ltui.object
local object = require("ltui/object")

---@class ltui.point : ltui.object
---@field x number X coordinate
---@field y number Y coordinate
---@field _init string[] Field initialization order: {"x", "y"}
local point = point or object { _init = {"x", "y"} }

---Add delta x and y coordinates to this point
---@param dx number Delta X value to add
---@param dy number Delta Y value to add
---@return ltui.point Self for method chaining
function point:addxy(dx, dy)
    self.x = self.x + dx
    self.y = self.y + dy
    return self
end

---Add another point's coordinates to this point
---@param p ltui.point Point to add
---@return ltui.point Self for method chaining
function point:add(p)
    return self:addxy(p.x, p.y)
end

---Subtract delta x and y coordinates from this point
---@param dx number Delta X value to subtract
---@param dy number Delta Y value to subtract
---@return ltui.point Self for method chaining
function point:subxy(dx, dy)
    return self:addxy(-dx, -dy)
end

---Subtract another point's coordinates from this point
---@param p ltui.point Point to subtract
---@return ltui.point Self for method chaining
function point:sub(p)
    return self:addxy(-p.x, -p.y)
end

---Addition metamethod: p1 + p2
---@param p ltui.point Point to add
---@return ltui.point New point with added coordinates
function point:__add(p)
    local np = self()
    np.x = np.x + p.x
    np.y = np.y + p.y
    return np
end

---Subtraction metamethod: p1 - p2
---@param p ltui.point Point to subtract
---@return ltui.point New point with subtracted coordinates
function point:__sub(p)
    local np = self()
    np.x = np.x - p.x
    np.y = np.y - p.y
    return np
end

---Unary minus metamethod: -p
---@return ltui.point New point with negated coordinates
function point:__unm()
    local p = self()
    p.x = -p.x
    p.y = -p.y
    return p
end

---Equality metamethod: p1 == p2
---@param p ltui.point Point to compare with
---@return boolean True if points have same coordinates
function point:__eq(p)
    return self.x == p.x and self.y == p.y
end

---String conversion metamethod: tostring(p)
---@return string String representation of point "(x, y)"
function point:__tostring()
    return '(' .. self.x .. ', ' .. self.y .. ')'
end

---Concatenation metamethod: p1 .. p2
---@param op1 string|ltui.point First operand
---@param op2 string|ltui.point Second operand  
---@return string Concatenated string representation
function point.__concat(op1, op2)
    if type(op1) == 'string' then
        return op1 .. op2:__tostring()
    elseif type(op2) == 'string' then
        return op1:__tostring() .. op2
    else
        return op1:__tostring() .. op2:__tostring()
    end
end

---@type ltui.point
return point
