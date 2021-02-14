Lever = Entity:extend()

function Lever:new(x, y, linkedTo, id)
  Lever.super.new(self, x, y, "res/lever_l.png", 3.125)
  self.leverL = love.graphics.newImage("res/lever_l.png")
  self.leverR = love.graphics.newImage("res/lever_r.png")
  self.isAffectedByGravity = false
  self.isActive = isActive or false
  self.linkedTo = linkedTo
  self.id = id
end

function Lever:switch()
  if self.isActive == true then
    self.isActive = false
    self.drawable = self.leverL
  else
    self.isActive = true
    self.drawable = self.leverR
  end
end

function Lever:draw()
  if self.isActive == true then
    self.drawable = self.leverR
  else
    self.drawable = self.leverL
  end
  if self.scale then
    love.graphics.draw(self.drawable, self.x, self.y, 0, self.scale, self.scale)
  else
    love.graphics.draw(self.drawable, self.x, self.y)
  end
end
