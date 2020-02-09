background1y = 0
background2y = -2690
backgroundScrollingSpeed = 150


function scrollingBackgroundUpdate()
	dt = love.timer.getDelta( )

	--scrolling background
	background1y = background1y + backgroundScrollingSpeed * dt
	background2y = background2y + backgroundScrollingSpeed * dt
	
	if background1y >= 2690 then
		background1y = 0
	end
	
	if background2y >= 0 then
		background2y = -2690
	end
end


function drawScrollingBackground()
	--draws background
	love.graphics.draw(sprites.background, 0, background1y, r, sx, sy, ox, backgroundScrollerY, kx, ky)
	love.graphics.draw(sprites.background, 0, background2y, r, sx, sy, ox, backgroundScrollerY, kx, ky)
end