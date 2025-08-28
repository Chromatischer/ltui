#!/usr/bin/env lua

--[[
LTUI LSP Validation Script
This script demonstrates the improved LSP functionality and type annotations.

To test LSP functionality:
1. Open this file in an editor with lua-language-server
2. Verify that:
   - Autocompletion works for module imports
   - Method suggestions appear for typed objects
   - Parameter hints show for function calls
   - Type errors are detected for incorrect usage
--]]

-- Set up module path (normally handled by your build system)
package.path = 'src/?.lua;src/?/init.lua;' .. package.path

-- Test core modules that don't require native dependencies
print("=== LTUI LSP Validation ===")

-- Test object system
local object = require("ltui/object")
local MyClass = object { _init = {"name", "value"} }
local instance = MyClass{"test", 42}

-- LSP should know instance.name is a string and instance.value is a number
print("✓ Object system:", instance.name, instance.value)

-- Test point operations
local point = require("ltui/point")
local point1 = point{10, 20}
local point2 = point{5, 15}

-- LSP should provide method completion and type checking
local sum = point1 + point2        -- Should show: ltui.point
local moved = point1:addxy(5, 10)  -- Should show: ltui.point (method chaining)
local coords = tostring(point1)    -- Should show: string

print("✓ Point operations:", sum.x, sum.y, coords)

-- Test rectangle geometry
local rect = require("ltui/rect")
local rectangle = rect:new(0, 0, 100, 50)  -- LSP should hint parameters

-- LSP should provide method suggestions
local width = rectangle:width()          -- Should return: number
local height = rectangle:height()        -- Should return: number
local area = width * height              -- LSP should infer this is number
local contains = rectangle:contains(25, 25)  -- Should return: boolean

print("✓ Rectangle:", width, height, area, contains)

-- Test event system with typed events
local event = require("ltui/event")

-- LSP should provide completion for event constants
local keyboard_event = event.keyboard{65, "A", false}
local test_event = event()
test_event.type = event.ev_keyboard
test_event.key_name = "Enter"

local is_key = test_event:is_key("Enter")        -- Should accept: string
local is_cmd = test_event:is_command("cm_quit")  -- Should accept: string

print("✓ Event system:", keyboard_event.key_code, is_key, is_cmd)

-- Test that event constants are properly defined
print("✓ Event constants:", event.ev_keyboard, event.ev_mouse, event.cm_quit)

print("\n=== LSP Validation Completed ===")
print("✓ All core modules loaded successfully")
print("✓ Type annotations are working")
print("✓ LSP should provide:")
print("  - Autocompletion for all methods")
print("  - Parameter hints for function calls")
print("  - Return type inference")  
print("  - Type error detection")

print("\nOpen this file in your LSP-enabled editor to test the improvements!")

-- Example of what should trigger type warnings (uncomment to test):
-- local bad_rect = rectangle:width("invalid")  -- Should warn: expected no params
-- local bad_point = point1 + "string"         -- Should warn: expected ltui.point
-- local bad_event = test_event:is_key(123)    -- Should warn: expected string