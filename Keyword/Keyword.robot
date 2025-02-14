*** Keywords ***
Call Get Asset API
    ${headers}=      Login & Get Token
    Asset session create
    ${get_resp}=    GET On Session    assetSession    /assets       headers=${headers}      expected_status=200
    ${count}=       Get Length  ${get_resp.json()}
    ${morethanone}=     Evaluate    ${count}>1
    Should Be True      ${morethanone}

Call Login API with wrong password
    Login session create
    ${request_body}=    Create Dictionary   username=doppio222  password=12345
    ${resp}=    POST On Session     loginSession    /login      json=${request_body}    expected_status=401
    RETURN  ${resp}

Verified Error Message TC_001
    ${resp_TC_001}=     Call Login API with wrong password
    Should Be Equal     ${resp_TC_001.json()['status']}    error
    Should Be Equal     ${resp_TC_001.json()['message']}    invalid username or password

Call API Get asset & Verified Error Message TC_003
    Asset session create
    ${get_resp}=    GET On Session      assetSession    /assets    expected_status=401
    Should Be Equal     ${get_resp.json()['status']}    error
    Should Be Equal     ${get_resp.json()['message']}    you do not have access to this resource

Call Create Asset API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${request_body}=    Create Dictionary   assetId=${asset_id}  assetName=${asset_name}      assetType=${asset_type}      inUse=${asset_inuse}
    ${create_resp}=    POST On Session     AssetSession    /assets     headers=${headers}      json=${request_body}    expected_status=200
    RETURN      ${create_resp}

Call Modify Asset API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${request_body}=    Create Dictionary   assetId=${asset_id}  assetName=${asset_name}      assetType=${asset_type}      inUse=${asset_inuse}
    ${resp}=    PUT On Session     AssetSession    /assets  headers=${headers}      json=${request_body}    expected_status=200

Call Delete Asset API
    [Arguments]     ${asset_id}
    ${headers}=      Login & Get Token
    ${resp}=    DELETE On Session     AssetSession    /assets/${asset_id}   headers=${headers}    expected_status=200
    RETURN  ${resp}

Call API delete & Verified Error Message TC_008
    ${headers}=      Login & Get Token
    Asset session create
    ${resp_TC_008}=     Call Delete Asset API   a998
    Should Be Equal     ${resp_TC_008.json()['status']}    failed
    Should Be Equal     ${resp_TC_008.json()['message']}    cannot find this id in database

Call API create asset & Verified Error Message TC_005
    ${resp_TC_005}=     Call Create Asset API   a001    duplicate for sure   1   true
    #Log      ${resp_TC_005.json()}
    Should Be Equal     ${resp_TC_005.json()['status']}    failed
    Should Be Equal     ${resp_TC_005.json()['message']}    id : a001 is already exists , please try with another id


    
