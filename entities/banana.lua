Banana = Entity:extend()

function Banana:new(x, y)
  Banana.super.new(self, x, y, "res/banana.png", 1)
  self.isAffectedByGravity = false
end