local PARENT = UI.Elements.Panel
local Clickable = PARENT:extend()

function Clickable:new(x, y, width, height, ...)
    Clickable.super.new(self, x, y, width, height)

    local arg = ...

    if not arg then
        arg = { callback = {} }
    elseif not arg.callback then
        arg.callback = {}
    end

    local callback = arg.callback.func or function() end
    local callargs = arg.callback.args or {}

    self.clicked = callback
    self.args = callargs
end

function Clickable:setCallback(func, ...)
    self.args = {...}

    self.clicked = function(args)
        return func(args)
    end
end

function Clickable:mouseClicked()
    if self.hovered and self.is_enabled then
        self:setBackgroundColor(self.clickable_highlight_color)
        return self.clicked(self.args)
    end
end

function Clickable:clickableHighlightColor()
    return self.clickable_highlight_color
end

function Clickable:setClickableHighlightColor(color)
    if type(color) == "string" then
        color = Utility.hexColor(color)
    end

    self.clickable_highlight_color = color
end

function Clickable:mouseUnClicked()
    if self:hover() then
        self:setBackgroundColor(self:highlightColor())
    else
        self:setBackgroundColor(self:defaultBackgroundColor())
    end
end

return Clickable