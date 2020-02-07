function love.load()
    --button properties
    button = {}
    button.x = 200
    button.y = 200
    button.size = 50

    --global game variables
    score = 0
    timer = 10
    gameStarted = false

    myFont = love.graphics.newFont(40)
end

function love.update(dt)
  if gameStarted == true then
    if timer > 0 then
      timer = timer - dt
    end

    if timer < 0 then
      timer = 0
      gameStarted = false
    end
  end
end

function love.draw()
  if gameStarted == true then
    love.graphics.setColor(255,0,0)
    love.graphics.circle("fill", button.x, button.y, button.size)
    love.graphics.setFont(myFont)
    love.graphics.setColor(255,255,255)
    love.graphics.print("Score: "..score)
    love.graphics.print("Time: "..math.ceil(timer), 625,0)
  end

  if gameStarted == false then
    love.graphics.setFont(myFont)
    love.graphics.printf("Click anywhere to begin!", 0, love.graphics.getHeight()/2,love.graphics.getWidth(), "center")
  end

end

function love.mousepressed(x, y, mouseButton, isTouch)
  if mouseButton==1 and gameStarted == true then
    if distanceFromRadius(button.x, button.y, love.mouse.getX(),love.mouse.getY()) < button.size then
      score = score + 1
      button.x = math.random(button.size,love.graphics.getWidth()-button.size)
      button.y = math.random(button.size,love.graphics.getHeight()-button.size)
    end
  end

  if gameStarted == false then
    gameStarted = true
    timer = 10
    score = 0
  end
end


function distanceFromRadius (x1, y1, x2, y2)
  return math.sqrt((y2-y1)^2 + (x1 - x2)^2 )
end
