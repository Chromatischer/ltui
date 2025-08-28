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
-- @file        bit.lua
--

---@class ltui.base.bit
---@field band fun(a: integer, b: integer): integer
---@field bor fun(a: integer, b: integer): integer
---@field bxor fun(a: integer, b: integer): integer
local bit = bit or {}

-- bit/and operation
---@param a integer First operand
---@param b integer Second operand
---@return integer Bitwise AND result
function bit.band(a, b)
    return a & b
end

-- bit/or operation
---@param a integer First operand
---@param b integer Second operand
---@return integer Bitwise OR result
function bit.bor(a, b)
    return a | b
end

-- bit/xor operation
---@param a integer First operand
---@param b integer Second operand
---@return integer Bitwise XOR result
function bit.bxor(a, b)
    return a ~ b
end

-- load bit module
---@type ltui.base.bit
return bit
