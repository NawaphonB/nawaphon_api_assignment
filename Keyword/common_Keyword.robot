*** Keywords ***
Login & Get Token 
    Create Session      loginSession             ${BASE_URL}
    ${request_body}=    Create Dictionary   username=${USERNAME}  password=${PASSWORD}
    ${resp}=    POST On Session     loginSession    /login      json=${request_body}    expected_status=200
    ${token}=   Set Variable    ${resp.json()['message']}
    ${headers}=     Create Dictionary       token=${token}
    RETURN  ${headers}

Asset session create
    Create Session  assetSession    http://localhost:8082

Login session create 
    Create Session      loginSession       http://localhost:8082

Reset Data by delete asset
    [Arguments]    ${delete_id} 
    Asset session create
    Call Delete Asset API   ${delete_id}


