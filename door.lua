DoorOpen = Entity:extend()

function DoorOpen:new(x, y)
  DoorOpen.super.new(self, x, y, "res/dooropen.png")
end


DoorClose = Entity:extend()

function DoorClose:new(x, y)
  DoorOpen.super.new(self, x, y, "res/doorclose.png")
end