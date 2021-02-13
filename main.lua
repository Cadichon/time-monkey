function love.load()
  require("utils.functions")
  tick = require("utils.tick")
  Object = require("utils.classic")
  bump = require("utils.bump")
  
  require("game")
  game = Game()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end