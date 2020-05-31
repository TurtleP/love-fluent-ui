UI = require('ui')

--[[
    -- TODO: Allow individual controls to have their own Font value
    -- TODO: Allow use of global accent color to be set
--]]

function love.load()
    UI.init("data/states")

    love.graphics.setBackgroundColor(0, 0, 0)

    GUI = {}

    table.insert(GUI, UI.Elements.Button(10, 10, 64, 32, {text = "Button"}))

    local config =
    {
        text = "Toggle Left",
        callback =
        {
            func = function(arg)
                arg.obj:setEnabled(not arg.obj:enabled())
            end,
            args = {obj = GUI[1]}
        }
    }

    table.insert(GUI, UI.Elements.Checkbox(96, 18, config))
    table.insert(GUI, UI.Elements.RadioButton("test", 10, 64, 16, 16, {text = "Click Me"}))
    table.insert(GUI, UI.Elements.Toggle(96, 61, 48, 22, {text = "Click Me"}))
end

function love.update(dt)
    UI.update(dt)
end

function love.draw()
    for i, v in ipairs(GUI) do
        v:draw()
    end
end

function love.mousepressed(x, y)
    for i, v in ipairs(GUI) do
        v:mouseClicked()
    end
end

function love.mousereleased(x, y)
    for i, v in ipairs(GUI) do
        v:mouseUnClicked()
    end
end

function love.mousemoved(x, y, dx, dy)
    for i, v in ipairs(GUI) do
        v:mouseMoved(x, y, dx, dy)
    end
end
