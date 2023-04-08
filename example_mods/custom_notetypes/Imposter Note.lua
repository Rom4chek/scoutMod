function onCreate()

	for i = 0, getProperty('unspawnNotes.length')-1 do

		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Imposter Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'IMPOSTERNOTE_assets');
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

	--precacheImage('IMPOSTERNOTE_assets')
	--precacheImage('IMPOSTERNOTE_splashes')
	--precacheSound('imposterhit1')
	--precacheSound('imposterhit2')
	--precacheSound('imposterhit3')

end

local missAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local notedata = 1
	
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Imposter Note' then
		addMisses(1)
		setHits(0)
		setProperty('totalPlayed', getProperty('totalPlayed')+1);
		addScore(-1000)
		setRatingPercent(math.min(1, math.max(0, getProperty('totalNotesHit')/getProperty('totalPlayed'))));
		notedata = noteData
		characterPlayAnim('boyfriend', missAnims[notedata + 1]..'miss', true);
		playSound('badnoise'.. getRandomInt(1, 3), 1)
		setProperty('vocals.volume', 0)
		setProperty('combo', 0)
		if getProperty('combo') >= 12 then
			triggerEvent('Play Animation', 'sad', 'gf')
		end
		if difficulty == 0 then
			addHealth(-0.25)
			cameraFlash("game", "0x7424a4", 0.3, true)
			end
			if difficulty == 1 then
				addHealth(-0.45)
				cameraFlash("game", "0x7424a4", 0.5, true)
			end
			if difficulty == 2 then
				addHealth(-0.5)
				cameraFlash("game", "0x7424a4", 1, true)
		end
	end
end