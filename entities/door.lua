Door = Entity:extend()

function Door:new(x, y, dr, sc)
  Door.super.new(self, x, y, dr, sc)
  self.isAffectedByGravity = false;
end

DoorOpen = Door:extend()

function DoorOpen:new(x, y)
  DoorOpen.super.new(self, x, y, "res/door_open.png", 3.125)
end

DoorClose = Door:extend()

function DoorClose:new(x, y)
  DoorClose.super.new(self, x, y, "res/door_close.png", 3.125)
end