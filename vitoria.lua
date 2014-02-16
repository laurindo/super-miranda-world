module(..., package.seeall)

--====================================================================--
-- SCENE: mainMenu.lua
--====================================================================--

clean = function()
	
end


new = function ( params )

	local localGroup  = display.newGroup()
	local _W = display.contentWidth/2
	local _H = display.contentHeight/2

	local success = audio.loadStream("sounds/success.mp3")
	local successChannel = audio.play( success, { setVolume = 0.35 })

	local container = display.newRect( -45,0, display.contentWidth+90,320 )
	container:setFillColor( 255, 255, 255  )

	local btnStart = display.newText( "Jogar novamente", _W-20, _H, "Arial", 20 )
	btnStart:setTextColor( 0, 0, 0 )

	local btnMenu = display.newText( "Quero o menu principal", _W-20, _H + 30, "Arial", 20 )
	btnMenu:setTextColor( 0, 0, 0 )

	local logomarca = display.newImageRect("img/logomarca.png", 306, 63)
	logomarca.x = _W
	logomarca.y = _H - 100

	--adicionando eventos
	local carregarFase1 = function (event)
		if event.phase == "ended" then
			audio.stop( successChannel )
			director:changeScene(params, "fase1")
		end
	end
	btnStart:addEventListener( "touch", carregarFase1 )

	local carregarMenu = function (event)
		if event.phase == "ended" then
			audio.stop( successChannel )
			director:changeScene(params, "mainMenu")
		end
	end
	btnMenu:addEventListener( "touch", carregarMenu )

	local initVars = function ()
		localGroup:insert(container)
		localGroup:insert(btnStart)
		localGroup:insert(logomarca)
	end
	
	initVars()
	
	return localGroup
	
end

