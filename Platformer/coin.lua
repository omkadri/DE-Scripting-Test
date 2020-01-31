coinTracker = {}

function spawnCoin(x, y)
	local coin = {}
		coin.x = x
		coin.y = y
		
		coin.grid = anim8.newGrid(41, 42, 123, 126) --(tileWidth, tileHeight, spritsheetWidth, spritesheetHeight)
		coin.animation = anim8.newAnimation(coin.grid('1-3', 1, '1-3', 2, '1-2', 3), 0.1)
		
		table.insert(coinTracker, coin)
end