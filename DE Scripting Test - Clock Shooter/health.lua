dt = love.timer.getDelta( )

healthLength = 200
invulnerability = false
invulnerabilityTimer = 0


function healthUpdate()
	if invulnerabilityTimer > 0 then
		invulnerabilityTimer = invulnerabilityTimer - dt
	end
		
	if invulnerabilityTimer <= 0 then
		invulnerability = false
	end
	
	if healthLength >=200 then
		healthLength = 200
	end
	

end

function drawHealth()
	
	if healthLength >0 then
		love.graphics.setColor(0,1,0)
		love.graphics.rectangle( "fill", 10, 10, healthLength, 15 )
		love.graphics.setColor(255, 255, 255)
		
		--draws forcefield around player when invulnerable
		if invulnerability == true then
			love.graphics.draw(sprites.shieldEffect, player.x, player.y, nil, 0.5, 0.5,sprites.shieldEffect:getWidth()/2,sprites.shieldEffect:getHeight()/2)
		end
	end
		
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