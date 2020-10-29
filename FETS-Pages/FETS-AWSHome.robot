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

${AWSHome_menuUser}                      xpath=//button[@id="nav-usernameMenu"]
${AWSHome_liSwitchRole}                      xpath=//a[@data-testid="awsc-switch-roles"]
${AWSHome_btnSwitchRoleFirsrRun}                      xpath=//input[@id="switchrole_firstrun_button"]

*** Keywords ***

AWSHome_switch user role
    click user menu
    click switch role


click switch role
    wait until page contains element    ${AWSHome_liSwitchRole}
    click element    ${AWSHome_liSwitchRole}
    click element    ${AWSHome_btnSwitchRoleFirsrRun}

click user menu
    wait until page contains element    ${AWSHome_menuUser}
    click element    ${AWSHome_menuUser}