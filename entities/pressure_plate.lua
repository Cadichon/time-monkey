PressurePlate = Entity:extend()

function PressurePlate:new(x, y, linkedTo, id)
  PressurePlate.super.new(self, x, y, "res/pressure_plate.png", 3.125)
  self.isAffectedByGravity = false
  self.isActive = false
  self.linkedTo = linkedTo
  self.id = id
end

function PressurePlate:update(dt, world)
  PressurePlate.super.update(self, dt, world)
  local _, _, cols, nb_cols = world:check(self, self.x, self.y)
  self.isActive = false
  for i = 1, nb_cols
  do
    if cols[i].other:is(Player) or cols[i].other:is(Box)
    then
      self.isActive = true
      break
    end
  end
end


function PressurePlate:filter(other)
  return "cross"
end