# API example

Login first:

`curl -X POST localhost:3000/api/login -u "bob@example.com:123456"`

result:
`{"auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDA0NTU5MzV9.XN6xBrwqMXyRm78bdEw4Eu-FEzmDWNu_FGFPPCOA3yk"}`

It return "auth_token", pass in rest calls. Note: token will be valid within 1 day.

Get address for current user:

`curl -X GET localhost:3000/api/my_address -u "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDA0NTU5MzV9.XN6xBrwqMXyRm78bdEw4Eu-FEzmDWNu_FGFPPCOA3yk:"`

result:
`{"id":1,"address":"CjqFGZoccmKFg9nTB95hzmRvWguTdyLWeV"}`

Update address from pool:

`curl -X POST localhost:3000/api/addresses -u "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDA0NTU5MzV9.XN6xBrwqMXyRm78bdEw4Eu-FEzmDWNu_FGFPPCOA3yk:"`

result:
`{"error":"Address Pool empty, please try again in 1 Minutes and 22 Seconds"}`
