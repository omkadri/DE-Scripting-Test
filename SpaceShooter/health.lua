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
	

end

function drawHealth()
	if healthLength >0 then
		love.graphics.setColor(0,1,0)
		love.graphics.rectangle( "fill", 10, 10, healthLength, 15 )
		love.graphics.setColor(255, 255, 255)
	end
end