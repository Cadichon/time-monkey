function love.load()
  tick = require("utils.tick")
  Object = require("utils.classic")
  
  require("game")
  game = Game()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end