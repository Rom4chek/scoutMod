local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('bonkcutscene-older');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end