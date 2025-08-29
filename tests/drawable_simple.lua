--!A cross-platform terminal ui library based on Lua
--
-- Simple test to validate drawable canvas syntax
--
require("tests/load")

-- test basic module loading
local success, drawable_canvas = pcall(require, "ltui/drawable/canvas")
if not success then
    print("Error loading drawable canvas:", drawable_canvas)
    return
end

local success, drawtool = pcall(require, "ltui/drawable/drawtool") 
if not success then
    print("Error loading drawtool:", drawtool)
    return
end

local success, linedraw = pcall(require, "ltui/drawable/linedraw")
if not success then
    print("Error loading linedraw:", linedraw)
    return
end

print("All drawable modules loaded successfully!")

-- test basic instantiation (without actually running UI)
local rect = require("ltui/rect")
local test_rect = rect{10, 10, 50, 20}

local canvas = drawable_canvas:new("test_canvas", test_rect)
print("Canvas created:", tostring(canvas))

local line_tool = linedraw:new(canvas)
print("Line tool created:", tostring(line_tool))

-- test some basic operations
canvas:clear_buffer()
canvas:set_pixel(5, 5, "*")
canvas:draw_line(1, 1, 10, 10, "#")

line_tool:char("-")
line_tool:draw_horizontal(2, 5, 8)

print("Basic operations completed successfully!")