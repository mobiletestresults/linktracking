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
    Open Browser    ${server_url}    ${browser}
    sleep     2s
    FxForm_page does not contain details [${loop_number}] [${number}]
    FxForm_varify page contents
    Close Browser


FxForm_page does not contain details [${loop_number}] [${number}]
    ${status} =    run keyword and return status    run keyword and continue on failure    element should not be visible       xpath=//div[@class="row on-error page-active unknown-error"]
    run keyword if    '${status}' == 'False'        log to console    404 error (An error occurred while retrieving your information) loop : ${loop_number} link number : ${number}
#    Wait Until Page Does Not Contain    An error occurred while retrieving your information.        10s     error=404 error (An error occurred while retrieving your information)
#    Wait Until Page Does Not Contain    Please try the link you received again, or try again at a later time.       15s     error=404 error

FxForm_varify page contents
    title should be     QUU - Switch to eBilling
#    Wait Until Page Contains        Thanks for making the simple, smart, sustainable switch to eBilling.
#    Wait Until Page Contains        Please enter the postcode for your Sandstone Pl property in the field below.
#    Wait Until Page Contains        Once we've verified this, you can update your details and preferences.
    ${status1} =    run keyword and return status    run keyword and continue on failure    element should be visible       ${txt_postcode}
    ${status2} =    run keyword and return status    run keyword and continue on failure    element should be visible       ${btn_verify}
    run keyword if    '${status1}' == 'True' and '${status2}' == 'True'      log to console      Page successfully loaded.
    run keyword and continue on failure    element should be visible       ${txt_postcode}
