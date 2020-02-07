multishotActivate = false
multishotTimer = 0

multishotTracker = {}

function spawnmultishot()
		multishot = {}
		multishot.x = player.x
		multishot.y = player.y
		multishot.x2 = player.x
		multishot.y2 = player.y
		multishot.speed = 2000
		multishot.direction = playerMouseAngleCalculation()--this is conveninet, since we want the multishot going in the direction of the mouse
		multishot.offsetX = sprites.bullet:getWidth()/2
		multishot.offsetY = sprites.bullet:getHeight()/2--center multishot pivot point
		multishot.despawn = false
		
		bulletSFX:stop()--so we don't have to hear the whole sound before it plays again
		bulletSFX:play()
		
		table.insert(multishotTracker, multishot)--adds this multishot table to the enemy1Tracker table in love.load()
end

function multishotUpdate()
	--makes multishot move
	dt = love.timer.getDelta()
	for i, b in ipairs(multishotTracker) do
		b.x = b.x + math.cos(b.direction + (math.pi/12))  * b.speed * dt
		b.y = b.y + math.sin(b.direction + (math.pi/12))  * b.speed * dt
		b.x2 = b.x2 + math.cos(b.direction - (math.pi/12)) * b.speed * dt
		b.y2 = b.y2 + math.sin(b.direction - (math.pi/12)) * b.speed * dt
	end

	--destroys multishots
	for i=#multishotTracker,1,-1 do --#multishotTracker returns the total number of elements in multishotTracker	
		local b = multishotTracker[i] --unlike the previous for loops, here we need to specify the value of b.
		
		--for off-screen multishots
		if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then
			table.remove(multishotTracker, i) --removes any multishot in multishotTracker that meets the if condition
		
		--for multishots that hit Asteroids
		elseif b.despawn == true then
			table.remove(multishotTracker, i) 
			--destroys any multishots that meet the conditions
			
		end	
		
	end
	
	if multishotTimer >0 then
		multishotTimer = multishotTimer - dt
	end
	
	if multishotTimer <= 0 then
		multishotActivate = false
	end
end

function drawmultishot()
	for i,b in ipairs(multishotTracker) do
		love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5,multishot.offsetX,multishot.offsetY)
		love.graphics.draw(sprites.bullet, b.x2, b.y2, nil, 0.5, 0.5,multishot.offsetX,multishot.offsetY)
	end
	
	if multishotActivate == true then
		love.graphics.print("Multishot: "..math.ceil(multishotTimer), 10, 50)
		cooldown.overheated = false
	end
end

