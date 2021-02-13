require("entity")
require("player")
require("wall")
require("box")
require("level")
require("door")
require("button")

Game = Object:extend()

function Game:new()
  local files = love.filesystem.getDirectoryItems("levels")
  self.levels = {}
  self.world = bump.newWorld(50)
  for i, file in ipairs(files)
  do
    local level = require("levels." .. file:match("(.+)%..+"))
    table.insert(self.levels, level())
  end
  self.player = Player(self.levels[1].playerSpawn.x, self.levels[1].playerSpawn.y, "res/player.png")
  self.currentLevel = 1
  self.loadedEntities = {}
  self:setLoadedEntities()
  for k, v in pairs(self.loadedEntities)
  do
    self.world:add(v, v.x, v.y, v.width, v.height)
  end
end

function Game:update(dt)
  self:setLoadedEntities()
  for k, obj in pairs(self.loadedEntities)
  do
    obj:update(dt, self.world)
  end
  -- check if level is finished, if finised, load level[currentLevel]->nextLevel and currentLevel++
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
