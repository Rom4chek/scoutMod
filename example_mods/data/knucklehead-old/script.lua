function onEndSong()
	if not allowEnd then
		startVideo('knuckleheadendscene-older');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end