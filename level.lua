-- 0 fond
-- 1 mur
-- 2 PorteOuverte
-- 3 PorteFermé
-- 4 Bouton / Pressure plate
-- 5 Boite
-- 'P' Joueur

Level = Object:extend()

function Level:new()
  self.walls = {}
  self.objects = {}
  self.playerSpawn = {}
  self.nextLevel = nil
  self.isEnded = false
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
        table.insert(self.objects, DoorOpen((j-1)*50, (i-1)*50))
      elseif w == 3
      then
        table.insert(self.objects, DoorClose((j-1)*50, (i-1)*50))
      elseif w == 4
      then
        table.insert(self.objects, Button((j-1)*50, (i-1)*50))
      elseif w == 5
      then
        table.insert(self.objects, Box((j-1)*50, (i-1)*50))
      elseif w == 'P'
      then
        self.playerSpawn = {x=(j-1)*50, y=(i-1)*50}
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