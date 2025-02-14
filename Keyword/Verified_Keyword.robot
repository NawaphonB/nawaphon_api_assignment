*** Keywords ***
Call API Login & Verified Error Message TC_001
    Call Login API with wrong password
    Log     ${USERNAME_WRONG}
    ${resp_TC_001}=     Call Login API with wrong password
    Should Be Equal     ${resp_TC_001.json()['status']}    ${TC_001.status}
    Should Be Equal     ${resp_TC_001.json()['message']}    ${TC_001.message}

Call API Get asset & Verified Error Message TC_003
    Asset session create
    ${get_resp}=    GET On Session      assetSession    /assets    expected_status=401
    Should Be Equal     ${get_resp.json()['status']}    ${TC_003.status}
    Should Be Equal     ${get_resp.json()['message']}    ${TC_003.message}

Call API delete & Verified Error Message TC_008
    ${headers}=      Login & Get Token
    Asset session create
    ${resp_TC_008}=     Call Delete Asset API   ${TC_008.asset_id}
    Should Be Equal     ${resp_TC_008.json()['status']}    ${TC_008.status}
    Should Be Equal     ${resp_TC_008.json()['message']}    ${TC_008.message}

Call API create asset & Verified Error Message TC_005
    Asset session create
    ${resp_TC_005}=     Call Create Asset API   ${TC_005.asset_id}    ${TC_005.asset_name}   ${TC_005.asset_type}   ${TC_005.asset_inuse}
    Should Be Equal     ${resp_TC_005.json()['status']}    ${TC_005.status}
    Should Be Equal     ${resp_TC_005.json()['message']}    ${TC_005.message}


    
