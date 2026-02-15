. "$HOME\Documents\PowerShell\aliases.ps1"

# PSReadLine
Set-PSReadLineOption -Colors @{
    Command            = 'Cyan'
    Parameter          = 'Green'
    String             = 'Yellow'
    Variable           = 'White'
    Operator           = 'DarkGray'
    Number             = 'Magenta'
    Type               = 'Blue'
    Comment            = 'DarkGreen'
    InlinePrediction   = 'DarkGray'
    Error              = 'Red'
}

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
