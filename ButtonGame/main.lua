function love.load()
    --button properties
    button = {}
    button.x = 200
    button.y = 200
    button.size = 50

    --global game variables
    score = 0
    timer = 0

    myFont = love.graphics.newFont(40)
end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(255,0,0)
  love.graphics.circle("fill", button.x, button.y, button.size)

  love.graphics.setFont(myFont)
  love.graphics.setColor(255,255,255)
  love.graphics.print(score)
end
