--made by the greatest ramkek ever

function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Slow Note' then
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', -5);
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.brightness', -5);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Slow Note' then
		setProperty('playbackRate',getProperty('playbackRate')-0.05)
	end
end