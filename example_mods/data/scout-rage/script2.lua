function onCountdownStarted()
	doTweenAlpha('camGameOFF', 'camGame', 0, 0.001, 'linear')
end

function onSongStart()
	doTweenAlpha('camGameON', 'camGame', 1, 10, 'linear')
end