function drawCanvas()
	love.graphics.setColor(0.1,0.1,0.1)
	love.graphics.rectangle( "fill", 0, 900, love.graphics:getWidth(), 100)
	
	--DRAW SHIELD TIMER
	if shieldTimer > 0 then
		love.graphics.setColor(225,225,225)
		love.graphics.print("Overshield: "..math.ceil(shieldTimer), 320, 900, nil, 2, 2)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(sprites.shieldIcon, 295, 905, nil, 0.35, 0.35)
	end
	
	--MULTISHOT TIMER
	if multishotActivate == true then
		love.graphics.setColor(1,0.5,0)
		love.graphics.print("Multishot: "..math.ceil(multishotTimer), 320, 925, nil, 2, 2)
		love.graphics.setColor(255,255,255)
		cooldown.overheated = false
		love.graphics.draw(sprites.multishot, 295, 930, nil, 0.35, 0.35)
	end
	
	--DRAW SPEED TIMER
	if speedTimer > 0 then
		love.graphics.setColor(0,1,1)
		love.graphics.print("Super Speed: "..math.ceil(speedTimer), 320, 950, nil, 2, 2)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(sprites.superSpeed, 295, 955, nil, 0.35, 0.35)
	end
	
	--HEALTH BAR
	if healthLength >=150 then
		love.graphics.setColor(0,1,0)
		love.graphics.rectangle( "fill", 30, 910, healthLength, 15 )
		love.graphics.setColor(255, 255, 255)
	elseif healthLength ==100 then
		love.graphics.setColor(1,1,0)
		love.graphics.rectangle( "fill", 30, 910, healthLength, 15 )
		love.graphics.setColor(255, 255, 255)
	elseif healthLength ==50 then
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle( "fill", 30, 910, healthLength, 15 )
		love.graphics.setColor(255, 255, 255)
	end
	love.graphics.rectangle( "line", 30, 910, 200, 15 )
	love.graphics.draw(sprites.health, 5, 907, nil, 0.35, 0.35)
	
	
	--COOLDOWN
	--makes color more red as guage length increases
	if cooldown.length < 100 and cooldown.overheated == false then
		love.graphics.setColor(1,0.6,0)
	elseif cooldown.overheated == false then
		love.graphics.setColor(1,0.4,0)
	else love.graphics.setColor(math.random(0,1),0,0)
	end
	love.graphics.rectangle( "fill", 30, 935, cooldown.length, 15 )
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle( "line", 30, 935, 200, 15 )
	love.graphics.draw(sprites.bullet, 5, 932, nil, 0.35, 0.35)
	
	--draws OVERHEATED!!! text warning
	if cooldown.overheated == true then
		love.graphics.setColor(math.random(0,1),0,0)
		love.graphics.print("OVERHEATED!!!", 30, 950, nil, 2, 2)
		love.graphics.setColor(255, 255, 255)
	end
	
	
	--SCORE
	love.graphics.print(currentScore, 650, 925, nil, 2, 2)
	
end