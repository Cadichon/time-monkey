-- 0 fond
-- 1 mur
-- 2 PorteOuverte
-- 3 PorteFermé
-- 4 Bouton / Pressure plate
-- 5 Boite
-- 'P' Joueur

Level = Object:extend()

function Level:new()
  self.map = {}
  self.map.start = "present"
  self.map.actual = self.map.start
  self.map.present = {}
  self.map.presentBackground = love.graphics.newImage("res/present_bg.png")
  self.map.futurBackground = love.graphics.newImage("res/futur_bg.png")
  self.map.futur = {}
  self.entities = {}
  self.entities.present = {}
  self.entities.futur = {}
  self.playerSpawn = {}
  self.nextLevel = nil
  self.isEnded = false
  self.canPlayerTimeTravel = false
end

function Level:createMap()
  for time, map in pairs({["present"]=self.map.present, ["futur"]=self.map.futur})
  do
    for i, v in ipairs(map)
    do
      for j, w in ipairs(v)
      do
        if type(w) == "number" then
          if w == 1
          then
            table.insert(self.entities[time], Wall((j-1)*50, (i-1)*50))
          elseif w == 2 or w == 3
          then
            table.insert(self.entities[time], Door((j-1)*50, (i-1)*50, w))
          elseif w == 4
          then
            table.insert(self.entities[time], Lever((j-1)*50, (i-1)*50))
          elseif w == 5
          then
            table.insert(self.entities[time], Box((j-1)*50, (i-1)*50))
          end
        elseif type(w) == "string" then
          if w == 'P' then
            self.playerSpawn = {x=(j-1)*50, y=(i-1)*50}
          end
        else
          if w.type == "Lever" then
            table.insert(self.entities[time], Lever((j-1)*50, (i-1)*50, w.linkedTo))
          elseif w.type == "Door" then
            table.insert(self.entities[time], Door((j-1)*50, (i-1)*50, w.status, w.id))
          elseif w.type == "PressurePlate" then
            table.insert(self.entities[time], PressurePlate((j-1)*50, (i-1)*50, w.linkedTo))
          end
        end
      end
    end
  end
end

function Level:getAllEntities()
  return self.entities[self.map.actual]
end

function Level:timeTravel()
  if self.canPlayerTimeTravel
  then
    if self.map.actual == "present"
    then
      self.map.actual = "futur"
    else
      self.map.actual = "present"
    end
  end
end