Level4 = Level:extend()

function Level4:new()
  Level4.super.new(self)
  self.canPlayerTimeTravel = false
  self.map.presentBackground = love.graphics.newImage("res/bg.png")
  self.map.present = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,{type="MagicWall", id=1, status=3},0,0,0,1},
    {1,0,{type="Lever", linkedTo=1},0,0,0,0,0,0,0,0,{type="MagicWall", id=1, status=3},0,{type="Lever", linkedTo=2},0,1},
    {1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,3,0,0,0,1,1,1,0,0,0,0,0,0,{type="Door", id=2, status=3},1},
    {1,0,'P',0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }
  self:createMap()
end

return Level4