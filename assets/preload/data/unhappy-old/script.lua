-- Lua stuff
function onCreate()
	-- triggered when the lua file is started
	makeAnimatedLuaSprite('vhsoverlay', 'vhs', 150, 0)
	addAnimationByPrefix('vhsoverlay', 'vhs', 'vhs', 24, true)
	setObjectCamera('vhsoverlay', 'hud')
	setGraphicSize('vhsoverlay', 1000, 730)
	setProperty('vhsoverlay.alpha', 0.7)
	--screenCenter('vhsoverlay', 'X')

	makeLuaSprite('borders', 'borders', 0, 0)
	setObjectCamera('borders', 'hud')

	addLuaText('time')
	addLuaText('date')

	addLuaSprite('vhsoverlay', true)
	addLuaSprite('borders', true)
end

function onDestroy()
	-- triggered when the lua file is ended (Song fade out finished)
end


-- Gameplay/Song interactions
function onBeatHit()
	-- triggered 4 times per section
end

function onStepHit()
	-- triggered 16 times per section
end

function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
end

function onUpdatePost(elapsed)
	-- end of "update"
end

function onStartCountdown()
	-- countdown started, duh
	-- return Function_Stop if you want to stop the countdown from happening (Can be used to trigger dialogues and stuff! You can trigger the countdown with startCountdown())
	return Function_Continue;
end

function onCountdownTick(counter)
	counter = 0 --> "Three"
	noteTweenX('dadnote1', 0, defaultOpponentStrumX0 + 80, 0.00001, 'backInOut')
	noteTweenX('dadnote2', 1, defaultOpponentStrumX1 + 80, 0.00001, 'backInOut')
	noteTweenX('dadnote3', 2, defaultOpponentStrumX2 + 80, 0.00001, 'backInOut')
	noteTweenX('dadnote4', 3, defaultOpponentStrumX3 + 80, 0.00001, 'backInOut')
	noteTweenX('bfnote1', 4, defaultPlayerStrumX0  - 80, 0.00001, 'backInOut')
	noteTweenX('bfnote2', 5, defaultPlayerStrumX1  - 80, 0.00001, 'backInOut')
	noteTweenX('bfnote3', 6, defaultPlayerStrumX2  - 80, 0.00001, 'backInOut')
	noteTweenX('bfnote4', 7, defaultPlayerStrumX3  - 80, 0.00001, 'backInOut')
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
end

function onEndSong()
	-- song ended/starting transition (Will be delayed if you're unlocking an achievement)
	-- return Function_Stop to stop the song from ending for playing a cutscene or something.
	return Function_Continue;
end


-- Substate interactions
function onPause()
	-- Called when you press Pause while not on a cutscene/etc
	-- return Function_Stop if you want to stop the player from pausing the game
	return Function_Continue;
end

function onResume()
	-- Called after the game has been resumed from a pause (WARNING: Not necessarily from the pause screen, but most likely is!!!)
end

function onGameOver()
	-- You died! Called every single frame your health is lower (or equal to) zero
	-- return Function_Stop if you want to stop the player from going into the game over screen
	return Function_Continue;
end

function onGameOverConfirm(retry)
	-- Called when you Press Enter/Esc on Game Over
	-- If you've pressed Esc, value "retry" will be false
end


-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(line)
	-- triggered when the next dialogue line starts, dialogue line starts with 1
end

function onSkipDialogue(line)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end


-- Note miss/hit
function goodNoteHit(id, direction, noteType, isSustainNote)
	-- Function called when you hit a note (after note hit calculations)
	-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
	-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
	-- noteType: The note type string/tag
	-- isSustainNote: If it's a hold note, can be either true or false
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	-- Works the same as goodNoteHit, but for Opponent's notes being hit
end

function noteMissPress(direction)
	-- Called after the note press miss calculations
	-- Player pressed a button, but there was no note to hit (ghost miss)
end

function noteMiss(id, direction, noteType, isSustainNote)
	-- Called after the note miss calculations
	-- Player missed a note by letting it go offscreen
end


-- Other function hooks
function onRecalculateRating()
	-- return Function_Stop if you want to do your own rating calculation,
	-- use setRatingPercent() to set the number on the calculation and setRatingString() to set the funny rating name
	-- NOTE: THIS IS CALLED BEFORE THE CALCULATION!!!
	return Function_Continue;
end

function onMoveCamera(focus)
	if focus == 'boyfriend' then
		-- called when the camera focus on boyfriend
	elseif focus == 'dad' then
		-- called when the camera focus on dad
	end
end


-- Event notes hooks
function onEvent(name, value1, value2)
	-- event note triggered
	-- triggerEvent() does not call this function!!

	-- print('Event triggered: ', name, value1, value2);
end

function eventEarlyTrigger(name)
	--[[
	Here's a port of the Kill Henchmen early trigger but on Lua instead of Haxe:

	if name == 'Kill Henchmen'
		return 280;

	This makes the "Kill Henchmen" event be triggered 280 miliseconds earlier so that the kill sound is perfectly timed with the song
	]]--

	-- write your shit under this line, the new return value will override the ones hardcoded on the engine
end


-- Tween/Timer hooks
function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
end
