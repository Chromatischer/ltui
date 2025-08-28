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
-- @file        list.lua
--

-- load modules
---@type ltui.object
local object = require("ltui/object")

---@class ltui.base.list : ltui.object
---@field _length integer Current size of the list
---@field _first table? First item in the list
---@field _last table? Last item in the list
local list = list or object { _init = {"_length"} } {0}

-- clear list
---Clear all items from the list
function list:clear()
    self._length = 0
    self._first  = nil
    self._last   = nil
end

-- insert item after the given item
---@param t table Item to insert
---@param after? table Item to insert after (nil for last position)
function list:insert(t, after)
    if not after then
        return self:insert_last(t)
    end
    assert(t ~= after)
    if after._next then
        after._next._prev = t
        t._next = after._next
    else
        self._last = t
    end
    t._prev = after
    after._next = t
    self._length = self._length + 1
end

-- insert the first item in head
---@param t table Item to insert at beginning
function list:insert_first(t)
    if self._first then
        self._first._prev = t
        t._next = self._first
        self._first = t
    else
        self._first = t
        self._last = t
    end
    self._length = self._length + 1
end

-- insert the last item in tail
---@param t table Item to insert at end
function list:insert_last(t)
    if self._last then
        self._last._next = t
        t._prev = self._last
        self._last = t
    else
        self._first = t
        self._last = t
    end
    self._length = self._length + 1
end

-- remove item
---@param t table Item to remove
---@return table The removed item
function list:remove(t)
    if t._next then
        if t._prev then
            t._next._prev = t._prev
            t._prev._next = t._next
        else
            assert(t == self._first)
            t._next._prev = nil
            self._first = t._next
        end
    elseif t._prev then
        assert(t == self._last)
        t._prev._next = nil
        self._last = t._prev
    else
        assert(t == self._first and t == self._last)
        self._first = nil
        self._last = nil
    end
    t._next = nil
    t._prev = nil
    self._length = self._length - 1
    return t
end

-- remove the first item
---@return table? The removed item or nil if empty
function list:remove_first()
    if not self._first then
        return
    end
    local t = self._first
    if t._next then
        t._next._prev = nil
        self._first = t._next
        t._next = nil
    else
        self._first = nil
        self._last = nil
    end
    self._length = self._length - 1
    return t
end

-- remove last item
---@return table? The removed item or nil if empty
function list:remove_last()
    if not self._last then
        return
    end
    local t = self._last
    if t._prev then
        t._prev._next = nil
        self._last = t._prev
        t._prev = nil
    else
        self._first = nil
        self._last = nil
    end
    self._length = self._length - 1
    return t
end

-- push item to tail
---@param t table Item to push
function list:push(t)
    self:insert_last(t)
end

-- pop item from tail
---@return table? The popped item
function list:pop()
    self:remove_last()
end

-- shift item: 1 2 3 <- 2 3
---@return table? The shifted item
function list:shift()
    self:remove_first()
end

-- unshift item: 1 2 -> t 1 2
---@param t table Item to unshift
function list:unshift(t)
    self:insert_first(t)
end

-- get first item
---@return table? First item or nil if empty
function list:first()
    return self._first
end

-- get last item
---@return table? Last item or nil if empty
function list:last()
    return self._last
end

-- get next item
---@param last? table Previous item (nil for first)
---@return table? Next item or nil if at end
function list:next(last)
    if last then
        return last._next
    else
        return self._first
    end
end

-- get the previous item
---@param last? table Next item (nil for last)
---@return table? Previous item or nil if at beginning
function list:prev(last)
    if last then
        return last._prev
    else
        return self._last
    end
end

-- get list size
---@return integer Number of items in list
function list:size()
    return self._length
end

-- is empty?
---@return boolean True if list is empty
function list:empty()
    return self:size() == 0
end

-- get items
--
-- e.g.
--
-- for item in list:items() do
--     print(item)
-- end
--
---@return fun(): table? Iterator function for forward traversal
function list:items()
    local iter = function (list, item)
        return list:next(item)
    end
    return iter, self, nil
end

-- get reverse items
---@return fun(): table? Iterator function for reverse traversal
function list:ritems()
    local iter = function (list, item)
        return list:prev(item)
    end
    return iter, self, nil
end

-- new list
---@return ltui.base.list New empty list
function list.new()
    return list()
end

-- return module: list
---@type ltui.base.list
return list
