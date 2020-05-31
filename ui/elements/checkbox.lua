local PARENT = UI.Elements._Clickable
local Checkbox = PARENT:extend()

function Checkbox:new(x, y, ...)
    Checkbox.super.new(self, x, y, 16, 16, ...)

    local arg = ...

    if not arg then
        arg = {}
    end

    local text            = arg.text or ""
    local has_three_state = arg.three_state or false

    self.label = UI.Elements.Label(text, x + self:width() + Checkbox.PADDING, self:y(), {align = "vertical"})
end

function Checkbox:draw()
    if self:checked() then
        love.graphics.setColor(self:accentColor())

        local x, y, w, h = self:dimensions()
        love.graphics.rectangle("fill", x, y, w, h, self.corner_radius, self.corner_radius)

        love.graphics.setFont(UI.Fonts.FontAwesome)

        love.graphics.setColor(self:foregroundColor())
        love.graphics.print("", self:x() + 1.25, self:y() + 0.5)

        love.graphics.setFont(UI.DefaultFont)
    else
        love.graphics.setColor(self:backgroundColor())
        love.graphics.rectangle("line", self:x(), self:y(), self:width(), self:height(), self.corner_radius, self.corner_radius)
    end

    if self.label then
        love.graphics.setFont(UI.DefaultFont)
        love.graphics.setColor(self:foregroundColor())
        love.graphics.print(self.label:text(), self.label:x(), self.label:y())
    end
end

function Checkbox:mouseClicked()
    if self.hovered then
        self.is_checked = not self.is_checked

        return self.clicked(self.args)
    end
end

function Checkbox:checked()
    return self.is_checked
end

function Checkbox:__tostring()
    return "Checkbox"
end

return Checkbox
