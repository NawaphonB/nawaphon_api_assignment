*** Keywords ***
Verify get api response without asset ID
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    common_Keyword.Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should not Contain      ${json_data}    ${expected_result}

Call Get Asset API
    ${headers}=      Login & Get Token
    common_Keyword.Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${count}=       Get Length  ${get_resp.json()}
    ${morethanone}=     Evaluate    ${count}>1
    Should Be True      ${morethanone}

Verify get api response with asset ID
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    common_Keyword.Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${json_data}=      Convert To String       ${get_resp.json()}
    ${expected_result}=      Convert To String   {'assetId': '${asset_id}', 'assetName': '${asset_name}', 'assetType': ${asset_type}, 'inUse': ${asset_inuse}}
    Should Contain      ${json_data}    ${expected_result}

Call API Get asset & Verified Error Message TC_003
    common_Keyword.Asset session create
    ${get_resp}=    GET On Session      assetSession    /assets    expected_status=401
    Should Be Equal     ${get_resp.json()['status']}    ${TC_003.status}
    Should Be Equal     ${get_resp.json()['message']}    ${TC_003.message}