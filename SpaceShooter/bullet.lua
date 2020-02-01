bulletTracker = {}

function spawnBullet()
		bullet = {}
		bullet.x = player.x
		bullet.y = player.y
		bullet.speed = 2000
		bullet.direction = playerMouseAngleCalculation()--this is conveninet, since we want the bullet going in the direction of the mouse
		bullet.offsetX = sprites.bullet:getWidth()/2
		bullet.offsetY = sprites.bullet:getHeight()/2--center bullet pivot point
		bullet.despawn = false
		
		bulletSFX:stop()--so we don't have to hear the whole sound before it plays again
		bulletSFX:play()
		
		table.insert(bulletTracker, bullet)--adds this bullet table to the enemy1Tracker table in love.load()
end