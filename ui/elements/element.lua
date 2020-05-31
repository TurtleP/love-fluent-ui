
local Element = Object:extend()

function Element:new(x, y)
    self.bounds = {x = x, y = y, width = 64, height = 32}

    self.background_color = UI._hexColor("#FFFFFF")
    self.foreground_color = UI._hexColor("#FFFFFF")
    self.accent_color     = UI._hexColor("#039BE5")

    self.margin = {0, 0, 0, 0}

    self.default_background_color = self.background_color
    self.default_foreground_color = self.foreground_color
    self.default_accent_color     = self.accent_color

    self.font = UI.DefaultFont

    self.enums = {}
    self.hovered = false
end

function Element:setFont(font)
    self.font = font
end

function Element:hover()
    return self.hovered
end

function Element:setBackgroundColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    self.background_color = color
    self.default_background_color = color
end

function Element:accentColor()
    return self.accent_color
end

function Element:setAccentColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    self.accent_color = color
    self.default_accent_color = color
end

function Element:defaultAccentColor()
    return self.default_accent_color
end

function Element:backgroundColor()
    return self.background_color
end

function Element:defaultBackgroundColor()
    return self.default_background_color
end

function Element:setForegroundColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    self.foreground_color = color
    self.default_foreground_color = color
end

function Element:foregroundColor()
    return self.foreground_color
end

function Element:defaultForegroundColor()
    return self.default_foreground_color
end

function Element:_isHovered(x, y)
    return x > self.bounds.x and x < self.bounds.x + self.bounds.width and
           y > self.bounds.y and y < self.bounds.y + self.bounds.height
end

function Element:setHovered(hover)
    self.hovered = hover
end

function Element:dimensions()
    return self.bounds.x, self.bounds.y, self.bounds.width, self.bounds.height
end

function Element:size()
    return self.bounds.width, self.bounds.height
end

function Element:setSize(width, height)
    asset(tonumber(width) and tonumber(height), "expected size pair")

    self.bounds.width = width
    self.bounds.height = height
end

function Element:setWidth(width)
    self.bounds.width = width
end

function Element:setHeight(height)
    self.bounds.height = height
end

function Element:width()
    return self.bounds.width
end

function Element:height()
    return self.bounds.height
end

function Element:setCornerRadius(radius)
    self.corner_radius = radius
end

function Element:cornerRadius()
    return self.corner_radius
end

function Element:setPosition(x, y)
    assert(tonumber(x) and tonumber(y), "expected coordinates")

    self.bounds.x = x
    self.bounds.y = y
end

function Element:position()
    return self.bounds.x, self.bounds.y
end


function Element:setX(x)
    assert(tonumber(x), "number expected, got " .. type(x))

    self.bounds.x = x
end

function Element:setY(y)
    assert(tonumber(y), "number expected, got " .. type(y))

    self.bounds.y = y
end

function Element:x()
    return self.bounds.x
end

function Element:y()
    return self.bounds.y
end

function Element:setSize(width, height)
    self.bounds.width = width
    self.bounds.height = height
end

function Element:getEnum(in_value)
    for i = 1, #self.enums do
        if self.enums[i] == in_value then
            return in_value
        end
    end

    return false
end

function Element:setMargin(...)
    local args = {...}

    for i = 1, #args do
        self.margin[i] = args[i]
    end
end

function Element:margin()
    return self.margin
end

return Element
