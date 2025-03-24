-- Espera até que o jogo esteja carregado e o jogador local esteja pronto
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

-------------------------------------------------------------------------------

-- Variaveis Globais
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-------------------------------------------------------------------------------

-- Variaveis para o Infinite Jump
local InfiniteJumpEnabled = false  -- Começa desativado

-- Função que permite o pulo infinito quando ativado
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-------------------------------------------------------------------------------

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local IYMouse = LocalPlayer:GetMouse()
local flyKeyDown, flyKeyUp

-- Função para obter a raiz do personagem
function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end

-- Variáveis de controle
FLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1

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

------------------------------------------------------

-- Cria a interface gráfica (GUI)
local thisoneissocoldww = Instance.new("ScreenGui")
local madebybloodofbatus = Instance.new("Frame")
local UICornerw = Instance.new("UICorner")
local uselesslabelone = Instance.new("TextLabel")
local expandButton = Instance.new("TextButton") -- Botão para expandir
local creditsLabel = Instance.new("TextLabel") -- Label para os créditos
local UICornerww = Instance.new("UICorner")

-------------------------------------------------------------------------------

-- Configurações da GUI
thisoneissocoldww.Name = "thisoneissocoldww"
thisoneissocoldww.Parent = game.CoreGui
thisoneissocoldww.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

madebybloodofbatus.Name = "madebybloodofbatus"
madebybloodofbatus.Parent = thisoneissocoldww
madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
madebybloodofbatus.Position = UDim2.new(0.0854133144, 0, 0.13128835, 0)
madebybloodofbatus.Size = UDim2.new(0, 230, 0, 25) -- Tamanho inicial da GUI

local UICornerw = Instance.new("UICorner") -- Cria o UICorner
UICornerw.Parent = madebybloodofbatus -- Define como filho da GUI principal
UICornerw.CornerRadius = UDim.new(0, 5) -- Define o arredondamento (5 pixels)

-------------------------------------------------------------------------------

-- Labels
uselesslabelone.Name = "uselesslabelone"
uselesslabelone.Parent = madebybloodofbatus
uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.BackgroundTransparency = 1.000
uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
uselesslabelone.Font = Enum.Font.SourceSans
uselesslabelone.Text = "Roblox"
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 16
uselesslabelone.TextXAlignment = Enum.TextXAlignment.Center
uselesslabelone.Position = UDim2.new(0.5, -uselesslabelone.Size.X.Offset / 2, 0, 0)

uselesslabelone.Font = Enum.Font.ArialBold
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 16

-------------------------------------------------------------------------------

-- Botão expandir
expandButton.Name = "expandButton"
expandButton.Parent = madebybloodofbatus
expandButton.BackgroundColor3 =  Color3.fromRGB(0, 0, 0)
expandButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- Cor do texto do botão
expandButton.Text = "+" -- Texto do botão
expandButton.Size = UDim2.new(0, 25, 0, 25) -- Tamanho do botão
expandButton.Position = UDim2.new(1, -25, 0, 0) -- Posição do botão no canto direito
expandButton.Font = Enum.Font.ArialBold
expandButton.TextSize = 16
expandButton.ZIndex = 2 -- Garante que o botão fique na frente

UICornerww.Name = "UICornerww"
UICornerww.Parent = expandButton

-------------------------------------------------------------------------------

-- Label para créditos (inicialmente escondida)
creditsLabel.Name = "creditsLabel"
creditsLabel.Parent = madebybloodofbatus
creditsLabel.Text = "Discord: montovoni"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.BackgroundTransparency = 1  -- Mantém a transparência para o fundo cinza aparecer

-- Largura ajustada e altura fixa, mas alinhamento à esquerda
creditsLabel.Size = UDim2.new(0, 200, 0, 20)  -- Largura ajustada, altura fixa
creditsLabel.AnchorPoint = Vector2.new(0.5, 1) -- Centraliza horizontalmente e ancora na parte inferior
creditsLabel.Position = UDim2.new(0.5, 0, 1, -5) -- Centraliza horizontalmente e coloca 5 pixels acima da borda inferior

-- Fonte e tamanho do texto
creditsLabel.Font = Enum.Font.ArialBold
creditsLabel.TextSize = 16
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Inicialmente invisível
creditsLabel.Visible = false

-------------------------------------------------------------------------------

-- Criando um contêiner para os botões adicionais
local extraButtonsContainer = Instance.new("Frame")
extraButtonsContainer.Name = "extraButtonsContainer"
extraButtonsContainer.Parent = madebybloodofbatus
extraButtonsContainer.BackgroundTransparency = 1
extraButtonsContainer.Size = UDim2.new(1, -10, 0, 120) -- Ajusta altura para comportar os botões

-- Ajuste a posição do contêiner com 5 pixels entre o título e os botões
local alturaLabel = uselesslabelone.Size.Y.Offset
extraButtonsContainer.Position = UDim2.new(0, 5, 0, alturaLabel + 10) -- 10 pixels de espaçamento entre título e botões
extraButtonsContainer.Visible = false

-- Criando um contêiner para os elementos 
local container = Instance.new("Frame")
container.Name = "Container"
container.Parent = extraButtonsContainer
container.BackgroundTransparency = 1
container.Size = UDim2.new(1, -10, 0, 90) -- Altura ajustada para acomodar todos os elementos
container.Position = UDim2.new(0, 5, 0, 0) -- Espaçamento de 5px da borda superior

-------------------------------------------------------------------------------

-- Ajuste do texto "Infinite Jump" para alinhá-lo à esquerda
local CheckboxJumpLabel = Instance.new("TextLabel")
CheckboxJumpLabel.Name = "CheckboxJumpLabel"
CheckboxJumpLabel.Parent = container
CheckboxJumpLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxJumpLabel.BackgroundTransparency = 1
CheckboxJumpLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxJumpLabel.Font = Enum.Font.ArialBold
CheckboxJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxJumpLabel.TextSize = 16
CheckboxJumpLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxJumpLabel.Text = "Infinite Jump"
CheckboxJumpLabel.Position = UDim2.new(0, 0, 0, 0) -- Posição no topo do container

-- Ajuste do CheckboxJump para quadrado, alinhado à direita
local CheckboxJump = Instance.new("Frame")
CheckboxJump.Name = "CheckboxJump"
CheckboxJump.Parent = container
CheckboxJump.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxJump.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxJump.Position = UDim2.new(1, -5, 0, 0) -- Alinha à direita, 5px de distância da borda direita
CheckboxJump.Size = UDim2.new(0, 18, 0, 18)
CheckboxJump.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxJump
local UICornerCheckboxJump = Instance.new("UICorner")
UICornerCheckboxJump.Parent = CheckboxJump
UICornerCheckboxJump.CornerRadius = UDim.new(0, 3)

-- CheckboxJumpButton permanece com as mesmas configurações
local CheckboxJumpButton = Instance.new("TextButton")
CheckboxJumpButton.Name = "CheckboxJumpButton"
CheckboxJumpButton.Parent = CheckboxJump
CheckboxJumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxJumpButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxJumpButton.Text = "✔️"

-- Arredondando levemente o CheckboxJumpButton
local UICornerCheckboxJumpButton = Instance.new("UICorner")
UICornerCheckboxJumpButton.Parent = CheckboxJumpButton
UICornerCheckboxJumpButton.CornerRadius = UDim.new(0, 3)

-- Variável de estado para o CheckboxJump
local isCheckedJump = false

-- Função para lidar com o clique no CheckboxJump
CheckboxJumpButton.MouseButton1Click:Connect(function()
    isCheckedJump = not isCheckedJump -- Inverte o estado

    if isCheckedJump then
        CheckboxJumpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
        InfiniteJumpEnabled = true  -- Ativa o pulo infinito
        CheckboxFlyButton.Active = false
        CheckboxFlyButton.Visible = false
    else
        CheckboxJumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
        InfiniteJumpEnabled = false  -- Desativa o pulo infinito
        CheckboxFlyButton.Active = true
        CheckboxFlyButton.Visible = true
    end
end)

-------------------------------------------------------------------------------

-- Label do Fly, alinhado à esquerda, abaixo do Infinite Jump
local CheckboxFlyLabel = Instance.new("TextLabel")
CheckboxFlyLabel.Name = "CheckboxFlyLabel"
CheckboxFlyLabel.Parent = container
CheckboxFlyLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxFlyLabel.BackgroundTransparency = 1
CheckboxFlyLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxFlyLabel.Position = UDim2.new(0, 0, 0, CheckboxJumpLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxFlyLabel.Font = Enum.Font.ArialBold
CheckboxFlyLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxFlyLabel.Text = "Fly Speed"
CheckboxFlyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxFlyLabel.TextSize = 16

-- Configurações da GUI para o Fly, alinhado à direita
local CheckboxFly = Instance.new("Frame")
CheckboxFly.Name = "CheckboxFly"
CheckboxFly.Parent = container
CheckboxFly.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxFly.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxFly.Position = UDim2.new(1, -5, 0, CheckboxJumpLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxFly.Size = UDim2.new(0, 18, 0, 18)
CheckboxFly.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxFly
local UICornerFly = Instance.new("UICorner")
UICornerFly.Parent = CheckboxFly
UICornerFly.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxFlyButton
local CheckboxFlyButton = Instance.new("TextButton")
CheckboxFlyButton.Name = "CheckboxFlyButton"
CheckboxFlyButton.Parent = CheckboxFly
CheckboxFlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxFlyButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxFlyButton.Text = "✔️"

-- Levemente arredondando as pontas do CheckboxFlyButton
local UICornerCheckboxFlyButton = Instance.new("UICorner")
UICornerCheckboxFlyButton.Parent = CheckboxFlyButton
UICornerCheckboxFlyButton.CornerRadius = UDim.new(0, 3)

-- Variável de estado para o CheckboxFly
local isFlyEnabled = false

-- Função para lidar com o clique no CheckboxFly
CheckboxFlyButton.MouseButton1Click:Connect(function()
    isFlyEnabled = not isFlyEnabled -- Inverte o estado

    if isFlyEnabled then
        CheckboxFlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
        sFLY()  -- Ativa o fly
        CheckboxJumpButton.Active = false
        CheckboxJumpButton.Visible = false
    else
        CheckboxFlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
        NOFLY()  -- Desativa o fly
        CheckboxJumpButton.Active = true
        CheckboxJumpButton.Visible = true
    end
end)

-------------------------------------------------------------------------------

-- Label do ESP, alinhado à esquerda, abaixo do Fly Speed
local COREGUI = game:GetService("CoreGui")
local CheckboxEspLabel = Instance.new("TextLabel")

CheckboxEspLabel.Name = "CheckboxEspLabel"
CheckboxEspLabel.Parent = container
CheckboxEspLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxEspLabel.BackgroundTransparency = 1
CheckboxEspLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxEspLabel.Position = UDim2.new(0, 0, 0, CheckboxFlyLabel.Position.Y.Offset + CheckboxFlyLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxEspLabel.Font = Enum.Font.ArialBold
CheckboxEspLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxEspLabel.Text = "Esp Players"
CheckboxEspLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxEspLabel.TextSize = 16

-- Configurações da GUI para o ESP, alinhado à direita
local CheckboxEsp = Instance.new("Frame")
CheckboxEsp.Name = "CheckboxEsp"
CheckboxEsp.Parent = container
CheckboxEsp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxEsp.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxEsp.Position = UDim2.new(1, -5, 0, CheckboxFlyLabel.Position.Y.Offset + CheckboxFlyLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxEsp.Size = UDim2.new(0, 18, 0, 18)
CheckboxEsp.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxEsp
local UICornerEsp = Instance.new("UICorner")
UICornerEsp.Parent = CheckboxEsp
UICornerEsp.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxEspButton
local CheckboxEspButton = Instance.new("TextButton")
CheckboxEspButton.Name = "CheckboxEspButton"
CheckboxEspButton.Parent = CheckboxEsp
CheckboxEspButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxEspButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxEspButton.Text = "✔️"

local isESPEnabled = false 

-- Levemente arredondando as pontas do CheckboxEspButton
local UICornerCheckboxEspButton = Instance.new("UICorner")
UICornerCheckboxEspButton.Parent = CheckboxEspButton
UICornerCheckboxEspButton.CornerRadius = UDim.new(0, 3)

-- Evento de clique do CheckboxEspButton (modificado)
CheckboxEspButton.MouseButton1Click:Connect(function()
    isESPEnabled = not isESPEnabled

    if isESPEnabled then
        CheckboxEspButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        CheckboxEspButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end

    -- Alterna o ESP conforme o estado
    toggleESP()
end)

-------------------------------------------------------------------------------

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Plr = game.Players.LocalPlayer

local Clipon = false
local Stepped

-- Label do Noclip, alinhado à esquerda, abaixo do ESP Players
local CheckboxNoclipLabel = Instance.new("TextLabel")
CheckboxNoclipLabel.Name = "CheckboxNoclipLabel"
CheckboxNoclipLabel.Parent = container
CheckboxNoclipLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxNoclipLabel.BackgroundTransparency = 1
CheckboxNoclipLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxNoclipLabel.Position = UDim2.new(0, 0, 0, CheckboxEspLabel.Position.Y.Offset + CheckboxEspLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxNoclipLabel.Font = Enum.Font.ArialBold
CheckboxNoclipLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxNoclipLabel.Text = "Noclip"
CheckboxNoclipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxNoclipLabel.TextSize = 16

-- Configurações da GUI para o Noclip, alinhado à direita
local CheckboxNoclip = Instance.new("Frame")
CheckboxNoclip.Name = "CheckboxNoclip"
CheckboxNoclip.Parent = container
CheckboxNoclip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxNoclip.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxNoclip.Position = UDim2.new(1, -5, 0, CheckboxEspLabel.Position.Y.Offset + CheckboxEspLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxNoclip.Size = UDim2.new(0, 18, 0, 18)
CheckboxNoclip.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxNoclip
local UICornerNoclip = Instance.new("UICorner")
UICornerNoclip.Parent = CheckboxNoclip
UICornerNoclip.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxNoclipButton
local CheckboxNoclipButton = Instance.new("TextButton")
CheckboxNoclipButton.Name = "CheckboxNoclipButton"
CheckboxNoclipButton.Parent = CheckboxNoclip
CheckboxNoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxNoclipButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxNoclipButton.Text = "✔️"

-- Levemente arredondando as pontas do CheckboxNoclipButton
local UICornerCheckboxNoclipButton = Instance.new("UICorner")
UICornerCheckboxNoclipButton.Parent = CheckboxNoclipButton
UICornerCheckboxNoclipButton.CornerRadius = UDim.new(0, 3)

local function ToggleNoclip(enabled)
    Clipon = enabled -- Define o estado do noclip baseado no parâmetro

    if Clipon then
        -- Ativar noclip
        Stepped = RunService.Stepped:Connect(function()
            if Plr.Character then
                for _, part in pairs(Plr.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        -- Desativar noclip
        if Stepped then
            Stepped:Disconnect()
        end
    end
end

-- Função para lidar com o clique no CheckboxNoclip
CheckboxNoclipButton.MouseButton1Click:Connect(function()
    isNoclipEnabled = not isNoclipEnabled -- Inverte o estado

    if isNoclipEnabled then
        CheckboxNoclipButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
    else
        CheckboxNoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
    end

    ToggleNoclip(isNoclipEnabled) -- Chama a função ToggleNoclip com o estado atual
end)

-------------------------------------------------------------------------------

local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
local RunService = game:GetService("RunService")
local isTyping = false

-- Variável global para armazenar a velocidade do voo
local Speed = humanoid.WalkSpeed

local CheckboxWalkSpeedLabel = Instance.new("TextLabel")

-- Label do Walk Speed, alinhado à esquerda, abaixo do Noclip
CheckboxWalkSpeedLabel.Name = "CheckboxWalkSpeedLabel"
CheckboxWalkSpeedLabel.Parent = container
CheckboxWalkSpeedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxWalkSpeedLabel.BackgroundTransparency = 1
CheckboxWalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxWalkSpeedLabel.Position = UDim2.new(0, 0, 0, CheckboxNoclipLabel.Position.Y.Offset + CheckboxNoclipLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxWalkSpeedLabel.Font = Enum.Font.ArialBold
CheckboxWalkSpeedLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxWalkSpeedLabel.Text = "Walk Speed"
CheckboxWalkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxWalkSpeedLabel.TextSize = 16

-- TextBox para Walk Speed (alinhado à direita)
local WalkSpeedTextBox = Instance.new("TextBox")
WalkSpeedTextBox.Name = "WalkSpeedTextBox"
WalkSpeedTextBox.Parent = container
WalkSpeedTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WalkSpeedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedTextBox.Font = Enum.Font.ArialBold
WalkSpeedTextBox.TextSize = 14
WalkSpeedTextBox.Size = UDim2.new(0, 50, 0, 20) -- Tamanho ajustado

-- Alinhamento à direita

WalkSpeedTextBox.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
WalkSpeedTextBox.Position = UDim2.new(1, -5, 0, CheckboxNoclip.Position.Y.Offset + CheckboxNoclip.Size.Y.Offset + 10)
WalkSpeedTextBox.PlaceholderText = "Speed" -- Texto de dica
WalkSpeedTextBox.Text = tostring(humanoid.WalkSpeed) -- Valor inicial

-- Evento para quando o jogador pressiona Enter dentro do TextBox
WalkSpeedTextBox.FocusLost:Connect(function(focusLost)
    if focusLost then
        local newSpeed = tonumber(WalkSpeedTextBox.Text)
        if newSpeed and newSpeed > 0 then
            humanoid.WalkSpeed = newSpeed
            Speed = newSpeed -- Atualiza a variável global Speed
            WalkSpeedTextBox.Text = newSpeed
        else
            WalkSpeedTextBox.Text = tostring(humanoid.WalkSpeed)
            warn("Valor de WalkSpeed inválido. Usando valor padrão.")
        end
    end
end)

-- Evento para quando o texto do TextBox é alterado (opcional)
WalkSpeedTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    local newSpeed = tonumber(WalkSpeedTextBox.Text)
    if newSpeed and newSpeed > 0 then
        WalkSpeedTextBox.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        WalkSpeedTextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Quando o jogador começa a digitar, marcamos que ele está editando o campo
WalkSpeedTextBox.Focused:Connect(function()
    isTyping = true
end)

-- Quando o jogador perde o foco (pressiona Enter ou clica fora), aplicamos a mudança
WalkSpeedTextBox.FocusLost:Connect(function(focusLost)
    isTyping = false
    if focusLost then
        local newSpeed = tonumber(WalkSpeedTextBox.Text)
        if newSpeed and newSpeed > 0 then
            humanoid.WalkSpeed = newSpeed
            Speed = newSpeed -- Atualiza a variável global Speed
        else
            WalkSpeedTextBox.Text = tostring(humanoid.WalkSpeed)
            warn("Valor de WalkSpeed inválido. Usando valor padrão.")
        end
    end
end)

-- Atualiza o TextBox apenas se o jogador não estiver digitando
RunService.RenderStepped:Connect(function()
    if not isTyping then
        WalkSpeedTextBox.Text = tostring(humanoid.WalkSpeed)
    end
end)

-------------------------------------------------------------------------------

-- Botão Rejoin
local RejoinButton = Instance.new("TextButton")
RejoinButton.Name = "RejoinButton"
RejoinButton.Parent = container
RejoinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RejoinButton.Size = UDim2.new(0, 206, 0, 25) -- Tamanho do botão
RejoinButton.Position = UDim2.new(0, 0, 0, WalkSpeedTextBox.Position.Y.Offset + WalkSpeedTextBox.Size.Y.Offset + 10)

-- Arredondando as pontas do botão
local UICornerRejoinButton = Instance.new("UICorner")
UICornerRejoinButton.Parent = RejoinButton
UICornerRejoinButton.CornerRadius = UDim.new(0, 5)

RejoinButton.Text = "Rejoin"
RejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinButton.TextSize = 16
RejoinButton.Font = Enum.Font.ArialBold

-- Função para reentrar na partida
RejoinButton.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

-------------------------------------------------------------------------------

-- Função para expandir/retrair a GUI
local expanded = false
expandButton.MouseButton1Click:Connect(function()
    expanded = not expanded

    if expanded then
        -- Aumenta a altura da barra principal
        madebybloodofbatus.Size = UDim2.new(0, 230, 0, 240)
        creditsLabel.Visible = true  -- Mostra os créditos
        expandButton.Text = "-"  -- Muda o texto do botão para contrair
        extraButtonsContainer.Visible = true  -- Mostra os botões adicionais (CheckboxJump)
		creditsBackground.Visible = true -- Mostra o fundo cinza
    else
        -- Volta ao tamanho original
        madebybloodofbatus.Size = UDim2.new(0, 200, 0, 25)
        creditsLabel.Visible = false  -- Esconde os créditos
        expandButton.Text = "+"  -- Muda o texto do botão para expandir
        extraButtonsContainer.Visible = false  -- Esconde os botões adicionais (CheckboxJump)
		creditsBackground.Visible = false -- Esconde o fundo cinza
    end
end)

-------------------------------------------------------------------------------

-- Função para arrastar a GUI pela tela
local Drag = game.CoreGui.thisoneissocoldww.madebybloodofbatus
gsCoreGui = game:GetService("CoreGui")
gsTween = game:GetService("TweenService")
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

-- Função de voo (sFLY) atualizada para usar a variável global Speed
function sFLY(vfly)
    repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat wait() until IYMouse

    if flyKeyDown then flyKeyDown:Disconnect() end
    if flyKeyUp then flyKeyUp:Disconnect() end

    local T = getRoot(Players.LocalPlayer.Character)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat wait()
                if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = Speed -- Usa a variável global Speed
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = workspace.CurrentCamera.CoordinateFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            end
        end)
    end

    -- Verifica o estado das teclas imediatamente após ativar o fly
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
    end
    if QEfly and UserInputService:IsKeyDown(Enum.KeyCode.E) then
        CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
    end
    if QEfly and UserInputService:IsKeyDown(Enum.KeyCode.Q) then
        CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
    end

    -- Reconecta os eventos de teclado
    flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
        if KEY:lower() == 'w' then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 's' then
            CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 'a' then
            CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 'd' then 
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif QEfly and KEY:lower() == 'e' then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
        elseif QEfly and KEY:lower() == 'q' then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
    end)

    flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
        if KEY:lower() == 'w' then
            CONTROL.F = 0
        elseif KEY:lower() == 's' then
            CONTROL.B = 0
        elseif KEY:lower() == 'a' then
            CONTROL.L = 0
        elseif KEY:lower() == 'd' then
            CONTROL.R = 0
        elseif KEY:lower() == 'e' then
            CONTROL.Q = 0
        elseif KEY:lower() == 'q' then
            CONTROL.E = 0
        end
    end)

    FLY()
end

-- Função para desativar o fly
function NOFLY()
    FLYING = false
    if flyKeyDown then flyKeyDown:Disconnect() end
    if flyKeyUp then flyKeyUp:Disconnect() end
    if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

-------------------------------------------------------------------------------

-- Função para arredondar valores
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Função principal de ESP
function ESP(plr)
    task.spawn(function()
        -- Verifica se a ESP já foi criada para o jogador
        for i,v in pairs(COREGUI:GetChildren()) do
            if v.Name == plr.Name..'_ESP' then
                v:Destroy()
            end
        end
        wait()
        
        -- Garante que o personagem está presente e válido
        if plr.Character and plr.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name..'_ESP') then
            local ESPholder = Instance.new("Folder")
            ESPholder.Name = plr.Name..'_ESP'
            ESPholder.Parent = COREGUI
            repeat wait(1) until plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            
            -- Cria adornos (caixas) para cada parte do corpo
            for b,n in pairs(plr.Character:GetChildren()) do
                if n:IsA("BasePart") then
                    local a = Instance.new("BoxHandleAdornment")
                    a.Name = plr.Name
                    a.Parent = ESPholder
                    a.Adornee = n
                    a.AlwaysOnTop = true
                    a.ZIndex = 10
                    a.Size = n.Size
                    a.Transparency = 0.3
                    a.Color = plr.TeamColor
                end
            end
            
            -- Cria o BillboardGui com o nome e saúde do jogador
            if plr.Character and plr.Character:FindFirstChild('Head') then
                local BillboardGui = Instance.new("BillboardGui")
                local TextLabel = Instance.new("TextLabel")
                BillboardGui.Adornee = plr.Character.Head
                BillboardGui.Name = plr.Name
                BillboardGui.Parent = ESPholder
                BillboardGui.Size = UDim2.new(0, 100, 0, 150)
                BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
                BillboardGui.AlwaysOnTop = true
                TextLabel.Parent = BillboardGui
                TextLabel.BackgroundTransparency = 1
                TextLabel.Position = UDim2.new(0, 0, 0, -50)
                TextLabel.Size = UDim2.new(0, 100, 0, 100)
                TextLabel.Font = Enum.Font.SourceSansSemibold
                TextLabel.TextSize = 20
                TextLabel.TextColor3 = Color3.new(1, 1, 1)
                TextLabel.TextStrokeTransparency = 0
                TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
                TextLabel.Text = 'Name: '..plr.Name
                
                -- Atualiza a informação no label a cada frame
                game:GetService("RunService").RenderStepped:Connect(function()
                    if COREGUI:FindFirstChild(plr.Name..'_ESP') then
                        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                            local pos = math.floor((Players.LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude)
                            TextLabel.Text = plr.Name..' | ' .. round(plr.Character:FindFirstChildOfClass('Humanoid').Health, 1) .. ' | '..pos
                        end
                    end
                end)
            end
        end
    end)
end

-- Função para alternar o ESP
function toggleESP()
    if isESPEnabled then
        -- Executa a função de ESP para todos os jogadores atuais
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                ESP(plr)
            end
        end
    else
        -- Remove o ESP para todos os jogadores
        for _, plr in pairs(Players:GetPlayers()) do
            for i,v in pairs(COREGUI:GetChildren()) do
                if v.Name == plr.Name..'_ESP' then
                    v:Destroy()
                end
            end
        end
    end
end

-- Conectar a função para novos jogadores que entrarem no jogo
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if isESPEnabled then
            ESP(plr)
        end
    end)
end)

-- Conectar a função para jogadores que saírem do jogo
Players.PlayerRemoving:Connect(function(player)
    for i,v in pairs(COREGUI:GetChildren()) do
        if v.Name == player.Name..'_ESP' then
            v:Destroy()
        end
    end
end)

--------------------------------------------------------------


--------------------------------------------------------------z