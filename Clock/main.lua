function love.load()

end
--this is for preliminary setup before setting up the game

function love.update(dt)

end
--this function is basically like the update function in C#

function love.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", 100, 100, 100, 100)
    love.graphics.setColor(0,0,1)
    love.graphics.line(100,100, 150,150)
    love.graphics.setColor(1,0,0)
    love.graphics.line(100,100, 100,150)

end
--this function is for drawing graphics on screen (at every frame)
