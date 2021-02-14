Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, "res/funkykong.png", 1.5625)
  self.animation = newAnimation(love.graphics.newImage("res/funkykong.png"), 32, 32, 1)
  self.jumpImage = love.graphics.newImage("res/funkykongjump.png")
  -- self.stopImage = love.graphics.newImage("res/funkykongstop.png")
  self.direction = "right"

  self.width = 32 * 1.5625
  self.height = 32 * 1.5625
  self.hasColision = true
  self.speed = 500
  self.isOnFloor = false
end

function Player:update(dt, world)
  local dx = 0
  local tx, ty

  if love.keyboard.isDown("up") and self.isOnFloor
  then
    self.jumpVelocity = -1000
  end
  Player.super.update(self, dt, world)

  if love.keyboard.isDown("right")
  then
    self:anime(dt)
    self.direction = "right"
    dx = self.speed * dt
  elseif love.keyboard.isDown("left")
  then
    self:anime(dt)
    self.direction = "left"
    dx = -self.speed * dt
  end

  if dx ~= 0
  then
    local newX, newY, cols, nb_cols = world:move(self, self.x + dx, self.y, self.filter)
    self.x = newX
  end
end

function Player:draw()
  local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1
  local transform = love.math.newTransform(self.x, self.y, 0, self.scale, self.scale, 0)

  if self.isOnFloor == false then
    if self.direction == "right" then
      transform = love.math.newTransform(self.x, self.y, 0, self.scale, self.scale, 0)
    else
      transform = love.math.newTransform(self.x, self.y, 0, - self.scale, self.scale, 32)
    end
    love.graphics.draw(self.jumpImage, transform)
  else
    if self.direction == "right" then
      transform = love.math.newTransform(self.x, self.y, 0, - self.scale, self.scale, 32)
    else
      transform = love.math.newTransform(self.x, self.y, 0, self.scale, self.scale, 0)
    end
    love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], transform)
  end
end


function Player:filter(other)
  if other:is(Button) or other:is(Door)
  then
    return "cross"
  else
    return "slide"
  end
end

function Player:anime(dt)
  self.animation.currentTime = self.animation.currentTime + dt
  if self.animation.currentTime >= self.animation.duration then
      self.animation.currentTime = self.animation.currentTime - self.animation.duration
  end
end