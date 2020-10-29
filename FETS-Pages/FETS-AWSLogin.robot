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

${AWSLogin_txtAlias}                      xpath=//input[@id="account"]
${AWSLogin_txtUsername}                   xpath=//input[@id="username"]
${AWSLogin_txtPassword}                   xpath=//input[@id="password"]
${AWSLogin_btnLogin}                      xpath=//a[@id="signin_button"]

*** Keywords ***

AWSLogin_login to AWS console
    ${username} =       Config_get XML element value    username
    ${password} =       Config_get XML element value    password
    Input UserName [${username}]
    Input Password [${password}]
    Click_Login
    sleep    10s

Click_Login
    wait until page contains element    ${AWSLogin_btnLogin}
    click element    ${AWSLogin_btnLogin}

Input Password [${Password}]
    Input Password      password    ${Password}

Input UserName [${Username}]
    Input Text    username   ${Username}

AWSLogin_enter account alias [${alias_name}]
    wait until page contains element    ${AWSLogin_txtAlias}
    input text      ${AWSLogin_txtAlias}      ${alias_name}


AWSLogin_Open Chrome Browser To Login Page
    [Documentation]  for chrome browser
    ${server_url} =       Config_get XML element value    server-url
    ${now} =     Get Current Date       result_format=%Y%m%d%H%M%S
    ${DOWNLOAD_DIRECTORY}      Join Path        /Users/fxdmspmotestteam/JenkinsScreenshots/${ProjectFolderName}/screenshots/Downloads/Down_buildNo-${BuildNumber}-${now}-${browser}
    ${CHROME_OPTIONS}=      Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
    ${disabled}     Create List     Chrome PDF Viewer
    ${prefs}         Create Dictionary   download.default_directory=${DOWNLOAD_DIRECTORY}    plugins.plugins_disabled=${disabled}    download.prompt_for_download=${false}
    Call Method     ${CHROME_OPTIONS}   add_experimental_option     prefs    ${prefs}
    Create Webdriver    Chrome  chrome_options=${CHROME_OPTIONS}
    go to      ${server_url}
    Maximize Browser Window
    Set Selenium Speed    ${delay}
    [return]    ${DOWNLOAD_DIRECTORY}
