*** Settings ***
Documentation       Login feature keywords with direct xpath usage
Resource            ../../../resources/web/config.robot
Resource            ../page/login_page.robot

*** Keywords ***
Login With Valid Credentials
    [Documentation]    Login with valid username and password using direct xpath
    [Arguments]        ${username}=standard_user    ${password}=secret_sauce
    login_page.Input Username    ${username}
    login_page.Input Password    ${password}
    login_page.Click Login Button