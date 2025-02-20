*** Settings ***
Library     RequestsLibrary
Library     BuiltIn
Resource    ./Keyword/common_Keyword.robot
Library     SeleniumLibrary

#API-List Keyword
Resource    ./Keyword/API_list/Create_Asset.robot
Resource    ./Keyword/API_list/Delete_Asset.robot
Resource    ./Keyword/API_list/Get_Asset.robot
Resource    ./Keyword/API_list/Login.robot
Resource    ./Keyword/API_list/Modify_Asset.robot

#Test data
Variables   ./Resource/Testdata/Testdata.yaml
