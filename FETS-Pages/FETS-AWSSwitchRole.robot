*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           OperatingSystem
Library			  Collections
Library           String
Library			  Dialogs
Library           DateTime

*** Variables ***

${AWSSwitchRole_txtAccountr}                      xpath=//input[@id="account"]
${AWSSwitchRole_txtRole}                      xpath=//input[@id="roleName"]
${AWSSwitchRole_txtDisplayName}                      xpath=//input[@id="displayName"]
${AWSSwitchRole_btnSwitch}                      xpath=//input[@id="input_switchrole_button"]
${AWSSwitchRole_txtSearch}                      xpath=//input[@id="search-box-input"]

*** Keywords ***

AWSSwitchRole_Search for S3 service in Find services search box
    Enter search text [S3]
    press keys      ${AWSSwitchRole_txtSearch}      ENTER

Enter search text [${search_text}]
    wait until page contains element    ${AWSSwitchRole_txtSearch}
    input text    ${AWSSwitchRole_txtSearch}      ${search_text}

AWSSwitchRole_click switch role button
    wait until page contains element    ${AWSSwitchRole_btnSwitch}
    click element    ${AWSSwitchRole_btnSwitch}
    sleep   10s

AWSSwitchRole_fill switch role form
    Enter account number [fxdmsstaging]
    Enter role name [CrossAccountAdmins]
    Enter display name [account_admin]

Enter account number [${account_no}]
    wait until page contains element    ${AWSSwitchRole_txtAccountr}
    input text    ${AWSSwitchRole_txtAccountr}      ${account_no}

Enter role name [${role}]
    wait until page contains element    ${AWSSwitchRole_txtRole}
    input text    ${AWSSwitchRole_txtRole}      ${role}

Enter display name [${display_name}]
    wait until page contains element    ${AWSSwitchRole_txtDisplayName}
    input text    ${AWSSwitchRole_txtDisplayName}      ${display_name}