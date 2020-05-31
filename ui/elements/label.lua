local PARENT = UI.Elements.Panel
local Label = PARENT:extend()

function Label:new(text, x, y)
    self.text_object = love.graphics.newText(UI.DefaultFont, text)
    Label.super.new(self, x, y, self.text_object:getWidth(), self.text_object:getHeight())

    self.text_value = text
    self:setBackgroundColor("#00000000")

    self.enums = { "horizontal", "vertical", "center" }
end

function Label:draw()
    Label.super.draw(self)

    love.graphics.push()
    love.graphics.translate(self.margin[1], self.margin[2])

    love.graphics.setColor(self:foregroundColor())
    love.graphics.draw(self.text_object, self:x(), self:y())

    love.graphics.pop()
end

function Label:setFont(font)
    Label.super.setFont(self, font)

    self.text_object:setFont(font)
end

function Label:setTextAlign(mode)
    if self:getEnum(mode) then
        local x, y = 0, 0

        if mode == "horizontal" or mode == "center" then
            x = (self:width()  - self.text_object:getWidth()) / 2
        end

        if mode == "vertical" or mode == "center" then
            y = (self:height() - self.text_object:getHeight()) / 2
        end

        self:setMargin(UI._round(x), UI._round(y))
    end
end

function Label:setText(text)
    self.text_object:set(text)
end

function Label:mouseMoved(x, y)
    self.hovered = self:_isHovered(x, y)
end

function Label:text()
    return self.text_value
end

return Label
