local PARENT = UI.Elements.Base
local Panel = PARENT:extend()

function Panel:new(x, y, width, height)
    Panel.super.new(self, x, y)

    self:setSize(width, height)

    self.corner_radius = 2
end

function Panel:shadowColor()
    return self.shadow_color
end

function Panel:setShadowColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    self.shadow_color = color
end

function Panel:_zeroValues(...)
    local arg = {...}

    for i = 1, #arg do
        if not tonumber(arg[i]) or not arg[i] then
            arg[i] = 0
        end
    end

    return unpack(arg)
end

function Panel:_onEnter()
    self:setBackgroundColor(self.highlight_color)
end

function Panel:_onExit()
    self:setBackgroundColor(self.default_background_color)
end

function Panel:mouseMoved(x, y)
    if not self:enabled() then
        return
    end

    self.hovered = self:_isHovered(x, y)

    if self.hovered then
        self:_onEnter()
    else
        self:_onExit()
    end
end

function Panel:mouseUnClicked()
end

function Panel:mouseClicked()
end

function Panel:drawShadow(...)
    xOff, yOff, wOff, hOff = self:_zeroValues(...)
    local x, y, w, h = self:dimensions()

    love.graphics.setColor(self:shadowColor())
    love.graphics.rectangle("fill", x + xOff, y + yOff, w + wOff, h + hOff, self.corner_radius, self.corner_radius)
end

function Panel:draw(shadow, x, y, w, h)
    if shadow then
        self:drawShadow(x, y, w, h)
    end

    local x, y, w, h = self:dimensions()

    love.graphics.setColor(self:backgroundColor())
    love.graphics.rectangle("fill", x, y, w, h, self.corner_radius, self.corner_radius)
end

return Panel
