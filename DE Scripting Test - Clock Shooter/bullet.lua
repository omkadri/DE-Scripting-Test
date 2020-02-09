-- keeps track of all bullet instances
bulletTracker = {}

--contains all bullet properties
function spawnBullet()
		bullet = {}
		bullet.x = player.x
		bullet.y = player.y
		bullet.speed = 2000
		bullet.direction = playerMouseAngleCalculation()--this is conveninet, since we want the bullet going in the direction of the mouse
		bullet.offsetX = sprites.bullet:getWidth()/2
		bullet.offsetY = sprites.bullet:getHeight()/2--center bullet pivot point		
		bulletSFX:stop()--so we don't have to hear the whole sound before it plays again
		bulletSFX:play()
		
		table.insert(bulletTracker, bullet)--adds this bullet table to the enemy1Tracker table in love.load()
end


--called in main.lua update function
function bulletUpdate()
	dt = love.timer.getDelta( )

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
		end	
		
	end
	
end


--called in main.lua draw function
function drawBullet()
	for i,b in ipairs(bulletTracker) do
		--draws bullet sprite on every instance
		love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5,bullet.offsetX,bullet.offsetY)
	end
end


