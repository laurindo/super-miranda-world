module(..., package.seeall)

--====================================================================--
-- SCENE: FASE 01
--====================================================================--

clean = function()
	Runtime._functionListeners = nil
end


new = function ( params )

	local localGroup  = display.newGroup()
	local mirandaNaoVoe = false

	--physics.setDrawMode( "debug" )

	local cenario = display.newImageRect( "img/nuvens.png", 610, 320 )
	cenario.x = 200
	cenario.y = 200

	local limiteDireito = display.newRect( _W, 0, 1, 500)
	limiteDireito:setFillColor( 0,0,0,0 )
	physics.addBody( limiteDireito, "static" )
	
	local limiteEsquerdo = display.newRect( -20, 0, 1, 500)
	limiteEsquerdo:setFillColor( 0,0,0,0 )
	physics.addBody( limiteEsquerdo, "static" )

	local miranda = display.newImageRect( "img/miranda.png", 32, 46 )
	miranda.x = 0
	miranda.y = _H - 50
	physics.addBody( miranda, "dynamic", { bounce=0.2 } )
	miranda.isFixedRotation = true
	miranda.name = "miranda"

	local capim = display.newImageRect( "img/capim01.png", 286, 51 )
	capim.x = 100
	capim.y = _H
	physics.addBody( capim, "static", { bounce=0 } )

	local capim02 = display.newImageRect( "img/capim01.png", 286, 51 )
	capim02.x = _W-15
	capim02.y = _H
	physics.addBody( capim02, "static", { bounce=0 } )

	local cano = display.newImageRect( "img/cano.png", 66, 81 )
	cano.x = 80
	cano.y = _H - 65
	physics.addBody( cano, "static", { bounce=0 } )

	local flor = display.newImageRect( "img/flor.png", 34, 35 )
	flor.x = 80
	flor.y = _H - 65
	physics.addBody( flor, "static", { bounce = 0, radius = 20 } )
	flor.name = "flor"

	local chegada = display.newImageRect( "img/chegada.png", 39, 29 )
	chegada.x = _W- 50
	chegada.y = _H - 40
	physics.addBody( chegada, "static", { bounce=0 } )
	chegada.name = "chegada"

	--listeners
	local vai, volta = nil, nil
	local yStart  = _H - 95
	local xFinish = _H - 200
	volta = function ()
		transition.to( flor, {time=2000, delay=0, y = yStart, onComplete = vai, transition=easing.inQuad} )
	end
	vai = function ()
		transition.to( flor, {time=2000, delay=1000, y = xFinish, onComplete = volta, transition=easing.inCubic} )
	end
	vai()

	local moverMiranda = function ()
		if miranda ~= nil then
			miranda.x = miranda.x + 2.2
			if miranda.y > _H then
				local perdeu = display.newText("Voce perdeu", 150, 100, "Arial", 30 )
				miranda:removeSelf()
				miranda = nil
				Runtime._functionListeners = nil
			end
		end
		
	end
	Runtime:addEventListener( "enterFrame", moverMiranda )

	local btnTouch = display.newRect( -45,0, display.contentWidth+90,_H )
	btnTouch:setFillColor( 255, 255, 255, 0  )
	local pularMiranda = function ( event )
		if event.phase == "began" and mirandaNaoVoe == false then
			vx,vy = miranda:getLinearVelocity()
			mirandaNaoVoe = true
			miranda:setLinearVelocity( 0, -230 )
		end
	end
	btnTouch:addEventListener ( "touch", pularMiranda )

	--collision
	local lose, success = {}, {}
	local onColission = function ( event )
		
		if event.object1.name == "miranda" and event.object2.name == "flor" then
			lose = audio.loadStream("sounds/lose.mp3")
			loseChannel = audio.play( lose, { setVolume = 0.35 })
			Runtime._functionListeners = nil
			btnTouch:removeEventListener( "touch", pularMiranda )
			miranda:removeSelf()
			miranda = nil
		end

		if event.object1.name == "miranda" and event.object2.name == "chegada" then
			
			local ganhou = display.newText("Voce ganhou", 150, 50, "Arial", 30)

			local cenaVoceGanhou = function ()
				director:changeScene ( params, "vitoria")
			end
			timer.performWithDelay( 1, cenaVoceGanhou, 1 )
		end

		if event.object2.name == 'miranda' or event.object1.name == 'miranda' then
			mirandaNaoVoe = false
		end

	end
	Runtime:addEventListener( "collision", onColission )

	localGroup:insert( cenario )
	localGroup:insert( capim )
	localGroup:insert( capim02 )
	localGroup:insert( flor )
	localGroup:insert( cano )
	localGroup:insert( miranda )
	localGroup:insert( btnTouch )

	return localGroup
	
end

