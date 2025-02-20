*** Keywords ***
Call Create Asset API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${request_body}=    Create Dictionary   assetId=${asset_id}  assetName=${asset_name}      assetType=${asset_type}      inUse=${asset_inuse}
    ${create_resp}=    POST On Session     AssetSession    /assets     headers=${headers}      json=${request_body}    expected_status=200
    RETURN      ${create_resp}

Call API create asset & Verified Error Message TC_005
    Asset session create
    ${resp_TC_005}=     Call Create Asset API   ${TC_005.asset_id}    ${TC_005.asset_name}   ${TC_005.asset_type}   ${TC_005.asset_inuse}
    Should Be Equal     ${resp_TC_005.json()['status']}    ${TC_005.status}
    Should Be Equal     ${resp_TC_005.json()['message']}    ${TC_005.message}