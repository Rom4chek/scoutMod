--Script Config: Images
--Find these inside of mods/images
local DefaultImage2 = 'ready'
local DefaultImage1 = 'set'
local DefaultImage0 = 'go'

--Script Config: Sounds
--Find these inside of mods/sounds
local DefaultSound3 = 'intro3'
local DefaultSound2 = 'intro2'
local DefaultSound1 = 'intro1'
local DefaultSound0 = 'IntroGo'

--Script Config Fade
--controls how the stuff fades out
local FadeTime = 0.5
local FadeEase = 'CircInOut'

function onCreate()
	FadeTime = crochet / 1000
end

function onEvent(name, value1, value2)
	if name == 'Play_1_Part_of_Countdown' then
		makeLuaSprite('CountImage', value1, 0, 0)
		screenCenter('CountImage', 'xy')
		setObjectCamera('CountImage', 'other')
		addLuaSprite('CountImage', true)
		setProperty('CountImage.visible', true)
		playSound(value2)
		doTweenAlpha('ThreeFade', 'CountImage', 0, FadeTime, FadeEase)
		runTimer('removeSprite', FadeTime)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'removeSprite' then
		removeLuaSprite('CountImage', false)
	end
end