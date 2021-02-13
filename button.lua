Button = Entity:extend()

function Button:new(x, y)
  Button.super.new(self, x, y, "res/pressureplate.png", 3.125)
  self.strength = 100
end