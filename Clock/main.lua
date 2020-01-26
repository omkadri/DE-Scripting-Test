function love.load()
	--initial clock transform data. This can be changed by using SetClockTansform()
	clockOriginX = 100
	clockOriginY = 100
	clockRadius = 100
end

function love.update(dt)
	--setting clock position and size data
	SetClockTansform(200,200,100)--(xPos, yPos, Radius)
	GetCurrentTimeData()
	
	--trigonometry
	GetThetaAngles()
	GetTerminalEndCoordinates()
end

function love.draw()
	drawClock()
    drawDebugger()
end


-- **FUNCTIONS**

--initialization
function GetCurrentTimeData()
	--creating table for getting time data from OS
    currentTime = {}
		currentTime.fullTime = os.date()
		currentTime.hour = os.date("%I") --based on 12 hour clock
		currentTime.minute = os.date("%M")
		currentTime.second = os.date("%S")
end

function SetClockTansform(x, y, size)
	clockOriginX = x
	clockOriginY = y
	clockRadius = size
end


--trigonometric functions
function thetaAngleCalculator (currentTimeParameter, totalTimescale)
	
	theta = (currentTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi
    --multiplying by (-1) makes the hand tick in the right direction, and adding math.pi makes the hand start at the top

	return theta
    --example: to find the theta angle for the clock's minute hand, we would call thetaAngleCalculator (currentTime.minute, 60)
end

function GetThetaAngles()
	thetaAngleForHours = thetaAngleCalculator (currentTime.hour, 12)
    thetaAngleForMinutes = thetaAngleCalculator (currentTime.minute, 60)
    thetaAngleForSeconds = thetaAngleCalculator (currentTime.second, 60)
end

function GetTerminalEndCoordinates()
    --This function calculates the coordinate data for the terminal ends of each clock hand.

    --Terminal End of hour hand
    terminalEndHourX = (math.sin(thetaAngleForHours)*(clockRadius*0.3) + clockOriginX)
    terminalEndHourY = (math.cos(thetaAngleForHours)*(clockRadius*0.3) + clockOriginY)

    --Terminal End of minute hand
    terminalEndMinuteX = (math.sin(thetaAngleForMinutes)*(clockRadius*0.60) + clockOriginX)
    terminalEndMinuteY = (math.cos(thetaAngleForMinutes)*(clockRadius*0.60) + clockOriginY)
	
	--Terminal End of second hand
    terminalEndSecondX = (math.sin(thetaAngleForSeconds)*(clockRadius*0.75) + clockOriginX)
    terminalEndSecondY = (math.cos(thetaAngleForSeconds)*(clockRadius*0.75) + clockOriginY)
end


--drawing
function drawClock()

	clockFont = love.graphics.newFont(clockRadius / 4, center)

	--clock outline and appearence
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.circle("fill", clockOriginX, clockOriginY, clockRadius)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", clockOriginX, clockOriginY, clockRadius)
    love.graphics.circle("line", clockOriginX, clockOriginY, clockRadius)

	--clock numbers
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(clockFont)
    love.graphics.print("3", (clockOriginX+(clockRadius*0.75)), clockOriginY - 7)
    love.graphics.print("6", clockOriginX - 7, (clockOriginY+(clockRadius*0.75)))
    love.graphics.print("9", (clockOriginX-(clockRadius*0.9)), clockOriginY - 8 )
    love.graphics.print("12", clockOriginX - 11, (clockOriginY-(clockRadius*0.9)))


    --Coordinating each of the hands
		--Seconds Hand
    love.graphics.setColor(0,0,1)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndSecondX,terminalEndSecondY)--blue line(seconds)
    love.graphics.circle("fill", terminalEndSecondX, terminalEndSecondY, 3) --terminalEnd of Hour hand
	
		--Minute Hand
    love.graphics.setColor(1,0,0)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndMinuteX,terminalEndMinuteY)--red line (minutes)
    love.graphics.circle("fill", terminalEndMinuteX, terminalEndMinuteY, 3) --terminalEnd of Hour hand

		--Hour Hand
    love.graphics.setColor(0,1,0)
    love.graphics.line(clockOriginX,clockOriginY, terminalEndHourX,terminalEndHourY)--green line (hours)
    love.graphics.circle("fill", terminalEndHourX, terminalEndHourY, 3) --terminalEnd of Hour hand

    --circle in center of clock
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.circle("fill", clockOriginX, clockOriginY, 5)
end

function drawDebugger()
  if love.keyboard.isDown("i") then
    debuggerX = 250
    debuggerY = 0
    love.graphics.setColor(0,1,0)
    love.graphics.setNewFont(15)
    love.graphics.print("Debug Info:",debuggerX,debuggerY)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Current Date/Time: "..currentTime.fullTime,debuggerX,debuggerY + 50)
    love.graphics.print("Current Hour: "..currentTime.hour,debuggerX,debuggerY + 100)
    love.graphics.print("Current Minute: "..currentTime.minute,debuggerX,debuggerY + 150)
    love.graphics.print("Current Second: "..currentTime.second,debuggerX,debuggerY + 200)
    love.graphics.print("Theta Angle For Hour Hand: "..thetaAngleForHours,debuggerX,debuggerY + 250)
    love.graphics.print("Theta Angle For Minute Hand: "..thetaAngleForMinutes,debuggerX,debuggerY + 300)
    love.graphics.print("Theta Angle For Second Hand: "..thetaAngleForSeconds,debuggerX,debuggerY + 350)
    love.graphics.print("Clock Radius: "..clockRadius,debuggerX,debuggerY + 400)
    love.graphics.print("Terminal End Coordinate for Hour: ("..terminalEndHourX..", "..terminalEndHourY..")",debuggerX,debuggerY + 450)
    love.graphics.print("Terminal End Coordinate for Minute: ("..terminalEndMinuteX..", "..terminalEndMinuteY..")",debuggerX,debuggerY + 500)
    love.graphics.print("Terminal End Coordinate for Second: ("..terminalEndSecondX..", "..terminalEndSecondY..")",debuggerX,debuggerY + 550)
  end
end


--***Written by Omar Kadri***