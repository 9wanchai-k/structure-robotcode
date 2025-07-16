*** Settings ***
Documentation       Configuration file for NEW BRMS web automation testing

###### Library ######
Library             Collections
Library             String
Library             DateTime
Library             OperatingSystem
Library             SeleniumLibrary    screenshot_root_directory=EMBED
Library             RequestsLibrary

###### Common Keywords ######
Resource            ${CURDIR}/../../keywords/web/common/common.robot

###### Keywords Features ######
Resource            ${CURDIR}/../../keywords/web/feature/login_keywords.robot

###### Keywords Pages ######
Resource            ${CURDIR}/../../keywords/web/page/login_page.robot

