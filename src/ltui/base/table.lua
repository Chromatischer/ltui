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
-- @file        table.lua
--

---@class ltui.base.table
---@field clear fun(self: table): nil
---@field join fun(...): table
---@field join2 fun(self: table, ...): table
---@field slice fun(self: table, first?: integer, last?: integer, step?: integer): table
---@field is_array fun(array: any): boolean
---@field is_dictionary fun(dict: any): boolean
---@field unwrap fun(object: any): any
---@field wrap fun(object: any): table
---@field unique fun(array: table, barrier?: fun(v: any): boolean): table
---@field pack fun(...): table
---@field unpack fun
---@field keys fun(tab: table): table, integer
---@field values fun(tab: table): table, integer
---@field map fun(tab: table, mapper: fun(k: any, v: any): any): table
---@field imap fun(arr: table, mapper: fun(k: integer, v: any): any): table
---@field reverse fun(arr: table): table
local table = table or {}

-- clear the table
---@param self table Table to clear
function table.clear(self)
    for k in next, self do
        rawset(self, k, nil)
    end
end

-- join all objects and tables
---@vararg table|any Objects and tables to join
---@return table Combined table
function table.join(...)

    local result = {}
    for _, t in ipairs({...}) do
        if type(t) == "table" then
            for k, v in pairs(t) do
                if type(k) == "number" then table.insert(result, v)
                else result[k] = v end
            end
        else
            table.insert(result, t)
        end
    end
    return result
end

-- join all objects and tables to self
---@param self table Target table to join into
---@vararg table|any Objects and tables to join
---@return table Self table with new items added
function table.join2(self, ...)

    for _, t in ipairs({...}) do
        if type(t) == "table" then
            for k, v in pairs(t) do
                if type(k) == "number" then table.insert(self, v)
                else self[k] = v end
            end
        else
            table.insert(self, t)
        end
    end
    return self
end

-- slice table array
---@param self table Array to slice
---@param first? integer Start index (default 1)
---@param last? integer End index (default #self)
---@param step? integer Step size (default 1)
---@return table Sliced array
function table.slice(self, first, last, step)

    -- slice it
    local sliced = {}
    for i = first or 1, last or #self, step or 1 do
        sliced[#sliced + 1] = self[i]
    end
    return sliced
end

-- is array?
---@param array any Value to check
---@return boolean True if value is an array-like table
function table.is_array(array)
    return type(array) == "table" and array[1] ~= nil
end

-- is dictionary?
---@param dict any Value to check
---@return boolean True if value is a dictionary-like table
function table.is_dictionary(dict)
    return type(dict) == "table" and dict[1] == nil
end

-- unwrap object if be only one
---@param object any Object to unwrap
---@return any Unwrapped object or original if not single-element table
function table.unwrap(object)
    if type(object) == "table" then
        if #object == 1 then
            return object[1]
        end
    end
    return object
end

-- wrap object to table
---@param object any Object to wrap
---@return table Object wrapped in table or original table
function table.wrap(object)

    -- no object?
    if nil == object then
        return {}
    end

    -- wrap it if not table
    if type(object) ~= "table" then
        return {object}
    end

    -- ok
    return object
end

-- remove repeat from the given array
---@param array table Array to make unique
---@param barrier? fun(v: any): boolean Optional function to clear existing items
---@return table Array with duplicates removed
function table.unique(array, barrier)

    -- remove repeat
    if type(array) == "table" then

        -- not only one?
        if table.getn(array) ~= 1 then

            -- done
            local exists = {}
            local unique = {}
            for _, v in ipairs(array) do

                -- exists barrier? clear the current existed items
                if barrier and barrier(v) then
                    exists = {}
                end

                -- add unique item
                if type(v) == "string" then
                    if not exists[v] then
                        exists[v] = true
                        table.insert(unique, v)
                    end
                else
                    local key = "\"" .. tostring(v) .. "\""
                    if not exists[key] then
                        exists[key] = true
                        table.insert(unique, v)
                    end
                end
            end

            -- update it
            array = unique
        end
    end

    -- ok
    return array
end

-- pack arguments into a table
-- polyfill of lua 5.2, @see https://www.lua.org/manual/5.2/manual.html#pdf-table.pack
---@vararg any Arguments to pack
---@return table Table with packed arguments and n field
function table.pack(...)
    return { n = select("#", ...), ... }
end

-- unpack table values
-- polyfill of lua 5.2, @see https://www.lua.org/manual/5.2/manual.html#pdf-table.unpack
table.unpack = unpack

-- get keys of a table
---@param tab table Table to get keys from
---@return table Keys array
---@return integer Number of keys
function table.keys(tab)

    assert(tab)

    local keyset = {}
    local n = 0
    for k, _ in pairs(tab) do
        n = n + 1
        keyset[n] = k
    end
    return keyset, n
end

-- get values of a table
---@param tab table Table to get values from
---@return table Values array
---@return integer Number of values
function table.values(tab)

    assert(tab)

    local valueset = {}
    local n = 0
    for _, v in pairs(tab) do
        n = n + 1
        valueset[n] = v
    end
    return valueset, n
end

-- map values to a new table
---@param tab table Table to map
---@param mapper fun(k: any, v: any): any Mapping function
---@return table New table with mapped values
function table.map(tab, mapper)

    assert(tab)
    assert(mapper)

    local newtab = {}
    for k, v in pairs(tab) do
        newtab[k] = mapper(k, v)
    end
    return newtab
end

-- map values to a new array
---@param arr table Array to map
---@param mapper fun(k: integer, v: any): any Mapping function
---@return table New array with mapped values
function table.imap(arr, mapper)

    assert(arr)
    assert(mapper)

    local newarr = {}
    for k, v in ipairs(arr) do
        table.insert(newarr, mapper(k, v))
    end
    return newarr
end

-- reverse table values
---@param arr table Array to reverse
---@return table New array with values in reverse order
function table.reverse(arr)

    assert(arr)

    local revarr = {}
    local l = #arr
    for i = 1, l do
        revarr[i] = arr[l - i + 1]
    end
    return revarr
end

-- return module: table
---@type ltui.base.table
return table
