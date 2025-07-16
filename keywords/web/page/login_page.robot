*** Settings ***
Documentation       Login page keywords with direct xpath usage
Resource            ${CURDIR}/../../../resources/web/config.robot

*** Keywords ***
Verify Go To Login Page Success
    [Documentation]    Verify Go To Login Page Success using direct xpath
    [Arguments]        ${timeout}=${DEFAULT_TIMEOUT}
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//div[@class='login_logo']    timeout=${timeout}
    SeleniumLibrary.Element Should Be Visible        xpath=//div[@class='login_logo']

Input Username
    [Documentation]    Input username using direct xpath
    [Arguments]        ${username}    ${timeout}=${DEFAULT_TIMEOUT}
    common.Input Text When Ready    xpath=//input[@id="user-name"]    ${username}    ${timeout}

Input Password
    [Documentation]    Input password using direct xpath
    [Arguments]        ${password}    ${timeout}=${DEFAULT_TIMEOUT}
    common.Input Text When Ready    xpath=//input[@id="password"]    ${password}    ${timeout}

Click Login Button
    [Documentation]    Click login button using direct xpath
    [Arguments]        ${timeout}=${DEFAULT_TIMEOUT}
    common.Click Element When Ready    id=login-button