maxTimeBetweenAsteroidSpawn = 2
asteroidSpawnTimer = maxTimeBetweenAsteroidSpawn
difficultyTimer = 10

bigAsteroidTracker = {}

function spawnbigAsteroid(x, y, radius, vx, vy)
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
		bigAsteroid.radius = radius
		
		getCoordinatesFromThetaAngles()
		--These next lines calculate the XY coordinate data for the terminal ends of each clock hand.
		--Terminal End of hour hand
		bigAsteroid.hourHandX = (math.sin(thetaAngleForHours)*(bigAsteroid.radius*0.3) + bigAsteroid.x)
		bigAsteroid.hourHandY = (math.cos(thetaAngleForHours)*(bigAsteroid.radius*0.3) + bigAsteroid.y)

		--Terminal End of minute hand
		bigAsteroid.minuteHandX = (math.sin(thetaAngleForMinutes)*(bigAsteroid.radius*0.60) + bigAsteroid.x)
		bigAsteroid.minuteHandY = (math.cos(thetaAngleForMinutes)*(bigAsteroid.radius*0.60) + bigAsteroid.y)
		
		--Terminal End of second hand
		bigAsteroid.SecondHandX = (math.sin(thetaAngleForSeconds)*(bigAsteroid.radius*0.75) + bigAsteroid.x)
		bigAsteroid.SecondHandY = (math.cos(thetaAngleForSeconds)*(bigAsteroid.radius*0.75) + bigAsteroid.y)
		
		
		
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
		spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30, 50, math.random(-3, 3),math.random (1, 5))
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
		--Terminal End of hour hand
		z.hourHandX = z.hourHandX + z.vectorX * z.speed * z.direction * dt
		z.hourHandY = z.hourHandY + z.vectorY * z.speed * dt
		--Terminal End of minute hand
		z.minuteHandX = z.minuteHandX + z.vectorX * z.speed * z.direction * dt
		z.minuteHandY = z.minuteHandY + z.vectorY * z.speed * dt
		--Terminal End of second hand
		z.SecondHandX = z.SecondHandX + z.vectorX * z.speed * z.direction * dt
		z.SecondHandY = z.SecondHandY + z.vectorY * z.speed * dt
		
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
			if distanceBetween(z.x,z.y,b.x,b.y)	< z.radius then
				if z.radius == 50 then
					deathSFX:play()
					spawnbigAsteroid(z.x, z.y, 25, z.vectorX, z.vectorY)
					spawnbigAsteroid(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
					currentScore = currentScore + 50
					table.remove(bigAsteroidTracker, i)
					table.remove(bulletTracker, j) 
				else 
					table.remove(bigAsteroidTracker, i)
					table.remove(bulletTracker, j) 
				end	
			end	
		end

		
		--collision with multishot
		for j, b in ipairs(multishotTracker) do --using j because i is taken
			if distanceBetween(z.x,z.y,b.x,b.y) < z.radius then
				deathSFX:play()
				spawnbigAsteroid(z.x, z.y, 25, z.vectorX, z.vectorY)
				spawnbigAsteroid(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
				currentScore = currentScore + 50
				table.remove(bigAsteroidTracker, i) 
				table.remove(multishotTracker, j) 
			end	
			if distanceBetween(z.x,z.y,b.x2,b.y2) < z.radius then
				deathSFX:play()
				spawnbigAsteroid(z.x, z.y, 25, z.vectorX, z.vectorY)
				spawnbigAsteroid(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
				currentScore = currentScore + 50
				table.remove(bigAsteroidTracker, i) 
				table.remove(multishotTracker, j) 
			end	
		end	
		
	end
end
	
	
function drawAsteroid()
	--draws bigAsteroids
	for i, z in ipairs(bigAsteroidTracker) do
		
		--clock outline and appearence
		love.graphics.setColor(0.5,0.5,0.5)
		love.graphics.circle("fill", z.x, z.y, z.radius)
		love.graphics.setColor(1,1,1)
		love.graphics.circle("line", z.x, z.y, z.radius)
		love.graphics.circle("line", z.x, z.y, z.radius)

		--Coordinating each of the hands
			--Seconds Hand
		love.graphics.setColor(0,0,1)
		love.graphics.line(z.x,z.y, z.SecondHandX,z.SecondHandY)--blue line(seconds)
		love.graphics.circle("fill", z.SecondHandX, z.SecondHandY, (z.radius/15)) --terminalEnd of Hour hand
		
			--Minute Hand
		love.graphics.setColor(1,0,0)
		love.graphics.line(z.x,z.y, z.minuteHandX,z.minuteHandY)--red line (minutes)
		love.graphics.circle("fill", z.minuteHandX, z.minuteHandY, (z.radius/15)) --terminalEnd of Hour hand

			--Hour Hand
		love.graphics.setColor(0,1,0)
		love.graphics.line(z.x,z.y, z.hourHandX,z.hourHandY)--green line (hours)
		love.graphics.circle("fill", z.hourHandX, z.hourHandY, (z.radius/15)) --terminalEnd of Hour hand

		--circle in center of clock
		love.graphics.setColor(0.1,0.1,0.1)
		love.graphics.circle("fill", z.x, z.y, (z.radius/20))
		
		--reset color data to default
		love.graphics.setColor(255,255,255)
	end
		
end



function thetaAngleCalculator (currentTimeParameter, totalTimescale)
	
	theta = (currentTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi
    --multiplying by (-1) makes the hand tick clockwise, and adding math.pi makes the hand start at the top

	return theta
    --example: to find the theta angle for the clock's minute hand, we would call thetaAngleCalculator (os.date("%M"), 60)
end

function getCoordinatesFromThetaAngles()
	
	thetaAngleForHours = thetaAngleCalculator (os.date("%I"), 12)
    thetaAngleForMinutes = thetaAngleCalculator (os.date("%M"), 60)
    thetaAngleForSeconds = thetaAngleCalculator (os.date("%S"), 60)
	

end