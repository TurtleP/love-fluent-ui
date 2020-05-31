local PARENT = UI.Elements.Panel
local Slider = PARENT:extend()
-- TODO: USE PANEL AS BASE
function Slider:new(x, y, width, height, default, min, max)
    Slider.super.new(self, x, y, width or 120, height or 2)

    self.min = min
    self.max = max

    self:setBackgroundColor("#9e9e9e")
    self.accent_highlight_color = UI._hexColor("#0288d1")

    self.default = default
    self.value = 0

    self.vertical = false
    if self:width() < self:height() then
        self.vertical = true
    end

    if not self.vertical then
        self.label = UI.Elements.Label("", self:x() + (self:width() * self.value), self:y() + (self:height() - 16) / 2)
    else
        self.label = UI.Elements.Label("", self:x() + (self:width() - 16) / 2 + 1, self:y() + (self:height() * self.value))
        self.label:setMargin(0, -8)
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

    self.label:draw()
end

function Slider:mouseClicked()
    if self.label:hover() then
        self.sliding = true
    end
end

function Slider:mouseUnClicked()
    self.sliding = false
end

function Slider:mouseMoved(x, y, dx, dy)
    self.label:mouseMoved(x, y)

    if self.sliding then
        if not self.vertical then
            self.offset = math.max(0, math.min(self.offset + dx, self:width()))
            self.label:setX(self:x() + self.offset)
            self.value = UI._round((self.offset / self:width()) * self.max)
        else
            self.offset = math.max(0, math.min(self.offset + dy, self:height()))
            self.label:setY(self:y() + self.offset)
            self.value = UI._round((self.offset / self:height()) * self.max)
        end
    end
end

return Slider
