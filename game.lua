require("level")
require("entity")
require("entities.player")
require("entities.wall")
require("entities.box")
require("entities.door")
require("entities.button")
require("animation")

Game = Object:extend()

function Game:new()
  local files = love.filesystem.getDirectoryItems("levels")
  local i = 1
  self.levels = {}
  self.world = bump.newWorld(50)
  for _, file in ipairs(files)
  do
    if string.find(file, "^level%d%.lua$")
    then
      local level = require("levels." .. file:match("(.+)%..+"))
      self.levels[i] = level()
      i = i + 1
    end
  end
  for i=1,#self.levels
  do
    if i < #self.levels
    then
      self.levels[i].nextLevel = self.levels[i + 1]
    end
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
  if self.levels[self.currentLevel].isEnded
  then
    self:unloadLevel(self.currentLevel)
    self.currentLevel = self.currentLevel + 1
    self:loadLevel(self.currentLevel)
  end
end

function Game:draw()
  for i, obj in ipairs(self.loadedEntities)
  do
    obj:draw()
  end
  self.loadedEntities[0]:draw()
end

function Game:setLoadedEntities()
  local currentLevelEntities = self.levels[self.currentLevel]:getAllEntities()
  self.loadedEntities[0] = self.player
  for i, obj in ipairs(currentLevelEntities)
  do
    self.loadedEntities[i] = obj
  end
end