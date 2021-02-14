Box = Entity:extend()

function Box:new(x, y)
  Box.super.new(self, x, y, "res/box.png", 2)
  self.playerHolding = nil
end

function Box:update(dt, world)
  if self.playerHolding ~= nil
  then
    self.isAffectedByGravity = false
    local dx
    if self.playerHolding.direction == "right"
    then
      dx = self.playerHolding.width + 5
    else
      dx = -(self.width + 5)
    end
    self.x = self.playerHolding.x + dx
    self.y = self.playerHolding.y + 5
  else
    self.isAffectedByGravity = true
  end
  world:move(self, self.x, self.y, self.filter)
  Box.super.update(self, dt, world)
end

function Box:filter(other)
  if other:is(Button)
  then
    return "cross"
  else
    return "slide"
  end
end