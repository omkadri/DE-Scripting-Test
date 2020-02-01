enemy1Tracker = {}

function spawnenemy1()
	enemy1 = {}
		enemy1.x = 0
		enemy1.y = 0
		enemy1.speed = 100
		enemy1.offsetX = sprites.enemy1:getWidth()/2
		enemy1.offsetY = sprites.enemy1:getHeight()/2--center enemy1 pivot point
		enemy1.despawn = false

		enemy1.x = math.random(0, love.graphics.getWidth())
		enemy1.y = - 30		
		
		
		table.insert(enemy1Tracker, enemy1)--adds this enemy1 table to the enemy1Tracker table in love.load()
end