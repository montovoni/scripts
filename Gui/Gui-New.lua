-- Espera até que o jogo esteja carregado e o jogador local esteja pronto
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

-------------------------------------------------------------------------------
-- Verifica se o script já foi executado antes para evitar duplicação
if getgenv().GuiExecuted then 
    -- Se a GUI foi criada anteriormente, destrua-a
    if game.CoreGui:FindFirstChild("thisoneissocoldww") then
        game.CoreGui.thisoneissocoldww:Destroy()
    end
    getgenv().GuiExecuted = false  -- Marca que a execução foi cancelada
end

-- Marca o script como executado
getgenv().GuiExecuted = true

-------------------------------------------------------------------------------

-- Cria a interface gráfica (GUI) para exibir informações
local thisoneissocoldww = Instance.new("ScreenGui")
local madebybloodofbatus = Instance.new("Frame")
local UICornerw = Instance.new("UICorner")
local DestroyButton = Instance.new("TextButton")
local uselesslabelone = Instance.new("TextLabel")
local uselessframeone = Instance.new("Frame")
local UICornerww = Instance.new("UICorner")

-------------------------------------------------------------------------------

-- Configurações da GUI
thisoneissocoldww.Name = "thisoneissocoldww"
thisoneissocoldww.Parent = game.CoreGui
thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

madebybloodofbatus.Name = "madebybloodofbatus"
madebybloodofbatus.Parent = thisoneissocoldww
madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
madebybloodofbatus.Position = UDim2.new(0.0854133144, 0, 0.13128835, 0)
madebybloodofbatus.Size = UDim2.new(0, 200, 0, 96) -- Tamanho da gui principal

UICornerw.Name = "UICornerw"
UICornerw.Parent = madebybloodofbatus

-------------------------------------------------------------------------------

-- Botão para fechar a GUI
DestroyButton.Name = "DestroyButton"
DestroyButton.Parent = madebybloodofbatus
DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DestroyButton.BackgroundTransparency = 1.000
DestroyButton.Position = UDim2.new(0.871702373, 0, 0.0245379955, 0)
DestroyButton.Size = UDim2.new(0, 27, 0, 15)
DestroyButton.Font = Enum.Font.SourceSans
DestroyButton.Text = "X"
DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyButton.TextSize = 14.000

-- Função para fechar a GUI ao clicar no botão "X"
DestroyButton.MouseButton1Click:connect(function()
    getgenv().GuiExecuted = false
    wait(0.1)
    thisoneissocoldww:Destroy()
end)

-------------------------------------------------------------------------------

-- Labels para exibir informações
uselesslabelone.Name = "uselesslabelone"
uselesslabelone.Parent = madebybloodofbatus
uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.BackgroundTransparency = 1.000
uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
uselesslabelone.Font = Enum.Font.SourceSans
uselesslabelone.Text = "Discord: montovoni"
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 15
uselesslabelone.TextXAlignment = Enum.TextXAlignment.Center  -- Centraliza o texto

-- Centraliza a posição da label
uselesslabelone.Position = UDim2.new(0.5, -uselesslabelone.Size.X.Offset / 2, 0, 0)

-- Ajusta a fonte e a cor
uselesslabelone.Font = Enum.Font.ArialBold
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 15 -- Ajuste o tamanho da fonte aqui

-------------------------------------------------------------------------------

-- Frame decorativo 
uselessframeone.Name = "uselessframeone"
uselessframeone.Parent = madebybloodofbatus
uselessframeone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselessframeone.Position = UDim2.new(0.00444444455, 0, 0.243312627, 0)
uselessframeone.Size = UDim2.new(0, 224, 0, 5)

-- Função para ajustar o tamanho do frame decorativo
local function adjustFrameSize()
    local screenWidth = workspace.CurrentCamera.ViewportSize.X
    local frameWidth = madebybloodofbatus.AbsoluteSize.X  -- Largura do frame principal

    -- Define a largura do frame decorativo proporcionalmente à largura da tela ou do frame principal
    local frameScaleX = 0.95 -- Ajuste este valor para a proporção desejada (ex: 0.95 para 95%)
    uselessframeone.Size = UDim2.new(0, frameWidth * frameScaleX, 0, 5) -- Largura proporcional ao frame principal
    -- Ou, para largura proporcional à tela:
    -- uselessframeone.Size = UDim2.new(0, screenWidth * frameScaleX, 0, 5)

    -- Centraliza o frame decorativo horizontalmente
    uselessframeone.Position = UDim2.new(0.5 - frameScaleX/2, 0, uselessframeone.Position.Y.Scale, uselessframeone.Position.Y.Offset)
end

-- Chama a função inicialmente para ajustar o tamanho ao carregar a GUI
adjustFrameSize()

-- Conecta a função ao evento de redimensionamento da tela (opcional, mas recomendado)
game:GetService("RunService").RenderStepped:Connect(adjustFrameSize)

-------------------------------------------------------------------------------

-- Função para arrastar a GUI pela tela
local Drag = game.CoreGui.thisoneissocoldww.madebybloodofbatus
gsCoreGui = game:GetService("CoreGui")
gsTween = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

-- Função para atualizar a posição do objeto durante o arrasto
local function update(input)
    local delta = input.Position - dragStart
    local dragTime = 0.04
    local SmoothDrag = {}
    SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    local dragSmoothFunction = gsTween:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
    dragSmoothFunction:Play()
end

-- Quando o usuário começa a interagir com o objeto (clicando ou tocando)
Drag.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Drag.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

-- Quando há uma mudança no input enquanto o usuário interage com o objeto
Drag.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- Escuta por mudanças no input global (movimento do mouse ou toque)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and Drag.Size then
        update(input)
    end
end)

-------------------------------------------------------------------------------