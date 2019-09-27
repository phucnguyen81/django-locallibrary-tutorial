Properties {
    $requiredDirectories = @(
        '.git',
        'venv_locallibrary',
        'manage.py'
    )
}

TaskSetup {
    Set-Location $PSScriptRoot
}

Task precondition `
    -alias pre `
    -description 'Required before running other tasks' {
    foreach ($dir in $requiredDirectories) {
        Assert $(Test-Path $dir) "$dir is missing"
    }
}

Task activate `
    -alias act `
    -depends precondition `
    -description 'Activate project virtual environment' {
    $activate_script = './venv_locallibrary/Scripts/activate.ps1'
    Assert $(Test-Path $activate_script) "$activate_script is missing"
    Invoke-Expression $activate_script
}

Task runserver `
    -alias run `
    -depends activate `
    -description 'Start django development server' {
    python manage.py runserver 8000
}

Task deactivate `
    -alias deact `
    -depends precondition `
    -description 'Deactivate project virtual environment' {
    $deactivate_command = (Get-Command deactivate -ErrorAction SilentlyContinue)
    $has_deactivate = ($deactivate_command -and $True)
    Assert $has_deactivate 'deactivate command not found'
    deactivate
}
