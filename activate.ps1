# Activate project virtual environment
Set-Location $PSScriptRoot
$activate_script = Resolve-Path 'venv_locallibrary/Scripts/activate.ps1'
if (-not $activate_script) { return }
& "$activate_script"
