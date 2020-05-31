local PARENT = UI.Elements.Button
local Checkbox = PARENT:extend()

function Checkbox:new(x, y, ...)
    Checkbox.super.new(self, x, y, 16, 16, ...)

    self.accent_highlight_color = UI._hexColor("#0288d1")
    self.checked_highlight_foreground = UI._hexColor("#e0e0e0")

    self:setForegroundColor("#FFFFFF")

    if self.label then
        self.label:setPosition(x + self:width() + 8, UI._round(self:y() + (self:height() - self.label:height()) / 2))
    end
end

function Checkbox:draw()
    if self:checked() then
        love.graphics.setColor(self:defaultAccentColor())

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
        self.label:draw()
    end
end

function Checkbox:_onEnter()
    self.background_color = self.highlight_color

    if self:checked() then
        self.default_accent_color = self.accent_highlight_color
        self.foreground_color = self.checked_highlight_foreground
    end
end

function Checkbox:_onExit()
    Checkbox.super._onExit(self)

    if self.is_checked then
        self.default_accent_color = self.accent_color
        self.foreground_color = self:defaultForegroundColor()
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

return Checkbox
