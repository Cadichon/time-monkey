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

function love.keypressed(key, scancode, isrepeat)
  game:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode, isrepeat)
  game:keyreleased(key, scancode, isrepeat)
end