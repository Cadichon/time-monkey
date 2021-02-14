Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "res/monkeystop.png", 1.5625)
  self.hasColision = true
  self.speed = 500
  self.isOnFloor = false
end

function Player:update(dt, world)
  local dx = 0
  local tx, ty

  if love.keyboard.isDown("up") and self.isOnFloor
  then
    self.jumpVelocity = -1000
  end
  Player.super.update(self, dt, world)
  
  if love.keyboard.isDown("right")
  then
    dx = self.speed * dt
  elseif love.keyboard.isDown("left")
  then
    dx = -self.speed * dt
  end
  
  if dx ~= 0
  then
    local newX, newY, cols, nb_cols = world:move(self, self.x + dx, self.y, self.filter)
    self.x = newX    
  end
end

function Player:filter(other)
  if other:is(Button) or other:is(Door)
  then
    return "cross"
  else
    return "slide"
  end
end