require("entity")
require("player")
require("wall")
require("level")
require("utils.functions")

Game = Object:extend()

function Game:new()
  local files = love.filesystem.getDirectoryItems("levels")
  self.levels = {}
  for i, file in ipairs(files)
  do
    local level = require("levels." .. file:match("(.+)%..+"))
    table.insert(self.levels, level())
  end
  self.player = Player(self.levels[1].playerSpawn.x, self.levels[1].playerSpawn.y, "res/player.png")
  self.currentLevel = 1
  self.loadedEntities = {}
  self:setLoadedEntities()
end

function Game:update(dt)
  self:setLoadedEntities()
  for k, obj in pairs(self.loadedEntities)
  do
    obj:update(dt)
  end
  for i=0,#self.loadedEntities
  do
    for j=i+1, #self.loadedEntities
    do
      self.loadedEntities[i]:resolveCollision(self.loadedEntities[j])
    end
  end
end

function Game:draw()
  for k, obj in pairs(self.loadedEntities)
  do
    obj:draw()
  end
end

function Game:setLoadedEntities()
  local currentLevelEntities = self.levels[self.currentLevel]:getAllEntities()
  self.loadedEntities[0] = self.player
  for i, obj in ipairs(currentLevelEntities)
  do
    self.loadedEntities[i] = obj
  end
end
