	player = {}
		player.x = love.graphics.getWidth()/2
		player.y = 550
		player.speed = 250
		player.offsetX = sprites.player:getWidth()/2
		player.offsetY = sprites.player:getHeight()/2-- offsets center pivot point
	
	
function playerUpdate(dt)
	dt = love.timer.getDelta( )
		--player movement
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt
	end
	if player.x <=10 then
		player.x = 11
	end
	if player.x >=love.graphics:getWidth()-10 then
		player.x = love.graphics:getWidth() -11
	end
end

function drawPlayer()
	love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)--we use nil to ignore parameters we don't want to mess with
end