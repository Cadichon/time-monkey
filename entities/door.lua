Door = Entity:extend()

function Door:new(x, y, w, id)
  if w == 2 then
    Door.super.new(self, x, y, "res/door_open.png", 3.125)
    self.isOpen = true
  else
    Door.super.new(self, x, y, "res/door_close.png", 3.125)
    self.isOpen = false
  end
  self.isAffectedByGravity = false
  self.id = id
end

function Door:switch()
  if self.isOpen == true then
    self.isOpen = false
    self.drawable = love.graphics.newImage("res/door_close.png")
  else
    self.isOpen = true
    self.drawable = love.graphics.newImage("res/door_open.png")
  end
end