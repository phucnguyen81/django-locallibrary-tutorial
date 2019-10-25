# Login and request my books using httpie command

foreach ($cmd in Get-Command @('http', 'jq')) {
    if (-not (Get-Command $cmd)) { return }
}

$login_url = 'localhost:8000/accounts/login/'
$secured_url = 'localhost:8000/catalog/mybooks/'
$username = 'phuc'
$password = 'phuc'

$curdir = Get-Location
if ($PSScriptRoot) {
    $curdir = $PSScriptRoot
}

$session_file = ''
if (Test-Path -LiteralPath $curdir) {
    $session_file = Join-Path $curdir `
        -ChildPath 'http_session.json'
}

# Initial request for csrf token
http $login_url --session $session_file --headers

# Parse response with jq to get the csrf token
$json_query = '..|.csrftoken?|select(.!=null)|.value'
$csrf_token = $(jq --raw-output $json_query $session_file)

# Login with the response CRRFToken
http --form POST $login_url username=$username password=$password `
    X-CSRFToken:$csrf_token `
    --session=$session_file --follow --headers

# Request secure data
http $secured_url --session=$session_file --headers
