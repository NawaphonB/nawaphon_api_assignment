*** Keywords ***
Login & Get Token 
    Create Session      loginSession             http://localhost:8082
    ${request_body}=    Create Dictionary   username=doppio  password=weBuildBestQa
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

Verified result by calling get API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should Contain      ${json_data}    ${expected_result}

Verified delete result by calling get API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should not Contain      ${json_data}    ${expected_result}