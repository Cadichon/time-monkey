Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "res/monkeystop.png", 1.5625)
  self.strength = 10
end

function Player:update(dt)
  Player.super.update(self, dt)

  if love.keyboard.isDown("left") then
    self.x = self.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + 200 * dt
  end

  if love.keyboard.isDown("up") then
    self.y = self.y - 200 * dt
  elseif love.keyboard.isDown("down") then
    self.y = self.y + 200 * dt
  end
end
