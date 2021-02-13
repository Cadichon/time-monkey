Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, "res/wall.png")
  self.strenght = 100
end