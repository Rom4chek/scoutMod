function onCreate()

	for i = 0, getProperty('unspawnNotes.length')-1 do
		
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Swamp Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'SWAMPNOTE_assets');
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'SWAMPNOTE_splashes');
			setPropertyFromGroup("unspawnNotes", i, "offset.x", 44)
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
			setPropertyFromGroup('unspawnNotes', i, 'earlyHitMult', 0.4);
            setPropertyFromGroup('unspawnNotes', i, 'lateHitMult', 0.4);
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
		--precacheImage('SWAMPNOTE_assets')
		--precacheImage('SWAMPNOTE_splashes')
	end

end

local missAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local notedata = 1
	
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Swamp Note' then
	addMisses(1)
	setHits(0)
	setRatingPercent(math.min(1, math.max(0, getProperty('totalNotesHit')/getProperty('totalPlayed'))));
	cameraFlash("game", "755400", 1, true)
	notedata = noteData
	characterPlayAnim('boyfriend', missAnims[notedata + 1]..'miss', true);
	setProperty('totalPlayed', getProperty('totalPlayed')+1);
	playSound('badnoise'.. getRandomInt(1, 3), 1)
	setProperty('vocals.volume', 0)
	setProperty('combo', 0)
	if getProperty('combo') >= 12 then
		triggerEvent('Play Animation', 'sad', 'gf')
	end

	if difficulty == 1 or difficulty == 0 then
    		if getHealth() > 0.1 then
				setHealth(0.01)
			else
				addHealth(-1)
		    end
		else
				if noteType == 'Swamp Note' then
					addHealth(-1);
				end
		end
	end
end
