local PARENT = UI.Elements.Panel
local Tab = PARENT:extend()

function Tab:new(title, x, y, width, height)
    Tab.super.new(self, x, y, width, height)

    self.label = UI.Elements.Label(title, self:x() + Tab.PADDING, self:y(), {align = "vertical", height = height})
end

function Tab:setForegroundColor(color)
    Tab.super.setForegroundColor(self, color)
    self.label:setForegroundColor(color)
end

function Tab:draw()
    Tab.super.draw(self)

    self.label:draw()
end

return Tab