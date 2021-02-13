Level = Object:extend()

function Level:new()
  self.walls = nil
  self.playerSpawn = nil
  self.nextLevel = nil
end

function Level:getAllEntities()
  return self.walls;
end

function Level:whenEnd()
end