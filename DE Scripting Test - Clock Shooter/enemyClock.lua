-- enemyClock spawn configuration
maxTimeBetweenEnemyClockSpawn = 2
enemyClockSpawnTimer = maxTimeBetweenEnemyClockSpawn
difficultyTimer = 10

-- keeps track of all current clock instances
enemyClockTracker = {}

--contains all clock parameters
function spawnenemyClock(x, y, radius, vx, vy)
	enemyClock = {}
		enemyClock.x = x
		enemyClock.y = y
		enemyClock.vectorX = vx
		enemyClock.vectorY = vy
		enemyClock.direction = 1
		enemyClock.speed = 100
		enemyClock.despawn = false	
		enemyClock.radius = radius

		--Terminal End of hour hand
		enemyClock.hourHandX = 0
		enemyClock.hourHandY = 0

		--Terminal End of minute hand
		enemyClock.minuteHandX = 0
		enemyClock.minuteHandY = 0
		
		--Terminal End of second hand
		enemyClock.SecondHandX = 0
		enemyClock.SecondHandY = 0
		
		
		
		table.insert(enemyClockTracker, enemyClock)--adds this enemyClock table to the enemyClockTracker table in love.load()

		
end

--CALLED IN MAIN.LUA	
function enemyClockUpdate()
	dt = love.timer.getDelta( )


	--Gets current angle for Hour Hand, Minute Hand, and Second Hand
	getThetaAngles()
	--enemyClock spawn initialization
	enemyClockSpawnTimer = enemyClockSpawnTimer - dt
	if enemyClockSpawnTimer <= 0 then
		spawnenemyClock(math.random(0, love.graphics:getWidth()), -30, 50, math.random(-3, 3),math.random (1, 5))
		enemyClockSpawnTimer = maxTimeBetweenEnemyClockSpawn
	end
	--increases difficulty
	difficultyTimer = difficultyTimer - dt
	if difficultyTimer <= 0 then
		maxTimeBetweenEnemyClockSpawn = maxTimeBetweenEnemyClockSpawn * 0.90
		difficultyTimer = 10
	end
	--caps difficulty increase
	if maxTimeBetweenEnemyClockSpawn <= 0.35 then
		maxTimeBetweenEnemyClockSpawn = 0.55
	end
	
	
	--MAIN ENEMYCLOCK FOR LOOP
	for i,z in ipairs(enemyClockTracker) do

		--moves enemyClock in downward direction
		z.x = z.x + z.vectorX * z.speed * z.direction * dt
		z.y = z.y + z.vectorY * z.speed * dt
	
	
		--stops enemyClocks from leaving screen
		if z.x <= 0 or z.x >= love.graphics:getWidth() then
			z.direction = z.direction * -1
		end
		
		--collision with player
		if distanceBetween(z.x, z.y, player.x, player.y) < (z.radius+20) and invulnerability == false then
				invulnerability = true
				healthLength = healthLength - 50
				invulnerabilityTimer = 0.25 -- So player has time to breathe before being instantly destroyed by new enemyClock spawn
				playerHitSFX:stop()
				playerHitSFX:play()
				table.remove(enemyClockTracker, i) 
		elseif distanceBetween(z.x, z.y, player.x, player.y) < (z.radius+10) and invulnerability == true then
				deathSFX:stop()
				deathSFX:play()
				table.remove(enemyClockTracker, i) 
		end
		
		
		--collision with bullet
		for j, b in ipairs(bulletTracker) do --using j because i is taken
				if distanceBetween(z.x,z.y,b.x,b.y)	< (z.radius+10) then
						if z.radius == 50 then --for colliding with big clocks
							spawnenemyClock(z.x, z.y, 25, z.vectorX, z.vectorY)
							spawnenemyClock(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
							deathSFX:play()
							currentScore = currentScore + 50
							table.remove(enemyClockTracker, i)
							table.remove(bulletTracker, j) 
						else --for colliding with small clocks
							deathSFX:play()
							currentScore = currentScore + 50
							table.remove(enemyClockTracker, i)
							table.remove(bulletTracker, j)  
						end	
				end	
		end
		
		
		--collision with multishot
		for j, b in ipairs(multishotTracker) do --using j because i is taken
						
				--collision with right multishot
				if distanceBetween(z.x,z.y,b.x,b.y) < (z.radius+10) then
						if z.radius == 50 then
							spawnenemyClock(z.x, z.y, 25, z.vectorX, z.vectorY)
							spawnenemyClock(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
							currentScore = currentScore + 50
							deathSFX:play()
							currentScore = currentScore + 50
							table.remove(enemyClockTracker, i)
							table.remove(bulletTracker, j) 
						elseif z.radius == 25 then
							table.remove(enemyClockTracker, i) 
							table.remove(multishotTracker, j) 
						end
				end	
				
				--collision with left multishot
				if distanceBetween(z.x,z.y,b.x2,b.y2) < (z.radius+10) then
						if z.radius == 50 then
							spawnenemyClock(z.x, z.y, 25, z.vectorX, z.vectorY)
							spawnenemyClock(z.x, z.y, 25, (z.vectorX*-1), z.vectorY)
							currentScore = currentScore + 50
							deathSFX:play()
							currentScore = currentScore + 50
							table.remove(enemyClockTracker, i)
							table.remove(bulletTracker, j) 
						elseif z.radius == 25 then
							table.remove(enemyClockTracker, i) 
							table.remove(multishotTracker, j) 
						end
				end	
		end	
		
		
	end
	
end
	
	

--CALLED IN MAIN.LUA	
function drawEnemyClock()

	--draws enemyClocks
	for i, z in ipairs(enemyClockTracker) do
		
		--clock outline and appearence
		love.graphics.setColor(0.5,0.5,0.5)
		love.graphics.circle("fill", z.x, z.y, z.radius)
		love.graphics.setColor(1,1,1)
		love.graphics.circle("line", z.x, z.y, z.radius)
		love.graphics.circle("line", z.x, z.y, z.radius)

				--Updating and drawing Coordinates of hour hands
					z.hourHandX = (math.sin(thetaAngleForHours)*(z.radius*0.3) + z.x)
					z.hourHandY = (math.cos(thetaAngleForHours)*(z.radius*0.3) + z.y)
					love.graphics.setColor(0,1,0)
					love.graphics.line(z.x,z.y, z.hourHandX,z.hourHandY)--green line (hours)
					love.graphics.circle("fill", z.hourHandX, z.hourHandY, (z.radius/15))

				--Updating and drawing Coordinates of minute hand
					z.minuteHandX = (math.sin(thetaAngleForMinutes)*(z.radius*0.60) + z.x)
					z.minuteHandY = (math.cos(thetaAngleForMinutes)*(z.radius*0.60) + z.y)
					love.graphics.setColor(1,0,0)
					love.graphics.line(z.x,z.y, z.minuteHandX,z.minuteHandY)--red line (minutes)
					love.graphics.circle("fill", z.minuteHandX, z.minuteHandY, (z.radius/15))
				
				--Updating and drawing Coordinates of second hand
					z.SecondHandX = (math.sin(thetaAngleForSeconds)*(z.radius*0.75) + z.x)
					z.SecondHandY = (math.cos(thetaAngleForSeconds)*(z.radius*0.75) + z.y)
					love.graphics.setColor(0,0,1)
					love.graphics.line(z.x,z.y, z.SecondHandX,z.SecondHandY)--blue line(seconds)
					love.graphics.circle("fill", z.SecondHandX, z.SecondHandY, (z.radius/15))
		

		--circle in center of clock
		love.graphics.setColor(0.1,0.1,0.1)
		love.graphics.circle("fill", z.x, z.y, (z.radius/20))
		
		--reset color data to default
		love.graphics.setColor(255,255,255)
	end
		
end




--**FUNCTIONS**--

--can calculate the theta handle for each clock hand
function thetaAngleCalculator (currentOSTimeParameter, totalTimescale)
	
	local theta = (currentOSTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi
    --multiplying by (-1) makes the hand tick clockwise
	--adding math.pi fixes the offset and makes the hand start in the right spot

	return theta
    --example: to find the theta angle for the clock's minute hand, we would call thetaAngleCalculator (os.date("%M"), 60)
end

function getThetaAngles()
	
	thetaAngleForHours = thetaAngleCalculator (os.date("%I"), 12)
    thetaAngleForMinutes = thetaAngleCalculator (os.date("%M"), 60)
    thetaAngleForSeconds = thetaAngleCalculator (os.date("%S"), 60)
	

end