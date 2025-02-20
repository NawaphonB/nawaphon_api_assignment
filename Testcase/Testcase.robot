*** Settings ***
Resource    ../import.robot  

*** Test cases ***
TC-001 Verify when input wrong username or password, API should return error
    [Tags]  Test    e2e
    Login.Call API Login & Verified Error Message TC_001

TC-002 Verify That Can Get Asset List From Get API correctly
    [Tags]  Test2   e2e
    #call Get API to get asset (with token) and verify status code is 200
    #check response contains at least 1 assets
    Get_Asset.Call Get Asset API
    
TC-003 Verify that get asset API always require valid token
    [Tags]  Test3   e2e
    #call asset API with invalid token or with no token 
    # check response code = 401 
    # check error message
    Get_Asset.Call API Get asset & Verified Error Message TC_003

TC-004 Verify that create asset API can work correctly 
    [Tags]  Test4   e2e
    #call create asset API (POST /assets) with valid token 
    # check response code = 200 
    # check status message = success
    # check that created asset can be returned from GET /assets
    Create_Asset.Call Create Asset API   ${TC_004.asset_id}    ${TC_004.asset_name}   ${TC_004.asset_type}   ${TC_004.asset_inuse}
    Get_Asset.Verify get api response with asset ID      ${TC_004.asset_id}    ${TC_004.asset_name}   ${TC_004.asset_type}   ${TC_004.asset_inuse}
    [Teardown]  Delete_Asset.Reset Data by delete asset      ${TC_004.asset_id}
    

TC-005 Verify that cannot create asset with duplicated ID
    [Tags]  Test5   e2e
    #call create asset with valid token but use duplicate asset ID 
    # check status message 
    # check error message 
    # check that no duplicated asset returned from GET /assets
    Create_Asset.Call API create asset & Verified Error Message TC_005

TC-006 Verify that modify asset API can work correctly
    [Tags]  Test6   e2e
    #call modify asset with valid token and try to change name of some asset 
    #check status message = success 
    #call get api to check that asset Name has been changed
    Create_Asset.Call Create Asset API   ${TC_006.asset_id}    ${TC_006.asset_name}   ${TC_006.asset_type}   ${TC_006.asset_inuse}
    Get_Asset.Verify get api response with asset ID      ${TC_006.asset_id}    ${TC_006.asset_name}    ${TC_006.asset_type}   ${TC_006.asset_inuse}
    Modify_Asset.Call Modify Asset API   ${TC_006.asset_id_mod}    ${TC_006.asset_name_mod}    ${TC_006.asset_type_mod}   ${TC_006.asset_inuse_mod}
    Get_Asset.Verify get api response with asset ID      ${TC_006.asset_id_mod}    ${TC_006.asset_name_mod}    ${TC_006.asset_type_mod}    ${TC_006.asset_inuse_mod}
    [Teardown]  Delete_Asset.Reset Data by delete asset      ${TC_006.asset_id_mod}

TC-007 Verify that delete asset API can work correctly
    [Tags]  Test7   e2e
    #call delete asset 
    #call GET to check that asset has been deleted
    Create_Asset.Call Create Asset API   ${TC_007.asset_id}    ${TC_007.asset_name}   ${TC_007.asset_type}  ${TC_007.asset_inuse}   
    Get_Asset.Verify get api response with asset ID      ${TC_007.asset_id}    ${TC_007.asset_name}   ${TC_007.asset_type}  ${TC_007.asset_inuse}
    Delete_Asset.Call Delete Asset API   ${TC_007.asset_id}
    Get_Asset.Verify get api response without asset ID   ${TC_007.asset_id}    ${TC_007.asset_name}   ${TC_007.asset_type}  ${TC_007.asset_inuse}

TC-008 Verify that cannot delete asset which ID does not exists
    [Tags]  Test8   e2e
    #call delete asset with non-existing id 
    #check error message 
    Delete_Asset.Call API delete & Verified Error Message TC_008
