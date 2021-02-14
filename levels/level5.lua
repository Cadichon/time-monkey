Level5 = Level:extend()

function Level5:new()
  Level5.super.new(self)
  self.canPlayerTimeTravel = true
  self.map.present = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,1,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,1,0,1,0,1,1,1,1,1,1,1},
    {1,0,0,1,1,0,0,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,0,0,1,1,1,1,0,0,1,0,1},
    {1,0,0,0,1,0,1,1,0,0,1,1,1,1,1,1},
    {1,0,0,0,1,0,0,1,1,1,1,0,0,0,0,1},
    {1,3,0,1,1,0,0,0,0,0,1,0,0,0,2,1},
    {1,0,'P',1,1,0,1,0,1,0,1,0,1,1,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }
  self.map.futur = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,1,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,1,0,1,0,1,1,0,0,0,0,1},
    {1,0,0,1,1,0,0,1,0,0,1,0,0,0,0,1},
    {1,0,0,0,1,0,0,1,0,1,1,0,0,1,0,1},
    {1,1,0,0,1,0,1,1,0,0,1,1,1,1,1,1},
    {1,0,0,0,1,0,0,1,1,0,1,0,1,0,0,1},
    {1,3,0,1,1,0,0,0,0,0,0,0,1,0,3,1},
    {1,0,0,1,1,0,1,0,1,0,0,0,1,1,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }
  self:createMap()
end

return Level5