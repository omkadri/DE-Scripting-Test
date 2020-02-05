powerUpTracker = {}

function spawnPowerUp(x, y)
powerUp = {}
	powerUp.x = x
	powerUp.y = y
	powerUp.type = 1
	powerUp.offsetX = sprites.multishot:getWidth()/2
	powerUp.offsetY = sprites.multishot:getHeight()/2
	
	table.insert(powerUpTracker, powerUp)
end





function powerUpUpdate()
	dt = love.timer.getDelta()
	for i, p in ipairs(powerUpTracker) do
		p.y = p.y + 100 * dt
		if distanceBetween(player.x,player.y,p.x,p.y) < 60 then
			multishotActivate = true
			multishotTimer = 10
			deathSFX:play()
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
		love.graphics.draw(sprites.multishot, p.x, p.y, nil, 0.5, 0.5,powerUp.offsetX,powerUp.offsetY)
	end
end


-- 

-- colllsion with player
	-- set multishot to true
	-- set multishot timer to 10

-- draw
	-- 
	
	
	