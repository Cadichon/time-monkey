Box = Entity:extend()

function Box:new(x, y)
  Box.super.new(self, x, y, "res/box.png", 3.125)
end