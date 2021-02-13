Object = require("utils.classic")

Entity = Object:extend()

function Entity:new(x, y, drawable)
  self.x = x
  self.y = y
  if not drawable
  then
    self.drawable = love.graphics.newImage("res/default.png")
  elseif type(drawable) == "string"
  then
    self.drawable = love.graphics.newImage(drawable)
  else
    self.drawable = drawable
  end
  self.width = self.drawable:getWidth()
  self.height = self.drawable:getHeight()
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y
  self.strenght = 0
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
end

function Entity:draw()
  love.graphics.draw(self.drawable, self.x, self.y)
end

function Entity:checkCollision(e)
  return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

function Entity:resolveCollision(e)
  if self.strenght > e.strenght
  then
    e:resolveCollision(self)
    return
  end
  
  if self:checkCollision(e)
  then
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
  end
end

function Entity:wasVerticallyAligned(e)
  return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
  return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end
