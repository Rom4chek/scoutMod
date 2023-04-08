function onUpdate()
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F') then
		endSong(true)
		loadSong('knucklehead', 'vibing-revenge', true);
	end
end
