local isHudAboveNotes = false -- Is Hud Above Notes? -- false // true
local forcePixel = false -- You Want Force Pixel Hud? -- false // true

local hudAlpha = 0.9 -- Hud Alpha -- from 0 to 1

function onCreatePost()
	opponentHealth = 50
	bluStreak = 0
	isBfStopedSinging = true
	canShowStreak = true
	if stringStartsWith(getProperty('boyfriend.curCharacter'), 'bf') then
		bfName = 'Boyfriend'
	else
		bfName = 'Player Two'
	end
	setProperty('healthBarBG.visible', false)
	setProperty('healthBar.visible', false)
	--setProperty('timeTxt.visible', false)
	
	--opponent hud
	makeLuaSprite('RedTeamBG', 'hud/panel_scalable', -60, 560)
	setObjectCamera('RedTeamBG', 'hud')
	setProperty('RedTeamBG.alpha', hudAlpha)
	scaleObject('RedTeamBG', 0.4, 0.4)
	
	if downscroll and not middlescroll then
		setProperty('RedTeamBG.y', 0)
	end
	
	makeLuaSprite('RedTeamOutl', 'hud/panel_scalable_outline', getProperty('RedTeamBG.x'),getProperty('RedTeamBG.y'))
	setObjectCamera('RedTeamOutl', 'hud')
	scaleObject('RedTeamOutl', 0.4, 0.4)
	
	makeLuaSprite('RedHealthBG', 'hud/health_bg', getProperty('RedTeamBG.x') + 220, getProperty('RedTeamBG.y') - 40)
	setObjectCamera('RedHealthBG', 'hud')
	scaleObject('RedHealthBG', 1.2, 1.2)
	
	if downscroll and not middlescroll then
		setProperty('RedHealthBG.y', getProperty('RedTeamBG.y') + 20)
	end
	
	makeLuaSprite('RedOverHealth', 'hud/health_over_bg', getProperty('RedHealthBG.x') + 13, getProperty('RedHealthBG.y') + 13)
	setObjectCamera('RedOverHealth', 'hud')
	setProperty('RedOverHealth.origin.x', 64)
	setProperty('RedOverHealth.origin.y', 64)
	setProperty('RedOverHealth.visible', false)
	setProperty('RedOverHealth.scale.x', getProperty('RedHealthBG.scale.x'))
	setProperty('RedOverHealth.scale.y', getProperty('RedHealthBG.scale.y'))
	
	makeLuaSprite('RedHealthA', 'hud/health_color', getProperty('RedHealthBG.x') + 6, getProperty('RedHealthBG.y') + 6)
	setObjectCamera('RedHealthA', 'hud')
	setProperty('RedHealthA.angle', 180)
	scaleObject('RedHealthA', getProperty('RedHealthBG.scale.x') - 0.1, getProperty('RedHealthBG.scale.y') - 0.1)
	
	makeLuaText('RedHealthTexto', opponentHealth, 128, getProperty('RedOverHealth.x'), getProperty('RedOverHealth.y') + 42)
	setTextSize('RedHealthTexto', 48)
	setTextBorder('RedHealthTexto', 0)
	setTextColor('RedHealthTexto', '8f8068')
	
	--boyfriend hud
	makeLuaSprite('BluTeamBG', 'hud/panel_scalable', 1010, 560)
	setObjectCamera('BluTeamBG', 'hud')
	setProperty('BluTeamBG.flipX', true)
	setProperty('BluTeamBG.alpha', hudAlpha)
	scaleObject('BluTeamBG', 0.4, 0.4)
	
	if downscroll and not middlescroll then
		setProperty('BluTeamBG.y', 0)
	end
	
	makeLuaSprite('BluTeamOutl', 'hud/panel_scalable_outline', getProperty('BluTeamBG.x'),getProperty('BluTeamBG.y'))
	setObjectCamera('BluTeamOutl', 'hud')
	setProperty('BluTeamOutl.flipX', true)
	scaleObject('BluTeamOutl', 0.4, 0.4)
	
	makeLuaSprite('BluHealthBG', 'hud/health_bg', getProperty('BluTeamBG.x') - 60, getProperty('BluTeamBG.y') - 40)
	setObjectCamera('BluHealthBG', 'hud')
	scaleObject('BluHealthBG', 1.2, 1.2)
	
	if downscroll and not middlescroll then
		setProperty('BluHealthBG.y', getProperty('BluTeamBG.y') + 20)
	end
	
	makeLuaSprite('BluOverHealth', 'hud/health_over_bg', getProperty('BluHealthBG.x') + 13, getProperty('BluHealthBG.y') + 13)
	setObjectCamera('BluOverHealth', 'hud')
	setProperty('BluOverHealth.origin.x', 64)
	setProperty('BluOverHealth.origin.y', 64)
	setProperty('BluOverHealth.visible', false)
	setProperty('BluOverHealth.scale.x', getProperty('BluHealthBG.scale.x'))
	setProperty('BluOverHealth.scale.y', getProperty('BluHealthBG.scale.y'))
	
	makeLuaSprite('BluHealthA', 'hud/health_color', getProperty('BluHealthBG.x') + 6, getProperty('BluHealthBG.y') + 6)
	setObjectCamera('BluHealthA', 'hud')
	setProperty('BluHealthA.angle', 180)
	scaleObject('BluHealthA', getProperty('BluHealthBG.scale.x') - 0.1, getProperty('BluHealthBG.scale.y') - 0.1)
	
	makeLuaText('BluHealthTexto', realHealth, 128, getProperty('BluOverHealth.x'), getProperty('BluOverHealth.y') + 42)
	setTextSize('BluHealthTexto', 48)
	setTextBorder('BluHealthTexto', 0)
	setTextColor('BluHealthTexto', '8f8068')
	
	addLuaSprite('RedTeamBG', isHudAboveNotes)
	addLuaSprite('RedTeamOutl', isHudAboveNotes)
	addLuaSprite('RedOverHealth', isHudAboveNotes)
	addLuaSprite('RedHealthBG', isHudAboveNotes)
	addLuaSprite('RedHealthA', isHudAboveNotes)
	addLuaText('RedHealthTexto')
	
	addLuaSprite('BluTeamBG', isHudAboveNotes)
	addLuaSprite('BluTeamOutl', isHudAboveNotes)
	addLuaSprite('BluOverHealth', isHudAboveNotes)
	addLuaSprite('BluHealthBG', isHudAboveNotes)
	addLuaSprite('BluHealthA', isHudAboveNotes)
	addLuaText('BluHealthTexto')
	
	--streak
	
	makeLuaSprite('BluStreakBG', 'hud/panel_scalable', 1140, 440)
	setObjectCamera('BluStreakBG', 'hud')
	setProperty('BluStreakBG.flipX', true)
	setProperty('BluStreakBG.alpha', hudAlpha)
	scaleObject('BluStreakBG', 0.25, 0.4)
	
	if downscroll and not middlescroll then
		setProperty('BluStreakBG.y', 110)
	end
	
	makeLuaSprite('BluStreakOutl', 'hud/panel_scalable_outline', getProperty('BluStreakBG.x'),getProperty('BluStreakBG.y'))
	setProperty('BluStreakOutl.flipX', true)
	setObjectCamera('BluStreakOutl', 'hud')
	scaleObject('BluStreakOutl', getProperty('BluStreakBG.scale.x'), getProperty('BluStreakBG.scale.y'))
	
	makeLuaText('BluStreakTxt', 'streak', 128, getProperty('BluStreakBG.x') + 12, getProperty('BluStreakBG.y') + 102)
	setTextSize('BluStreakTxt', 28)
	setTextBorder('BluStreakTxt', 0)
	
	makeLuaText('BluStreakCounter', bluStreak, 128, getProperty('BluStreakTxt.x'), getProperty('BluStreakTxt.y') - 50)
	setTextSize('BluStreakCounter', 64)
	setTextBorder('BluStreakCounter', 0)
	
	addLuaSprite('BluStreakBG', isHudAboveNotes)
	addLuaSprite('BluStreakOutl', isHudAboveNotes)
	addLuaText('BluStreakTxt')
	addLuaText('BluStreakCounter')
	
	-- payload timer
	-- welp later
	
	--godlike notestreak
	
	makeLuaText('godlikeStreak', bfName..' is godlike '..bluStreak, 400, 0, 0)
	screenCenter('godlikeStreak')
	setTextSize('godlikeStreak', 28)
	setTextBorder('godlikeStreak', 0)
	setProperty('godlikeStreak.y', 200)
	
	makeLuaSprite('godlikeBG', 'fff', 0, 0)
	makeGraphic('godlikeBG', getTextWidth('godlikeStreak'), 28, '353330')
	screenCenter('godlikeBG')
	setProperty('godlikeBG.y', getProperty('godlikeStreak.y'))
	setObjectCamera('godlikeBG', 'hud')
	setProperty('godlikeBG.alpha', 0.7)
	
	makeLuaSprite('streakImage', 'hud/leaderboard_streak', getProperty('godlikeBG.x') + getProperty('godlikeBG.width') - 28, getProperty('godlikeBG.y') + 1)
	scaleObject('streakImage', 0.8, 0.8)
	setObjectCamera('streakImage', 'hud')
	
	setProperty('godlikeStreak.alpha', 0)
	setProperty('godlikeBG.alpha', 0)
	setProperty('streakImage.alpha', 0)
	
	addLuaSprite('godlikeBG', isHudAboveNotes)
	addLuaText('godlikeStreak')
	addLuaSprite('streakImage', isHudAboveNotes)
	
	setProperty('RedTeamBG.color', getIconColor('dad'))
	setProperty('BluTeamBG.color', getIconColor(chr))
	setProperty('BluStreakBG.color', getIconColor(chr))
	if not getPropertyFromClass('PlayState', 'isPixelStage', true) or forcePixel then
		setTextFont('godlikeStreak', 'TF2.ttf')
		setTextFont('RedHealthTexto', 'TF2.ttf')
		setTextFont('BluHealthTexto', 'TF2.ttf')
		setTextFont('BluStreakCounter', 'TF2.ttf')
	end
	if downscroll then
		setProperty('scoreTxt.y', 20)
	end
end

function setObjectClip(spr, x, y, width, height) -- holy shit raltyro
    -- Check and Fix Arguments
    if (type(spr) ~= "string" or type(getProperty(spr .. ".frame.frame.x")) ~= "number") then return end
    x = type(x) == "number" and x or getProperty(spr .. ".frame.frame.x")
    y = type(y) == "number" and y or getProperty(spr .. ".frame.frame.y")
    width = type(width) == "number" and width >= 0 and width or getProperty(spr .. ".frame.frame.width")
    height = type(height) == "number" and height >= 0 and height or getProperty(spr .. ".frame.frame.height")

    -- ClipRect
    setProperty(spr .. "._frame.frame.x", x)
    setProperty(spr .. "._frame.frame.y", y)
    setProperty(spr .. "._frame.frame.width", width)
    setProperty(spr .. "._frame.frame.height", height)

    return x, y, width, height
end

function onUpdatePost(el)
	setProperty('iconP1.x', getProperty('BluTeamBG.x') + 100)
	setProperty('iconP1.y', getProperty('BluTeamBG.y') + 10)
	setProperty('iconP2.x', getProperty('RedTeamBG.x') + 80)
	setProperty('iconP2.y', getProperty('RedTeamBG.y') + 10)
	setObjectOrder('iconP1', getObjectOrder('BluTeamOutl') + 1)
	setObjectOrder('iconP2', getObjectOrder('RedTeamOutl') + 1)
	if realHealth > 50 then
		setProperty('BluOverHealth.visible', true)
	elseif realHealth < 50 then
		setProperty('BluOverHealth.visible', false)
	end
	if opponentHealth > 50 then
		setProperty('RedOverHealth.visible', true)
	elseif opponentHealth < 50 then
		setProperty('RedOverHealth.visible', false)
	end
end

function onUpdate(el)
	--setProperty('Payload.x', getProperty('timeBar.percent') * 3.9 + 350)
	realHealth = getProperty('health') * 100 / 2 
	setTextString('BluHealthTexto', math.modf(realHealth))
	setTextString('RedHealthTexto', math.modf(opponentHealth))
	setTextString('BluStreakCounter', bluStreak)
	if getProperty('health') <= 1 then
		setObjectClip('BluHealthA', 0, 0, 128, 128 * getProperty('health'))
	end
	if opponentHealth <= 50 then
		setObjectClip('RedHealthA', 0, 0, 128, 128 * opponentHealth / 100 * 2)
	end
	if getProperty('health') < 0.01 then
		setProperty('BluHealthA.visible', false)
	else
		setProperty('BluHealthA.visible', true)
	end
	if opponentHealth < 1 then
		setProperty('RedHealthA.visible', false)
	else
		setProperty('RedHealthA.visible', true)
	end
end

function onBeatHit()
	if bluStreak > 100 and isBfStopedSinging and canShowStreak and not mustHitSection then
		godlike()
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	opponentHealth = opponentHealth + 1
	if opponentHealth > 50 then
		setProperty('RedOverHealth.scale.x', opponentHealth / 100 * 2)
		setProperty('RedOverHealth.scale.y', opponentHealth / 100 * 2)
	end
	if opponentHealth > 100 then
		opponentHealth = 100
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if realHealth > 50 then
		setProperty('BluOverHealth.scale.x', getProperty('health'))
		setProperty('BluOverHealth.scale.y', getProperty('health'))
	end
	if opponentHealth > 50 then
		setProperty('RedOverHealth.scale.x', opponentHealth / 100 * 2)
		setProperty('RedOverHealth.scale.y', opponentHealth / 100 * 2)
	end
	opponentHealth = opponentHealth + 1
	if opponentHealth > 100 then
		opponentHealth = 100
	end
	bluStreak = 0
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	opponentHealth = opponentHealth - 1
	if realHealth > 50 then
		setProperty('BluOverHealth.scale.x', getProperty('health'))
		setProperty('BluOverHealth.scale.y', getProperty('health'))
	end
	if opponentHealth > 50 then
		setProperty('RedOverHealth.scale.x', opponentHealth / 100 * 2)
		setProperty('RedOverHealth.scale.y', opponentHealth / 100 * 2)
	end
	if opponentHealth < 1 then
		opponentHealth = 1
	end
	if getProperty('health') > 2 then
		setProperty('health', 2)
	end
	if not isSustainNote then
		bluStreak = bluStreak + 1
	end
	isBfStopedSinging = false
	if not mustHitSection then
		canShowStreak = false
	end
	runTimer('bfStopedSinging', 1, 1)
end

function onEvent(n, v1, v2)
	if n == 'Change Character' then
		setProperty('RedTeamBG.color', getIconColor('dad'))
		setProperty('BluTeamBG.color', getIconColor(chr))
		setProperty('BluStreakBG.color', getIconColor(chr))
	end
	if n == 'doc' then
			opponentHealth = opponentHealth + 17

			if opponentHealth < 1 then
				opponentHealth = 1
			end
			
			if (getProperty('health') > 0.5) then
				addHealth(-0.25)
			end
	end
end

function getIconColor(chr)
	local chr = chr or "boyfriend"
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function godlike()
	setTextString('godlikeStreak', bfName..' is godlike '..bluStreak)
	setProperty('godlikeStreak.alpha', 1)
	setProperty('godlikeBG.alpha', 0.7)
	setProperty('streakImage.alpha', 1)
	playSound('noteComboSound')
	runTimer('streakFade', 2, 1)
	canShowStreak = false
end

function onTimerCompleted(tag)
	if tag == 'streakFade' then
		doTweenAlpha('streakFade1', 'godlikeStreak', 0, 1)
		doTweenAlpha('streakFade2', 'godlikeBG', 0, 1)
		doTweenAlpha('streakFade3', 'streakImage', 0, 1)
	end
	if tag == 'bfStopedSinging' then
		isBfStopedSinging = true
		canShowStreak = true
	end
end