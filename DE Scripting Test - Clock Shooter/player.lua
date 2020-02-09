	player = {}
		player.x = love.graphics.getWidth()/2
		player.y = 850
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
		love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)

end




function love.mousepressed(x, y, b, istouch)
	if gameState == 2 then
		if b ==1 and cooldown.overheated == false and multishotActivate == true then
			spawnBullet()
			spawnmultishot()
		elseif b ==1 and cooldown.overheated == false then
			spawnBullet()
			cooldown.length = cooldown.length + 15
		end
	end
end