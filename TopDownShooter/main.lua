function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
end

function love.update(dt)
  -- body...
end

function love.draw()
  love.graphics.draw(sprites.player, 100, 100)
end
