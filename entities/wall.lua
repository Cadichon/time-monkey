Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, "res/wall_1.png", 3.125)
  self.isAffectedByGravity = false
end