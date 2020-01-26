function love.load()--this function is like the Start() function in C#
  clockOriginX = 100
  clockOriginY = 100
  clockRadius = 100
end


function love.update(dt)--this function is like the Update() function in C#

  --creating table for getting time data
    currentTime = {}
      currentTime.fullTime = os.date()
      currentTime.hour = os.date("%I") --based on 12 hour clock
      currentTime.minute = os.date("%M")
      currentTime.second = os.date("%S")

    --This table contains the x and y coordinates for all terminal ends of the 3 clock hands
    clockHandCoordinates = {}
      clockHandCoordinates.hourX = 0
      clockHandCoordinates.hourY = 0
      clockHandCoordinates.minuteX = 0
      clockHandCoordinates.minuteY = 0
      clockHandCoordinates.secondX = 0
      clockHandCoordinates.secondY = 0
      --the zero is arbritrary for initialization.

    --trigonometric functions
    function thetaCalculation (currentTimeParameter, totalTimescale)
      theta = (currentTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi

      --multiplying by (-1) makes the hand tick in the right direction, and adding math.pi makes the hand start at the top

      return theta --theta variable is local to this function

        --example - to find the theta angle for the clock's minute hand, we would call thetaCalculation (currentTime.minute, 60)

    end

    -- thetaCalculation for hours, minutes, and seconds
    thetaAngleHours = thetaCalculation (currentTime.hour, 12)
    thetaAngleMinutes = thetaCalculation (currentTime.minute, 60)
    thetaAngleSeconds = thetaCalculation (currentTime.second, 60)

    --This function calculates the coordinate data for the terminal ends.
    terminalEndSecondX = (math.sin(thetaAngleSeconds)*(clockRadius*0.25) + clockOriginX)
    terminalEndSecondY = (math.cos(thetaAngleSeconds)*(clockRadius*0.25) + clockOriginY)

    terminalEndMinuteX = (math.sin(thetaAngleMinutes)*(clockRadius*0.75) + clockOriginX)
    terminalEndMinuteY = (math.cos(thetaAngleMinutes)*(clockRadius*0.75) + clockOriginY)

    terminalEndHourX = (math.sin(thetaAngleHours)*(clockRadius*0.5) + clockOriginX)
    terminalEndHourY = (math.cos(thetaAngleHours)*(clockRadius*0.5) + clockOriginY)

end


function love.draw()
    --clock outline
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", clockOriginX, clockOriginY, clockRadius)

    --Coordinating each of the hands
    love.graphics.setColor(0,0,1)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndSecondX,terminalEndSecondY)--blue line(seconds)

    love.graphics.setColor(1,0,0)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndMinuteX,terminalEndMinuteY)--red line (minutes)

    love.graphics.setColor(0,1,0)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndHourX,terminalEndHourY)--green line (hours)

    --display clock data on-screen
    love.graphics.print(currentTime.fullTime,0,200)
    love.graphics.print(currentTime.hour,0,225)
    love.graphics.print(currentTime.minute,0,250)
    love.graphics.print(currentTime.second,0,275)

    love.graphics.print(thetaAngleHours,300,100)
    love.graphics.print(thetaAngleMinutes,300,200)
    love.graphics.print(thetaAngleSeconds,300,300)
    love.graphics.print(clockRadius,300,400)
    love.graphics.print(terminalEndSecondX,300,500)
    love.graphics.print(terminalEndSecondY,300,550)



end
--this function is for drawing graphics on screen (at every frame)
