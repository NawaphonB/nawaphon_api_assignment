*** Keywords ***
Login & Get Token 
    common_keyword.Login session create
    ${request_body}=    Create Dictionary   username=${USERNAME}  password=${PASSWORD}
    ${resp}=    POST On Session     loginSession    /login      json=${request_body}    expected_status=200
    ${token}=   Set Variable    ${resp.json()['message']}
    ${headers}=     Create Dictionary       token=${token}
    RETURN  ${headers}

Call Login API with wrong password
    common_keyword.Login session create
    ${request_body}=    Create Dictionary   username=${USERNAME_WRONG}  password=${PASSWORD_WRONG}
    ${resp}=    POST On Session     loginSession    /login      json=${request_body}    expected_status=401
    RETURN  ${resp}

Call API Login & Verified Error Message TC_001
    Call Login API with wrong password
    Log     ${USERNAME_WRONG}
    ${resp_TC_001}=     Call Login API with wrong password
    Should Be Equal     ${resp_TC_001.json()['status']}    ${TC_001.status}
    Should Be Equal     ${resp_TC_001.json()['message']}    ${TC_001.message}

