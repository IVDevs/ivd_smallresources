Thread.Create(function()
    local leftIndicatorTime = 0
    local rightIndicatorTime = 0
    local indicatorDuration = 5000 -- milliseconds (3 seconds)
    local HazardsOn = false
    local LeftClicked = false
    local RightClicked = false

    while true do
        local vehicle = Game.GetCarCharIsUsing(Game.GetPlayerChar(Game.GetPlayerId()))
        local currentTime = Game.GetGameTimer()

        if vehicle then

            if RightClicked and Game.IsGameKeyboardKeyPressed(32) then
                rightIndicatorTime = currentTime
            end
            if LeftClicked and Game.IsGameKeyboardKeyPressed(30) then
                leftIndicatorTime = currentTime
            end

            -- LEFT INDICATOR (LEFT ARROW)
            if Game.IsGameKeyboardKeyJustPressed(9) then
                if LeftClicked then
                    Game.SetVehTurnIndicatorlights(vehicle, true, true)  -- left on
                    Game.SetVehTurnIndicatorlights(vehicle, false, false) -- right off
                    LeftClicked = false
                else
                    Game.SetVehTurnIndicatorlights(vehicle, true, false)  -- left on
                    Game.SetVehTurnIndicatorlights(vehicle, false, false) -- right off
                    LeftClicked = true
                end
            end

            -- RIGHT INDICATOR (RIGHT ARROW)
            if Game.IsGameKeyboardKeyJustPressed(11) then
                if RightClicked then
                    Game.SetVehTurnIndicatorlights(vehicle, true, false)  -- left off
                    Game.SetVehTurnIndicatorlights(vehicle, false, true)  -- right on
                    RightClicked = false
                else
                    Game.SetVehTurnIndicatorlights(vehicle, true, false)  -- left off
                    Game.SetVehTurnIndicatorlights(vehicle, false, false)  -- right on
                    RightClicked = true
                end
            end

            -- HAZARDS
            if Game.IsGameKeyboardKeyJustPressed(10) then
                if HazardsOn then
                    Game.SetVehTurnIndicatorlights(vehicle, false, false)  -- left off
                    Game.SetVehTurnIndicatorlights(vehicle, true, false)  -- right on
                    HazardsOn = false
                else
                    Game.SetVehTurnIndicatorlights(vehicle, false, true)  -- left off
                    Game.SetVehTurnIndicatorlights(vehicle, true, true)  -- right on
                    HazardsOn = true
                end
            end

            -- Auto turn-off logic
            if leftIndicatorTime > 0 and currentTime - leftIndicatorTime > indicatorDuration then
                Game.SetVehTurnIndicatorlights(vehicle, true, false)
                leftIndicatorTime = 0
                LeftClicked = false
            end

            if rightIndicatorTime > 0 and currentTime - rightIndicatorTime > indicatorDuration then
                Game.SetVehTurnIndicatorlights(vehicle, false, false)
                rightIndicatorTime = 0
                RightClicked = false
            end
        end

        Thread.Pause(0)
    end
end)
