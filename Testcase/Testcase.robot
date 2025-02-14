*** Settings ***
Resource    ../import.robot  

*** Variables ***
${Base_URL}     http://localhost:8082

*** Test cases ***
TC-001 Verify when input wrong username or password, API should return error
    [Tags]  Test    e2e
    Call Login API with wrong password
    Verified Error Message TC_001

TC-002 Verify That Can Get Asset List From Get API correctly
    [Tags]  Test2   e2e
    #call Get API to get asset (with token) and verify status code is 200
    #check response contains at least 1 assets
    Call Get Asset API
    
TC-003 Verify that get asset API always require valid token
    [Tags]  Test3   e2e
    #call asset API with invalid token or with no token 
    # check response code = 401 
    # check error message
    Call API Get asset & Verified Error Message TC_003

TC-004 Verify that create asset API can work correctly 
    [Tags]  Test4   e2e
    #call create asset API (POST /assets) with valid token 
    # check response code = 200 
    # check status message = success
    # check that created asset can be returned from GET /assets
    Call Create Asset API   a133    now asset   1   True
    Verified result by calling get API      a133    now asset   1   True
    Reset Data by delete asset      a133



TC-005 Verify that cannot create asset with duplicated ID
    [Tags]  Test5   e2e
    #call create asset with valid token but use duplicate asset ID 
    # check status message 
    # check error message 
    # check that no duplicated asset returned from GET /assets
    Asset session create
    Call API create asset & Verified Error Message TC_005


TC-006 Verify that modify asset API can work correctly
    [Tags]  Test6   e2e
    #call modify asset with valid token and try to change name of some asset 
    #check status message = success 
    #call get api to check that asset Name has been changed
    Call Create Asset API   a134    modify asset   2   True
    Verified result by calling get API      a134    modify asset    2   True
    Call Modify Asset API   a134    modified    1   True
    Verified result by calling get API      a134    modified    1   True
    Reset Data by delete asset      a134

TC-007 Verify that delete asset API can work correctly
    [Tags]  Test7   e2e
    #call delete asset 
    #call GET to check that asset has been deleted
    Call Create Asset API   a135    to be delete   3   False
    Verified result by calling get API      a135    to be delete    3   False
    Call Delete Asset API   a135
    Verified delete result by calling get API   a135    to be delete   3   False

TC-008 Verify that cannot delete asset which ID does not exists
    [Tags]  Test8   e2e
    #call delete asset with non-existing id 
    #check error message 
    Call API delete & Verified Error Message TC_008
