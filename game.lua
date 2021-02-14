require("level")
require("entity")
require("entities.player")
require("entities.wall")
require("entities.box")
require("entities.door")
require("entities.lever")
require("animation")

Game = Object:extend()

function Game:new()
  local files = love.filesystem.getDirectoryItems("levels")
  local i = 1
  self.levels = {}
  self.world = bump.newWorld(50)
  self.currentLevel = 1
  self.loadedEntities = {}
  self.background = {}
  self.background.image = love.graphics.newImage("res/wall_2.png")
  self.background.scale = 3.125
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
  self:loadLevel(self.currentLevel)
end

function Game:update(dt)
  for k, obj in pairs(self.loadedEntities)
  do
    obj:update(dt, self.world)
  end
--  for i, v in ipairs(self.loadedEntities[0].collisions)
--  do
--  end
  if self.levels[self.currentLevel].isEnded
  then
    self:unloadCurrentLevel()
    self.currentLevel = self.currentLevel + 1
    if self.currentLevel <= #self.levels
    then
      self:loadLevel()
    end
  end
end

function Game:draw()
  self:drawBackground()
  for i, obj in ipairs(self.loadedEntities)
  do
    obj:draw()
  end
  self.loadedEntities[0]:draw()
end

function Game:keypressed(key, scancode, isrepeat)
  if key == "f"
  then
    self:timeTravel()
  elseif key == "e"
  then
    if not self.player.holdedBox
    then
      local lever = self.player:canActivateLever(self.world)
      if lever then
        local linkedDoor = self:searchById(lever.linkedTo)
        lever:switch()
        linkedDoor:switch()
      else
        self.player:tryTakeBox(self.world)
      end
    else
      self.player.holdedBox.playerHolding = nil
      self.player.holdedBox = nil
    end
  elseif key == "up"
  then
    self.player:jump()
  elseif key == "right"
  then
    self.player:startMoveRight()
  elseif key == "left"
  then
    self.player:startMoveLeft()
  end
end

function Game:keyreleased(key, scancode, isrepeat)
  if key == "right"
  then
    self.player:stopMoveRight()
  elseif key == "left"
  then
    self.player:stopMoveLeft()
  end
end

function Game:timeTravel()
  -- Attention au time travel si monkey est sur la porte de fin
  self.levels[self.currentLevel]:timeTravel()
  for i, obj in ipairs(self.loadedEntities)
  do
    -- Check si l'object est porté par le joueur // si l'objet peut voyager
    self.world:remove(obj)
  end
  self.loadedEntities = {}
  self:setLoadedEntities()
  for i, obj in ipairs(self.loadedEntities)
  do
    self.world:add(obj, obj.x, obj.y, obj.width, obj.height)
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

function Game:unloadCurrentLevel()
  for k, v in pairs(self.loadedEntities)
  do
    self.world:remove(v)
  end
  self.loadedEntities = {}
end

function Game:loadLevel(levelNumber)
  levelNumber = levelNumber or self.currentLevel
  self.player = Player(self.levels[levelNumber].playerSpawn.x, self.levels[levelNumber].playerSpawn.y)
  self:setLoadedEntities()
  for k, v in pairs(self.loadedEntities)
  do
    self.world:add(v, v.x, v.y, v.width, v.height)
  end
end

function Game:searchById(id)
  for i, value in pairs(self.loadedEntities) do
    if value.id and value.id == id then
      return value
    end
  end
  return nil
end

function Game:drawBackground()
  for i = 0, love.graphics.getWidth() / self.background.image:getWidth() * self.background.scale do
    for j = 0, love.graphics.getHeight() / self.background.image:getHeight() * self.background.scale do
      love.graphics.draw(self.background.image, i * self.background.image:getWidth() * self.background.scale, j * self.background.image:getHeight() * self.background.scale, 0, self.background.scale)
    end
  end
end
