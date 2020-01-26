function love.load()--this function is like the Start() function in C#
  clockOriginX = 100
  clockOriginY = 100
  clockRadius = 100
end


function love.update(dt)--this function is like the Update() function in C#
  --creating table for clock attributes
  currentTime = {}
    currentTime.fullTime = os.date()
    currentTime.hour = os.date("%I") --based on 12 hour clock
    currentTime.minute = os.date("%M")
    currentTime.second = os.date("%S")

    --This table contains the x and y coordinates for all 3 hands of the clock
    clockHandCoordinates = {}
      clockHandCoordinates.hourX = 0
      clockHandCoordinates.hourY = 0
      clockHandCoordinates.minuteX = 0
      clockHandCoordinates.minuteY = 0
      clockHandCoordinates.secondX = 0
      clockHandCoordinates.secondY = 0

    --trigonometric functions
    theta = 0
    function thetaCalculation (currentTimeParameter, totalTimescale)
      theta = (currentTimeParameter / totalTimescale) * (2*math.pi)
      return theta
      --example - to find the theta angle for the clock's minute hand, we would call thetaCalculation (currentTime.minute, 60)
    end

    -- thetaCalculation for hours, minutes, and seconds
    thetaAngleHours = thetaCalculation (currentTime.hour, 12)
    thetaAngleMinutes = thetaCalculation (currentTime.minute, 60)
    thetaAngleSeconds = thetaCalculation (currentTime.second, 60)


    terminalEndX = 0




end


function love.draw()
    --clock outline
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", clockOriginX, clockOriginY, clockRadius)

    --Coordinating each of the hands
    love.graphics.setColor(0,0,1)
    love.graphics.line(clockOriginX,clockOriginY, 150,150)--blue line

    love.graphics.setColor(1,0,0)
    love.graphics.line(clockOriginX,clockOriginY, 100,150)--red line

    --display clock data on-screen
    love.graphics.print(currentTime.fullTime,0,200)
    love.graphics.print(currentTime.hour,0,225)
    love.graphics.print(currentTime.minute,0,250)
    love.graphics.print(currentTime.second,0,275)

    love.graphics.print(thetaAngleHours,300,100)
    love.graphics.print(thetaAngleMinutes,300,200)
    love.graphics.print(thetaAngleSeconds,300,300)

end
--this function is for drawing graphics on screen (at every frame)
