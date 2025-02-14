*** Keywords ***
Verified delete result by calling get API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should not Contain      ${json_data}    ${expected_result}

Call Get Asset API
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${count}=       Get Length  ${get_resp.json()}
    ${morethanone}=     Evaluate    ${count}>1
    Should Be True      ${morethanone}

Verified result by calling get API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should Contain      ${json_data}    ${expected_result}
