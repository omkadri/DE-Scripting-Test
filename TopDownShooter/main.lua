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
	
	--we create tracker tables for objects that will have multiple spawning
	zombieTracker = {}
	bulletTracker = {}

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
	
		
	--moves zombie towards player using trigonometry
	for i,z in ipairs(zombieTracker) do
		z.x = z.x + math.cos(zombiePlayerAngleCalculation(z)) * z.speed * dt
		z.y = z.y + math.sin(zombiePlayerAngleCalculation(z)) * z.speed * dt
		
		if distanceBetween(z.x, z.y, player.x, player.y) < 30 then --this if condition also calls the function
			for i,z in ipairs(zombieTracker) do
				zombieTracker[i] = nil
			end
		end
	end

	--makes bullet move
	for i, b in ipairs(bulletTracker) do
		b.x = b.x + math.cos(b.direction) * b.speed * dt
		b.y = b.y + math.sin(b.direction) * b.speed * dt
	end
end

function love.draw()
	--draws zombies
	love.graphics.draw(sprites.background, 0, 0)
	
	--draws player
	love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)--we use nil to ignore parameters we don't want to mess with
	
	--draws zombies
	for i, z in ipairs(zombieTracker) do -- this for loop draws every current zombie in zombieTracker
		love.graphics.draw(sprites.zombie, z.x, z.y,zombiePlayerAngleCalculation(z), nil,nil, zombie.offsetX, zombie.offsetY)-- z is the current zombie we are on
	end
	
	
	--draws bullets
	for i,b in ipairs(bulletTracker) do
		love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5,bullet.offsetX,bullet.offsetY)
	end
end

function playerMouseAngleCalculation()
	-- uses trig to calculate the angle in which the player is facing the mouse
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function zombiePlayerAngleCalculation(enemy)
	--uses trig to calculate the angle in which the zombie is facing the player
	return math.atan2(enemy.y - player.y, enemy.x - player.x) + math.pi
end

function distanceBetween(x1,y1,x2,y2)
	--can be used to find the distance between any formula.
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

function spawnZombie()
	zombie = {}
		zombie.x = math.random(0, love.graphics.getWidth())
		zombie.y = math.random(0, love.graphics.getHeight())--ensures random spawning
		zombie.speed = 100
		zombie.offsetX = sprites.zombie:getWidth()/2
		zombie.offsetY = sprites.zombie:getHeight()/2--center zombie pivot point
		
		table.insert(zombieTracker, zombie)--adds this zombie table to the zombieTracker table in love.load()
end

function spawnBullet()
		bullet = {}
		bullet.x = player.x
		bullet.y = player.y
		bullet.speed = 1000
		bullet.direction = playerMouseAngleCalculation()--this is conveninet, since we want the bullet going in the direction of the mouse
		bullet.offsetX = sprites.bullet:getWidth()/2
		bullet.offsetY = sprites.bullet:getHeight()/2--center bullet pivot point
		
		table.insert(bulletTracker, bullet)--adds this bullet table to the zombieTracker table in love.load()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "space" then
		spawnZombie()
	end
end

function love.mousepressed(x, y, b, istouch)
	if b ==1 then
		spawnBullet()
	end
end