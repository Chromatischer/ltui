---Standalone example demonstrating drawable canvas and line drawing tool usage
--
-- This example shows how to use the new drawable components:
-- 1. Creating a drawable canvas
-- 2. Using the line drawing tool
-- 3. Drawing various shapes and text
--

-- Load the ltui library (assuming it's in the path)
-- require("tests/load")  -- Uncomment if running from tests directory
local ltui = require("ltui")

-- Example of using drawable canvas programmatically
local rect = ltui.rect
local drawable_canvas = ltui.drawable.canvas
local linedraw = ltui.drawable.linedraw

-- Create a drawable canvas
print("Creating drawable canvas...")
local canvas_bounds = rect{0, 0, 40, 15}  -- 40x15 character canvas
local canvas = drawable_canvas:new("example_canvas", canvas_bounds)

-- Set background character
canvas:background_char(".")

-- Create a line drawing tool
print("Creating line drawing tool...")
local line_tool = linedraw:new(canvas)

-- Example 1: Basic pixel operations
print("\nExample 1: Basic pixel operations")
canvas:clear_buffer()
canvas:set_pixel(5, 5, "*")
canvas:set_pixel(10, 10, "#", "red")
print("Set pixels at (5,5) and (10,10)")

-- Example 2: Drawing lines
print("\nExample 2: Drawing lines")
line_tool:char("-")
line_tool:draw_horizontal(2, 3, 10)
print("Drew horizontal line")

line_tool:char("|")
line_tool:draw_vertical(5, 2, 8)
print("Drew vertical line")

line_tool:char("\\")
line_tool:draw_between(15, 2, 25, 8)
print("Drew diagonal line")

-- Example 3: Drawing shapes
print("\nExample 3: Drawing shapes")
canvas:draw_rect(30, 5, 8, 6, "#")
canvas:fill_rect(32, 7, 4, 2, "O")
print("Drew rectangle and filled inner area")

-- Example 4: Drawing text
print("\nExample 4: Drawing text")
canvas:draw_text(2, 12, "Hello Drawable Canvas!")
print("Drew text")

-- Example 5: Interactive line drawing
print("\nExample 5: Interactive line drawing")
line_tool:char("*")
line_tool:begin(1, 1)          -- Start line at (1,1)
line_tool:continue(5, 3)       -- Move to (5,3) - could show preview
line_tool:finish(8, 1)         -- Finish line at (8,1)
print("Drew interactive line from (1,1) to (8,1)")

-- Example 6: Tool chaining and method chaining
print("\nExample 6: Method chaining")
line_tool:char("+"):draw_horizontal(1, 14, 15)
canvas:draw_text(20, 14, "Chained!"):set_pixel(39, 14, "!")
print("Used method chaining for efficient drawing")

-- Example 7: Cloning tools
print("\nExample 7: Tool cloning")
local line_tool2 = line_tool:clone()
line_tool2:char("="):draw_vertical(38, 1, 10)
print("Cloned tool and drew with different character")

-- Print some information about the canvas
print("\nCanvas Information:")
print("Canvas bounds:", tostring(canvas:bounds()))
print("Drawing bounds:", tostring(canvas:drawing_bounds()))
print("Background character:", canvas:background_char())

-- Print some information about the tools
print("\nTool Information:")
print("Line tool:", tostring(line_tool))
print("Line tool character:", line_tool:char())
print("Cloned tool:", tostring(line_tool2))

-- Example of getting pixel data
print("\nPixel data examples:")
local char, attr = canvas:get_pixel(5, 5)
print("Pixel at (5,5):", char, attr or "no attributes")

local char2, attr2 = canvas:get_pixel(10, 10)
print("Pixel at (10,10):", char2, attr2 or "no attributes")

-- Note: To actually see the visual output, you would need to:
-- 1. Create an ltui application
-- 2. Add the canvas to a desktop/panel
-- 3. Run the application event loop
-- 
-- This example demonstrates the API usage programmatically.

print("\nExample completed successfully!")
print("To see visual output, run the drawable.lua test in a terminal with ltui support.")