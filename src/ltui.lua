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
-- @file        ltui.lua
--

---@class ltui
---@field action ltui.action Action management module
---@field application ltui.application Application framework
---@field border ltui.border Border drawing utilities
---@field boxdialog ltui.boxdialog Box dialog component
---@field button ltui.button Button component
---@field canvas ltui.canvas Canvas for drawing  
---@field choicebox ltui.choicebox Choice selection component
---@field choicedialog ltui.choicedialog Choice selection dialog
---@field curses ltui.curses Curses terminal interface
---@field desktop ltui.desktop Desktop/workspace component
---@field dialog ltui.dialog Base dialog component
---@field event ltui.event Event system
---@field inputdialog ltui.inputdialog Text input dialog
---@field label ltui.label Text label component
---@field mconfdialog ltui.mconfdialog Menu configuration dialog
---@field menubar ltui.menubar Menu bar component
---@field menuconf ltui.menuconf Menu configuration system
---@field object ltui.object Base object system
---@field panel ltui.panel Panel container component
---@field point ltui.point 2D coordinate system
---@field program ltui.program Base program framework
---@field rect ltui.rect Rectangle geometry
---@field scrollbar ltui.scrollbar Scrollbar component
---@field statusbar ltui.statusbar Status bar component
---@field textarea ltui.textarea Text area component
---@field textdialog ltui.textdialog Text display dialog
---@field textedit ltui.textedit Text editor component
---@field view ltui.view Base view component
---@field window ltui.window Window container component
local ltui = ltui or {}

-- register modules
ltui.action       = require("ltui/action")
ltui.application  = require("ltui/application")
ltui.border       = require("ltui/border")
ltui.boxdialog    = require("ltui/boxdialog")
ltui.button       = require("ltui/button")
ltui.canvas       = require("ltui/canvas")
ltui.choicebox    = require("ltui/choicebox")
ltui.choicedialog = require("ltui/choicedialog")
ltui.curses       = require("ltui/curses")
ltui.desktop      = require("ltui/desktop")
ltui.dialog       = require("ltui/dialog")
ltui.event        = require("ltui/event")
ltui.inputdialog  = require("ltui/inputdialog")
ltui.label        = require("ltui/label")
ltui.mconfdialog  = require("ltui/mconfdialog")
ltui.menubar      = require("ltui/menubar")
ltui.menuconf     = require("ltui/menuconf")
ltui.object       = require("ltui/object")
ltui.panel        = require("ltui/panel")
ltui.point        = require("ltui/point")
ltui.program      = require("ltui/program")
ltui.rect         = require("ltui/rect")
ltui.scrollbar    = require("ltui/scrollbar")
ltui.statusbar    = require("ltui/statusbar")
ltui.textarea     = require("ltui/textarea")
ltui.textdialog   = require("ltui/textdialog")
ltui.textedit     = require("ltui/textedit")
ltui.view         = require("ltui/view")
ltui.window       = require("ltui/window")

---@type ltui
return ltui
