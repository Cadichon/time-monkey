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
    {1,0,0,0,0,0,0,0,0,0,0,0,0,{type="MagicWall", linkedId=1, status=3, id=1},{type="MagicWall", linkedId=1, status=3, id=2},1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,{type="MagicWall", linkedId=1, status=3,id=3},{type="Door", linkedId=1, status=3, id=4},1},
    {1,3,0,0,0,0,0,5,0,0,{type="PressurePlate", linkedTo=1, id=5},0,0,{type="MagicWall", linkedId=1, status=3, id=6},0,1},
    {1,0,'P',0,0,0,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }
  self:createMap()
end

return Level3