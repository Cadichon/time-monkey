-- 0 fond
-- 1 mur
-- 2 PorteTopOpen
-- 3 PorteBotOpen
-- 4 PorteTopClose
-- 5 PorteBotOpen
-- 6 Bouton / Pressure plate
-- 7 Boite

Level = Object:extend()

function Level:new()
  self.walls = {}
  self.objects = {}
  self.playerSpawn = {}
  self.nextLevel = nil
end

function Level:createMap()
  for i, v in ipairs(self.map)
  do
    for j, w in ipairs(v)
    do
      if w == 1
      then
        table.insert(self.walls, Wall((j-1)*50, (i-1)*50))
      elseif w == 2
      then
        table.insert(self.objects, DoorTopOpen((j-1)*50, (i-1)*50))
      elseif w == 3
      then
        table.insert(self.objects, DoorBotOpen((j-1)*50, (i-1)*50))
      elseif w == 4
      then
        table.insert(self.objects, DoorTopClose((j-1)*50, (i-1)*50))
      elseif w == 5
      then
        table.insert(self.objects, DoorBotClose((j-1)*50, (i-1)*50))
      elseif w == 6
      then
        table.insert(self.objects, Button((j-1)*50, (i-1)*50))
      elseif w == 7
      then
        table.insert(self.objects, Box((j-1)*50, (i-1)*50))
      end
    end
  end
end

function Level:getAllEntities()
  local ret = {}
  local i = 1
  for k, obj in multpairs(self.walls, self.objects)
  do
    ret[i] = obj
    i = i + 1
  end
  return ret;
end

function Level:whenEnd()
end