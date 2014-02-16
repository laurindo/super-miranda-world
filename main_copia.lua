-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require( "physics" )
physics.start()

--physics.setDrawMode( "debug" )

local miranda = display.newImageRect( "img/miranda.png", 32, 46 )
miranda.x = 20
miranda.y = 100
miranda.name = "jogador"
physics.addBody( miranda, "dynamic", {bounce=0}  )

local capim = display.newImageRect( "img/capim01.png", 286, 51 )
capim.x = 100
capim.y = display.contentHeight
capim.name = "capim"
physics.addBody( capim, "static", {bounce=0} )

local moverMiranda = function (e)
	if e.phase == "ended" then
		miranda.x = miranda.x + 10
	end
end

local moverMirandaEnterframe = function ()
	miranda.x = miranda.x + 0.1
end

miranda:addEventListener( "touch" , moverMiranda )

local onCollision = function (event)
	if event.object1.name == "jogador" and event.object2.name == "capim" then
		miranda.removeSelf()
		miranda = nil
	end
end

local vai, volta = nil, nil
volta = function ()
	transition.to( miranda, { time=1000, delay=1000, x= 20, onComplete=vai } )	
end

vai = function ()
	transition.to( miranda, { time=1000, delay=1000, x= 200, onComplete=volta } )
end
vai()

--toimer
local timeLimit = 300
timeLeft = display.newText(timeLimit, 160, 20, native.systemFontBold, 14)
timeLeft:setTextColor(255,255,255)

local function timerDown()
	timeLimit = timeLimit-1
	timeLeft.text = timeLimit
	if(timeLimit==0)then
		print("Time Out") -- or do your code for time out
	end
  end
timer.performWithDelay( 100,timerDown,timeLimit )

--Runtime:addEventListener( "collision", onCollision )
--miranda:removeEventListener( "touch", moverMiranda )
--Runtime:addEventListener( "enterFrame" , moverMirandaEnterframe )


