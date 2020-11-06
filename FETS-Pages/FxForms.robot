*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
#Library           Selenium2Library
Library           AppiumLibrary
Library           OperatingSystem
Library			  Collections
Library           String
Library			  Dialogs
Library           DateTime

*** Variables ***
${txt_postcode}         xpath=//input[@id="postcode"]
${btn_verify}           xpath=//button[@id="verifybutton"]

*** Keywords ***

FxForm_execute all the links [${loop_count}]
    log to console      \n->
    FOR     ${index}    IN RANGE    1       ${loop_count}+1
        log to console    loop ${index} : link 1
        FxForm_Access link [1] [${index}]
        log to console    loop ${index} : link 2
        FxForm_Access link [2] [${index}]
        log to console    loop ${index} : link 3
        FxForm_Access link [3] [${index}]
        log to console    loop ${index} : link 4
        FxForm_Access link [4] [${index}]
        log to console    loop ${index} : link 5
        FxForm_Access link [5] [${index}]
        log to console    loop ${index} : link 6
        FxForm_Access link [6] [${index}]
        log to console    loop ${index} : link 7
        FxForm_Access link [7] [${index}]
        log to console    loop ${index} : link 8
        FxForm_Access link [8] [${index}]
    END

FxForm_Access link [${number}] [${loop_number}]
    ${server_url} =       Config_get XML element value    link${number}
    Open the Browser    ${server_url}    ${browser}
    sleep     2s
    FxForm_page does not contain details [${loop_number}] [${number}]
    FxForm_varify page contents [${server_url}]
    Close Application

open the browser     [Arguments]        ${server_url}       ${browser} 
    #${status}=      Run keyword and return status       open application	http://127.0.0.1:4723/wd/hub	automationName=XCUITest		xcodeSigningId=iPhone Developer		deviceName=iPhone 8		platformName=iOS		platformVersion=14.1	browserName=safari		startIWDP=true		newCommandTimeout=600
    ${status}=      Run keyword and return status       open application	http://127.0.0.1:4723/wd/hub	browserName=safari      platformName=iOS    deviceName=iPhone 8     platformVersion=14.1    udid=0dc1d871a25ffcffe62eb09ea7e7649f83747968   newCommandTimeout=360   launchTimeout=30000     autoAcceptAlerts=true       webviewConnectRetries=12    webkitResponseTimeout=15000     startIWDP=true
    Run Keyword If  '${status}'=='False'     open the browser      ${server_url}       ${browser}
    go to url        ${server_url}

FxForm_page does not contain details [${loop_number}] [${number}]
    ${status} =    run keyword and return status    run keyword and continue on failure    element should be visible       xpath=//div[@class="row on-error page-active unknown-error"]
    run keyword if    '${status}' == 'True'        log to console    404 error (An error occurred while retrieving your information) loop : ${loop_number} link number : ${number}

FxForm_varify page contents [${url}]
    #${status1} =    run keyword and return status    run keyword and continue on failure    element should be visible       ${txt_postcode}
    #${status2} =    run keyword and return status    run keyword and continue on failure    element should be visible       ${btn_verify}
    ${status1} =    run keyword and return status       element should be visible       ${txt_postcode}
    ${status2} =    run keyword and return status       element should be visible       ${btn_verify}
    run keyword if    '${status1}' == 'True' and '${status2}' == 'True'      log to console      Page successfully loaded.
    run keyword if    '${status1}' == 'False' and '${status2}' == 'False'      log to console      Postcode text and verify button are not visible\nError Url : ${url}
