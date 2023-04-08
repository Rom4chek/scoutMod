function onCreate()

	for i = 0, getProperty('unspawnNotes.length')-1 do

		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'knife' then			                        setPropertyFromGroup('unspawnNotes', i, 'texture', 'knife');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', "IMPOSTERNOTE_splashes");
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
			setPropertyFromGroup('unspawnNotes', i, 'earlyHitMult', 0.5);
            setPropertyFromGroup('unspawnNotes', i, 'lateHitMult', 0.5);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', 0);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 0);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Lets Opponent's instakill notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			else
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end		
		end
	end

	--precacheImage('knife')
	--precacheImage('IMPOSTERNOTE_splashes')
	--precacheSound('knifeSlash1')
	--precacheSound('knifeSlash2')

end

local missAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local notedata = 1
	
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'knife' then
		addMisses(1)
		setHits(0)
		setProperty('totalPlayed', getProperty('totalPlayed')+1);
		addScore(-1000)
		setRatingPercent(math.min(1, math.max(0, getProperty('totalNotesHit')/getProperty('totalPlayed'))));
		notedata = noteData
		characterPlayAnim('boyfriend', missAnims[notedata + 1]..'miss', true);
		characterPlayAnim('mouse angry', 'fuck you' , true);
		playSound('knifeSlash'.. getRandomInt(1, 2), 1)
		setProperty('vocals.volume', 0)
		setProperty('combo', 0)
		if getProperty('combo') >= 12 then
			triggerEvent('Play Animation', 'sad', 'gf')
		end
		if difficulty == 0 then
			addHealth(-0.25)
			cameraFlash("game", "c21111", 0.3, true)
			end
			if difficulty == 1 then
				addHealth(-0.45)
				cameraFlash("game", "c21111", 0.5, true)
			end
			if difficulty == 2 then
				addHealth(-0.5)
				cameraFlash("game", "c21111", 1, true)
		end
	end
end