function onCreate()

	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Medic Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'MEDICNOTE_assets');
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', 0);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 0);
			setPropertyFromGroup('unspawnNotes', i, 'goodmechanicnote', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'mustPress', true); --Miss has penalties

				end				
		end
	end

	--precacheSound('medicHit1')
	--precacheSound('medicHit2')
	--precacheSound('medicHit3')
	--precacheImage('MEDICNOTE_assets')

	function noteMiss(id, i, noteType, isSustainNote)
		if noteType == 'Medic Note' then
			setProperty('health', getProperty('health') -0.125);
			addScore(-500)
	end
end
end

local missAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
local notedata = 1

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Medic Note' then
		--cameraFlash("game", "0x7424a4", 0.5, true)
		--notedata = noteData
		--characterPlayAnim('boyfriend', missAnims[notedata + 1]..'miss', true);
		playSound('medicHit'.. getRandomInt(1, 3), 1)
		addScore(500)
		if difficulty == 0 then
		setProperty('health',getProperty('health') +0.45)				
		end
		if difficulty == 1 then
			setProperty('health',getProperty('health') +0.4)
		end
		if difficulty == 2 then
			setProperty('health',getProperty('health') +0.3)
		end
	end
end