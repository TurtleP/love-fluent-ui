local flux = require("ui.libs.flux")

local PARENT = UI.Elements._Clickable
local Toggle = PARENT:extend()

function Toggle:new(x, y, width, height, ...)
    Toggle.super.new(self, x, y, width, height, ...)

    self.toggle_radius = 5

    self.toggled = false
    self.circle_pos = self:x() + 5

    local arg = ...

    if not arg then
        arg = {}
    end

    local text = arg.text or ""

    self.label = UI.Elements.Label(text, x + self:width() + Toggle.PADDING, self:y(), {height = height, align = "vertical"})
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

    love.graphics.setColor(self:foregroundColor())
    love.graphics.setFont(UI.Fonts.FontAwesomeSolid)
    love.graphics.print("", self.circle_pos, self:y() + (self:height() - UI.Fonts.FontAwesomeSolid:getHeight()) / 2 - 1)

    if self.label then
        love.graphics.setColor(self:foregroundColor())
        love.graphics.print(self.label:text(), self.label:x(), self.label:y())
    end
end

function Toggle:mouseClicked()
    local ret
    if self.hovered then
        self.toggled = not self.toggled

        ret = self.clicked(self.args)
    end

    if self.toggled then
        flux.to(self, 0.1, {circle_pos = (self:x() + (self:width() - UI.Fonts.FontAwesomeSolid:getWidth("") - 5))}):ease("linear")
    else
        flux.to(self, 0.1, {circle_pos = (self:x() + 5)}):ease("linear")
    end

    return ret
end

function Toggle:__tostring()
    return "Toggle"
end

return Toggle
