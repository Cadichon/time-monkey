function love.load()
  tick = require("utils.tick")
  Object = require("utils.classic")

  require("entity")
  require("player")
  require("wall")
  
  player = Player(100, 100)
  wall = Wall(100, 200)
end

function love.update(dt)
  player:update(dt)
  wall:update(dt)
  player:resolveCollision(wall)
end

function love.draw()
  player:draw()
  wall:draw()
end