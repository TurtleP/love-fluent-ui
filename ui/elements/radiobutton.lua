local PARENT = UI.Elements._Clickable
local RadioButton = PARENT:extend()

RadioButton.GROUPS = {}

RadioButton.SetDefault = function(group, which)
    assert(RadioButton.GROUPS[group], "invalid group " .. tostring(group))
    assert(RadioButton.GROUPS[group]._RADIOS[which], "invalid group index " .. tostring(which))

    RadioButton.GROUPS[group]._RADIOS[which]:setDefault()
end

function RadioButton:new(group, x, y, width, height, ...)

    local arg = ...

    if not arg then
        arg = {}
    end

    local text    = arg.text or ""
    local default = arg.default or 1

    RadioButton.super.new(self, x, y, width + UI.DefaultFont:getWidth(text) + RadioButton.PADDING, height, ...)

    if not RadioButton.GROUPS[group] then
        RadioButton.GROUPS[group] = {_DEFAULT = default, _RADIOS = {}}
    end

    table.insert(RadioButton.GROUPS[group]._RADIOS, self)

    self.label = UI.Elements.Label(text, x + width + RadioButton.PADDING, self:y(), {align = "vertical"})
    self.group = group
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

    if self.label then
        love.graphics.setColor(self:foregroundColor())
        love.graphics.print(self.label:text(), self.label:x(), self.label:y())
    end
end

function RadioButton:mouseClicked()
    if self:hover() then
        for i, v in pairs(RadioButton.GROUPS[self.group]._RADIOS) do
            v.is_checked = false
        end
        self.is_checked = true

        if self.is_checked then
            return self.clicked(self.args)
        end
    end
end

function RadioButton:setDefault()
    self.is_checked = true

    if self.is_checked then
        return self.clicked(self.args)
    end
end

function RadioButton:checked()
    return self.is_checked
end

function RadioButton:__tostring()
    return "RadioButton"
end

return RadioButton
