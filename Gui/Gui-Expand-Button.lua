-- Espera até que o jogo esteja carregado e o jogador local esteja pronto
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

------------------------------------------------------------------------------------------

-- Verifica se o script já foi executado antes para evitar duplicação
if getgenv().GuiExecuted then
    if game.CoreGui:FindFirstChild("thisoneissocoldww") then
        game.CoreGui.thisoneissocoldww:Destroy()
    end
    getgenv().GuiExecuted = false
end

getgenv().GuiExecuted = true

------------------------------------------------------------------------------------------

-- Cria a interface gráfica (GUI)
local thisoneissocoldww = Instance.new("ScreenGui")
local madebybloodofbatus = Instance.new("Frame")
local UICornerw = Instance.new("UICorner")
local uselesslabelone = Instance.new("TextLabel")
local expandButton = Instance.new("TextButton") -- Botão para expandir
local creditsLabel = Instance.new("TextLabel") -- Label para os créditos
local UICornerww = Instance.new("UICorner")

------------------------------------------------------------------------------------------

-- Configurações da GUI
thisoneissocoldww.Name = "thisoneissocoldww"
thisoneissocoldww.Parent = game.CoreGui
thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

madebybloodofbatus.Name = "madebybloodofbatus"
madebybloodofbatus.Parent = thisoneissocoldww
madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Preto
madebybloodofbatus.Position = UDim2.new(0.0854133144, 0, 0.13128835, 0)
madebybloodofbatus.Size = UDim2.new(0, 200, 0, 25) -- Tamanho inicial da GUI

UICornerw.Name = "UICornerw"
UICornerw.Parent = madebybloodofbatus

------------------------------------------------------------------------------------------

-- Gui - Modelo
uselesslabelone.Name = "uselesslabelone"
uselesslabelone.Parent = madebybloodofbatus
uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.BackgroundTransparency = 1.000
uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
uselesslabelone.Font = Enum.Font.SourceSans
uselesslabelone.Text = "Gui - Modelo"
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 15
uselesslabelone.TextXAlignment = Enum.TextXAlignment.Center
uselesslabelone.Position = UDim2.new(0.5, -uselesslabelone.Size.X.Offset / 2, 0, 0)

uselesslabelone.Font = Enum.Font.ArialBold
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 15

------------------------------------------------------------------------------------------

-- Botão expandir
expandButton.Name = "expandButton"
expandButton.Parent = madebybloodofbatus
expandButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Cor de fundo do botão
expandButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Cor do texto do botão
expandButton.Text = "+" -- Texto do botão
expandButton.Size = UDim2.new(0, 25, 0, 25) -- Tamanho do botão
expandButton.Position = UDim2.new(1, -25, 0, 0) -- Posição do botão no canto direito
expandButton.Font = Enum.Font.ArialBold
expandButton.TextSize = 16
expandButton.ZIndex = 2 -- Garante que o botão fique na frente

UICornerww.Name = "UICornerww"
UICornerww.Parent = expandButton

-----------------------------------------------------------------------------------------------------------

-- Criando um contêiner para os botões adicionais
local extraButtonsContainer = Instance.new("Frame")
extraButtonsContainer.Name = "extraButtonsContainer" -- Nomeando o container
extraButtonsContainer.Parent = madebybloodofbatus
extraButtonsContainer.BackgroundTransparency = 1
extraButtonsContainer.Size = UDim2.new(1, -10, 0, 60) -- Ajusta altura para comportar os botões

-- Ajusta a posição do container com 5 pixels entre o título e os botões
local alturaLabel = uselesslabelone.Size.Y.Offset
extraButtonsContainer.Position = UDim2.new(0, 5, 0, alturaLabel + 5 + 5)  -- 5 pixels de espaçamento entre título e botões
extraButtonsContainer.Visible = false

-- Criando o primeiro botão adicional
local extraButton1 = Instance.new("TextButton")
extraButton1.Parent = extraButtonsContainer
extraButton1.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Cinza médio para diferenciar
extraButton1.Size = UDim2.new(1, 0, 0, 25)

-- Atualiza a posição do container dos botões adicionais, adicionando espaçamento entre o título e os botões
extraButtonsContainer.Position = UDim2.new(0, 5, 0, alturaLabel + 5 + 5) -- 5 pixels entre o título e os botões

extraButton1.Font = Enum.Font.ArialBold
extraButton1.Text = "Botão Extra 1"
extraButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
extraButton1.TextSize = 14

local extraCorner1 = Instance.new("UICorner")
extraCorner1.Parent = extraButton1

-- Criando o segundo botão adicional
local extraButton2 = Instance.new("TextButton")
extraButton2.Parent = extraButtonsContainer
extraButton2.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Mesmo tom de cinza do primeiro extra
extraButton2.Size = UDim2.new(1, 0, 0, 25)
extraButton2.Position = UDim2.new(0, 0, 0, extraButton1.Size.Y.Offset + 5) -- 5 pixels de espaçamento
extraButton2.Font = Enum.Font.ArialBold
extraButton2.Text = "Botão Extra 2"
extraButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
extraButton2.TextSize = 14

local extraCorner2 = Instance.new("UICorner")
extraCorner2.Parent = extraButton2

-- Atualiza a posição dos créditos, com espaçamento de 5 pixels da parte inferior da tela
creditsLabel.Position = UDim2.new(0.5, -creditsLabel.Size.X.Offset / 2, 1, -creditsLabel.Size.Y.Offset - 5) -- 5 pixels de espaçamento

-----------------------------------------------------------------------------------------------------------

-- Função para expandir/retrair
local expanded = false

expandButton.MouseButton1Click:Connect(function()
    expanded = not expanded

    if expanded then
        madebybloodofbatus.Size = UDim2.new(0, 200, 0, 110) -- Aumenta a altura da barra principal
        creditsLabel.Visible = true -- Mostra os créditos
        extraButtonsContainer.Visible = true -- Mostra o container dos botões extras
        expandButton.Text = "-" -- Muda o texto do botão para contrair
    else
        madebybloodofbatus.Size = UDim2.new(0, 200, 0, 25) -- Volta ao tamanho original
        creditsLabel.Visible = false -- Esconde os créditos
        extraButtonsContainer.Visible = false -- Esconde o container dos botões extras
        expandButton.Text = "+" -- Muda o texto do botão para expandir
    end
end)

-----------------------------------------------------------------------------------------------------------

-- Label para créditos (inicialmente escondida)
creditsLabel.Name = "creditsLabel"
creditsLabel.Parent = madebybloodofbatus
creditsLabel.Text = "Discord: montovoni"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Size = UDim2.new(1, -50, 0, 20) -- Largura ajustada, altura fixa
creditsLabel.AnchorPoint = Vector2.new(0.5, 1) -- Centraliza horizontalmente e ancora na parte inferior
creditsLabel.Position = UDim2.new(0.5, 0, 1, -5) -- Centraliza horizontalmente e coloca 5 pixels acima da borda inferior
creditsLabel.Font = Enum.Font.Arial
creditsLabel.TextSize = 12
creditsLabel.Visible = false

creditsLabel.Font = Enum.Font.ArialBold
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.TextSize = 15

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