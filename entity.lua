Object = require("utils.classic")

Entity = Object:extend()

function Entity:new(x, y, drawable, scale)
  self.x = x
  self.y = y
  self.scale = scale
  if not drawable
  then
    self.drawable = love.graphics.newImage("res/default.png")
  elseif type(drawable) == "string"
  then
    self.drawable = love.graphics.newImage(drawable)
  else
    self.drawable = drawable
  end
  if self.scale then
    self.width = self.drawable:getWidth() * scale
    self.height = self.drawable:getHeight() * scale
  else
    self.width = self.drawable:getWidth()
    self.height = self.drawable:getHeight()
  end
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y
  self.strength = 0
  self.tempStrength = 0
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  self.tempStrength = self.strength
end

function Entity:draw()
  if self.scale
  then
    love.graphics.draw(self.drawable, self.x, self.y, 0, self.scale, self.scale)
  else
    love.graphics.draw(self.drawable, self.x, self.y)
  end
end

function Entity:checkCollision(e)
  return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

function Entity:resolveCollision(e)
  if self.tempStrength > e.tempStrength
  then
    return e:resolveCollision(self)
  end
  if self:checkCollision(e)
  then
    self.tempStrength = e.tempStrength
    if self:wasVerticallyAligned(e)
    then
      if self.x + self.width / 2 < e.x + e.width / 2
      then
      	local pushback = self.x + self.width - e.x
      	self.x = self.x - pushback
      else
	      local pushback = e.x + e.width - self.x
      	self.x = self.x + pushback
      end
    elseif self:wasHorizontallyAligned(e)
    then
      if self.y + self.height / 2 < e.y + e.height / 2
      then
	      local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
      else
      	local pushback = e.y + e.height - self.y
      	self.y = self.y + pushback
      end
    end
    return true
  end
  return false
end

function Entity:wasVerticallyAligned(e)
  return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
  return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end
