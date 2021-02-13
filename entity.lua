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
  if self.scale
  then
    self.width = self.drawable:getWidth() * scale
    self.height = self.drawable:getHeight() * scale
  else
    self.width = self.drawable:getWidth()
    self.height = self.drawable:getHeight()
  end
end

function Entity:update(dt)
end

function Entity:draw()
  if self.scale
  then
    love.graphics.draw(self.drawable, self.x, self.y)
  else
    love.graphics.draw(self.drawable, self.x, self.y, 0, self.scale, self.scale)
  end
end