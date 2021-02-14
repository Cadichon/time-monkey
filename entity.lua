Entity = Object:extend()

function Entity:new(x, y, drawable, scale)
  self.x = x
  self.y = y
  self.scale = scale
  self.isOnFloor = false
  self.gravity = 4000
  self.jumpVelocity = 0
  self.isAffectedByGravity = true
  self.collisions = {}
  
  if not drawable
  then
    self.drawable = love.graphics.newImage("res/default.png")
  elseif type(drawable) == "string"
  then
    self.drawable = love.graphics.newImage(drawable)
  else
    self.drawable = drawable
  end
  if self.scale
  then
    self.width = self.drawable:getWidth() * self.scale
    self.height = self.drawable:getHeight() * self.scale
  else
    self.width = self.drawable:getWidth()
    self.height = self.drawable:getHeight()
  end
end

function Entity:update(dt, world)
  local tx, ty
  local dy = 0
  
  if (self.isAffectedByGravity)
  then
    tx, ty = world:check(self, self.x, self.y - 0.1, self.filter); -- check if top touch smth
    if ty == self.y
    then
      self.jumpVelocity = -math.abs(self.jumpVelocity)
    end
    if self.isOnFloor and self.jumpVelocity > 0
    then
      self.jumpVelocity = 0
    end
    
    tx, ty = world:check(self, self.x, self.y + 0.1, self.filter); -- check if on floor
    if ty == self.y
    then
      self.isOnFloor = true
    else
      self.isOnFloor = false
    end
    
    if (not self.isOnFloor) or (self.jumpVelocity ~= 0) 
    then
      self.jumpVelocity = self.jumpVelocity + self.gravity * dt
      dy = self.jumpVelocity * dt
    end
    
    local newX, newY, cols, nb_cols = world:move(self, self.x, self.y + dy, self.filter)
    if newY == self.y
    then
      self.isOnFloor = true
    else
      self.y = newY
      self.isOnFloor = false
    end
  end
  _, _, self.collisions = world:check(self, self.x, self.y, self.filter)
end

function Entity:draw()
  if self.scale
  then
    love.graphics.draw(self.drawable, self.x, self.y, 0, self.scale, self.scale)
  else
    love.graphics.draw(self.drawable, self.x, self.y)
  end
end

function Entity:filter(other)
  return "slide"
end
