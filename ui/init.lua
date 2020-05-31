local PATH = (...):gsub('%.init$', '')

local JSON    = require(PATH .. ".libs.json")
local flux    = require(PATH .. ".libs.flux")
local Utility = require(PATH .. ".libs.util")

local UI =
{
    _VERSION     = "0.1.0",
    _DESCRIPTION = "UI library",
    _LICENSE     =
    [[
        MIT LICENSE

        Copyright (c) 2020 Jeremy S. Postelnek / TurtleP

        Permission is hereby granted, free of charge, to any person obtaining a
        copy of this software and associated documentation files (the
        "Software"), to deal in the Software without restriction, including
        without limitation the rights to use, copy, modify, merge, publish,
        distribute, sublicense, and/or sell copies of the Software, and to
        permit persons to whom the Software is furnished to do so, subject to
        the following conditions:

        The above copyright notice and this permission notice shall be included
        in all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
        OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
        IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
        CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
        TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
        SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]
}

function UI.init(path)
    if not love.filesystem.getInfo(path, "directory") then
        error(string.format("Could not find directory '%s'", path))
    end

    love.graphics.setLineWidth(1)

    UI.Fonts = {}

    local DEFAULT_SIZE = 14

    UI.Fonts.RobotoRegular        = love.graphics.newFont(PATH .. "/fonts/Roboto-Regular.ttf", DEFAULT_SIZE)
    UI.Fonts.RobotoItalic         = love.graphics.newFont(PATH .. "/fonts/Roboto-Italic.ttf",  DEFAULT_SIZE)
    UI.Fonts.RobotoBold           = love.graphics.newFont(PATH .. "/fonts/Roboto-Bold.ttf",    DEFAULT_SIZE)
    UI.Fonts.FontAwesomeSolid     = love.graphics.newFont(PATH .. "/fonts/Font Awesome 5 Solid.otf", DEFAULT_SIZE)
    UI.Fonts.FontAwesomeRegular   = love.graphics.newFont(PATH .. "/fonts/Font Awesome 5 Regular.otf", DEFAULT_SIZE)
    UI.Fonts.FontAwesome          = UI.Fonts.FontAwesomeSolid

    love.graphics.setFont(UI.Fonts.RobotoRegular)
    UI.DefaultFont = UI.Fonts.RobotoRegular

    UI.Elements = {}
    UI.Elements.Base        = require(PATH .. ".elements.element")

    -- Require in order of Dependency
    UI.Elements.Panel       = require(PATH .. ".elements.panel")
    UI.Elements._Clickable  = require(PATH .. ".elements.clickable")

    UI.Elements.Label       = require(PATH .. ".elements.label")
    UI.Elements.Button      = require(PATH .. ".elements.button")
    UI.Elements.Checkbox    = require(PATH .. ".elements.checkbox")
    UI.Elements.Slider      = require(PATH .. ".elements.slider")
    UI.Elements.Toggle      = require(PATH .. ".elements.toggle")
    UI.Elements.ListBox     = require(PATH .. ".elements.listbox")
    UI.Elements.RadioButton = require(PATH .. ".elements.radiobutton")
    UI.Elements.Tab         = require(PATH .. ".elements.tab")

    UI.setAccentColor("#1e88e5")

    UI.Colors = {}
    UI.loadColors("dark")

    local items = love.filesystem.getDirectoryItems(path)
    UI._Schemas = {}

    for i = 1, #items do
        local name = items[i]:gsub(".json", "")
        UI._Schemas[name] = JSON:decode(path .. "/" .. items[i])
    end
end

function UI.loadColors(name)
    local colors = require(PATH .. ".colors." .. name)
    UI.Colors[name] = colors

    UI.Theme = name
end

function UI.update(dt)
    flux.update(dt)
end

function UI.loadSchema(name)
    local GUI = {}

    if not UI._Schemas[name] then
        error(string.format("Schema not found: '%s'", name))
    end

    local schema = UI._Schemas[name]

    return GUI
end

function UI._hexColor(hex)
    return Utility.hexColor(hex)
end

function UI.Color(name)
    return Utility.hexColor(UI.Colors[name])
end

function UI.setAccentColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    UI.accent_color = color
end

function UI.accentColor()
    return UI.accent_color
end

function UI._round(x)
    return math.floor(x + 0.5)
end

return UI
