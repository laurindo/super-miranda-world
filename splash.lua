module(..., package.seeall)

--====================================================================--
-- SCENE: SPLASH
--====================================================================--

clean = function()
	print('cleaned main menu')
end


new = function ( params )

	local localGroup  = display.newGroup()
	local throwBrickTimer = nil
	local menu = display.newImageRect( "img/splash.png", 610, 340 )
	menu:setReferencePoint( display.CenterReferencePoint )
	menu.x = display.contentCenterX-20
	menu.y = display.contentCenterY

	local initVars = function ()
		
		localGroup:insert( menu )
		
		local loadingMainMenu = function () 
			--timer.cancel(throwBrickTimer)
			director:changeScene(params, "mainMenu")
		end
		--timerStash:add(3000, loadingMainMenu, 1)
		throwBrickTimer = timer.performWithDelay( 3000, loadingMainMenu, 1 )
		
	end
	
	initVars()
	
	return localGroup
	
end

