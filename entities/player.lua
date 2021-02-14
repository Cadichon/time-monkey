Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "res/monkeystop.png", 1.5625)
  self.hasColision = true
  self.speed = 250
  self.gravity = 400
  self.jumpVelocity = 0;
  self.isOnFloor = false
end

function Player:update(dt, world)
  local dx, dy = 0, 0
  local tx, ty
  

  if love.keyboard.isDown("right")
  then
    dx = self.speed * dt
  elseif love.keyboard.isDown("left")
  then
    dx = -self.speed * dt
  end
  
  tx, ty = world:check(self, self.x, self.y - 0.001, self.filter); -- check if head touch smth
  
  if self.isOnFloor or ty == self.y
  then
    self.jumpVelocity = 0
  end
  
  if love.keyboard.isDown("up") and self.isOnFloor
  then
    self.jumpVelocity = -300
  end

  if (not self.isOnFloor) or (self.jumpVelocity ~= 0) 
  then
    self.jumpVelocity = self.jumpVelocity + self.gravity * dt
    dy = self.jumpVelocity * dt
  end

  if dx ~= 0 or dy ~= 0
  then
    local newX, newY, cols, nb_cols = world:move(self, self.x + dx, self.y + dy, self.filter)
    if self.holdedBox
    then
      local newBoxX, newBoxY = world:move(self.holdedBox, self.holdedBox.x + dx, self.holdedBox.y + dy, self.holdedBox.filter)
      self.holdedBox.x = newBoxX
      self.holdedBox.y = newBoxY
    end
    if newY == self.y
    then
      self.isOnFloor = true
    else
      self.isOnFloor = false
    end
    self.y = newY
    self.x = newX
    
    for i=1, nb_cols
    do
      if cols[i].other:is(Box)
      then
        self.holdedBox = cols[i].other
      end
    end
  end
  tx, ty = world:check(self, self.x, self.y + 0.001, self.filter); -- check if on floor
  if ty == self.y
  then
  	self.isOnFloor = true
  else
	  self.isOnFloor = false
  end
end