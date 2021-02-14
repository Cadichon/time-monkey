Teleportatron = Entity:extend()

function Teleportatron:new(x, y)
  Teleportatron.super.new(self, x, y, "res/teleportatron.png", 3.125)
  self.isAffectedByGravity = false
  self.isTaken = false
end

function Teleportatron:update(dt, world)
  if self.isTaken
  then
    self.drawable = love.graphics.newImage("res/empty.png")
  end
  Teleportatron.super.update(self, dt, world)
end

function Teleportatron:filter(other)
  if other:is(Player)
  then
    self.isTaken = true
    return "cross"
  else
    return "slide"
  end
end