Level3 = Level:extend()

function Level3:new()
  Level3.super.new(self)
  self.canPlayerTimeTravel = false
  self.map.presentBackground = love.graphics.newImage("res/bg.png")
  self.map.present = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,{type="MagicWall", id=1, status=3},{type="MagicWall", id=1, status=3},1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,{type="MagicWall", id=1, status=3},{type="Door", id=1, status=3},1},
    {1,3,0,0,0,0,0,5,0,0,{type="PressurePlate", linkedTo=1},0,0,{type="MagicWall", id=1, status=3},0,1},
    {1,0,'P',0,0,0,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }
  self:createMap()
end

return Level3