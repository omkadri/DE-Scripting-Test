gameState = 2

function love.load()
	--sets up window
	success = love.window.setMode( 750, 1000)
	love.window.setTitle("Omar Kadri - DE Scripting Test")
	
	-- makes mouse invisible and locks to screen
	love.mouse.setVisible(false)
	grabMouse = love.mouse.setGrabbed(true)


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
	

	--sound
	deathSFX = love.audio.newSource("sfx/death.ogg", "static")
	bulletSFX = love.audio.newSource("sfx/bullet.ogg", "static")
	powerUpSFX = love.audio.newSource("sfx/powerUp.ogg", "static")
	playerHitSFX = love.audio.newSource("sfx/playerHit.ogg", "static")
	cooldownSFX = love.audio.newSource("sfx/cooldown.ogg", "static")
		
	--music
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
	require ('powerUp')
	require ('health')
	require ('canvas')
	
	--Game State Initialization
	currentScore = 0

end

function love.update(dt)
	scrollingBackgroundUpdate()
	
	if gameState == 2 then
		playerUpdate()
		bulletUpdate()
		multishotUpdate()
		enemyClockUpdate()
		powerUpUpdate()
		cooldownUpdate()
		healthUpdate()
	end	
end



function love.draw(dt)
	drawScrollingBackground()
	
	if gameState == 2 then
		powerUpDraw()
		drawEnemyClock()
		drawmultishot()
		drawBullet()
		drawPlayer()
		drawHealth()
		drawCanvas()
	end
	
	if gameState == 3 then
		love.graphics.print("GAME OVER!!!", 250, 445, nil , 3, 3)
		love.graphics.setColor(0, 1, 0)
		love.graphics.print("Final Score: "..currentScore, 250, 490, nil, 3, 3)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print("'ALT' + 'F4' To Quit...", 210, 590, nil, 3, 3)
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

