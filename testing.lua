--// ======================================================
--// RIICUY ULTIMATE UI LIBRARY - COMPLETE EDITION
--// ======================================================

local UILib = {}
UILib.__index = UILib

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

function UILib:CreateWindow(settings)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "RiicuyUI"

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.fromOffset(650, 450)
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    
    -- Judul Riicuy
    local Title = Instance.new("TextLabel", Main)
    Title.Text = "Riicuy Dashboard"
    -- ... (sisa logika library UI)
    return Main
end

return UILib
