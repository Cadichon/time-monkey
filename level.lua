Level = Object:extend()

function Level:new()
  self.walls = nil
  self.objects = nil
  self.playerSpawn = nil
  self.nextLevel = nil
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