Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "res/monkeystop.png", 1.5625)
  self.speed = 250
  self.gravity = 350
  self.jumpVelocity = 0;
  self.isOnFloor = false
end

function Player:update(dt, world)
  local dx, dy = 0, 0

  if love.keyboard.isDown("right")
  then
    dx = self.speed * dt
  elseif love.keyboard.isDown("left")
  then
    dx = -self.speed * dt
  end
  
  if self.isOnFloor
  then
    self.jumpVelocity = 0
  end
  
  if love.keyboard.isDown("up") and self.isOnFloor
  then
    self.jumpVelocity = -250
  end

  if (not self.isOnFloor) or (self.jumpVelocity ~= 0) 
  then
    if not self.isOnFloor then print("floor") end
    if self.jumpVelocity ~= 0 then print("jump") end
    print(self.jumpVelocity)
    dy = self.jumpVelocity * dt
    self.jumpVelocity = self.jumpVelocity + self.gravity * dt
  end
  
--  if not self.isOnFloor
--  then
--    dy = dy + self.gravity * dt
--  end

  if dx ~= 0 or dy ~= 0
  then
    local newX, newY = world:move(self, self.x + dx, self.y + dy)
    if newY == self.y
    then
      self.isOnFloor = true
    end
    self.y = newY
    self.x = newX
  end
end
