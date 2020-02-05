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
	if healthLength > 0 then
		love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)
	else
		love.graphics.print("GAME OVER!!!", love.graphics:getWidth()/2, love.graphics:getHeight()/2)
	end
	
end




function love.mousepressed(x, y, b, istouch)
	if b ==1 and cooldown.overheated == false and multishotActivate == true then
		spawnBullet()
		spawnmultishot()
	elseif b ==1 and cooldown.overheated == false then
		spawnBullet()
		cooldown.length = cooldown.length + 20
	end
end