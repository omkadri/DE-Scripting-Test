--variables for spawning powerUps
maxTimeBetweenPowerUpSpawn = 2
powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn


shieldTimer = 0
speedTimer = 0


-- keeps track of all powerUp instances
powerUpTracker = {}


--spawns powerUp at XY position with a certain flavor(shield pickup, multishot pickup, health pickup, multishot pickup)
function spawnPowerUp(x, y, flavor)
powerUp = {}
	powerUp.x = x
	powerUp.y = y
	powerUp.flavor = flavor
	powerUp.offsetX = sprites.multishot:getWidth()/2
	powerUp.offsetY = sprites.multishot:getHeight()/2
	table.insert(powerUpTracker, powerUp)
end


--CALLED IN MAIN.LUA
function powerUpUpdate()
	dt = love.timer.getDelta( )

	--ensures limited shield
	if shieldTimer > 0 then
		shieldTimer = shieldTimer - dt
	end
	
	
	--properties of speed powerUp
	if speedTimer > 0 then
		speedTimer = speedTimer - dt
		player.speed = 750
	elseif speedTimer <=0 then
		player.speed = 250
	end
	
	
	--powerUp Spawn Behaviour
	powerUpSpawnTimer = powerUpSpawnTimer - dt
	if powerUpSpawnTimer <= 0 then
		spawnPowerUp(math.random(0, love.graphics:getWidth()), -30, math.random (1,15))
		maxTimeBetweenPowerUpSpawn = maxTimeBetweenPowerUpSpawn * 1.01
		powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn
	end
	
	
	--makes powerUp spawn rates go back and fourth from high to low
	if maxTimeBetweenPowerUpSpawn >= 3.75 then
		maxTimeBetweenPowerUpSpawn = 2.5
	end

	--MAIN POWER UP FOR LOOP
	for i, p in ipairs(powerUpTracker) do
		
		--makes powerUps move downward vertically
		p.y = p.y + math.random(100, 200) * dt
		
			--collision with player
			if distanceBetween(player.x,player.y,p.x,p.y) < 60 then
					--multishot activation
					if p.flavor == 1 then
						multishotActivate = true
						multishotTimer = 10
						currentScore = currentScore + 100 
						powerUpSFX:stop()
						powerUpSFX:play()					
					-- health pickup activation
					elseif p.flavor == 2 then
						healthLength = healthLength + 50
						currentScore = currentScore + 100 
						powerUpSFX:stop()
						powerUpSFX:play()					
					-- shield activation
					elseif p.flavor == 3 then
						invulnerability = true
						invulnerabilityTimer = 10
						shieldTimer = 10
						currentScore = currentScore + 100 
						powerUpSFX:stop()
						powerUpSFX:play()
					--speed activation
					elseif p.flavor == 4 then
						speedTimer = 10
						currentScore = currentScore + 100 
						powerUpSFX:stop()
						powerUpSFX:play()
					end	
				--destroys powerUp instance
				table.remove(powerUpTracker, i)
			end
			
			--destroys off-screen powerUpSFX
			if p.y >= 1100 then
				table.remove(powerUpTracker, i)
			end
	end
	
end

--CALLED IN MAIN.LUA
function powerUpDraw()
	
	--draws every power up instance
	for i,p in ipairs(powerUpTracker) do
			--draws multishot icon
			if p.flavor == 1 then
				love.graphics.draw(sprites.multishot, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
			--draws health pickup icon
			elseif p.flavor == 2 then
				love.graphics.draw(sprites.health, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
			--draws shield icon
			elseif p.flavor == 3 then
				love.graphics.draw(sprites.shieldIcon, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
			--draws speed icon
			elseif p.flavor == 4 then
				love.graphics.draw(sprites.superSpeed, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
			end
	end

	if shieldTimer > 0 then
		love.graphics.draw(sprites.shieldEffect, player.x, player.y, nil, 1, 1,sprites.shieldEffect:getWidth()/2,sprites.shieldEffect:getHeight()/2)
	end
end
	
	