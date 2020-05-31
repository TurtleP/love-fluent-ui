local PARENT = UI.Elements.Panel
local Label = PARENT:extend()

function Label:new(text, x, y, ...)
    self.text_object = love.graphics.newText(UI.DefaultFont, text)

    local arg = ...

    if not arg then
        arg = {}
    end

    local width  = arg.width or self.text_object:getWidth()
    local height = arg.height or self.text_object:getHeight()

    Label.super.new(self, x, y, width, height)

    self.text_value = text
    self.enums = { "horizontal", "vertical", "center" }

    if text then
        if not text:match("%w+") then
            self.is_glyph = true
        end
    end

    local align = arg.align or ""

    self:setTextAlign(align)
end

function Label:draw()
    Label.super.draw(self)

    love.graphics.push()
    love.graphics.translate(self.margin[1], self.margin[2])

    local color = self:foregroundColor()
    if self.is_glyph then
        color = self:accentColor()
    end

    love.graphics.setColor(color)
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

        local off = 0
        if self.corner_radius > 0 then
            off = self.corner_radius
        end

        self:setPosition(self:x() + UI._round(x), self:y() + UI._round(y) + off)
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

function Label:__tostring()
    return "Label"
end

return Label
