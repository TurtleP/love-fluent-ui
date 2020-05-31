UI = require('ui')

--[[
    -- TODO: Allow individual controls to have their own Font value
    -- TODO: Allow use of global accent color to be set
--]]

function love.load()
    UI.init("data/states")
    -- UI.loadSchema("penis")

    love.graphics.setBackgroundColor(0, 0, 0)

    GUI = {}
    table.insert(GUI, UI.Elements.Label("Favorie Programming Language?", 10, 10))

    local choices = {"C", "Java", "C++"}
    for i = 1, #choices do
        table.insert(GUI, UI.Elements.RadioButton("people", 24, 32 + (i - 1) * 20, choices[i]))
    end

    table.insert(GUI, UI.Elements.ListBox(10, 120, 120, 32, {header = "What is LÖVE?", items = {
        "Baby don't hurt me", "no more", "AAAAAAAAAAAAAAA"
    }}))

    table.insert(GUI, UI.Elements.Slider(10, 175, nil, nil, 0, 0, 10))
    table.insert(GUI, UI.Elements.Slider(200, 80, 2, 120, 0, 0, 10))

    table.insert(GUI, UI.Elements.Button(10, 200, 64, 32, {text = "Button"}))
    table.insert(GUI, UI.Elements.Checkbox(10, 250, {text = "I agree to the terms of service."}))
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
