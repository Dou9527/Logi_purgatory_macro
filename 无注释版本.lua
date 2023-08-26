switch_key = 3
purgatory_key = 4
switch = true
EnablePrimaryMouseButtonEvents(true)
math.randomseed(GetDate("%H%M%S"):reverse())
function generate_normal_random(mean, stddev)
    local u1 = math.random()
    local u2 = math.random()
    local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
    return math.floor(mean + z0 * stddev + 0.5)
end
function random(m, n)
    local mean = (m + n) / 2
    local sigma = (n - m) / (2 * 1.645)
    local generated_random = generate_normal_random(mean, sigma)
    while (generated_random < m) do
        generated_random = math.random(m, n)
    end
    if (m == 10) then
        OutputLogMessage("%f\n", generated_random)
    end
    return generated_random
end

function OnEvent(event, arg)
    if (event == "MOUSE_BUTTON_PRESSED") then
        if (arg == switch_key) then
            switch = not switch
            if (switch) then
                OutputLogMessage("Macro is on!\n")
            else
                OutputLogMessage("Macro is off!\n")
            end
        elseif (switch) then
            if (arg == purgatory_key) then
                Sleep(random(10, 25))
                if (arg ~= 1) then
                    repeat
                        PressMouseButton(1)
                        Sleep(random(100, 185))
                        ReleaseMouseButton(1)
                        Sleep(random(10, 25))
                    until not IsMouseButtonPressed(purgatory_key)
                else
                    repeat
                        PressKey("L")
                        Sleep(random(100, 185))
                        ReleaseKey("L")
                        Sleep(random(10, 25))
                    until not IsMouseButtonPressed(1)
                end
            end
        end
    end
end
