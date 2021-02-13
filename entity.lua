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
  if self:checkCollision(e)
  then
    self.x = self.last.x
    self.y = self.last.y
  end
end
