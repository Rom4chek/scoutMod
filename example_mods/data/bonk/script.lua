playVideo = true;

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			startVideo('Cutscene1W1S'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end