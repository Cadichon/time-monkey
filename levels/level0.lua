Level0 = Level:extend()

function Level0:new()
  Level0.super.new(self)
  self.playerSpawn = {x=100, y=100}
  self.walls = {
    Wall(100, 200, "res/wall.png")
  }
end

return Level0