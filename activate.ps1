# Activate project virtual environment
Set-Location $PSScriptRoot
$activate_script = './venv_locallibrary/Scripts/activate.ps1'
Assert $(Test-Path $activate_script) "$activate_script is missing"
./venv_locallibrary/Scripts/activate.ps1
