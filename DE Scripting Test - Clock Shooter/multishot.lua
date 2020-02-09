--multishot initial configuration
multishotActivate = false
multishotTimer = 0

--tracks all multishot instances
multishotTracker = {}

--contains multishot properties
function spawnmultishot()
		multishot = {}
		
		--left bullet
		multishot.x = player.x
		multishot.y = player.y
		
		--right bullet
		multishot.x2 = player.x
		multishot.y2 = player.y
		multishot.speed = 2000
		
		multishot.direction = playerMouseAngleCalculation()
		
		multishot.offsetX = sprites.bullet:getWidth()/2
		multishot.offsetY = sprites.bullet:getHeight()/2
		
		multishot.despawn = false
		
		bulletSFX:stop()--so we don't have to hear the whole sound before it plays again
		bulletSFX:play()
		
		table.insert(multishotTracker, multishot)
end

--CALLED IN MAIN.LUA
function multishotUpdate()
	dt = love.timer.getDelta( )

	--makes multishot move
	for i, b in ipairs(multishotTracker) do
		--left bullet
		b.x = b.x + math.cos(b.direction + (math.pi/12))  * b.speed * dt
		b.y = b.y + math.sin(b.direction + (math.pi/12))  * b.speed * dt
		--right bullet
		b.x2 = b.x2 + math.cos(b.direction - (math.pi/12)) * b.speed * dt
		b.y2 = b.y2 + math.sin(b.direction - (math.pi/12)) * b.speed * dt
	end


	--destroys multishots
	for i=#multishotTracker,1,-1 do --#multishotTracker returns the total number of elements in multishotTracker	
		local b = multishotTracker[i] --unlike the previous for loops, here we need to specify the value of b.
		
		--for off-screen multishots
		if b.x < -1000 or b.y < -1000 or b.x > (love.graphics.getWidth()+1000) or b.y > (love.graphics.getHeight()+1000) then
			table.remove(multishotTracker, i) --removes any multishot in multishotTracker that meets the if condition
		
		--for multishots that hit enemyClock
		elseif b.despawn == true then
			table.remove(multishotTracker, i) 
			
			
		end	
		
	end
	
	--ensures limited multishot timer
	if multishotTimer >0 then
		multishotTimer = multishotTimer - dt
	end
	
	--turns off multishot
	if multishotTimer <= 0 then
		multishotActivate = false
	end
	
end


--CALLED IN MAIN.LUA
function drawmultishot()

	--draws multishot bullets
	for i,b in ipairs(multishotTracker) do
		--left bullet
		love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5,multishot.offsetX,multishot.offsetY)
		--right bullet
		love.graphics.draw(sprites.bullet, b.x2, b.y2, nil, 0.5, 0.5,multishot.offsetX,multishot.offsetY)
	end
end

