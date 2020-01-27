function love.load()
	sprites = {}
	sprites.player = love.graphics.newImage('sprites/player.png')
	sprites.bullet = love.graphics.newImage('sprites/bullet.png')
	sprites.zombie = love.graphics.newImage('sprites/zombie.png')
	sprites.background = love.graphics.newImage('sprites/background.png')
  


	player = {}
		player.x = 100
		player.y = 100
		player.speed = 250
		player.offsetX = sprites.player:getWidth()/2
		player.offsetY = sprites.player:getHeight()/2-- offsets center pivot point
		
	zombieTracker = {}

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
	love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)--we use nil to ignore parameters we don't want to mess with
	
	for i, z in ipairs(zombieTracker) do -- this for loop draws every current zombie in zombieTracker
		love.graphics.draw(sprites.zombie, z.x, z.y,ZombiePlayerAngleCalculation(z), nil,nil, zombie.offsetX, zombie.offsetY)-- z is the current zombie we are on
	end
	
end

function playerMouseAngleCalculation()
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function ZombiePlayerAngleCalculation(enemy)
	return math.atan2(enemy.y - player.y, enemy.x - player.x) + math.pi
end

function spawnZombie()
	zombie = {}
		zombie.x = math.random(0, love.graphics.getWidth())
		zombie.y = math.random(0, love.graphics.getHeight())
		zombie.speed = 100
		zombie.offsetX = sprites.zombie:getWidth()/2
		zombie.offsetY = sprites.zombie:getHeight()/2--center zombie pivot point
		
		table.insert(zombieTracker, zombie)--adds this zombie table to the zombieTracker table in love.load()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		spawnZombie()
	end
end