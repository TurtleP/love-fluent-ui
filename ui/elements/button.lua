local PARENT = UI.Elements._Clickable
local Button = PARENT:extend()

-- Button:implement(UI.Elements._Clickable)

local Label = UI.Elements.Label

function Button:new(x, y, width, height, ...)
    Button.super.new(self, x, y, width, height)

    self:applyColors(UI.Colors[UI.Theme].Button)

    local arg = ...

    if not arg then
        arg = {}
    end

    local text = arg.text or "Button"

    self.label = Label(text, x, y)
    self.enums = { "horizontal", "vertical", "center" }

    self:setTextAlign("center")
end

function Button:draw()
    local x, y, w, h = self:dimensions()

    love.graphics.setColor(self:backgroundColor())
    love.graphics.rectangle("fill", x, y, w, h, self.corner_radius, self.corner_radius)

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

function Button:setBackgroundColor(color)
    Button.super.setBackgroundColor(self, color)

    if self.label then
        self.label:setBackgroundColor(color)
    end
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

function Button:setEnabled(enabled)
    self.is_enabled = enabled

    if enabled then
        self:setForegroundColor(self.text_color_enabled)
    else
        self:setForegroundColor(self.text_color_disabled)
    end
end

function Button:__tostring()
    return "Button"
end

return Button
