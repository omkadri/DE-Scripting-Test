gameState = 2

function love.load()
	--removes mouse cursor
	love.mouse.setVisible(false)

	--sprite setup
	sprites = {}
		sprites.player = love.graphics.newImage('sprites/player.png')
		sprites.bullet = love.graphics.newImage('sprites/bullet.png')
		sprites.background = love.graphics.newImage('sprites/background.png')
		sprites.reticle = love.graphics.newImage('sprites/reticle.png')
		sprites.multishot = love.graphics.newImage('sprites/multishot.png')
		sprites.shieldIcon = love.graphics.newImage('sprites/shieldIcon.png')
		sprites.superSpeed = love.graphics.newImage('sprites/superSpeed.png')
		sprites.shieldEffect = love.graphics.newImage('sprites/shieldEffect.png')
		sprites.health = love.graphics.newImage('sprites/health.png')
		sprites.damage1 = love.graphics.newImage('sprites/damage1.png')
		sprites.damage2 = love.graphics.newImage('sprites/damage2.png')
		sprites.damage3 = love.graphics.newImage('sprites/damage3.png')
	
	success = love.window.setMode( 750, 900)

	--sound
	deathSFX = love.audio.newSource("sfx/death.ogg", "static")
	bulletSFX = love.audio.newSource("sfx/bullet.ogg", "static")
	powerUpSFX = love.audio.newSource("sfx/powerUp.ogg", "static")
	
	music = love.audio.newSource("sfx/ColdplayClocks8Bit.ogg", "static")
    music:setLooping(true)
    music:play()
	
	--calling external scripts
	require ('bullet')
	require ('enemyClock')
	require ('multishot')
	require ('cooldown')
	require ('player')
	require ('scrollingBackground')
	require ('health')
	require ('powerUp')
	
	

	--Game State Initialization
	currentScore = 0

		
	maxTimeBetweenPowerUpSpawn = 2
	powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn

end

function love.update(dt)
	love.window.setTitle("Omar Kadri - DE Scripting Test")
	grabMouse = love.mouse.setGrabbed(true)
	scrollingBackgroundUpdate()
	
	if gameState == 2 then
		playerUpdate()
		bulletUpdate()
		multishotUpdate()
		enemyClockUpdate()
		powerUpUpdate()
		cooldownUpdate()
		healthUpdate()
		
		powerUpSpawnTimer = powerUpSpawnTimer - dt
		if powerUpSpawnTimer <= 0 then
			spawnPowerUp(math.random(30, love.graphics:getWidth()-30), -30, math.random (1,15))
			powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn
		end
	end	

end



function love.draw(dt)
	drawScrollingBackground()
	love.graphics.print(currentScore, 650, 10, nil, 2, 2)

	
	if gameState == 2 then
		powerUpDraw()
		drawBullet()
		drawPlayer()
		drawEnemyClock()
		drawmultishot()
		drawCooldown()
		drawHealth()
	end
	if gameState == 3 then
		love.graphics.print("GAME OVER!!!", love.graphics:getWidth()/2, love.graphics:getHeight()/2)
	end

	
	--draws reticle
	love.graphics.draw(sprites.reticle, love.mouse.getX(), love.mouse.getY(),nil, nil, nil, sprites.reticle:getWidth()/2, sprites.reticle:getHeight()/2)
end



































--**FUNCTIONS**

--MATH 

--finds theta angle between mouse and player (used for aiming)
function playerMouseAngleCalculation()
	-- uses trig to calculate the angle in which the player is facing the mouse
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end


--calculates distance between to coordinates (used for collision detection)
function distanceBetween(x1,y1,x2,y2)
	--can be used to find the distance between any formula.
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

