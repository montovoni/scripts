-- Espera até que o jogo esteja carregado e o jogador local esteja pronto
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

-------------------------------------------------------------------------------

-- Verifica se a GUI já existe e a destrói antes de recriar
if game.CoreGui:FindFirstChild("Gui122874030534085") then
    game.CoreGui.Gui122874030534085:Destroy()
end

------------------------------------------------------------------------------- GLOBAL

-- Variáveis globais (acessíveis por todo o script)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = Character:WaitForChild("Humanoid")

-- Sempre atualizar o Character quando o jogador respawnar
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
end)

-- Função para obter o HumanoidRootPart de forma segura
local function getHumanoidRootPart()
    if Character then
        return Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- Função para arredondar números
local function round(num, decimalPlaces)
    local mult = 10^(decimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Função para obter a raiz do personagem
local function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end

-------------------------------------------------------------------------------
-- Cria a interface gráfica (GUI)
local Gui122874030534085 = Instance.new("ScreenGui")
local madebybloodofbatus = Instance.new("Frame")
local UICornerw = Instance.new("UICorner")
local uselesslabelone = Instance.new("TextLabel")
local expandButton = Instance.new("TextButton") -- Botão para expandir
local creditsLabel = Instance.new("TextLabel") -- Label para os créditos
local UICornerww = Instance.new("UICorner")

-- Configurações da GUI
Gui122874030534085.Name = "Gui122874030534085"
Gui122874030534085.Parent = game.CoreGui
Gui122874030534085.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

madebybloodofbatus.Name = "madebybloodofbatus"
madebybloodofbatus.Parent = Gui122874030534085
madebybloodofbatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
madebybloodofbatus.Position = UDim2.new(0.0854133144, 0, 0.13128835, 0)
madebybloodofbatus.Size = UDim2.new(0, 230, 0, 25) -- Tamanho inicial da GUI

UICornerw.Parent = madebybloodofbatus
UICornerw.CornerRadius = UDim.new(0, 5)

-------------------------------------------------------------------------------

-- Labels
uselesslabelone.Name = "uselesslabelone"
uselesslabelone.Parent = madebybloodofbatus
uselesslabelone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.BackgroundTransparency = 1.000
uselesslabelone.Size = UDim2.new(0, 95, 0, 24)
uselesslabelone.Font = Enum.Font.SourceSans
uselesslabelone.Text = "Potato Hell BackRooms"
uselesslabelone.TextColor3 = Color3.fromRGB(255, 255, 255)
uselesslabelone.TextSize = 16
uselesslabelone.TextXAlignment = Enum.TextXAlignment.Center
uselesslabelone.Position = UDim2.new(0.5, -uselesslabelone.Size.X.Offset / 2, 0, 0)
uselesslabelone.Font = Enum.Font.ArialBold

-------------------------------------------------------------------------------

-- Botão expandir
expandButton.Name = "expandButton"
expandButton.Parent = madebybloodofbatus
expandButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
expandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
expandButton.Text = "+"
expandButton.Size = UDim2.new(0, 25, 0, 25)
expandButton.Position = UDim2.new(1, -25, 0, 0)
expandButton.Font = Enum.Font.ArialBold
expandButton.TextSize = 16
expandButton.ZIndex = 2

UICornerww.Parent = expandButton

-------------------------------------------------------------------------------

-- Label para créditos (inicialmente escondida)
creditsLabel.Name = "creditsLabel"
creditsLabel.Parent = madebybloodofbatus
creditsLabel.Text = "Discord: montovoni"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Size = UDim2.new(0, 200, 0, 20)
creditsLabel.AnchorPoint = Vector2.new(0.5, 1)
creditsLabel.Position = UDim2.new(0.5, 0, 1, -5)
creditsLabel.Font = Enum.Font.ArialBold
creditsLabel.TextSize = 16
creditsLabel.Visible = false

-------------------------------------------------------------------------------

-- Criando um contêiner para os botões adicionais
local extraButtonsContainer = Instance.new("Frame")
extraButtonsContainer.Name = "extraButtonsContainer"
extraButtonsContainer.Parent = madebybloodofbatus
extraButtonsContainer.BackgroundTransparency = 1
extraButtonsContainer.Size = UDim2.new(1, -10, 0, 60)
extraButtonsContainer.Position = UDim2.new(0, 5, 0, uselesslabelone.Size.Y.Offset + 10)
extraButtonsContainer.Visible = false

-- Criação do container
local checkboxContainer = Instance.new("Frame")
checkboxContainer.Name = "CheckboxContainer"
checkboxContainer.Parent = extraButtonsContainer
checkboxContainer.BackgroundTransparency = 1
checkboxContainer.Size = UDim2.new(1, -10, 0, 20)
checkboxContainer.Position = UDim2.new(0, 5, 0, 0)

-------------------------------------------------------------------------------

Lighting = cloneref(game:GetService("Lighting"))
local isFullbrightEnabled = false

-- Armazenar as configurações originais de iluminação
local origsettings = {
    abt = Lighting.Ambient,
    oabt = Lighting.OutdoorAmbient,
    brt = Lighting.Brightness,
    time = Lighting.ClockTime,
    fe = Lighting.FogEnd,
    fs = Lighting.FogStart,
    gs = Lighting.GlobalShadows
}

-- Função para aplicar o fullbright
local function applyFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

-- Função para restaurar as configurações originais
local function restoreLighting()
    Lighting.Ambient = origsettings.abt
    Lighting.OutdoorAmbient = origsettings.oabt
    Lighting.Brightness = origsettings.brt
    Lighting.ClockTime = origsettings.time
    Lighting.FogEnd = origsettings.fe
    Lighting.FogStart = origsettings.fs
    Lighting.GlobalShadows = origsettings.gs
end

-- Criação do CheckboxFullbrightLabel
local CheckboxFullbrightLabel = Instance.new("TextLabel")
CheckboxFullbrightLabel.Name = "CheckboxFullbrightLabel"
CheckboxFullbrightLabel.Parent = checkboxContainer
CheckboxFullbrightLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxFullbrightLabel.BackgroundTransparency = 1
CheckboxFullbrightLabel.TextXAlignment = Enum.TextXAlignment.Left
CheckboxFullbrightLabel.Font = Enum.Font.ArialBold
CheckboxFullbrightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxFullbrightLabel.TextSize = 16
CheckboxFullbrightLabel.Size = UDim2.new(0, 100, 0, 20)
CheckboxFullbrightLabel.Text = "Fullbright"
CheckboxFullbrightLabel.Position = UDim2.new(0, 0, 0, 0)

-- Criação do CheckboxFullbright
local CheckboxFullbright = Instance.new("Frame")
CheckboxFullbright.Name = "CheckboxFullbright"
CheckboxFullbright.Parent = checkboxContainer
CheckboxFullbright.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxFullbright.AnchorPoint = Vector2.new(1, 0)
CheckboxFullbright.Position = UDim2.new(1, -5, 0, 0)
CheckboxFullbright.Size = UDim2.new(0, 18, 0, 18)
CheckboxFullbright.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Arredondando as pontas do CheckboxFullbright
local UICornerCheckboxFullbright = Instance.new("UICorner")
UICornerCheckboxFullbright.Parent = CheckboxFullbright
UICornerCheckboxFullbright.CornerRadius = UDim.new(0, 3)

-- Criação do CheckboxFullbrightButton
local CheckboxFullbrightButton = Instance.new("TextButton")
CheckboxFullbrightButton.Name = "CheckboxFullbrightButton"
CheckboxFullbrightButton.Parent = CheckboxFullbright
CheckboxFullbrightButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxFullbrightButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxFullbrightButton.Text = "✔️"

-- Arredondando o CheckboxFullbrightButton
local UICornerCheckboxFullbrightButton = Instance.new("UICorner")
UICornerCheckboxFullbrightButton.Parent = CheckboxFullbrightButton
UICornerCheckboxFullbrightButton.CornerRadius = UDim.new(0, 3)

-- Função para lidar com o clique no CheckboxFullbright
CheckboxFullbrightButton.MouseButton1Click:Connect(function()
    isFullbrightEnabled = not isFullbrightEnabled -- Inverte o estado

    if isFullbrightEnabled then
        CheckboxFullbrightButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
        applyFullbright() -- Aplica o fullbright
    else
        CheckboxFullbrightButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
        restoreLighting() -- Restaura as configurações originais
    end
end)

-------------------------------------------------------------------------------

local zombiesFolder = workspace:FindFirstChild("ZombieSystem") and workspace.ZombieSystem:FindFirstChild("Zombies")
local isEspZombiesEnabled = false

-- Esp Zombie
local CheckboxZombiesLabel = Instance.new("TextLabel")
CheckboxZombiesLabel.Name = "CheckboxZombiesLabel"
CheckboxZombiesLabel.Parent = checkboxContainer
CheckboxZombiesLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxZombiesLabel.BackgroundTransparency = 1
CheckboxZombiesLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxZombiesLabel.Position = UDim2.new(0, 0, 0, CheckboxFullbrightLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxZombiesLabel.Font = Enum.Font.ArialBold
CheckboxZombiesLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxZombiesLabel.Text = "Esp Zombies"
CheckboxZombiesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxZombiesLabel.TextSize = 16

local CheckboxZombies = Instance.new("Frame")
CheckboxZombies.Name = "CheckboxZombies"
CheckboxZombies.Parent = checkboxContainer
CheckboxZombies.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxZombies.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxZombies.Position = UDim2.new(1, -5, 0, CheckboxFullbrightLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxZombies.Size = UDim2.new(0, 18, 0, 18)
CheckboxZombies.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxZombies
local UICornerCheckboxZombies = Instance.new("UICorner")
UICornerCheckboxZombies.Parent = CheckboxZombies
UICornerCheckboxZombies.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxZombiesButton
local CheckboxZombiesButton = Instance.new("TextButton")
CheckboxZombiesButton.Name = "CheckboxZombiesButton"
CheckboxZombiesButton.Parent = CheckboxZombies
CheckboxZombiesButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxZombiesButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxZombiesButton.Text = "✔️"

-- Levemente arredondando as pontas do CheckboxZombiesButton
local UICornerCheckboxZombiesButton = Instance.new("UICorner")
UICornerCheckboxZombiesButton.Parent = CheckboxZombiesButton
UICornerCheckboxZombiesButton.CornerRadius = UDim.new(0, 3)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Função para criar ESP nos zumbis (apenas texto)
local function createZombieESP(zombie)
    -- Verifica se o ESP já existe
    if zombie:FindFirstChild("ESP") then
        zombie.ESP:Destroy()
    end

    -- Cria um folder para armazenar os elementos do ESP
    local ESPholder = Instance.new("Folder")
    ESPholder.Name = "ESP"
    ESPholder.Parent = zombie

    -- Aguarda até que o zumbi tenha um Humanoid válido
    local humanoid = zombie:FindFirstChildOfClass("Humanoid")
    local rootPart = zombie:FindFirstChild("HumanoidRootPart")

    if not humanoid or not rootPart then return end

    -- Criar BillboardGui para mostrar nome e distância do zumbi
    if zombie:FindFirstChild("Head") then
        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")

        BillboardGui.Adornee = zombie.Head
        BillboardGui.Name = "ZombieInfo"
        BillboardGui.Parent = ESPholder
        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
        BillboardGui.StudsOffset = Vector3.new(0, 3.5, 0) -- Posiciona acima da cabeça
        BillboardGui.AlwaysOnTop = true

        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.SourceSansBold
        TextLabel.TextSize = 18
        TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Texto verde
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextYAlignment = Enum.TextYAlignment.Top

		-- Atualiza o texto do ESP a cada frame
		local connection
		connection = RunService.RenderStepped:Connect(function()
			-- Verifica se o zumbi ainda existe, caso contrário, desconecta a conexão
			if not zombie or not zombie.Parent or not humanoid or humanoid.Health <= 0 then
				if ESPholder then
					ESPholder:Destroy()
				end
				connection:Disconnect()
				return
			end

			local distance = (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and 
				(localPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) or 0

			TextLabel.Text = "Zombie | " .. round(distance, 1) .. "m"
		end)
    end
end

-- Função para ativar/desativar ESP em todos os zumbis
local function updateZombieESP()
    if not zombiesFolder then return end

    for _, zombie in ipairs(zombiesFolder:GetChildren()) do
        if zombie:IsA("Model") and zombie:FindFirstChildOfClass("Humanoid") then
            if isEspZombiesEnabled then
                createZombieESP(zombie)
            else
                -- Remove o ESP se existir
                local ESPholder = zombie:FindFirstChild("ESP")
                if ESPholder then
                    ESPholder:Destroy()
                end
            end
        end
    end
end

-- Monitorar novos zumbis que aparecem
if zombiesFolder then
    zombiesFolder.ChildAdded:Connect(function(zombie)
        wait(1) -- Espera um pouco para garantir que o modelo carregou
        if isEspZombiesEnabled and zombie:IsA("Model") then
            createZombieESP(zombie)
        end
    end)
end

-- Ativar/desativar ESP ao clicar no checkbox
CheckboxZombiesButton.MouseButton1Click:Connect(function()
    isEspZombiesEnabled = not isEspZombiesEnabled

    if isEspZombiesEnabled then
        CheckboxZombiesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando ativado
    else
        CheckboxZombiesButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desativado
    end

    updateZombieESP() -- Atualiza o ESP para todos os zumbis
end)

-------------------------------------------------------------------------------

local isGeneratorEnabled = false
local generatorPart = nil
local isCheckingForGenerator = true

-- Atualiza a referência do Character sempre que o jogador respawnar
LocalPlayer.CharacterAdded:Connect(function(character)
    Character = character
end)

-- Função para verificar se a pasta generatorPart existe
local function checkGeneratorPart()
    -- Verifica o primeiro local
    if workspace:FindFirstChild("backrooms area 1") and workspace["backrooms area 1"]:FindFirstChild("gen_area") and workspace["backrooms area 1"].gen_area:FindFirstChild("generator") then
        generatorPart = workspace["backrooms area 1"].gen_area.generator.Screen
        return true
    -- Verifica o segundo local
    elseif workspace:FindFirstChild("01_subway") and workspace["01_subway"]:FindFirstChild("genarea") and workspace["01_subway"].genarea:FindFirstChild("generator") then
        generatorPart = workspace["01_subway"].genarea.generator.Screen
        return true
    else
        generatorPart = nil
        return false
    end
end

-- Função para criar ESP no gerador
local function createGeneratorESP(part)
    if not part then return end -- Verifica se a parte existe
    
    -- Verifica se o ESP já existe
    if part:FindFirstChild("ESP") then
        part.ESP:Destroy()
    end

    -- Cria um folder para armazenar os elementos do ESP
    local ESPholder = Instance.new("Folder")
    ESPholder.Name = "ESP"
    ESPholder.Parent = part

    -- Criar BillboardGui para mostrar informações do gerador
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")

    BillboardGui.Adornee = part
    BillboardGui.Name = "GeneratorInfo"
    BillboardGui.Parent = ESPholder
    BillboardGui.Size = UDim2.new(0, 100, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 3.5, 0) -- Posição acima do gerador
    BillboardGui.AlwaysOnTop = true

    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextSize = 18
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top

    -- Atualiza o texto do ESP a cada frame
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not part or not part.Parent then
            ESPholder:Destroy()
            connection:Disconnect()
            return
        end

        -- Obtém o HumanoidRootPart com segurança
        local humanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local distance = 0

        if humanoidRootPart then
            distance = (humanoidRootPart.Position - part.Position).Magnitude
        end

        -- Atualiza o texto com o nome "Generator" e a distância
        TextLabel.Text = "Generator | " .. string.format("%.1f", distance) .. "m"
    end)
end

-- Função para ativar/desativar o ESP do gerador
local function toggleGeneratorESP()
    if isGeneratorEnabled then
        -- Verifica se a pasta generatorPart existe
        if checkGeneratorPart() then
            -- Aplica o ESP ao gerador
            createGeneratorESP(generatorPart)
        else
            warn("GeneratorPart não encontrado. Verifique se o jogo foi iniciado corretamente.")
        end
    else
        -- Remove o ESP do gerador
        if generatorPart and generatorPart:FindFirstChild("ESP") then
            generatorPart.ESP:Destroy()
        end
    end
end

-- Verificar continuamente se a pasta generatorPart foi adicionada
local function waitForGeneratorPart()
    while isCheckingForGenerator do
        if checkGeneratorPart() then
            -- Quando a pasta for encontrada, ative o ESP se estiver habilitado
            if isGeneratorEnabled then
                toggleGeneratorESP()
            end
            isCheckingForGenerator = false -- Para o loop de verificação
            break
        end
        wait(1) -- Espera 1 segundo antes de verificar novamente
    end
end

-- Iniciar a verificação em uma nova thread para não bloquear a GUI
spawn(waitForGeneratorPart)

-- Esp Generator
local CheckboxGeneratorLabel = Instance.new("TextLabel")
CheckboxGeneratorLabel.Name = "CheckboxGeneratorLabel"
CheckboxGeneratorLabel.Parent = checkboxContainer
CheckboxGeneratorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxGeneratorLabel.BackgroundTransparency = 1
CheckboxGeneratorLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxGeneratorLabel.Position = UDim2.new(0, 0, 0, CheckboxZombiesLabel.Position.Y.Offset + CheckboxZombiesLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxGeneratorLabel.Font = Enum.Font.ArialBold
CheckboxGeneratorLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxGeneratorLabel.Text = "Esp Generator"
CheckboxGeneratorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxGeneratorLabel.TextSize = 16

local CheckboxGenerator = Instance.new("Frame")
CheckboxGenerator.Name = "CheckboxGenerator"
CheckboxGenerator.Parent = checkboxContainer
CheckboxGenerator.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxGenerator.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxGenerator.Position = UDim2.new(1, -5, 0, CheckboxZombiesLabel.Position.Y.Offset + CheckboxZombiesLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxGenerator.Size = UDim2.new(0, 18, 0, 18)
CheckboxGenerator.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxGenerator
local UICornerGenerator = Instance.new("UICorner")
UICornerGenerator.Parent = CheckboxGenerator
UICornerGenerator.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxGeneratorButton
local CheckboxGeneratorButton = Instance.new("TextButton")
CheckboxGeneratorButton.Name = "CheckboxGeneratorButton"
CheckboxGeneratorButton.Parent = CheckboxGenerator
CheckboxGeneratorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxGeneratorButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxGeneratorButton.Text = "✔️"

-- Levemente arredondando as pontas do CheckboxGeneratorButton
local UICornerCheckboxGeneratorButton = Instance.new("UICorner")
UICornerCheckboxGeneratorButton.Parent = CheckboxGeneratorButton
UICornerCheckboxGeneratorButton.CornerRadius = UDim.new(0, 3)

-- Conectar o clique do botão para ativar/desativar o ESP
CheckboxGeneratorButton.MouseButton1Click:Connect(function()
    isGeneratorEnabled = not isGeneratorEnabled -- Inverte o estado

    if isGeneratorEnabled then
        CheckboxGeneratorButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando marcado
        toggleGeneratorESP()
    else
        CheckboxGeneratorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desmarcado
        toggleGeneratorESP()
    end
end)

-------------------------------------------------------------------------------

local isSpeedEnabled = false
local originalWalkSpeed

-- Walk Speed
local CheckboxSpeedLabel = Instance.new("TextLabel")
CheckboxSpeedLabel.Name = "CheckboxSpeedLabel"
CheckboxSpeedLabel.Parent = checkboxContainer
CheckboxSpeedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckboxSpeedLabel.BackgroundTransparency = 1
CheckboxSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left -- Alinha o texto à esquerda
CheckboxSpeedLabel.Position = UDim2.new(0, 0, 0, CheckboxGeneratorLabel.Position.Y.Offset + CheckboxGeneratorLabel.Size.Y.Offset + 10) -- 10 pixels de espaçamento
CheckboxSpeedLabel.Font = Enum.Font.ArialBold
CheckboxSpeedLabel.Size = UDim2.new(0, 100, 0, 20) -- Tamanho fixo para o texto
CheckboxSpeedLabel.Text = "Walk Speed"
CheckboxSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckboxSpeedLabel.TextSize = 16

local CheckboxSpeed = Instance.new("Frame")
CheckboxSpeed.Name = "CheckboxSpeed"
CheckboxSpeed.Parent = checkboxContainer
CheckboxSpeed.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CheckboxSpeed.AnchorPoint = Vector2.new(1, 0) -- Ancoragem à direita
CheckboxSpeed.Position = UDim2.new(1, -5, 0, CheckboxGeneratorLabel.Position.Y.Offset + CheckboxGeneratorLabel.Size.Y.Offset + 10) -- Posiciona à direita, 10px de espaçamento
CheckboxSpeed.Size = UDim2.new(0, 18, 0, 18)
CheckboxSpeed.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Levemente arredondando as pontas do CheckboxSpeed
local UICornerSpeed = Instance.new("UICorner")
UICornerSpeed.Parent = CheckboxSpeed
UICornerSpeed.CornerRadius = UDim.new(0, 3)

-- Configuração do CheckboxSpeedButton
local CheckboxSpeedButton = Instance.new("TextButton")
CheckboxSpeedButton.Name = "CheckboxSpeedButton"
CheckboxSpeedButton.Parent = CheckboxSpeed
CheckboxSpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor cinza
CheckboxSpeedButton.Size = UDim2.new(1, 0, 1, 0)
CheckboxSpeedButton.Text = "✔️"

-- Levemente arredondando as pontas do CheckboxSpeedButton
local UICornerCheckboxSpeedButton = Instance.new("UICorner")
UICornerCheckboxSpeedButton.Parent = CheckboxSpeedButton
UICornerCheckboxSpeedButton.CornerRadius = UDim.new(0, 3)

-- Criar uma task que monitora a velocidade
task.spawn(function()
    while true do
        if isSpeedEnabled and humanoid then
            humanoid.WalkSpeed = 26 -- Mantém em 26 sempre que ativado
        end
        task.wait(0.1) -- Pequena pausa para evitar uso excessivo de processamento
    end
end)

-- Conectar o clique do botão para ativar/desativar a velocidade
CheckboxSpeedButton.MouseButton1Click:Connect(function()
    isSpeedEnabled = not isSpeedEnabled -- Inverte o estado

    if isSpeedEnabled then
        CheckboxSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde quando ativado
        if humanoid then
            originalWalkSpeed = humanoid.WalkSpeed -- Armazena a velocidade original
            humanoid.WalkSpeed = 26 -- Aumenta a velocidade
        end
    else
        CheckboxSpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza quando desativado
        if humanoid then
            humanoid.WalkSpeed = originalWalkSpeed or 16 -- Restaura a velocidade original ou usa 16 como padrão
        end
    end
end)

-- Reseta o check e a velocidade quando o personagem respawnar
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    humanoid = newCharacter:WaitForChild("Humanoid") -- Atualiza o humanoid

    -- Reseta a velocidade e desativa o checkbox
    isSpeedEnabled = false
    CheckboxSpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cinza
    humanoid.WalkSpeed = originalWalkSpeed or 16 -- Restaura a velocidade original ou usa 16 como padrão
end)

-------------------------------------------------------------------------------

-- Botão Collect Water
local WaterButton = Instance.new("TextButton")
WaterButton.Name = "WaterButton"
WaterButton.Parent = checkboxContainer
WaterButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WaterButton.Size = UDim2.new(0, 206, 0, 25) -- Tamanho do botão
WaterButton.Position = UDim2.new(0, 0, 0, CheckboxSpeedLabel.Position.Y.Offset + CheckboxSpeedLabel.Size.Y.Offset + 10)

-- Arredondando as pontas do botão
local UICornerWaterButton = Instance.new("UICorner")
UICornerWaterButton.Parent = WaterButton
UICornerWaterButton.CornerRadius = UDim.new(0, 5)

WaterButton.Text = "Collect Water"
WaterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WaterButton.TextSize = 16
WaterButton.Font = Enum.Font.ArialBold

WaterButton.MouseButton1Click:Connect(function()
    for _, water in pairs(workspace:GetChildren()) do
        if water:IsA("Model") and water:FindFirstChild("Handle") and water.Name == "Almond Water" then
            local handle = water.Handle
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, handle, 0) -- Simula toque
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, handle, 1) -- Finaliza o toque
        end
    end
end)

-------------------------------------------------------------------------------

-- Botão Collect Vector
local VectorButton = Instance.new("TextButton")
VectorButton.Name = "VectorButton"
VectorButton.Parent = checkboxContainer
VectorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
VectorButton.Size = UDim2.new(0, 206, 0, 25) -- Tamanho do botão
VectorButton.Position = UDim2.new(0, 0, 0, WaterButton.Position.Y.Offset + WaterButton.Size.Y.Offset + 10)

-- Arredondando as pontas do botão
local UICornerMp5Button = Instance.new("UICorner")
UICornerMp5Button.Parent = VectorButton
UICornerMp5Button.CornerRadius = UDim.new(0, 5)

VectorButton.Text = "Collect Kris Vector"
VectorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VectorButton.TextSize = 16
VectorButton.Font = Enum.Font.ArialBold

VectorButton.MouseButton1Click:Connect(function()
    -- Verifica se o personagem do jogador existe e tem um HumanoidRootPart
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        -- Obtém o modelo KrisVector diretamente
        local destinationModel = workspace.give_weapon.KrisVector

        -- Verifica se o modelo existe e tem uma posição válida
        if destinationModel then
            -- Obtém a posição do modelo (usando PrimaryPart ou posição padrão)
            local destination = destinationModel:GetPivot().Position

            -- Teleporta o jogador instantaneamente para a posição do modelo
            Character.HumanoidRootPart.CFrame = CFrame.new(destination)
        else
            warn("KrisVector model not found in give_weapon!")
        end
    else
        warn("Character or HumanoidRootPart not found!")
    end
end)


-------------------------------------------------------------------------------

-- Botão Collect AWP
local AwpButton = Instance.new("TextButton")
AwpButton.Name = "AwpButton"
AwpButton.Parent = checkboxContainer
AwpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AwpButton.Size = UDim2.new(0, 206, 0, 25) -- Tamanho do botão
AwpButton.Position = UDim2.new(0, 0, 0, VectorButton.Position.Y.Offset + VectorButton.Size.Y.Offset + 10)

-- Arredondando as pontas do botão
local UICornerMp5Button = Instance.new("UICorner")
UICornerMp5Button.Parent = AwpButton
UICornerMp5Button.CornerRadius = UDim.new(0, 5)

AwpButton.Text = "Collect Awp"
AwpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AwpButton.TextSize = 16
AwpButton.Font = Enum.Font.ArialBold

AwpButton.MouseButton1Click:Connect(function()
    -- Verifica se o personagem do jogador existe e tem um HumanoidRootPart
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        -- Obtém o modelo AWP diretamente
        local destinationModel = workspace.give_weapon.AWP

        -- Verifica se o modelo existe e tem uma posição válida
        if destinationModel then
            -- Obtém a posição do modelo (usando PrimaryPart ou posição padrão)
            local destination = destinationModel:GetPivot().Position

            -- Ajusta a altura da posição de destino para que o personagem não afunde
            local correctedPosition = Vector3.new(destination.X, destination.Y + 3, destination.Z)

            -- Teleporta o jogador para a nova posição ajustada
            Character.HumanoidRootPart.CFrame = CFrame.new(correctedPosition)
        else
            warn("AWP model not found in give_weapon!")
        end
    else
        warn("Character or HumanoidRootPart not found!")
    end
end)

-------------------------------------------------------------------------------

-- Função para expandir/retrair a GUI
local expanded = false
expandButton.MouseButton1Click:Connect(function()
    expanded = not expanded

    if expanded then
        madebybloodofbatus.Size = UDim2.new(0, 230, 0, 285)
        creditsLabel.Visible = true
        expandButton.Text = "-"
        extraButtonsContainer.Visible = true
    else
        madebybloodofbatus.Size = UDim2.new(0, 230, 0, 25)
        creditsLabel.Visible = false
        expandButton.Text = "+"
        extraButtonsContainer.Visible = false
    end
end)

-------------------------------------------------------------------------------

-- Função para arrastar a GUI pela tela
local Drag = madebybloodofbatus
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    local dragTime = 0.04
    local SmoothDrag = {}
    SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    local dragSmoothFunction = game:GetService("TweenService"):Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
    dragSmoothFunction:Play()
end

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

Drag.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging and Drag.Size then
        update(input)
    end
end)
