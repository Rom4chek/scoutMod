function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Boom Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Boom Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'BOOMNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.3); --Change amount of health to take when you miss like a fucking moron
			setPropertyFromGroup('unspawnNotes', i, 'offset.x', 50);

		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false

dodgeAnimations = {'dodge', 'dodge', 'dodge', 'dodge'}
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Boom Note' then
		characterPlayAnim('boyfriend', dodgeAnimations[noteData+1], true);
		setProperty('boyfriend.specialAnim', true);

		local animToPlay = '';
		if noteData == 0 then
			animToPlay = 'singLEFT-alt';
		elseif noteData == 1 then
			animToPlay = 'singDOWN-alt';
		elseif noteData == 2 then
			animToPlay = 'singUP-alt';
		elseif noteData == 3 then
			animToPlay = 'singRIGHT-alt';
		end
		characterPlayAnim('dad', animToPlay, true);
		setProperty('dad.specialAnim', true);
	end
end
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Boom Note' then
		-- bf anim
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);

		-- dad anim
		characterPlayAnim('dad', animToPlay, true);
		setProperty('dad.specialAnim', true);

	end
end