function opponentNoteHit()
       health = getProperty('health')
    if getProperty('health') > 0.1 then
       setProperty('health', health- 0.02);
	end

   cameraShake('camGame', 0.01, 0.1);
   cameraShake('hud', 0.01, 0.01);
end

function onUpdate(elapsed)

   if curStep >= 0 then
 
     songPos = getSongPosition()
 
     local currentBeat = (songPos/1000)*(bpm/80)
 
     doTweenY(dadTweenY, 'dad', -300-110*math.sin((currentBeat*0.25)*math.pi),0.001)
 
   end
 
 end
