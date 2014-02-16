module(..., package.seeall)

--====================================================================--
-- SCENE: mainMenu.lua
--====================================================================--

clean = function()
	print('cleaned main menu')
end


new = function ( params )

	local localGroup  = display.newGroup()
	local _W = display.contentWidth/2
	local _H = display.contentHeight/2

	local sound = audio.loadStream("sounds/theme.mp3")
	--soundChannel = audio.play( sound, { setVolume = 0.15 })
	--audio.stop( soundChannel )
	
	local container = display.newRect( -45,0, display.contentWidth+90,320 )
	container:setFillColor( 255, 255, 255  )

	local btnStart = display.newText( "Start", _W-50, _H, "Arial", 50 )
	btnStart:setTextColor( 0, 0, 0 )

	local logomarca = display.newImageRect("img/logomarca.png", 306, 63)
	logomarca.x = _W
	logomarca.y = _H - 100

	--adicionando eventos
	local carregarFase1 = function (event)
		if event.phase == "ended" then
			director:changeScene(params, "fase1")
		end
	end
	btnStart:addEventListener( "touch", carregarFase1 )

	local initVars = function ()
		localGroup:insert(container)
		localGroup:insert(btnStart)
		localGroup:insert(logomarca)
	end
	
	initVars()
	
	return localGroup
	
end

