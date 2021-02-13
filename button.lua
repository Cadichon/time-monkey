Button = Entity:extend()

function Button:new(x, y)
  Button.super.new(self, x, y, "res/dooropen.png")
end