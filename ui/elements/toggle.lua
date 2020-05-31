local PARENT = UI.Elements.Button
local Toggle = PARENT:extend()

function Toggle:new(x, y, width, height, ...)
    Toggle.super.new(self, x, y, width, height, ...)

    self.toggle_color = UI._hexColor("#FFFFFF")
    self.toggle_radius = 5

    self.toggled = false
    self.circle_pos = self:x() + 10
end

function Toggle:draw()
    if not self.toggled then
        love.graphics.setColor(self:backgroundColor())
        love.graphics.rectangle("line", self:x(), self:y(), self:width(), self:height(), 10, 10)
    else
        love.graphics.setColor(self:accentColor())
        love.graphics.rectangle("fill", self:x(), self:y(), self:width(), self:height(), 10, 10)
        love.graphics.rectangle("line", self:x(), self:y(), self:width(), self:height(), 10, 10)
    end

    love.graphics.setColor(self.toggle_color)
    love.graphics.circle("fill", self.circle_pos, self:y() + self:height() / 2, self.toggle_radius)
    love.graphics.circle("line", self.circle_pos, self:y() + self:height() / 2, self.toggle_radius)
end

function Toggle:mouseClicked()
    local ret
    if self.hovered then
        self.toggled = not self.toggled

        ret = self.clicked(self.args)
    end

    if self.toggled then
        flux.to(self, 0.1, {circle_pos = (self:x() + self:width() - 10)}):ease("linear")
    else
        flux.to(self, 0.1, {circle_pos = (self:x() + 10)}):ease("linear")
    end

    return ret
end

return Toggle
