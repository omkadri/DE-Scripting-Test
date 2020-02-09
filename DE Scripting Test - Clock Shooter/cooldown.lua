--cooldown properties
cooldown = {}
	cooldown.overheated = false
	cooldown.length = 0
	
	
--called in main.lua
function cooldownUpdate()
	dt = love.timer.getDelta( )

	--lowers cooldown guage
	if cooldown.length > 0 then
		cooldown.length = cooldown.length - 50 * dt
	end
	
	--limits maximum guage length
	if cooldown.length > 200 then
		cooldown.length = 200
		cooldown.overheated = true
	end
	
	--turns off overheating when guage length = 0
	if cooldown.length <= 0 then
		cooldown.overheated = false
	end
end
	
--called in main.lua
function drawCooldown()
	
	--draws OVERHEATED!!! text warning
	if cooldown.overheated == true then
		love.graphics.setColor(1,0,0)
		love.graphics.print("OVERHEATED!!!", 10, 50, nil, 2, 2)
		
	--makes color more red as guage length increases
	elseif cooldown.length < 100 then
		love.graphics.setColor(1,1,0)
	else 
		love.graphics.setColor(1,0.4,0)
	end
	love.graphics.rectangle( "fill", 10, 30, cooldown.length, 15 )
	love.graphics.setColor(255, 255, 255)
	
end