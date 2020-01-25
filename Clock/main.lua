function love.load()--this function is like the Start() function in C#

end


function love.update(dt)--this function is like the Update() function in C#
  --creating table for clock attributes
  currentTime = {}
    currentTime.fullTime = os.date()
    currentTime.hour = os.date("%I") --based on 12 hour clock
    currentTime.minute = os.date("%M")
    currentTime.second = os.date("%S")
end

function love.draw()
    --clock outline
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", 100, 100, 100, 100)
    love.graphics.setColor(0,0,1)
    love.graphics.line(100,100, 150,150)
    love.graphics.setColor(1,0,0)
    love.graphics.line(100,100, 100,150)

    --display clock data on-screen
    love.graphics.print(currentTime.fullTime,0,200)
    love.graphics.print(currentTime.hour,0,225)
    love.graphics.print(currentTime.minute,0,250)
    love.graphics.print(currentTime.second,0,275)

end
--this function is for drawing graphics on screen (at every frame)
