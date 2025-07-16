*** Settings ***
Documentation       Complete SQ1 test suite for NEW BRMS automation
Resource            ${CURDIR}/../../resources/web/config.robot
Test Setup          common.Open Browser To NEW_BRMS
Test Teardown       common.Run Web Test Teardown
Suite Teardown      common.Run Web Suite Teardown

*** Test Cases ***
TC_Automate_test_web
    [Documentation]    TC_Automate_test_web
    [Tags]             web    sq1    smoke
    login_page.Verify Go To Login Page Success
    login_page.Input Username    standard_user
    login_page.Input Password    secret_sauce
    login_page.Click Login Button
