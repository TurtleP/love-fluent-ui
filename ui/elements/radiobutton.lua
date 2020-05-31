local PARENT = UI.Elements.Button
local RadioButton = PARENT:extend()

RadioButton.GROUPS = {}

function RadioButton:new(group, x, y, text)
    RadioButton.super.new(self, x, y, 16 + UI.DefaultFont:getWidth(text) + 8, 16, {text = text})
    table.insert(RadioButton.GROUPS, self)

    self.label:setPosition(x + 24, UI._round(self:y() + (self:height() - self.label:height()) / 2))
end

function RadioButton:draw()

    if not self:checked() then
        love.graphics.setFont(UI.Fonts.FontAwesomeRegular)

        love.graphics.setColor(self:backgroundColor())
        love.graphics.print("", self:x(), self:y())
    else
        love.graphics.setFont(UI.Fonts.FontAwesomeRegular)
        love.graphics.setColor(self:accentColor())
        love.graphics.print("", self:x(), self:y())
    end

    love.graphics.setFont(UI.DefaultFont)

    love.graphics.setColor(self:foregroundColor())
    self.label:draw()
end

function RadioButton:mouseClicked()
    if self:hover() then
        for i, v in pairs(RadioButton.GROUPS) do
            v.is_checked = false
        end
        self.is_checked = true
    end
end

function RadioButton:checked()
    return self.is_checked
end

return RadioButton
