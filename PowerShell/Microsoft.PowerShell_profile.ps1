. "$HOME\Documents\PowerShell\aliases.ps1"

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi

function conda {
    Remove-Item function:conda
    if (Test-Path "$HOME\miniconda3\Scripts\conda.exe") {
        (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
        conda @args
    } else {
        Write-Error "Miniconda not found at $HOME\miniconda3"
    }
}

# Starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
