function love.load()
	--removes mouse cursor
	love.mouse.setVisible(false)

	--sprite setup
	sprites = {}
		sprites.player = love.graphics.newImage('sprites/player.png')
		sprites.bullet = love.graphics.newImage('sprites/bullet.png')
		sprites.background = love.graphics.newImage('sprites/background.png')
		sprites.reticle = love.graphics.newImage('sprites/reticle.png')
		sprites.asteroid1 = love.graphics.newImage('sprites/asteroid1.png')
		sprites.asteroid2 = love.graphics.newImage('sprites/asteroid2.png')
  
	--sound
	deathSFX = love.audio.newSource("sfx/death.ogg", "static")
	bulletSFX = love.audio.newSource("sfx/bullet.ogg", "static")
	
	--calling external scripts
	require ('asteroid')
	require ('bullet')
	require ('player')

	--Game State Initialization
	gameState = 2
	maxTimeBetweenSpawn = 2
	spawnTimer = maxTimeBetweenSpawn
	backgroundScrollerY = 0

end

function love.update(dt)
	--player movement
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt
	end
	
	--moves bigAsteroid towards player using trigonometry
	for i,z in ipairs(bigAsteroidTracker) do
		z.x = z.x + math.cos(enemyToPlayerAngleCalculation(z)) * z.speed * z.direction * dt
		z.y = z.y + math.sin(enemyToPlayerAngleCalculation(z)) * z.speed * dt
		
		--stops asteroids from leaving screen
		if z.x <= 0 or z.x >= love.graphics:getWidth() then
			z.direction = z.direction * -1
		end
		
		if distanceBetween(z.x, z.y, player.x, player.y) < 30 then --this if condition also calls the function
			for i,z in ipairs(bigAsteroidTracker) do
				bigAsteroidTracker[i] = nil
			end
		end
	end
	
	--moves smallAsteroid towards player using trigonometry
	for i,z in ipairs(smallAsteroidTracker) do
		if z.direction == 1 then
			z.x = z.x + math.cos(enemyToPlayerAngleCalculation(z)) * z.speed * dt
			z.y = z.y + math.sin(enemyToPlayerAngleCalculation(z)) * z.speed * dt
		elseif z.direction == -1 then
			z.x = z.x + math.cos(enemyToPlayerAngleCalculation(z)) * z.speed * -1 * dt  -- makes the 2nd asteroid move in another direction
			z.y = z.y + math.sin(enemyToPlayerAngleCalculation(z)) * z.speed * dt
		end
		
		--stops asteroids from leaving screen
		if z.x <= 0 or z.x >= love.graphics:getWidth() then
			z.direction = z.direction * -1
		end
		
		
		if distanceBetween(z.x, z.y, player.x, player.y) < 30 then --this if condition also calls the function
			for i,z in ipairs(smallAsteroidTracker) do
				smallAsteroidTracker[i] = nil
			end
		end
	end

	--makes bullet move
	for i, b in ipairs(bulletTracker) do
		b.x = b.x + math.cos(b.direction) * b.speed * dt
		b.y = b.y + math.sin(b.direction) * b.speed * dt
	end

	--destroys bullets
	for i=#bulletTracker,1,-1 do --#bulletTracker returns the total number of elements in bulletTracker	
		local b = bulletTracker[i] --unlike the previous for loops, here we need to specify the value of b.
		
		--for off-screen bullets
		if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
			table.remove(bulletTracker, i) --removes any bullet in bulletTracker that meets the if condition
		
		--for bullets that hit Asteroids
		elseif b.despawn == true then
			table.remove(bulletTracker, i) 
			--destroys any bullets that meet the conditions
		end	
		
	end
	
	
	--this implements collision between bigAsteroid and bullets
	for i, z in ipairs(bigAsteroidTracker) do
		for j, b in ipairs(bulletTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y)	<60 then
				b.despawn = true
				deathSFX:play()
				z.despawn = true
			end	
		end
	end
	
	
	--this implements collision between smallAsteroid and bullets
	for i, z in ipairs(smallAsteroidTracker) do
		for j, b in ipairs(bulletTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y)	<30 then
				deathSFX:play()
				z.despawn = true
				b.despawn = true
				-- in another function, we destroy any bullets or bigAsteroids who's despawn = true
			end	
		end
	end
	

	--destroy bigAsteroids
	for i=#bigAsteroidTracker, 1, -1 do 
		
		local z = bigAsteroidTracker[i]
		
		if z.despawn == true then
		
			--spawn small asteroids
			spawnSmallAsteroid(z.x, z.y, 1) --exact same velocity as big asteroid 
			spawnSmallAsteroid(z.x, z.y, -1) --inverse x velocity
			
			
			table.remove(bigAsteroidTracker, i) 
			--destroys any bigAsteroids that meet the conditions
		end	
	end
	
	
	--this destroy smallAsteroids who have despawn = true
	for i=#smallAsteroidTracker, 1, -1 do 
		
		local z = smallAsteroidTracker[i]
		
		if z.despawn == true then
			table.remove(smallAsteroidTracker, i) 
			--destroys any smallAsteroids that meet the conditions
		end	
	end


	--Game State Parameters
	if gameState == 2 then
		spawnTimer = spawnTimer - dt
		if spawnTimer <= 0 then
			spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30)
			maxTimeBetweenSpawn = maxTimeBetweenSpawn * 0.97
			spawnTimer = maxTimeBetweenSpawn
		end
	end

end

function love.draw()
	--draws background
	love.graphics.draw(sprites.background, 0, 0, r, sx, sy, ox, backgroundScrollerY, kx, ky)
	
	--draws player
	love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)--we use nil to ignore parameters we don't want to mess with
	
	--draws bigAsteroids
	for i, z in ipairs(bigAsteroidTracker) do
		love.graphics.draw(sprites.asteroid1, z.x, z.y,enemyToPlayerAngleCalculation(z), nil,nil, bigAsteroid.offsetX, bigAsteroid.offsetY)-- z is the current bigAsteroid we are on
	end
	
	--draws smallAsteroids
	for i, z in ipairs(smallAsteroidTracker) do
		love.graphics.draw(sprites.asteroid2, z.x, z.y,enemyToPlayerAngleCalculation(z), nil,nil, smallAsteroid.offsetX, smallAsteroid.offsetY)-- z is the current bigAsteroid we are on
	end
		
	--draws bullets
	for i,b in ipairs(bulletTracker) do
		love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5,bullet.offsetX,bullet.offsetY)
	end
	
	--draws reticle
	love.graphics.draw(sprites.reticle, love.mouse.getX(), love.mouse.getY(),nil, nil, nil, sprites.reticle:getWidth()/2, sprites.reticle:getHeight()/2)
end



--**FUNCTIONS**


--MATH 

--finds theta angle between mouse and player (used for aiming)
function playerMouseAngleCalculation()
	-- uses trig to calculate the angle in which the player is facing the mouse
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

--finds theta angle between player and enemy of interest
function enemyToPlayerAngleCalculation(enemy)
	--uses trig to calculate the angle in which the bigAsteroid is facing the player
	return math.atan2(enemy.y - player.y, enemy.x - player.x) + math.pi
end

--calculates distance between to coordinates (used for collision detection)
function distanceBetween(x1,y1,x2,y2)
	--can be used to find the distance between any formula.
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end



--PLAYER INPUT

--player shooting
function love.mousepressed(x, y, b, istouch)
	if b ==1 then
		spawnBullet()
	end
end