local bigStuff = {
	trailEnabled = {
		dad = false,
		gf = false,
		boyfriend = false
	},
	timerStarted = {
		dad = false,
		gf = false,
		boyfriend = false
	},
	curTrail = {
		dad = 0,
		gf = 0,
		boyfriend = 0
	},

	defaultColor = {
		dad,
		gf,
		boyfriend
	},
	isDefColor = {
		dad = true,
		gf = true,
		boyfriend = true
	},
	color = {
		dad,
		gf,
		boyfriend
	},

	colorSync = {
		dad = false,
		gf = false,
		boyfriend = false
	},
	velocityLooksCool = {
		dad = false,
		gf = false,
		boyfriend = false
	},
	flying = {
		dad = false,
		gf = false,
		boyfriend = false
	}
}

local trailLength = lowQuality and 3 or 5
local trailDelay = lowQuality and 0.5 or 0.05

local gfNote

local strumStuff = {
	opponent = {
		fromGetProperty = 'NOTE_assets',
		noDirectory = 'NOTE_assets'
	},
	player = {
		fromGetProperty = 'NOTE_assets',
		noDirectory = 'NOTE_assets'
	}
}
local colorManagement = {
	opponent = {
		left,
		down,
		up,
		right,
		hasIdle,
		idle,
		state = {
			idle,
			left,
			down,
			up,
			right
		}
	},
	player = {
		left,
		down,
		up,
		right,
		hasIdle,
		idle,
		state = {
			idle,
			left,
			down,
			up,
			right
		}
	}
}

function onUpdatePost()
	if getPropertyFromClass('PlayState', 'chartingMode') then luaDebugMode = true end
	-- local isModDirectory = (getPropertyFromClass('Paths', 'currentModDirectory') ~= '' and getPropertyFromClass('Paths', 'currentModDirectory') .. '/')
	local fileDirectory = 'custom_events/FlxTrail Stuff/'
	
	if flashingLights == false then
		bigStuff.velocityLooksCool.dad = false
		bigStuff.velocityLooksCool.gf = false
		bigStuff.velocityLooksCool.boyfriend = false
	end
	
	bigStuff.defaultColor.dad = rgbToHex(getProperty('dad.healthColorArray'))
	bigStuff.defaultColor.gf = rgbToHex(getProperty('gf.healthColorArray'))
	bigStuff.defaultColor.boyfriend = rgbToHex(getProperty('boyfriend.healthColorArray'))
	
	-- Removed DragShot's stuff as I wanted to not make the script really big (like that's gonna do anything).
	for i = 0, getProperty('opponentStrums.length')-1 do
		strumStuff.opponent.fromGetProperty = getPropertyFromGroup('opponentStrums', i, 'texture')
		strumStuff.opponent.noDirectory = strumStuff.opponent.fromGetProperty:gsub('.+/', '')
	end
	local opponentTxt = readFileLines(fileDirectory .. 'notes/' .. strumStuff.opponent.noDirectory .. '.txt')
	for i = 0, getProperty('playerStrums.length')-1 do
		strumStuff.player.fromGetProperty = getPropertyFromGroup('playerStrums', i, 'texture')
		strumStuff.player.noDirectory = strumStuff.player.fromGetProperty:gsub('.+/', '')
	end
	local playerTxt = readFileLines(fileDirectory .. 'notes/' .. strumStuff.player.noDirectory .. '.txt')

	colorManagement.opponent.left = opponentTxt[1]
	colorManagement.opponent.down = opponentTxt[2]
	colorManagement.opponent.up = opponentTxt[3]
	colorManagement.opponent.right = opponentTxt[4]
	colorManagement.opponent.hasIdle = opponentTxt[5]
	colorManagement.opponent.idle = opponentTxt[6]
	
	if checkFileExists(fileDirectory .. 'notes/' .. strumStuff.opponent.noDirectory .. '.txt', false) == true then
		colorManagement.opponent.state.idle = colorManagement.opponent.idle
		colorManagement.opponent.state.left = colorManagement.opponent.left
		colorManagement.opponent.state.down = colorManagement.opponent.down
		colorManagement.opponent.state.up = colorManagement.opponent.up
		colorManagement.opponent.state.right = colorManagement.opponent.right
	else
		colorManagement.opponent.state.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.dad)
		colorManagement.opponent.state.left = 'c24b99'
		colorManagement.opponent.state.down = '00ffff'
		colorManagement.opponent.state.up = '12fa05'
		colorManagement.opponent.state.right = 'f9393f'
	end

	if colorManagement.opponent.state.idle == 'default' then
		colorManagement.opponent.state.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.dad)
	end
	
	----------------------------------------------------------------------------------------
	
	colorManagement.player.left = playerTxt[1]
	colorManagement.player.down = playerTxt[2]
	colorManagement.player.up = playerTxt[3]
	colorManagement.player.right = playerTxt[4]
	colorManagement.player.hasIdle = toboolean(playerTxt[5])
	colorManagement.player.idle = playerTxt[6]

	if checkFileExists(fileDirectory .. 'notes/' .. strumStuff.player.noDirectory .. '.txt', false) == true then
		colorManagement.player.state.idle = colorManagement.player.idle
		colorManagement.player.state.left = colorManagement.player.left
		colorManagement.player.state.down = colorManagement.player.down
		colorManagement.player.state.up = colorManagement.player.up
		colorManagement.player.state.right = colorManagement.player.right
	else
		colorManagement.player.state.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.boyfriend)
		colorManagement.player.state.left = 'c24b99'
		colorManagement.player.state.down = '00ffff'
		colorManagement.player.state.up = '12fa05'
		colorManagement.player.state.right = 'f9393f'
	end

	if colorManagement.player.state.idle == 'default' then
		colorManagement.player.state.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.boyfriend)
	end

	local dadAnimName = getProperty('dad.animation.curAnim.name')
	local gfAnimName = getProperty('gf.animation.curAnim.name')
	local boyfriendAnimName = getProperty('boyfriend.animation.curAnim.name')

	if colorManagement.opponent.hasIdle == true and bigStuff.colorSync.dad == true then
		if dadAnimName == 'idle' .. getIdleSuffix('dad') or dadAnimName == 'danceLeft' .. getIdleSuffix('dad') or dadAnimName == 'danceRight' .. getIdleSuffix('dad') then
			-- debugPrint('dad')
			triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.idle)
		end
	end

	if (colorManagement.player.hasIdle == true or colorManagement.player.hasIdle == true) and bigStuff.colorSync.gf == true then
		if gfAnimName == 'idle' .. getIdleSuffix('gf') or gfAnimName == 'danceLeft' .. getIdleSuffix('gf') or gfAnimName == 'danceRight' .. getIdleSuffix('gf') then
			-- debugPrint('gf')
			triggerEvent('Change FlxTrail Color', 'gf', (colorManagement.player.state.idle or colorManagement.opponent.state.idle))
		end
	end
	
	if colorManagement.player.hasIdle == true and bigStuff.colorSync.boyfriend == true then
		if boyfriendAnimName == 'idle' .. getIdleSuffix('boyfriend') or boyfriendAnimName == 'danceLeft' .. getIdleSuffix('boyfriend') or boyfriendAnimName == 'danceRight' .. getIdleSuffix('boyfriend') then
			-- debugPrint('boyfriend')
			triggerEvent('Change FlxTrail Color', 'boyfriend', colorManagement.player.state.idle)
		end
	end
	
	if bigStuff.isDefColor.dad == true then
		bigStuff.color.dad = bigStuff.defaultColor.dad
	end
	if bigStuff.isDefColor.gf == true then
		bigStuff.color.gf = bigStuff.defaultColor.gf
	end
	if bigStuff.isDefColor.boyfriend == true then
		bigStuff.color.boyfriend = bigStuff.defaultColor.boyfriend
	end
end

function getIdleSuffix(char)
	if char == 'dad' or char == 'gf' or char == 'boyfriend' then
		return getProperty(char .. '.idleSuffix')
	else
		debugPrint(char .. ' is not a character please try again.')
	end
end

function onCreatePost()

	if strumStuff.opponent.fromGetProperty == '' or strumStuff.opponent.fromGetProperty == nil then
		strumStuff.opponent.noDirectory = 'NOTE_assets'
	end

	if strumStuff.player.fromGetProperty == '' or strumStuff.player.fromGetProperty == nil then
		strumStuff.player.noDirectory = 'NOTE_assets'
	end

	triggerEvent('Change FlxTrail Color', 'dad', 'default')
	triggerEvent('Change FlxTrail Color', 'gf', 'default')
	triggerEvent('Change FlxTrail Color', 'boyfriend', 'default')
end

local noteStuffs = {
	directions = {'left', 'down', 'up', 'right'},
	distance = 100,
	duration = 0.7,
	ease = 'elasticOut'
}
function onEvent(name, value1, value2)
	if name == 'Toggle FlxTrail' then
		-- dad
		if value1 == 'dad' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.dad then
					runTimer('timerTraildad', trailDelay, 0)
					bigStuff.timerStarted.dad = true
				end
				bigStuff.trailEnabled.dad = true
				bigStuff.curTrail.dad = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.dad = false
			end
		end
		
		-- gf
		if value1 == 'gf' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.gf then
					runTimer('timerTrailgf', trailDelay, 0)
					bigStuff.timerStarted.gf = true
				end
				bigStuff.trailEnabled.gf = true
				bigStuff.curTrail.gf = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.gf = false
			end
		end
		
		-- boyfriend
		if value1 == 'boyfriend' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.boyfriend then
					runTimer('timerTrailboyfriend', trailDelay, 0)
					bigStuff.timerStarted.boyfriend = true
				end
				bigStuff.trailEnabled.boyfriend = true
				bigStuff.curTrail.boyfriend = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.boyfriend = false
			end
		end
		
		if value1 == 'all' then
			if value2 == 'on' then
				triggerEvent('Toggle FlxTrail', 'dad', 'on')
				triggerEvent('Toggle FlxTrail', 'gf', 'on')
				triggerEvent('Toggle FlxTrail', 'boyfriend', 'on')
			elseif value2 == 'off' then
				triggerEvent('Toggle FlxTrail', 'dad', 'off')
				triggerEvent('Toggle FlxTrail', 'gf', 'off')
				triggerEvent('Toggle FlxTrail', 'boyfriend', 'off')
			end
		end
	end
	
	if name == 'Toggle FlxTrail Options' then
		local valueContents = {v1 = {}, v2 = {}}
		valueContents.v1 = Split(value1, ',')
		valueContents.v2 = Split(value2, ',')

		-- dad
		if valueContents.v1[1] == 'dad' then
			if valueContents.v1[2] == 'colorsync' then
				if valueContents.v2[1] == 'on' then
					bigStuff.colorSync.dad = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.colorSync.dad = false
				end
			end

			if valueContents.v1[2] == 'blur' then
				if valueContents.v2[1] == 'on' then
					bigStuff.velocityLooksCool.dad = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.velocityLooksCool.dad = false
				end
			end

			if valueContents.v1[2] == 'fly' then
				if valueContents.v2[1] == 'on' then
					bigStuff.flying.dad = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.flying.dad = false
				end
			end
		end
		
		-- gf
		if valueContents.v1[1] == 'gf' then
			if valueContents.v1[2] == 'colorsync' then
				if valueContents.v2[1] == 'on' then
					bigStuff.colorSync.gf = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.colorSync.gf = false
				end
			end

			if valueContents.v1[2] == 'blur' then
				if valueContents.v2[1] == 'on' then
					bigStuff.velocityLooksCool.gf = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.velocityLooksCool.gf = false
				end
			end

			if valueContents.v1[2] == 'fly' then
				if valueContents.v2[1] == 'on' then
					bigStuff.flying.gf = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.flying.gf = false
				end
			end
		end
		
		-- boyfriend
		if valueContents.v1[1] == 'boyfriend' then
			if valueContents.v1[2] == 'colorsync' then
				if valueContents.v2[1] == 'on' then
					bigStuff.colorSync.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.colorSync.boyfriend = false
				end
			end

			if valueContents.v1[2] == 'blur' then
				if valueContents.v2[1] == 'on' then
					bigStuff.velocityLooksCool.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.velocityLooksCool.boyfriend = false
				end
			end

			if valueContents.v1[2] == 'fly' then
				if valueContents.v2[1] == 'on' then
					bigStuff.flying.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.flying.boyfriend = false
				end
			end
		end
		
		if valueContents.v1[1] == 'all' then
			if valueContents.v1[2] == 'colorsync' then
				if valueContents.v2[1] == 'on' then
					bigStuff.colorSync.dad = true
					bigStuff.colorSync.gf = true
					bigStuff.colorSync.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.colorSync.dad = false
					bigStuff.colorSync.gf = false
					bigStuff.colorSync.boyfriend = false
				end
			end

			if valueContents.v1[2] == 'blur' then
				if valueContents.v2[1] == 'on' then
					bigStuff.velocityLooksCool.dad = true
					bigStuff.velocityLooksCool.gf = true
					bigStuff.velocityLooksCool.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.velocityLooksCool.dad = false
					bigStuff.velocityLooksCool.gf = false
					bigStuff.velocityLooksCool.boyfriend = false
				end
			end

			if valueContents.v1[2] == 'fly' then
				if valueContents.v2[1] == 'on' then
					bigStuff.flying.dad = true
					bigStuff.flying.gf = true
					bigStuff.flying.boyfriend = true
				elseif valueContents.v2[1] == 'off' then
					bigStuff.flying.dad = false
					bigStuff.flying.gf = false
					bigStuff.flying.boyfriend = false
				end
			end

			if valueContents.v1[1] == 'config' then
				if valueContents.v1[2] == 'fly' then
					valueContents.v2[3] = noteStuffs.distance
					valueContents.v2[4] = noteStuffs.duration
					valueContents.v2[5] = noteStuffs.ease
				end
			end
		end
	end
	
	if name == 'Change FlxTrail Color' then
		-- dad
		if value1 == 'dad' then
			if value2 == 'default' then
				bigStuff.isDefColor.dad = true
			elseif value2 ~= 'default' then
				bigStuff.isDefColor.dad = false	
			end
		end
		
		-- gf
		if value1 == 'gf' then
			if value2 == 'default' then
				bigStuff.isDefColor.gf = true
			elseif value2 ~= 'default' then
				bigStuff.isDefColor.gf = false	
			end
		end
		
		-- boyfriend
		if value1 == 'boyfriend' then
			if value2 == 'default' then
				bigStuff.isDefColor.boyfriend = true
			elseif value2 ~= 'default' then
				bigStuff.isDefColor.boyfriend = false	
			end
		end
		
		-- Took forever to work properly ong
		if value1 == 'dad' then
			bigStuff.color.dad = value2
		elseif value1 == 'gf' then
			bigStuff.color.gf = value2
		elseif value1 == 'boyfriend' then
			bigStuff.color.boyfriend = value2
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'timerTraildad' then
		createTrailFrame('dad')
	elseif tag == 'timerTrailgf' then
		createTrailFrame('gf')
	elseif tag == 'timerTrailboyfriend' then
		createTrailFrame('boyfriend')
	end
end

local miss = {dad = false, gf = false, boyfriend = false}	
local daThings = {
	num = 0,
	color = 'ffffff',
	image = 'characters/BOYFRIEND',
	frame = 'boyfriend idle dance',
	x = 0,
	y = 0,
	scaleX = 0,
	scaleY = 0,
	scrollX = 0,
	scrollY = 0,
	offsetX = 0,
	offsetY = 0,
	originX = 0,
	originY = 0,
	accelerationX = 0,
	accelerationY = 0,
	flipX = false,
	flipY = false,
	alpha = 0.6,
	visible = true,
	--cameras = 'camGame',
	antialiasing = false
}
function createTrailFrame(tag)
	if bigStuff.color.dad == 'default' then
		bigStuff.color.dad = bigStuff.defaultColor.dad
	end
	if bigStuff.color.gf == 'default' then
		bigStuff.color.gf = bigStuff.defaultColor.gf
	end
	if bigStuff.color.boyfriend == 'default' then
		bigStuff.color.boyfriend = bigStuff.defaultColor.boyfriend
	end
	
	local dadOrder = getObjectOrder('dadGroup')
	local gfOrder = getObjectOrder('gfGroup')
	local boyfriendOrder = getObjectOrder('boyfriendGroup')

	if tag == 'dad' then
		daThings.num = bigStuff.curTrail.dad
		bigStuff.curTrail.dad = bigStuff.curTrail.dad + 1
		if bigStuff.trailEnabled.dad then
			daThings.color = getColorFromHex(bigStuff.color.dad)
			daThings.image = getProperty('dad.imageFile')
			daThings.frame = getProperty('dad.animation.frameName')
			daThings.x = getProperty('dad.x')
			daThings.y = getProperty('dad.y')
			daThings.scaleX = getProperty('dad.scale.x')
			daThings.scaleY = getProperty('dad.scale.y')
			daThings.scrollX = getProperty('dad.scrollFactor.x')
			daThings.scrollY = getProperty('dad.scrollFactor.y')
			daThings.offsetX = getProperty('dad.offset.x')
			daThings.offsetY = getProperty('dad.offset.y')
			daThings.originX = getProperty('dad.origin.x')
			daThings.originY = getProperty('dad.origin.y')
			daThings.accelerationX = getProperty('dad.acceleration.x')
			daThings.accelerationY = getProperty('dad.acceleration.y')
			daThings.flipX = getProperty('dad.flipX')
			daThings.flipY = getProperty('dad.flipY')
			daThings.alpha = getProperty('dad.alpha')
			daThings.visible = getProperty('dad.visible')
			--daThings.cameras = getProperty('dad.cameras[0]')
			daThings.antialiasing = getProperty('dad.antialiasing')
		end
	end

	if tag == 'gf' then
		daThings.num = bigStuff.curTrail.gf
		bigStuff.curTrail.gf = bigStuff.curTrail.gf + 1
		if bigStuff.trailEnabled.gf then
			daThings.color = getColorFromHex(bigStuff.color.gf)
			daThings.image = getProperty('gf.imageFile')
			daThings.frame = getProperty('gf.animation.frameName')
			daThings.x = getProperty('gf.x')
			daThings.y = getProperty('gf.y')
			daThings.scaleX = getProperty('gf.scale.x')
			daThings.scaleY = getProperty('gf.scale.y')
			daThings.scrollX = getProperty('gf.scrollFactor.x')
			daThings.scrollY = getProperty('gf.scrollFactor.y')
			daThings.offsetX = getProperty('gf.offset.x')
			daThings.offsetY = getProperty('gf.offset.y')
			daThings.originX = getProperty('gf.origin.x')
			daThings.originY = getProperty('gf.origin.y')
			daThings.accelerationX = getProperty('gf.acceleration.x')
			daThings.accelerationY = getProperty('gf.acceleration.y')
			daThings.flipX = getProperty('gf.flipX')
			daThings.flipY = getProperty('gf.flipY')
			daThings.alpha = getProperty('gf.alpha')
			daThings.visible = getProperty('gf.visible')
			--daThings.cameras = getProperty('gf.cameras[0]')
			daThings.antialiasing = getProperty('gf.antialiasing')
		end
	end

	if tag == 'boyfriend' then
		daThings.num = bigStuff.curTrail.boyfriend
		bigStuff.curTrail.boyfriend = bigStuff.curTrail.boyfriend + 1
		if bigStuff.trailEnabled.boyfriend then
			daThings.color = getColorFromHex(bigStuff.color.boyfriend)
			daThings.image = getProperty('boyfriend.imageFile')
			daThings.frame = getProperty('boyfriend.animation.frameName')
			daThings.x = getProperty('boyfriend.x')
			daThings.y = getProperty('boyfriend.y')
			daThings.scaleX = getProperty('boyfriend.scale.x')
			daThings.scaleY = getProperty('boyfriend.scale.y') 
			daThings.scrollX = getProperty('boyfriend.scrollFactor.x')
			daThings.scrollY = getProperty('boyfriend.scrollFactor.y')
			daThings.offsetX = getProperty('boyfriend.offset.x')
			daThings.offsetY = getProperty('boyfriend.offset.y')
			daThings.originX = getProperty('boyfriend.origin.x')
			daThings.originY = getProperty('boyfriend.origin.y')
			daThings.accelerationX = getProperty('boyfriend.acceleration.x')
			daThings.accelerationY = getProperty('boyfriend.acceleration.y')
			daThings.flipX = getProperty('boyfriend.flipX')
			daThings.flipY = getProperty('boyfriend.flipY')
			daThings.alpha = getProperty('boyfriend.alpha')
			daThings.visible = getProperty('boyfriend.visible')
			--daThings.cameras = getProperty('boyfriend.cameras[0]')
			daThings.antialiasing = getProperty('boyfriend.antialiasing')
		end
	end
	
	if daThings.num - trailLength + 1 >= 0 then
		for i = (daThings.num - trailLength + 1), (daThings.num - 1) do
			-- if you get a #333 object doesn't exist that's just this. Idk why this is but it hasn't happened again... so you know ig.
			setProperty('psychicTrail' .. tag .. i .. '.alpha', getProperty('psychicTrail' .. tag .. i .. '.alpha') - ((tag == 'boyfriend' and miss.boyfriend == true) and 2 or (tag == 'gf' and miss.gf == true) and 2 or (tag == 'dad' and miss.dad == true) and 2 or trailLength * 0.01))
		end
	end
	removeLuaSprite('psychicTrail' .. tag .. (daThings.num - trailLength), true)
	if not (daThings.image == '') then
		trailTag = {
			TAG = tag,
			name = 'psychicTrail' .. tag,
			full = 'psychicTrail' .. tag .. daThings.num
		}
		local velocityStuffs = (lowQuality and math.random(-50, 50) or math.random(-100, 100))
		makeAnimatedLuaSprite(trailTag.full, daThings.image, daThings.x, daThings.y)
		setProperty(trailTag.full .. '.scale.x', daThings.scaleX)
		setProperty(trailTag.full .. '.scale.y', daThings.scaleY)
		setScrollFactor(trailTag.full, daThings.scrollX, daThings.scrollY)
		setProperty(trailTag.full .. '.offset.x', daThings.offsetX)
		setProperty(trailTag.full .. '.offset.y', daThings.offsetY)
		setProperty(trailTag.full .. '.origin.x', daThings.originX)
		setProperty(trailTag.full .. '.origin.y', daThings.originY)
		setProperty(trailTag.full .. '.acceleration.x', daThings.accelerationX)
		setProperty(trailTag.full .. '.acceleration.y', daThings.accelerationY)
		setProperty(trailTag.full .. '.flipX', daThings.flipX)
		setProperty(trailTag.full .. '.flipY', daThings.flipY)
		setProperty(trailTag.full .. '.alpha', daThings.alpha - 0.4)
		setProperty(trailTag.full .. '.visible', daThings.visible)
		--setObjectCamera(trailTag.full, daThings.cameras)
		setProperty(trailTag.full .. '.antialiasing', daThings.antialiasing)
		setProperty(trailTag.full .. '.color', daThings.color)
		setProperty(trailTag.full .. '.velocity.x', (((tag == 'boyfriend' and bigStuff.velocityLooksCool.boyfriend) and (velocityStuffs or 0)) or ((tag == 'dad' and bigStuff.velocityLooksCool.dad) and (velocityStuffs or 0)) or ((tag == 'gf' and bigStuff.velocityLooksCool.gf) and (velocityStuffs or 0))))
		setProperty(trailTag.full .. '.velocity.y', (((tag == 'boyfriend' and bigStuff.velocityLooksCool.boyfriend) and (velocityStuffs or 0)) or ((tag == 'dad' and bigStuff.velocityLooksCool.dad) and (velocityStuffs or 0)) or ((tag == 'gf' and bigStuff.velocityLooksCool.gf) and (velocityStuffs or 0))))
		setObjectOrder(trailTag.full, ((tag == 'boyfriend' and boyfriendOrder - 0.1) or (tag == 'gf' and gfOrder - 0.1) or (tag == 'dad' and dadOrder - 0.1)))
		setBlendMode(trailTag.full, 'add')
		addAnimationByPrefix(trailTag.full, 'stuff', daThings.frame, 0, false)
		addLuaSprite(trailTag.full, false)
		if getProperty(trailTag.full .. '.alpha') <= (lowQuality and (daThings.alpha - 0.55) or 0) then
			removeLuaSprite(trailTag.full, true)
		end
		if getProperty(trailTag.full .. '.visible') == false then
			removeLuaSprite(trailTag.full, true)
		end
	end
end

-- dad
function opponentNoteHit(id, noteData, noteType, isSustainNote)
	gfNote = getPropertyFromGroup('notes', id, 'gfNote')
	if gfNote == false then
		miss.dad = false
		if bigStuff.colorSync.dad == true then
			if noteData == 0 then
				triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.left)
			elseif noteData == 1 then
				triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.down)
			elseif noteData == 2 then
				triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.up)
			elseif noteData == 3 then
				triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.right)
			end
		end

		if bigStuff.flying.dad == true then
			flyCool('dad', noteData)
		end
	else
		gfNoteHit(id, noteData, noteType, isSustainNote, true , false)
	end
end

function noteMissP2(id, noteData, noteType, isSustainNote)
	gfNote = getPropertyFromGroup('notes', id, 'gfNote')
	if gfNote == false then
		miss.dad = true
	else
		gfNoteHit(id, noteData, noteType, isSustainNote, true, true)
	end
end

-- gf
function gfNoteHit(id, noteData, noteType, isSustainNote, dad, missed)
	miss.gf = missed
	if missed == false then
		if bigStuff.colorSync.gf == true then
			if noteData == 0 then
				triggerEvent('Change FlxTrail Color', 'gf', (dad and colorManagement.opponent.state.left or colorManagement.player.state.left))
			elseif noteData == 1 then
				triggerEvent('Change FlxTrail Color', 'gf', (dad and colorManagement.opponent.state.down or colorManagement.player.state.down))
			elseif noteData == 2 then
				triggerEvent('Change FlxTrail Color', 'gf', (dad and colorManagement.opponent.state.up or colorManagement.player.state.up))
			elseif noteData == 3 then
				triggerEvent('Change FlxTrail Color', 'gf', (dad and colorManagement.opponent.state.right or colorManagement.player.state.right))
			end
		end
		if bigStuff.flying.gf == true then
			flyCool('gf', noteData)
		end
	end
end

-- boyfriend
function goodNoteHit(id, noteData, noteType, isSustainNote)
	gfNote = getPropertyFromGroup('notes', id, 'gfNote')
	if gfNote == false then
		miss.boyfriend = false
		if bigStuff.colorSync.boyfriend == true then
			-- triggerEvent('Change FlxTrail Color', 'boyfriend', _G['colorManagement.player.state.' .. noteStuffs.directions[noteData + 1]])
			if noteData == 0 then
				triggerEvent('Change FlxTrail Color', 'boyfriend', colorManagement.player.state.left)
			elseif noteData == 1 then
				triggerEvent('Change FlxTrail Color', 'boyfriend', colorManagement.player.state.down)
			elseif noteData == 2 then
				triggerEvent('Change FlxTrail Color', 'boyfriend', colorManagement.player.state.up)
			elseif noteData == 3 then
				triggerEvent('Change FlxTrail Color', 'boyfriend', colorManagement.player.state.right)
			end
		end
		
		if bigStuff.flying.boyfriend == true then
			flyCool('boyfriend', noteData)
		end
	else
		gfNoteHit(id, noteData, noteType, isSustainNote, false, false)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	gfNote = getPropertyFromGroup('notes', id, 'gfNote')
	if gfNote == false then
		miss.boyfriend = true
	else
		gfNoteHit(id, noteData, noteType, isSustainNote, false, true)
	end
end

-- Custom Functions
function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
	return string.format("%02x%02x%02x", math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end -- color stuffs not by cherry anymore idr who tho

function readFileLines(directory)
	-- thx super
	local file = getTextFromFile(directory)
	local fLines = {}
	for i in string.gmatch(file, "([^\n]+)") do
		table.insert(fLines, i)
	end
	return fLines
end

function toboolean(str)
	-- maru thx
	local bool = false
	if str == "true" then
		bool = true
	end
	return bool
end

function flyCool(tag, noteData)
	-- For "bigStuff.flying"!
	if noteData == 0 then
		doTweenX('fly' .. tag .. 'left' .. daThings.num, 'psychicTrail' .. tag .. daThings.num, getProperty(tag .. '.x') - noteStuffs.distance, noteStuffs.duration, noteStuffs.ease)
	elseif noteData == 1 then
		doTweenY('fly' .. tag .. 'down' .. daThings.num, 'psychicTrail' .. tag .. daThings.num, getProperty(tag .. '.y') + noteStuffs.distance, noteStuffs.duration, noteStuffs.ease)
	elseif noteData == 2 then
		doTweenY('fly' .. tag .. 'up' .. daThings.num, 'psychicTrail' .. tag .. daThings.num, getProperty(tag .. '.y') - noteStuffs.distance, noteStuffs.duration, noteStuffs.ease)
	elseif noteData == 3 then
		doTweenX('fly' .. tag .. 'right' .. daThings.num, 'psychicTrail' .. tag .. daThings.num, getProperty(tag .. '.x') + noteStuffs.distance, noteStuffs.duration, noteStuffs.ease)
	end
end

function Split(s, delimiter)
	-- cool stuff Unholy
	local result = {}
	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, tostring(match:gsub("^%s*(.-)%s*$", "%1")))
	end
	return result
end