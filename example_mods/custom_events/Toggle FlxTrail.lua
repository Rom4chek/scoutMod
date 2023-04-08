local bigStuff = {
	trailEnabled = {
		dad = false,
		gf = false,
		bf = false
	},
	timerStarted = {
		dad = false,
		gf = false,
		bf = false
	},
	curTrail = {
		dad = 0,
		gf = 0,
		bf = 0
	},
	defaultColor = {
		dad,
		gf,
		bf
	},
	color = {
		dad,
		gf,
		bf
	},
	
	isDefColor = {
		dad = true,
		gf = true,
		bf = true
	},
	colorSync = {
		dad = false,
		gf = false,
		bf = false
	},
	midfightmass = false
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
	
	if flashingLights == false then bigStuff.midfightmass = false end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		gfNote = getPropertyFromGroup('unspawnNotes', i, 'gfNote')
	end
	
	bigStuff.defaultColor.dad = rgbToHex(getProperty('dad.healthColorArray'))
	bigStuff.defaultColor.bf = rgbToHex(getProperty('boyfriend.healthColorArray'))
	bigStuff.defaultColor.gf = rgbToHex(getProperty('gf.healthColorArray'))
	
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
	colorManagement.opponent.hasIdle = toboolean(opponentTxt[5])
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

	if colorManagement.opponent.idle == 'default' then
		colorManagement.opponent.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.dad)
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
		colorManagement.player.state.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.bf)
		colorManagement.player.state.left = 'c24b99'
		colorManagement.player.state.down = '00ffff'
		colorManagement.player.state.up = '12fa05'
		colorManagement.player.state.right = 'f9393f'
	end

	if colorManagement.player.idle == 'default' then
		colorManagement.player.idle = (gfNote == true and bigStuff.defaultColor.gf or bigStuff.defaultColor.bf)
	end

	local dadAnimName = getProperty('dad.animation.curAnim.name')
	local gfAnimName = getProperty('gf.animation.curAnim.name')
	local bfAnimName = getProperty('boyfriend.animation.curAnim.name')

	if colorManagement.opponent.hasIdle == true and bigStuff.colorSync.dad == true then
		if dadAnimName == 'idle' .. getIdleSuffix('dad') or dadAnimName == 'danceLeft' .. getIdleSuffix('dad') or dadAnimName == 'danceRight' .. getIdleSuffix('dad') then
			-- debugPrint('dad')
			triggerEvent('Change FlxTrail Color', 'dad', colorManagement.opponent.state.idle)
		end
	end

	if (colorManagement.player.hasIdle == true or colorManagement.opponent.hasIdle == true) and bigStuff.colorSync.gf == true then
		if gfAnimName == 'idle' .. getIdleSuffix('gf') or gfAnimName == 'danceLeft' .. getIdleSuffix('gf') or gfAnimName == 'danceRight' .. getIdleSuffix('gf') then
			-- debugPrint('gf')
			triggerEvent('Change FlxTrail Color', 'gf', (colorManagement.player.state.idle or colorManagement.opponent.state.idle))
		end
	end
	
	if colorManagement.player.hasIdle == true and bigStuff.colorSync.bf == true then
		if bfAnimName == 'idle' .. getIdleSuffix('boyfriend') or bfAnimName == 'danceLeft' .. getIdleSuffix('boyfriend') or bfAnimName == 'danceRight' .. getIdleSuffix('boyfriend') then
			-- debugPrint('bf')
			triggerEvent('Change FlxTrail Color', 'bf', colorManagement.player.state.idle)
		end
	end
	
	if bigStuff.isDefColor.dad == true then
		bigStuff.color.dad = bigStuff.defaultColor.dad
	end
	if bigStuff.isDefColor.gf == true then
		bigStuff.color.gf = bigStuff.defaultColor.gf
	end
	if bigStuff.isDefColor.bf == true then
		bigStuff.color.bf = bigStuff.defaultColor.bf
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
	triggerEvent('Change FlxTrail Color', 'bf', 'default')
end

function onEvent(name, value1, value2)
	
	if name == 'Toggle FlxTrail' then
		
		-- Dad
		if value1 == 'dad' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.dad then
					runTimer('timerTrailDad', trailDelay, 0)
					bigStuff.timerStarted.dad = true
				end
				bigStuff.trailEnabled.dad = true
				bigStuff.curTrail.dad = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.dad = false
			end
		end
		
		-- GF
		if value1 == 'gf' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.gf then
					runTimer('timerTrailGF', trailDelay, 0)
					bigStuff.timerStarted.gf = true
				end
				bigStuff.trailEnabled.gf = true
				bigStuff.curTrail.gf = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.gf = false
			end
		end
		
		-- BF
		if value1 == 'bf' then
			if value2 == 'on' then
				if not bigStuff.timerStarted.bf then
					runTimer('timerTrailBF', trailDelay, 0)
					bigStuff.timerStarted.bf = true
				end
				bigStuff.trailEnabled.bf = true
				bigStuff.curTrail.bf = 0
			elseif value2 == 'off' then
				bigStuff.trailEnabled.bf = false
			end
		end
		
		if value1 == 'all' then
			if value2 == 'on' then
				triggerEvent('Toggle FlxTrail', 'dad', 'on')
				triggerEvent('Toggle FlxTrail', 'gf', 'on')
				triggerEvent('Toggle FlxTrail', 'bf', 'on')
			elseif value2 == 'off' then
				triggerEvent('Toggle FlxTrail', 'dad', 'off')
				triggerEvent('Toggle FlxTrail', 'gf', 'off')
				triggerEvent('Toggle FlxTrail', 'bf', 'off')
			end
		end
		
	end
	
	if name == 'Toggle FlxTrail Options' then
		
		-- Dad
		if value1 == 'dad' then
			if value2 == 'colorsync on' then
				bigStuff.colorSync.dad = true
			elseif value2 == 'colorsync off' then
				bigStuff.colorSync.dad = false
			end
		end
		
		-- GF
		if value1 == 'gf' then
			if value2 == 'colorsync on' then
				bigStuff.colorSync.gf = true
			elseif value2 == 'colorsync off' then
				bigStuff.colorSync.gf = false
			end
		end
		
		-- BF
		if value1 == 'bf' then
			if value2 == 'colorsync on' then
				bigStuff.colorSync.bf = true
			elseif value2 == 'colorsync off' then
				bigStuff.colorSync.bf = false
			end
		end
		
		if value1 == 'all' then
			if value2 == 'colorsync on' then
				bigStuff.colorSync.dad = true
				bigStuff.colorSync.gf = true
				bigStuff.colorSync.bf = true
			elseif value2 == 'colorsync off' then
				bigStuff.colorSync.dad = false
				bigStuff.colorSync.gf = false
				bigStuff.colorSync.bf = false
			end
			
			if value2 == 'blur on' then
				bigStuff.midfightmass = true
			elseif value2 == 'blur off' then
				bigStuff.midfightmass = false
			end
		end
		
	end
	
	if name == 'Change FlxTrail Color' then
		
		-- Dad
		if value1 == 'dad' and value2 == 'default' then
			bigStuff.isDefColor.dad = true
		elseif value1 == 'dad' and value2 ~= 'default' then
			bigStuff.isDefColor.dad = false
			
			-- GF
		elseif value1 == 'gf' and value2 == 'default' then
			bigStuff.isDefColor.gf = true
		elseif value1 == 'gf' and value2 ~= 'default' then
			bigStuff.isDefColor.gf = false
			
			-- BF
		elseif value1 == 'bf' and value2 == 'default' then
			bigStuff.isDefColor.bf = true
		elseif value1 == 'bf' and value2 ~= 'default' then
			bigStuff.isDefColor.bf = false
		end
		
		-- Took forever to work properly
		if value1 == 'dad' then
			bigStuff.color.dad = value2
		elseif value1 == 'gf' then
			bigStuff.color.gf = value2
		elseif value1 == 'bf' then
			bigStuff.color.bf = value2
		end
		
	end
	
end

function onSongEnd()
	triggerEvent('Toggle FlxTrail', 'all', 'off')
	return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'timerTrailDad' then
		createTrailFrame('Dad')
	elseif tag == 'timerTrailGF' then
		createTrailFrame('GF')
	elseif tag == 'timerTrailBF' then
		createTrailFrame('BF')
	end
end

local miss = {bf = false, gf = false, dad = false}
local daThings = {
	num = 0,
	color = 'ffffff',
	image = 'characters/BOYFRIEND',
	frame = 'BF idle dance',
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
	elseif bigStuff.color.gf == 'default' then
		bigStuff.color.gf = bigStuff.defaultColor.gf
	elseif bigStuff.color.bf == 'default' then
		bigStuff.color.bf = bigStuff.defaultColor.bf
	end
	
	local bfOrder = getObjectOrder('boyfriendGroup')
	local gfOrder = getObjectOrder('gfGroup')
	local dadOrder = getObjectOrder('dadGroup')
	if tag == 'BF' then
		daThings.num = bigStuff.curTrail.bf
		bigStuff.curTrail.bf = bigStuff.curTrail.bf + 1
		if bigStuff.trailEnabled.bf then
			-- setObjectOrder('psychicTrail', bfOrder)
			daThings.color = getColorFromHex(bigStuff.color.bf)
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
	elseif tag == 'GF' then
		daThings.num = bigStuff.curTrail.gf
		bigStuff.curTrail.gf = bigStuff.curTrail.gf + 1
		if bigStuff.trailEnabled.gf then
			-- setObjectOrder('psychicTrail', gfOrder)
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
	elseif tag == 'Dad' then
		daThings.num = bigStuff.curTrail.dad
		bigStuff.curTrail.dad = bigStuff.curTrail.dad + 1
		if bigStuff.trailEnabled.dad then
			-- setObjectOrder('psychicTrail', dadOrder)
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
	
	if daThings.num - trailLength + 1 >= 0 then
		for i = (daThings.num - trailLength + 1), (daThings.num - 1) do
			setProperty('psychicTrail' .. tag .. i .. '.alpha', getProperty('psychicTrail' .. tag .. i .. '.alpha') - ((tag == 'BF' and miss.bf == true) and 2 or (tag == 'GF' and miss.gf == true) or (tag == 'Dad' and miss.dad == true) or trailLength * 0.01))
		end
	end
	removeLuaSprite('psychicTrail' .. tag .. (daThings.num - trailLength))
	if not (daThings.image == '') then
		local trailTag = 'psychicTrail' .. tag .. daThings.num
		makeAnimatedLuaSprite(trailTag, daThings.image, daThings.x, daThings.y)
		setProperty(trailTag .. '.scale.x', daThings.scaleX)
		setProperty(trailTag .. '.scale.y', daThings.scaleY)
		setScrollFactor(trailTag, daThings.scrollX, daThings.scrollY)
		setProperty(trailTag .. '.offset.x', daThings.offsetX)
		setProperty(trailTag .. '.offset.y', daThings.offsetY)
		setProperty(trailTag .. '.origin.x', daThings.originX)
		setProperty(trailTag .. '.origin.y', daThings.originY)
		setProperty(trailTag .. '.acceleration.x', daThings.accelerationX)
		setProperty(trailTag .. '.acceleration.y', daThings.accelerationY)
		setProperty(trailTag .. '.flipX', daThings.flipX)
		setProperty(trailTag .. '.flipY', daThings.flipY)
		setProperty(trailTag .. '.alpha', daThings.alpha - 0.4)
		setProperty(trailTag .. '.visible', daThings.visible)
		--setObjectCamera(trailTag, daThings.cameras)
		setProperty(trailTag .. '.antialiasing', daThings.antialiasing)
		setProperty(trailTag .. '.color', daThings.color)
		setProperty(trailTag .. '.velocity.x', (bigStuff.midfightmass and (lowQuality and math.random(-50, 50) or math.random(-100, 100)) or 0))
		setProperty(trailTag .. '.velocity.y', (bigStuff.midfightmass and (lowQuality and math.random(-50, 50) or math.random(-100, 100)) or 0))
		setObjectOrder(trailTag, ((tag == 'BF' and bfOrder - 0.1) or (tag == 'GF' and gfOrder - 0.1) or (tag == 'Dad' and dadOrder - 0.1)))
		setBlendMode(trailTag, 'add')
		addAnimationByPrefix(trailTag, 'stuff', daThings.frame, 0, false)
		addLuaSprite(trailTag, false)
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	miss.bf = false
	if bigStuff.colorSync.bf == true then
		if noteData == 0 then
			triggerEvent('Change FlxTrail Color', 'bf', colorManagement.player.state.left)
		elseif noteData == 1 then
			triggerEvent('Change FlxTrail Color', 'bf', colorManagement.player.state.down)
		elseif noteData == 2 then
			triggerEvent('Change FlxTrail Color', 'bf', colorManagement.player.state.up)
		elseif noteData == 3 then
			triggerEvent('Change FlxTrail Color', 'bf', colorManagement.player.state.right)
		end
	end
	gfNoteHit(id, noteData, noteType, isSustainNote, false, false)
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
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
	gfNoteHit(id, noteData, noteType, isSustainNote, true , false)
end

function noteMiss(id, noteData, noteType, isSustainNote)
	miss.bf = true
	gfNoteHit(id, noteData, noteType, isSustainNote, false, true)
end

function noteMissP2(id, noteData, noteType, isSustainNote)
	miss.dad = true
	gfNoteHit(id, noteData, noteType, isSustainNote, true, true)
end

function gfNoteHit(id, noteData, noteType, isSustainNote, opponent, missed)
	if gfNote == true then
		miss.gf = false
		if bigStuff.colorSync.gf == true then
			if noteData == 0 then
				triggerEvent('Change FlxTrail Color', 'gf', (opponent and colorManagement.opponent.state.left or colorManagement.player.state.left))
			elseif noteData == 1 then
				triggerEvent('Change FlxTrail Color', 'gf', (opponent and colorManagement.opponent.state.down or colorManagement.player.state.down))
			elseif noteData == 2 then
				triggerEvent('Change FlxTrail Color', 'gf', (opponent and colorManagement.opponent.state.up or colorManagement.player.state.up))
			elseif noteData == 3 then
				triggerEvent('Change FlxTrail Color', 'gf', (opponent and colorManagement.opponent.state.right or colorManagement.player.state.right))
			end
		end
		if missed then
			miss.gf = true
		end
	end
end

-- Custom Functions
function rgbToHex(rgb) --https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
	return string.format("%02x%02x%02x", math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end -- color stuffs not by cherry anymore idr who tho

-- thx super
function readFileLines(directory)
	local file = getTextFromFile(directory)
	local fLines = {}
	for i in string.gmatch(file, "([^\n]+)") do
		table.insert(fLines, i)
	end
	return fLines
end

function toboolean(str)
	local bool = false
	if str == 'true' then
		bool = true
	end
	return bool
end

-- Currently Unused
function Split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, tostring(match))
	end
	return result
end