--[[
    Luau LSP Demo File

    This file demonstrates the LSP features available in Claude Code.
    Open this file and ask Claude about any API!

    Try asking:
    - "What does Raycast return?"
    - "Show me the parameters for TweenService:Create"
    - "What's wrong with this code?"
]]

-- ============================================
-- Services (hover to see documentation)
-- ============================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- ============================================
-- Raycast Example (modern API)
-- ============================================
local function performRaycast()
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {}

    local origin = Vector3.new(0, 10, 0)
    local direction = Vector3.new(0, -20, 0)

    local result = workspace:Raycast(origin, direction, raycastParams)

    if result then
        print("Hit:", result.Instance.Name)
        print("Position:", result.Position)
        print("Normal:", result.Normal)
        print("Material:", result.Material)
    end
end

-- ============================================
-- Tween Example
-- ============================================
local function tweenPart(part: BasePart)
    local tweenInfo = TweenInfo.new(
        1,                              -- duration
        Enum.EasingStyle.Quad,          -- easing style
        Enum.EasingDirection.Out,       -- easing direction
        0,                              -- repeat count
        false,                          -- reverses
        0                               -- delay
    )

    local goal = {
        Position = Vector3.new(0, 10, 0),
        Transparency = 0.5
    }

    local tween = TweenService:Create(part, tweenInfo, goal)
    tween:Play()

    return tween
end

-- ============================================
-- Player Events
-- ============================================
Players.PlayerAdded:Connect(function(player: Player)
    print("Welcome,", player.Name)

    player.CharacterAdded:Connect(function(character: Model)
        local humanoid = character:WaitForChild("Humanoid") :: Humanoid

        humanoid.Died:Connect(function()
            print(player.Name, "died")
        end)
    end)
end)

-- ============================================
-- Modern Task Library (use these!)
-- ============================================
task.wait(1)
task.spawn(function()
    print("Spawned in new thread")
end)
task.delay(5, function()
    print("Delayed execution")
end)

-- ============================================
-- DEPRECATED EXAMPLES (LSP will warn about these)
-- ============================================

-- Deprecated: use task.wait() instead
-- wait(1)

-- Deprecated: use task.spawn() instead
-- spawn(function() end)

-- Deprecated: use workspace:Raycast() instead
-- workspace:FindPartOnRay(ray)

-- Deprecated: use Animator:LoadAnimation() instead
-- humanoid:LoadAnimation(animation)

-- ============================================
-- TYPE ERROR EXAMPLES (LSP will catch these)
-- ============================================

-- Uncomment to see type errors:
-- local wrongNumber: number = "string"
-- local wrongVector: Vector3 = "not a vector"
-- Instance.new("FakeClassName")

-- ============================================
-- Run the demo
-- ============================================
RunService.Heartbeat:Connect(function(deltaTime: number)
    -- Game loop logic here
end)

print("Luau LSP Demo loaded!")
