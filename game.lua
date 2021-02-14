require("level")
require("entity")
require("entities.player")
require("entities.wall")
require("entities.box")
require("entities.door")
require("entities.lever")
require("entities.pressure_plate")
require("entities.magic_wall")
require("animation")

Game = Object:extend()

function Game:loadAllMap()
  local files = love.filesystem.getDirectoryItems("levels")
  local i = 1
  for _, file in ipairs(files)
  do
    if string.find(file, "^level%d%.lua$")
    then
      local levelFile = "levels." .. file:match("(.+)%..+")
      local level = require(levelFile)
      self.levels[i] = level()
      self.levels[i].file = levelFile
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
end

function Game:drawBackground()
  local bg
  if self.levels[self.currentLevel].map.actual == "present"
  then
    bg = self.levels[self.currentLevel].map.presentBackground
  else
    bg = self.levels[self.currentLevel].map.futurBackground
  end
  love.graphics.draw(bg, 0, 0, 0, 3.125)
end

function Game:new()
  self.levels = {}
  self.world = bump.newWorld(50)
  self.currentLevel = 1
  self.loadedEntities = {}
  self.background = {}
  self.background.image = love.graphics.newImage("res/wall_2.png")
  self.background.scale = 3.125
  self:loadAllMap()
  self:loadLevel(self.currentLevel)
end

function Game:update(dt)
  for k, obj in pairs(self.loadedEntities)
  do
    obj:update(dt, self.world)
    if obj:is(PressurePlate) and obj.isActive
    then
      local linked = self:searchById(obj.linkedTo)
      for i, v in ipairs(linked)
      do
        if not v.isOpen
        then
          v:switch()
        end
      end
    end
    if obj:is(PressurePlate) and (not obj.isActive)
    then
      local linked = self:searchById(obj.linkedTo)
      for i, v in ipairs(linked)
      do
        if v.isOpen
        then
          v:switch()
        end
      end
    end
  end
  if self:checkEndOfLevel()
  then
    self:unloadCurrentLevel()
    self.currentLevel = self.currentLevel + 1
    self:loadLevel()
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
        local linked = self:searchById(lever.linkedTo)
        for i, v in ipairs(linked)
        do
          v:switch()
        end
        lever:switch()
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

function Game:checkEndOfLevel()
  local _, _, cols, nb_cols = self.world:check(self.player, self.x, self.y, self.filter)
  
  for i = 1, nb_cols
  do
    if cols[i].other:is(Door) and cols[i].other.isOpen and (cols[i].other.x == self.player.x)
    then
      return true
    end
  end
  return false;
end

function Game:timeTravel()
  local level = self.levels[self.currentLevel]
  
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
  local list = {}
  for i, value in pairs(self.loadedEntities) do
    if value.id and value.id == id then
      table.insert(list, value)
    end
  end
  return list
end