maxTimeBetweenAsteroidSpawn = 2
asteroidSpawnTimer = maxTimeBetweenAsteroidSpawn
difficultyTimer = 10

bigAsteroidTracker = {}

smallAsteroidTracker = {}

function spawnbigAsteroid(x, y, vx, vy)
	bigAsteroid = {}
		bigAsteroid.x = x
		bigAsteroid.y = y
		bigAsteroid.vectorX = vx
		bigAsteroid.vectorY = vy
		bigAsteroid.direction = 1
		bigAsteroid.speed = 100
		bigAsteroid.offsetX = sprites.asteroid1:getWidth()/2
		bigAsteroid.offsetY = sprites.asteroid1:getHeight()/2--center bigAsteroid pivot point
		bigAsteroid.despawn = false	
		
		
	table.insert(bigAsteroidTracker, bigAsteroid)--adds this bigAsteroid table to the bigAsteroidTracker table in love.load()
end

function spawnSmallAsteroid(x, y, vx, vy)
	smallAsteroid = {}
		smallAsteroid.x = x
		smallAsteroid.y = y
		smallAsteroid.vectorX = vx
		smallAsteroid.vectorY = vy
		smallAsteroid.speed = 150
		smallAsteroid.offsetX = sprites.asteroid2:getWidth()/2
		smallAsteroid.offsetY = sprites.asteroid2:getHeight()/2--center bigAsteroid pivot point
		smallAsteroid.despawn = false	
		
	table.insert(smallAsteroidTracker, smallAsteroid)--adds this bigAsteroid table to the bigAsteroidTracker table in love.load()
end

function asteroidUpdate()
	
	--asteroid spawn initialization
	asteroidSpawnTimer = asteroidSpawnTimer - dt
	if asteroidSpawnTimer <= 0 then
		spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30, math.random(-3, 3),math.random (1, 5))
		asteroidSpawnTimer = maxTimeBetweenAsteroidSpawn
	end
	
	--increases difficulty
	difficultyTimer = difficultyTimer - dt
	if difficultyTimer <= 0 then
		maxTimeBetweenAsteroidSpawn = maxTimeBetweenAsteroidSpawn * 0.90
		difficultyTimer = 10
	end
	
	
	
	for i,z in ipairs(bigAsteroidTracker) do
		--moves bigAsteroid towards player
		z.x = z.x + z.vectorX * z.speed * z.direction * dt
		z.y = z.y + z.vectorY * z.speed * dt
		
		
		--stops asteroids from leaving screen
		if z.x <= 0 or z.x >= love.graphics:getWidth() then
			z.direction = z.direction * -1
		end
		
		--collision with player
		if distanceBetween(z.x, z.y, player.x, player.y) < 70 and invulnerability == false then
			invulnerability = true
			healthLength = healthLength - 50
			invulnerabilityTimer = 1
			table.remove(bigAsteroidTracker, i) 
		end
		
		--collision with bullet
		for j, b in ipairs(bulletTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y)	<60 then
				deathSFX:play()
				spawnSmallAsteroid(z.x, z.y, z.vectorX, z.vectorY) --exact same velocity as big asteroid 
				spawnSmallAsteroid(z.x, z.y, (z.vectorX*-1), z.vectorY) --inverse x velocity
				currentScore = currentScore + 50
				table.remove(bigAsteroidTracker, i)
				table.remove(bulletTracker, j) 
			end	
		end

		
		--collision with multishot
		for j, b in ipairs(multishotTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y) < 60 then
				deathSFX:play()
				spawnSmallAsteroid(z.x, z.y, z.vectorX, z.vectorY) --exact same velocity as big asteroid 
				spawnSmallAsteroid(z.x, z.y, (z.vectorX*-1), z.vectorY) --inverse x velocity
				currentScore = currentScore + 50
				table.remove(bigAsteroidTracker, i) 
				table.remove(multishotTracker, j) 
			end	
			if distanceBetween(z.x,z.y,b.x2,b.y2) < 60 then
				deathSFX:play()
				spawnSmallAsteroid(z.x, z.y, z.vectorX, z.vectorY) --exact same velocity as big asteroid 
				spawnSmallAsteroid(z.x, z.y, (z.vectorX*-1), z.vectorY) --inverse x velocity
				currentScore = currentScore + 50
				table.remove(bigAsteroidTracker, i) 
				table.remove(multishotTracker, j) 
			end	
		end	
		
	end
	

		--moves smallAsteroid towards player
	for i,z in ipairs(smallAsteroidTracker) do
		z.x = z.x + z.vectorX * z.speed * dt
		z.y = z.y + z.vectorY * z.speed * dt
			
		--stops asteroids from leaving screen
		if z.x <= 0 or z.x >= love.graphics:getWidth() then
			z.vectorX = z.vectorX * -1
		end
		
		--collision with player
		if distanceBetween(z.x, z.y, player.x, player.y) < 50 then --this if condition also calls the function
			for i,z in ipairs(smallAsteroidTracker) do
				if invulnerability == false then
						invulnerability = true
						healthLength = healthLength - 50
						invulnerabilityTimer = 1
					end
				smallAsteroidTracker[i] = nil
			end
		end
	end

	
	--this implements collision between smallAsteroid and bullets
	for i, z in ipairs(smallAsteroidTracker) do
		for j, b in ipairs(bulletTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y)	<30 then
				deathSFX:play()
				currentScore = currentScore + 50
				z.despawn = true
				b.despawn = true
			end	
		end
	end
	
		--this implements collision between smallAsteroid and multishot
	for i, z in ipairs(smallAsteroidTracker) do
		for j, b in ipairs(multishotTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y) < 60 then
				b.despawn = true
				deathSFX:play()
				currentScore = currentScore + 50
				z.despawn = true
			end	
			if distanceBetween(z.x,z.y,b.x2,b.y2) < 60 then
				b.despawn = true
				deathSFX:play()
				currentScore = currentScore + 50
				z.despawn = true
			end	
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
end

function drawAsteroid()
	--draws bigAsteroids
	for i, z in ipairs(bigAsteroidTracker) do
		love.graphics.draw(sprites.asteroid1, z.x, z.y,nil, nil,nil, bigAsteroid.offsetX, bigAsteroid.offsetY)-- z is the current bigAsteroid we are on
	end
	
	--draws smallAsteroids
	for i, z in ipairs(smallAsteroidTracker) do
		love.graphics.draw(sprites.asteroid2, z.x, z.y,nil, nil,nil, smallAsteroid.offsetX, smallAsteroid.offsetY)-- z is the current bigAsteroid we are on
	end
end