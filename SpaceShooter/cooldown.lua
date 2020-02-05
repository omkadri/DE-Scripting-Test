dt = love.timer.getDelta()

cooldown = {}

	cooldown.overheated = false
	cooldown.length = 0
	
function cooldownUpdate()
	if cooldown.length > 0 then
		cooldown.length = cooldown.length - 40 * dt
	end
	if cooldown.length > 200 then
		cooldown.length = 200
		cooldown.overheated = true
	end
	
	if cooldown.length <= 0 then
		cooldown.overheated = false
	end
end
	
function drawCooldown()
	if cooldown.overheated == true then
		love.graphics.setColor(1,0,0)
		love.graphics.print("OVERHEATED!!!", 10, 50)
		
	elseif cooldown.length < 100 then
		love.graphics.setColor(1,1,0)
	else 
		love.graphics.setColor(1,0.4,0)
	end
	love.graphics.rectangle( "fill", 10, 30, cooldown.length, 15 )
	love.graphics.setColor(255, 255, 255)
	
end