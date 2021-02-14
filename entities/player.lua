Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y)
  self.animation = newAnimation(love.graphics.newImage("res/funkykong.png"), 32, 32, 1)
  self.jumpImage = love.graphics.newImage("res/funkykongjump.png")
  self.direction = "right"

  self.scale = 1.5625
  self.width = 32 * 1.5625
  self.height = 32 * 1.5625
  self.hasColision = true
  self.speed = 500
  self.isMovingRight = false
  self.isMovingLeft = false
  self.releasedBoxKey = false
end

function Player:update(dt, world)
  local dx = 0

  Player.super.update(self, dt, world)
  if self.isMovingRight and not self.isMovingLeft
  then
    self:anime(dt)
    self.direction = "right"
    dx = self.speed * dt
  elseif self.isMovingLeft and not self.isMovingRight
  then
    self:anime(dt)
    self.direction = "left"
    dx = -self.speed * dt
  end
  self:takeBox(dt, world)

  if dx ~= 0
  then
    local newX, newY, cols, nb_cols = world:move(self, self.x + dx, self.y, self.filter)
    self.x = newX
  end
end

function Player:jump()
  if self.isOnFloor
  then
    self.jumpVelocity = -1000
  end
end

function Player:startMoveRight()
  self.isMovingRight = true
end

function Player:startMoveLeft()
  self.isMovingLeft = true
end

function Player:stopMoveRight()
  self.isMovingRight = false
end

function Player:stopMoveLeft()
  self.isMovingLeft = false
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

function Player:takeBox(dt, world)
  if love.keyboard.isDown("r")
  then
    if self.releasedBoxKey == true
    then
      if self.holdedBox == nil 
      then
        local dx = 0
        if self.direction == "right"
        then
          dx = 30
        end
        if self.direction == "left"
        then
          dx = -30
        end
        local tx, ty, cols, nbcols = world:check(self, self.x + dx, self.y, self.filter);
        for i, v in ipairs(cols)
        do
          if v.other:is(Box)
          then
            v.other.playerHolding = self
            self.holdedBox = v.other
            self.releasedBoxKey = false
            break
          end
        end
      else
        self.holdedBox.playerHolding = nil
        self.holdedBox = nil
        self.releasedBoxKey = false
      end
    end
  else
    self.releasedBoxKey = true
  end
end