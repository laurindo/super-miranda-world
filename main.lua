display.setStatusBar( display.HiddenStatusBar )
system.activate("multitouch")

local director = require("director")
local mainGroup = display.newGroup()

local main = function ()

	local physics = require "physics"
	physics.start()

	_W = display.contentWidth
	_H = display.contentHeight
	
	--tm 			= require("classes.transitionManager")
	--timerStash 	= require("classes.timerManager")

	params = {
		actualPhase = 'fase01'
	}
	
	--tm = tm.new()

	mainGroup:insert(director.directorView)

	--director:changeScene(params, "splash")
	director:changeScene(params, "mainMenu")
	
	return true
end

main()

