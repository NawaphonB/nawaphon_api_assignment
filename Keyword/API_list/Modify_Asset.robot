*** Keywords ***
Call Modify Asset API
    [Arguments]     ${asset_id}     ${asset_name}    ${asset_type}      ${asset_inuse}
    ${headers}=      Login & Get Token
    Asset session create
    ${request_body}=    Create Dictionary   assetId=${asset_id}  assetName=${asset_name}      assetType=${asset_type}      inUse=${asset_inuse}
    ${resp}=    PUT On Session     AssetSession    /assets  headers=${headers}      json=${request_body}    expected_status=200