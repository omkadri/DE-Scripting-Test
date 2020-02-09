--initializes current health status
healthLength = 200
invulnerability = false
invulnerabilityTimer = 0

--called in main.lua
function healthUpdate()
	dt = love.timer.getDelta( )

	
	--ensures limited invulnerability
	if invulnerabilityTimer > 0 then
		invulnerabilityTimer = invulnerabilityTimer - dt
	end
	if invulnerabilityTimer <= 0 then
		invulnerability = false
	end
	
	--health cannot exceed 200
	if healthLength >=200 then
		healthLength = 200
	end
	
	--causes game over because player is dead
	if healthLength <=0 then
		gameState =3
	end
end

--called in main.lua
function drawHealth()
			--draws wear-and-tear damage sprites on player (based on current health)
			if healthLength ==150 then
				love.graphics.draw(sprites.damage1, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)
			end
			if healthLength ==100 then
				love.graphics.draw(sprites.damage2, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)
			end
			if healthLength ==50 then
				love.graphics.draw(sprites.damage3, player.x, player.y, playerMouseAngleCalculation(), nil, nil, player.offsetX, player.offsetY)
			end
end