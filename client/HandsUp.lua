Thread.Create(function()
    local isHandsUp = false
    local animName = "idle_2_hands_up"
    local animGroup = "busted"
    local freezeFrame = 39.0

    while true do
        local playerChar = Game.GetPlayerChar(Game.GetPlayerId())

        if Game.DoesCharExist(playerChar) and not Game.IsCharDead(playerChar) then
            -- Press X to raise hands
            if Game.IsGameKeyboardKeyJustPressed(45) and not isHandsUp then
                Game.RequestAnims(animGroup)
                while not Game.HaveAnimsLoaded(animGroup) do
                    Thread.Pause(0)
                end

                Game.TaskPlayAnim(playerChar, animName, animGroup, 8.0, false, false, false, false, -1)
                isHandsUp = true
            end

            -- If animation is playing, freeze on frame 39
            if isHandsUp then
                local currentTime = Game.GetCharAnimCurrentTime(playerChar, animGroup, animName)
                Console.Log(currentTime)
                if(currentTime >= 0.27) then
                    Game.SetCharAnimCurrentTime(playerChar, animGroup, animName, currentTime)
                    Game.SetCharAnimSpeed(playerChar, animGroup, animName, 0.0)
                end
            end

            -- Release X to cancel hands up
            if isHandsUp and not Game.IsGameKeyboardKeyPressed(45) then
                Game.ClearCharTasks(playerChar)
                isHandsUp = false
            end
        end

        Thread.Pause(0)
    end
end)
