maxTimeBetweenPowerUpSpawn = 2
powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn

powerUpTracker = {}

function spawnPowerUp(x, y, flavor)
powerUp = {}
	powerUp.x = x
	powerUp.y = y
	powerUp.flavor = flavor
	powerUp.offsetX = sprites.multishot:getWidth()/2
	powerUp.offsetY = sprites.multishot:getHeight()/2
	
	table.insert(powerUpTracker, powerUp)
end

function powerUpUpdate()
	dt = love.timer.getDelta()
	
	--powerUp Spawn Initialization
	powerUpSpawnTimer = powerUpSpawnTimer - dt
	if powerUpSpawnTimer <= 0 then
		spawnPowerUp(math.random(0, love.graphics:getWidth()), -30, math.random (1,15))
		powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn
	end

	
	for i, p in ipairs(powerUpTracker) do
		p.y = p.y + math.random(100, 200) * dt
		if distanceBetween(player.x,player.y,p.x,p.y) < 60 then
			if p.flavor == 1 then
				multishotActivate = true
				multishotTimer = 10
				currentScore = currentScore + 100 
				powerUpSFX:play()
			elseif p.flavor == 2 then
				healthLength = healthLength + 100
				currentScore = currentScore + 100 
				powerUpSFX:play()
			elseif p.flavor == 3 then
				invulnerability = true
				invulnerabilityTimer = 10
				currentScore = currentScore + 100 
				powerUpSFX:play()
			end
			p.despawn = true
		end
	end
	
	
	--destroys power up
	for i=#powerUpTracker, 1, -1 do 
		
		local p = powerUpTracker[i]
		
		if p.despawn == true then
			table.remove(powerUpTracker, i) 
		end	
	end
	
end

function powerUpDraw()
	
	for i,p in ipairs(powerUpTracker) do
		if p.flavor == 1 then
			love.graphics.draw(sprites.multishot, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
		elseif p.flavor == 2 then
			love.graphics.draw(sprites.health, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
		elseif p.flavor == 3 then
			love.graphics.draw(sprites.shieldIcon, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
		end
	end
	
end
	
	