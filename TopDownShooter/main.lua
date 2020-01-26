function love.load()
  sprites = {}
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')
  sprites.background = love.graphics.newImage('sprites/background.png')
  
  --offsets
  playerOffsetX = sprites.player:getWidth()/2
  playerOffsetY = sprites.player:getHeight()/2

  player = {}
  player.x = 100
  player.y = 100
  player.speed = 250

end

function love.update(dt)
	if love.keyboard.isDown("s") then
		player.y = player.y + player.speed * dt
	end

	if love.keyboard.isDown("w") then
		player.y = player.y - player.speed * dt
	end

	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt
	end

	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt
	end
end

function love.draw()
	love.graphics.draw(sprites.background, 0, 0)
	love.graphics.draw(sprites.bullet, 200, 100)
	love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, playerOffsetX, playerOffsetY)--we use nil to ignore parameters we don't want to mess with
	love.graphics.draw(sprites.zombie, 300, 100)
end



function playerMouseAngleCalculation()
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end