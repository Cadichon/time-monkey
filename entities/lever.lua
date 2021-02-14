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
  if isActive == true then
    isActive = false
    self.drawable = self.leverL
  else
    isActive = true
    self.drawable = self.leverR
  end
end
