MagicWall = Entity:extend()

function MagicWall:new(x, y, w, id)
  if w == 2 then
    MagicWall.super.new(self, x, y, "res/empty.png", 3.125)
    self.isOpen = true
  else
    MagicWall.super.new(self, x, y, "res/block_1.png", 3.125)
    self.isOpen = false
  end
  self.isAffectedByGravity = false
  self.id = id
end

function MagicWall:update(dt, world)
  MagicWall.super.update(self, dt, world)
end

function MagicWall:switch()
  if self.isOpen == true then
    self.isOpen = false
    self.drawable = love.graphics.newImage("res/block_1.png")
  else
    self.isOpen = true
    self.drawable = love.graphics.newImage("res/empty.png")
  end
end

function MagicWall:filter(other)
  if self.isOpen
  then
    return "cross"
  else
    return "slide"
  end
end