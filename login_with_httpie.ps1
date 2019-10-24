# Get csrftoken
http localhost:8000/accounts/login/ --session=session2 -h
# Response looks like:
# HTTP/1.1 200 OK
# Set-Cookie: csrftoken=euogGDvtNo8JH6f5hWHm3yG7H0Lq9bbF72zLqAwSxphKKQgh2k77tyaWMBfKgUtF

# TODO parse response (e.g. with jq) to get the csrf token

# Login with the response CRRFToken
http -f POST localhost:8000/accounts/login/ `
    username=phuc password=phuc `
    X-CSRFToken:euogGDvtNo8JH6f5hWHm3yG7H0Lq9bbF72zLqAwSxphKKQgh2k77tyaWMBfKgUtF `
    --session=session2 -h
# Response looks like:
# HTTP/1.1 302 Found
# Location: /
# Set-Cookie: csrftoken=494DkUK7kRx0DacCrxn9SyTUjNm1SmsqiOO16zRYnt0xnTxEchm5GVeWN7u16Lz3
# Set-Cookie: sessionid=p0cochytq080zmbk6dncw0jiyukcvbw9

# Request secure data
http localhost:8000/catalog/mybooks/ --session=session2 -h
# Response looks like:
# HTTP/1.1 200 OK
