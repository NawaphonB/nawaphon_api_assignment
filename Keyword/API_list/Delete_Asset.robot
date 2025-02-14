*** Keywords ***
Call Delete Asset API
    [Arguments]     ${asset_id}
    ${headers}=      Login & Get Token
    ${resp}=    DELETE On Session     AssetSession    /assets/${asset_id}   headers=${headers}    expected_status=200
    RETURN  ${resp}
