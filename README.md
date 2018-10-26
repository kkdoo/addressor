# Task

## Project:
Use devise to create a simple authentication process (use of default devise templates allowed). A user should not have to confirm his email address. He will be allowed to login right after signup. After login, the user should get redirected to "/my_address". On view, a new address is assigned to the user. A button gives the possibility to assign a new address from the address pool to the user.

## Definitions:
Address: Random 34 characters, digits, uppercase, lowercase. Uppercase letter "O", uppercase letter "I", lowercase letter "l", and the number "0" are excluded!
Address Pool: Holds 10 addresses, generates new addresses through cronjob (use gem) every 12 minutes.

## Features:
If the address pool runs out of addresses and the user tries to generate a new one, a message should be shown: "Address Pool empty, please try again in x Minutes" where x is the value of the remaining time when the cronjob will run again.
Integrate a JWT authentication so that a user can view and generate a new address via API.
Write a short description how to call the api endpoint.

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
