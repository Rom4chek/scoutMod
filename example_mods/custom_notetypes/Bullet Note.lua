function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet Note' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_test_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			--setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.3); --Change amount of health to take when you miss like a fucking moron
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup("unspawnNotes", i, "offset.x", -20)
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
end

local shootAnims = {"LEFTshoot", "DOWNshoot", "UPshoot", "RIGHTshoot"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet Note' then
		playSound('bat_swing', 1.0);
		playAnim('dad', 'attack' , true);
		playAnim('boyfriend', 'dodge', true);
		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
		cameraShake('camGame', 0.01, 0.2)
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Bullet Note' then
    	runTimer('bleed', 0.2, 20);
    	playSound('bat_hit', 3.0);
    	playAnim('boyfriend', 'hurt', true);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if loopsLeft >= 1 then
		addHealth(-0.01)
	end
end