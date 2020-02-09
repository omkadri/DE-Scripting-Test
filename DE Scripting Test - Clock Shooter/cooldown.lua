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
	
	--overheating sound 
	if cooldown.overheated == true then
		cooldownSFX:setLooping(true)
		cooldownSFX:play()
	else 
		cooldownSFX:stop()
	end	
end