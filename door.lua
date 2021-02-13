DoorTopOpen = Entity:extend()

function DoorTopOpen:new(x, y)
  DoorTopOpen.super.new(self, x, y, "res/dooropen.png")
end

DoorBotOpen = Entity:extend()

function DoorBotOpen:new(x, y)
  DoorBotOpen.super.new(self, x, y, "res/dooropen.png")
end

DoorTopClose = Entity:extend()

function DoorTopClose:new(x, y)
  DoorTopClose.super.new(self, x, y, "res/doorclose.png")
end

DoorBotClose = Entity:extend()

function DoorBotClose:new(x, y)
  DoorBotClose.super.new(self, x, y, "res/doorclose.png")
end
