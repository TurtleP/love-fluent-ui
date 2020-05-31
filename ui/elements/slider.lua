local PARENT = UI.Elements.Panel
local Slider = PARENT:extend()

-- TODO: USE PANEL AS BASE
function Slider:new(x, y, width, height, ...)
    Slider.super.new(self, x, y, width or 120, height or 2)

    local args = ...

    if not args then
        args = {}
    end

    self.min  = args.min or 0
    self.max  = args.max or 1

    self.step = args.step or 0.1
    self._value = args.value or 0

    self:setBackgroundColor("#9e9e9e")

    self.raw_value = 0

    self.vertical = false
    if self:width() < self:height() then
        self.vertical = true
    end

    if not self.vertical then
        self.label = UI.Elements.Label("", self:x() + (self:width() * self._value) - 8, self:y() + (self:height() - 16) / 2)
    else
        self.label = UI.Elements.Label("", self:x() + (self:width() - 16) / 2 + 1, self:y() + (self:height() * self._value) - 8)
    end

    self.label:setFont(UI.Fonts.FontAwesomeSolid)
    self.label:setForegroundColor(self:accentColor())
    self.label:setSize(16, 16)

    self.sliding = false
    self.offset = 0
end

function Slider:draw()
    love.graphics.setColor(self:backgroundColor())
    love.graphics.rectangle("fill", self:x(), self:y(), self:width(), self:height(), self.corner_radius, self.corner_radius)

    love.graphics.setColor(self:accentColor())

    if not self.vertical then
        love.graphics.rectangle("fill", self:x(), self:y(), self.offset, self:height(), self.corner_radius, self.corner_radius)
    else
        love.graphics.rectangle("fill", self:x(), self:y(), self:width(), self.offset, self.corner_radius, self.corner_radius)
    end

    self.label:draw()
end

function Slider:mouseClicked()
    if self.label:hover() then
        self.sliding = true
    end
end

function Slider:mouseUnClicked()
    self.sliding = false
    self.raw_value = self._value
end

function Slider:mouseMoved(x, y, dx, dy)
    self.label:mouseMoved(x, y)

    if self.sliding then
        if not self.vertical then
            self.offset = math.max(0, math.min(self.offset + dx, self:width()))
            self.label:setX((self:x() - 8) + self.offset)
            self.raw_value = UI._round((self.offset / self:width()) * self.max)
        else
            self.offset = math.max(0, math.min(self.offset + dy, self:height()))
            self.label:setY((self:y() - 8) + self.offset)
            self.raw_value = UI._round((self.offset / self:height()) * self.max)
        end

        if self.step ~= 0 then
            self._value = math.floor(self.raw_value / self.step + 0.5) * self.step
        else
            self._value = self.raw_value
        end
    end
end

function Slider:value()
    return self._value
end

function Slider:rawValue()
    return self.raw_value
end

return Slider
