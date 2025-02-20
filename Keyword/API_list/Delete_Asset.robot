*** Keywords ***
Call Delete Asset API
    [Arguments]     ${asset_id}
    ${headers}=      Login & Get Token
    ${resp}=    DELETE On Session     AssetSession    /assets/${asset_id}   headers=${headers}    expected_status=200
    RETURN  ${resp}
    
Call API delete & Verified Error Message TC_008
    ${headers}=      Login & Get Token
    Asset session create
    ${resp_TC_008}=     Call Delete Asset API   ${TC_008.asset_id}
    Should Be Equal     ${resp_TC_008.json()['status']}    ${TC_008.status}
    Should Be Equal     ${resp_TC_008.json()['message']}    ${TC_008.message}

Reset Data by delete asset
    [Arguments]    ${delete_id} 
    Asset session create
    Call Delete Asset API   ${delete_id}
