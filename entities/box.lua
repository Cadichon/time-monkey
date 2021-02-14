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
    elseif self.playerHolding.direction == "left"
    then
      dx = -(self.width + 5)
    end
    self.x, self.y = world:move(self, self.playerHolding.x + dx, self.playerHolding.y + 5, self.filter)
  else
    self.isAffectedByGravity = true
  end
  
  Box.super.update(self, dt, world)
end

function Box:filter(other)
  if other:is(Player) and other == self.playerHolding
  then
    return "cross"
  elseif other:is(Lever) or other:is(PressurePlate)
  then
    return "cross"
  else
    return "slide"
  end
end