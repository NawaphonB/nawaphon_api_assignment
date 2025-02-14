*** Keywords ***
Call Login API with wrong password
    Login session create
    ${request_body}=    Create Dictionary   username=${USERNAME_WRONG}  password=${PASSWORD_WRONG}
    ${resp}=    POST On Session     loginSession    /login      json=${request_body}    expected_status=401
    RETURN  ${resp}