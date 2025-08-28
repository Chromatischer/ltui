# LTUI - LSP and Type System Documentation

## Overview

LTUI now includes comprehensive type annotations and LSP (Language Server Protocol) support for improved development experience with Lua editors and IDEs.

## LSP Setup

### Prerequisites

Install [lua-language-server](https://github.com/LuaLS/lua-language-server) for your editor:

- **VS Code**: Install the "Lua" extension by sumneko
- **Neovim**: Use `nvim-lspconfig` with lua-language-server
- **Emacs**: Use `lsp-mode` with lua-language-server

### Configuration

The repository includes a `.luarc.json` configuration file that automatically configures:

- Lua 5.3 runtime compatibility
- Module resolution paths for the `src/` directory  
- Library workspace settings
- Type checking and diagnostics
- Autocompletion and hints

## Type System

### Core Classes

#### Object System (`ltui.object`)
```lua
local object = require("ltui/object")

-- Create a new class with field initialization
local MyClass = object { _init = {"x", "y", "name"} }

-- Create instances
local instance = MyClass{10, 20, "example"}
-- instance.x = 10, instance.y = 20, instance.name = "example"
```

#### Point (`ltui.point`)
```lua
local point = require("ltui/point")

-- Create points
local p1 = point{10, 20}
local p2 = point{5, 15}

-- Arithmetic operations  
local sum = p1 + p2        -- {15, 35}
local diff = p1 - p2       -- {5, 5}
local negated = -p1        -- {-10, -20}

-- Method chaining
p1:addxy(5, 10):subxy(2, 3)
```

#### Rectangle (`ltui.rect`)
```lua
local rect = require("ltui/rect")

-- Create rectangles
local r = rect:new(10, 20, 100, 50)  -- x, y, width, height
local r2 = rect{0, 0, 200, 200}      -- sx, sy, ex, ey

-- Geometry operations
local width = r:width()              -- 100
local height = r:height()            -- 50
local contains = r:contains(50, 30)  -- true
local intersection = r / r2          -- shared area
local union = r + r2                 -- combined area
```

#### Events (`ltui.event`)
```lua
local event = require("ltui/event")

-- Create different event types
local key_event = event.keyboard{65, "A", false}  -- keycode, name, alt
local mouse_event = event.mouse{1, 100, 50, "LEFT_CLICK"}
local cmd_event = event.command{"cm_quit"}

-- Check event types
if event:is_key("Enter") then
    -- Handle enter key
end

if event:is_command("cm_quit") then
    -- Handle quit command  
end
```

### Framework Classes

#### Application (`ltui.application`)
```lua
local ltui = require("ltui")

-- Create application
local app = ltui.application()

-- Access components
local menubar = app:menubar()      -- ltui.menubar
local desktop = app:desktop()      -- ltui.desktop  
local statusbar = app:statusbar()  -- ltui.statusbar

-- Initialize and run
app:init("MyApp", arg)
app:run()
```

#### Views (`ltui.view`)
```lua
local view = require("ltui/view")
local rect = require("ltui/rect")

-- Create custom view
local my_view = view:new("my_view", rect:new(10, 10, 200, 100))

-- View hierarchy and state management provided through type system
```

## Benefits

### Autocompletion
- Method and property suggestions based on actual class definitions
- Parameter hints for function calls
- Smart completion for module imports

### Type Checking  
- Static analysis of type compatibility
- Detection of undefined methods or properties
- Validation of function argument types

### Navigation
- Go to definition for functions and classes
- Find all references to symbols
- Symbol outline and workspace navigation

### Refactoring
- Safe renaming of symbols across the codebase
- Intelligent code transformations
- Impact analysis for changes

## Module Structure

```
src/ltui/
├── ltui.lua           # Main module exports with type definitions
├── object.lua         # Base object system  
├── point.lua          # 2D coordinate system
├── rect.lua           # Rectangle geometry
├── view.lua           # Base UI component
├── event.lua          # Event handling system
├── application.lua    # Application framework
├── program.lua        # Program foundation
└── base/              # Utility modules
    ├── log.lua        # Logging system
    ├── string.lua     # String extensions
    └── ...
```

## Contributing

When adding new modules or functions:

1. Add proper `---@class`, `---@field`, and `---@param`/`---@return` annotations
2. Document the module's purpose and usage patterns
3. Include type information for all public APIs
4. Test that LSP can resolve types correctly

## Examples

See the `tests/` directory for examples of how to use the typed API effectively.