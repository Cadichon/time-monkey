Lever = Entity:extend()

function Lever:new(x, y, linkedTo)
  Lever.super.new(self, x, y, "res/lever_l.png", 3.125)
  self.activeLeverImage = love.graphics.newImage("res/lever_r.png")
  self.isAffectedByGravity = false
  self.isActive = false
  self.linkedTo = linkedTo
end

function Lever:switch()
  if isActive == true then
    isActive = false
    self.drawable = love.graphics.newImage("res/lever_l.png")
  else
    isActive = true
    self.drawable = love.graphics.newImage("res/lever_r.png")
  end
end

-- function Lever:callback(door)
--   door.
-- end