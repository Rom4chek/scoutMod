local angleshit = 1.5;
local anglevar = 1.5;
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if difficulty == 2 then
		if curBeat < 1 then
			if curBeat > 240 then
				cameraShake('cam', '0.5', '0.1')
			end
		end
	end
end

function onBeatHit()
    if curBeat > 1 then
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        setProperty('camHUD.angle',angleshit*6)
        setProperty('camGame.angle',angleshit*6)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*16, crochet*0.001, 'linear')
        doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('ttrn', 'camGame', -angleshit*16, crochet*0.001, 'linear')
    end
end