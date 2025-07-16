*** Settings ***
Documentation       Common keywords for web automation testing
Resource            ../../../resources/web/config.robot
Library             SeleniumLibrary
Library             RequestsLibrary
Library             BuiltIn

*** Keywords ***
Open Browser To NEW_BRMS
    [Documentation]    Opens the browser to the NEW_BRMS URL and maximizes the window.
    Open Browser       ${WEB_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Run Web Test Teardown
    [Documentation]    Run Web Test Teardown
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Run Keywords
    ...    Capture Element Screenshot    xpath=//body
    ...    AND    Log Source
    Close All Browsers

Run Web Suite Teardown
    [Documentation]    Run Web Suite Teardown
    Set Library Search Order    SeleniumLibrary
    Run Keyword If Any Tests Failed    Capture Page Screenshot
    Run Keyword If Any Tests Failed    Run Keywords
    ...    Capture Element Screenshot    xpath=//body
    ...    AND    Log Source
    Close All Browsers

Compare Message Should Be Correctly
    [Documentation]    Compare Message Should Be Correctly
    [Arguments]        ${message_1}    ${message_2}
    Should Be Equal    ${message_1}    ${message_2}
    ...    msg=Expected: '${message_2}', but got: '${message_1}'

Waiting For Loading
    [Documentation]    Waiting For Loading using direct xpath
    ${loading_xpath}=    Set Variable    xpath=//div[@id="loading" and contains(@style,"visibility: visible;")]
    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element    ${loading_xpath}    ${DEFAULT_TIMEOUT}

Wait Until Element Is Visible Except Stale
    [Documentation]    Wait and Except Stale Error with retry mechanism using direct xpath
    ...                time * count = total wait time
    [Arguments]        ${locator}    ${time}=${SHORT_TIMEOUT}    ${retry_count}=5
    
    FOR    ${index}    IN RANGE    1    ${retry_count + 1}
        ${status}    ${error}=    Run Keyword And Ignore Error
        ...    Wait Until Element Is Visible    ${locator}    ${time}
        
        IF    ${status}
            RETURN
        END
        
        ${is_stale}=    Run Keyword And Return Status
        ...    Should Contain    ${error}    StaleElementReferenceException
        
        IF    ${is_stale}
            ${message}=    Set Variable    RETRY-${index} Wait-${time} Second - Stale Element
            Log To Console    ${message}
            Sleep    0.5s
            CONTINUE
        END
        
        ${message}=    Set Variable    RETRY-${index} Wait-${time} Second
        Log To Console    ${message} - ${error}
    END
    
    # Final attempt - will fail if element still not visible
    Wait Until Element Is Visible    ${locator}    ${time}

Get Text When Ready
    [Documentation]    Get Text When Ready using direct xpath
    [Arguments]        ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible Except Stale    ${locator}    ${timeout}
    ${text}=    Get Text    ${locator}
    RETURN    ${text}

Select From List By Label When Ready
    [Documentation]    Select From List By Label When Ready using direct xpath
    [Arguments]        ${locator}    ${value}    ${timeout}=${SHORT_TIMEOUT}
    Wait Until Element Is Visible Except Stale    ${locator}    ${timeout}
    Select From List By Label    ${locator}    ${value}

Input Text When Ready
    [Documentation]    Input Text When Ready using direct xpath
    [Arguments]        ${locator}    ${text}    ${timeout}=${DEFAULT_TIMEOUT}
    SeleniumLibrary.Wait Until Element Is Enabled    ${locator}    ${timeout}
    SeleniumLibrary.Clear Element Text    ${locator}
    SeleniumLibrary.Input Text    ${locator}    ${text}

Click Element When Ready
    [Documentation]    Click Element When Ready using direct xpath
    [Arguments]        ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    SeleniumLibrary.Wait Until Element Is Enabled    ${locator}    ${timeout}
    SeleniumLibrary.Click Element    ${locator}


Default Teardown
    [Documentation]    Teardown test cases.
    Run Keyword If Test Failed    Capture Page Screenshot    Images/CaptureTestFail_${TEST NAME}.png
    Close All Browsers