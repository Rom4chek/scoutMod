playVideo = true;

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			startVideo('CutsceneW1S3'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end

function onEndSong()
	if isStoryMode and not allowEnd then
		startVideo('CutsceneW1END');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end