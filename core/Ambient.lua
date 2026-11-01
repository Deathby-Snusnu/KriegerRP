-- SPDX-License-Identifier: MPL-2.0
local _, addon = ...
-- A generation token prevents stale scheduled callbacks from continuing.
local generation = 0
function addon.ResetAmbientTimer()
    generation = generation + 1
    local thisGeneration = generation
    if not addon.ready or not addon.db or not addon.db.ambientEnabled then return end
    if not C_Timer or type(C_Timer.After) ~= "function" then return end
    local min = math.floor(addon.db.ambientMinInterval or 120)
    local max = math.floor(addon.db.ambientMaxInterval or 300)
    if min < 30 then min = 30 end
    if max < min then max = min end
    local function schedule()
        local delay = math.random(min, max)
        C_Timer.After(delay, function()
            if thisGeneration ~= generation or not addon.db.ambientEnabled then return end
            if addon.TryAmbient then addon.TryAmbient(nil, false) end
            if thisGeneration == generation and addon.db.ambientEnabled then schedule() end
        end)
    end
    schedule()
end
