local PARENT = UI.Elements.Button
local ListBox = PARENT:extend()

function ListBox:new(x, y, width, height, ...)
    ListBox.super.new(self, x, y, width, height, ...)

    local args = ...
    if not args then
        args = {}
    end

    self.header  = args.header or ""
    local items  = args.items or {}
    self.hint    = args.hint  or "Select an Item"
    self.default = args.default or 1

    self.item_padding = args.padding or 2

    local width = self:width()
    local original_width = self:width()

    for i = 1, #items do
        if 8 + UI.DefaultFont:getWidth(items[i]) > width then
            width = (UI.DefaultFont:getWidth(items[i]) + 16)
        end
    end

    self.panel = UI.Elements.Panel(self:x(), self:y() + self:height() + 1, width, (self:padding() * #items) + self.item_padding)

    self.items = {}

    for i = 1, #items do
        local y = self.panel:y()
        local label = UI.Elements.Label(items[i], self:x() + 1, (y + self.item_padding) + (i - 1) * self:padding())

        label:setSize(self.panel:width() - 2, self:height())
        label:setTextAlign("vertical")
        label:setMargin(7)

        table.insert(self.items, label)
    end

    self.item = self.items[self.default] or nil

    if self.item then
        self.item:setHovered(true)
    end

    self.panel:setBackgroundColor("#000000")
    self:setForegroundColor("#FFFFFF")
    self.item_highlight_color = UI._hexColor("#1b1b1b")

    self.hover_item = nil
    self.open = false
end

function ListBox:setSelectionTextColor(color)
    if type(color) == "string" then
        color = UI._hexColor(color)
    end

    self.item_highlight_color = color
end

function ListBox:selectionTextColor()
    return self.item_highlight_color
end

function ListBox:padding()
    return self:height() + self.item_padding
end

function ListBox:setEntryBackgroundColor(color)
    self.entry_background_color = color
end

function ListBox:draw()
    love.graphics.setColor(self:backgroundColor())
    love.graphics.rectangle("line", self:x(), self:y(), self:width(), self:height(), self.corner_radius, self.corner_radius)

    love.graphics.setFont(UI.Fonts.FontAwesome)
    love.graphics.print("", self:x() + (self:width() - 24), self:y() + (self:height() - UI.Fonts.FontAwesome:getHeight()) / 2)

    love.graphics.setFont(UI.DefaultFont)
    love.graphics.setColor(self:foregroundColor())

    love.graphics.print(self.header, self:x(), self:y() - UI.DefaultFont:getHeight() - 4)

    local text = self.hint
    if self.item then
        text = self.item:text()
    end

    love.graphics.setScissor(self:x(), self:y(), (self:width() - 32), self:height())
    love.graphics.print(text, self:x() + 8, self:y() + (self:height() - UI.DefaultFont:getHeight()) / 2)

    if self.open then
        love.graphics.setScissor(self:x() - 2, self.panel:y() - 2, self.panel:width() + 4, self.panel:height() + 4)

        self.panel:draw(true, -2, -2, 4, 4)

        for i = 1, #self.items do
            if self.items[i]:hover() then
                love.graphics.setColor(self:selectionTextColor())

                local x, y, w, h = self.items[i]:dimensions()
                love.graphics.rectangle("fill", x, y, w, h, self.corner_radius, self.corner_radius)
            end

            self.items[i]:draw()
        end
    end

    love.graphics.setScissor()
end

function ListBox:mouseMoved(x, y)
    ListBox.super.mouseMoved(self, x, y)

    for i = 1, #self.items do
        self.items[i]:mouseMoved(x, y)

        if self.items[i]:hover() then
            self.hover_item = i
        end
    end
end

function ListBox:mouseClicked()
    if self.hovered then
        self.open = not self.open
    else
        if self.open then
            if self.hover_item and self.items[self.hover_item]:hover() then
                self.item = self.items[self.hover_item]
            end
            self.open = false
        end
    end
end

function ListBox:value()
    return self.item:text()
end

return ListBox
