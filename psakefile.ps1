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

    $venv = [Environment]::GetEnvironmentVariable('VIRTUAL_ENV')
    Assert $($venv -and $True) 'Virtual environment is not activated '
    Assert $(Test-Path $venv) "Virtual environment not exists at $venv"

    foreach ($dir in $requiredDirectories) {
        Assert $(Test-Path $dir) "$dir is missing"
    }
}

Task runserver `
    -alias run `
    -depends precondition `
    -description 'Start django development server' {
    python manage.py runserver 8000
}
