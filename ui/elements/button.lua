local PARENT = UI.Elements.Panel
local Button = PARENT:extend()

local Label = UI.Elements.Label

function Button:new(x, y, width, height, ...)
    Button.super.new(self, x, y, width, height)

    -- self.highlight_color  = UI._hexColor("#9e9e9e")

    local arg = ...

    if arg then
        self.label = Label(arg.text, x, y)
        self.enums = { "horizontal", "vertical", "center" }

        self:setTextAlign("center")
    end

    self.clicked = function()
        print("yeet")
    end

    self:setBackgroundColor("#6d6d6d")
    -- self:setForegroundColor("#000000")

    self.args = nil
end

function Button:draw()
    local x, y, w, h = self:dimensions()

    love.graphics.setColor(self:defaultBackgroundColor())
    love.graphics.rectangle("fill", x, y, w, h, self.corner_radius, self.corner_radius)

    if self.hovered then
        love.graphics.setColor(self:highlightColor())
        love.graphics.rectangle("line", x, y, w, h, self.corner_radius, self.corner_radius)
    end

    love.graphics.push()
    love.graphics.translate(self.margin[1], self.margin[2])

    love.graphics.setColor(self:foregroundColor())
    self.label:draw()

    love.graphics.pop()
end

function Button:setText(text)
    self.label:setText(text)
end

function Button:setTextf(text, ...)
    self.label:setTextf(text, ...)
end

function Button:setForegroundColor(color)
    Button.super.setForegroundColor(self, color)

    if self.label then
        self.label:setForegroundColor(color)
    end
end

function Button:setTextAlign(mode)
    if self:getEnum(mode) then
        local x, y = self:x(), self:y()


        if mode == "horizontal" or mode == "center" then
            x = self:x() + (self:width()  - self.label:width()) / 2
        end

        if mode == "vertical" or mode == "center" then
            y = self:y() + (self:height() - self.label:height()) / 2
        end

        self.label:setPosition(UI._round(x), UI._round(y))
    end
end

function Button:setCallback(func, ...)
    self.args = {...}

    self.clicked = function(args)
        return func(args)
    end
end

function Button:mouseClicked()
    if self.hovered then
        return self.clicked(self.args)
    end
end

return Button
