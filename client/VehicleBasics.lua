Thread.Create(function()
    local leftIndicatorTime = 0
    local rightIndicatorTime = 0
    local indicatorDuration = 5000 -- milliseconds (3 seconds)

    while true do
        local vehicle = Game.GetCarCharIsUsing(Game.GetPlayerChar(Game.GetPlayerId()))
        local currentTime = Game.GetGameTimer()

        if vehicle then
            -- LEFT INDICATOR (LEFT ARROW)
            if Game.IsGameKeyboardKeyJustPressed(203) then
                Game.SetVehTurnIndicatorlights(vehicle, true, true)  -- left on
                Game.SetVehTurnIndicatorlights(vehicle, false, false) -- right off
                leftIndicatorTime = currentTime
                rightIndicatorTime = 0
            end

            -- RIGHT INDICATOR (RIGHT ARROW)
            if Game.IsGameKeyboardKeyJustPressed(205) then
                Game.SetVehTurnIndicatorlights(vehicle, true, false)  -- left off
                Game.SetVehTurnIndicatorlights(vehicle, false, true)  -- right on
                rightIndicatorTime = currentTime
                leftIndicatorTime = 0
            end

            -- TURN OFF (DOWN ARROW)
            if Game.IsGameKeyboardKeyJustPressed(208) then
                Game.SetVehTurnIndicatorlights(vehicle, true, false)
                Game.SetVehTurnIndicatorlights(vehicle, false, false)
                leftIndicatorTime = 0
                rightIndicatorTime = 0
            end

            -- Auto turn-off logic
            if leftIndicatorTime > 0 and currentTime - leftIndicatorTime > indicatorDuration then
                Game.SetVehTurnIndicatorlights(vehicle, true, false)
                leftIndicatorTime = 0
            end

            if rightIndicatorTime > 0 and currentTime - rightIndicatorTime > indicatorDuration then
                Game.SetVehTurnIndicatorlights(vehicle, false, false)
                rightIndicatorTime = 0
            end
        end

        Thread.Pause(0)
    end
end)
