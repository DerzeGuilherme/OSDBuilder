# Sistema Operacional com 2 HDS
# Microsoft ADK de Referencia e WinPE
# DarT
# 2 Discos, mesmo sendo VM
# Antivirus desabilitado
# RDP Habilitado
# Se for VM, otimiza-la para VDI

$Raiz = "Derze"
$ContentPack = "DerzeCP"
$Task = "DerzeTask"

# Instalação do OSD Builder
Install-Module -Name OSDBuilder -Force

# Importar OSDBuilder
Import-Module -Name OSDBuilder -Force

# Inicializar e definir o caminho
OSDBuilder -SetPath D:\$Raiz\$Task

# Para atualizar o OSDBuilder
OSDBuilder -Update

#Montar ISO no Sistema Operacional

# Para importar, baixar e aplicar as atualizacoes de uma nova media
Import-OSMedia -ImageName 'Windows 10 Enterprise' -SkipGrid -Update -BuildNetFX

# Deletar o conteudo dentro da pasta Templates

# Inicializar o comando  para criar todos os caminhos do OSD Builder
SDBuilder -Initialize
OSDBuilder -CreatePaths

# Para criar um novo Content Pack
New-OSDBuilderContentPack -Name $DerzeCP

#Para criar pastas do OS
New-OSDBuilderContentPack -Name WinPE -ContentType WinPE

# Para criar as pastas WinPE
New-OSDBuilderContentPack -Name WinPE -ContentType WinPE

# Habilitar .NET 3.5

# /Remover Adicionar pacotes RSAT caso precise, ver arquivo contido em Z-Extra

# /Remover Adicionar Drivers PE/OS

# /Remover Adicionar Arquivos Extras PE/OS

# /Remover Adicionar Pacotes Extraas PE/OS

#A /Remover dicionar modulos do Powershell, caso precise PE/OS

# Rmover Adicionar Pacotes de Registro PE/OS

# Rmover Adicionar Scripts Powershell caso necessario

# Rmover Adicionar Layout do Sistema Operacional

# Rmover Adcionar Ferramentas Necessarias para o ADK

# Rmover Adicionar Ferramentas DarT caso necessario

# Criar Nova Tarefa para Imagem Base
New-OSBuildTask -TaskName $Task -AddContentPacks

# Para atrelar com o content pack com seu imatem
New-OSBuildTask -TaskName SeguraOSD -AddContentPacks


OSLocalExperiencePacks\$ReleaseId $Architecture\$LanguageId

PEADKLang\$ReleaseId $Architecture

OSLocalExperiencePacks\$ReleaseId $Architecture\$LanguageId

OSLanguageFeatures\$ReleaseId $Architecture

OSLanguagePacks\$ReleaseId $Architecture

New-OSBuild -SkipTask -Execute -SkipComponentCleanup -SkipUpdates -CreateISO


New-OSBuild -SkipTask -Execute -SkipComponentCleanup -SkipUpdates -CreateISO

New-OSBuild -SkipTask -Execute -SkipComponentCleanup -SkipUpdates -CreateISO


#Para baixar modulos que onseguir
Save-Module -Name OSD -Path D:\OSDBuilder\SeguraOSD\ContentPacks\_Global\OSPoshMods\ProgramFiles
Save-Module -Name OSD -Path D:\OSDBuilder\SeguraOSD\ContentPacks\_Global\PEPoshMods\ProgramFiles

# Definir Base da Imagem em Todos os Aspectos Acima Citado
# Ver se ira fazer pelo MDT ou eplo Instalador com Autounnattend
# Fazer download das aplicacoes e realizar a imagem de referencia

