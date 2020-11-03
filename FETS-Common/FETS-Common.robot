*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
#Library           Selenium2Library
Library           RequestsLibrary
Library           Collections
Library           String
Library           XML

*** Variables ***
${v1}                           false
${v2}                           true
${partition_letter}             D
# Project settings file location
${XmlFile}                          /Users/fxdmspmotestteam/config/config.xml
# running envirement
${envirement}                       envb
# project
${project}                          fxforms
${server}                           https://fxdmssharedservices.signin.aws.amazon.com/console
${browser}                          safari
${delay}                            .5 second
${ProjectFolderName}                linktracking_chrome
${BuildNumber}                      1

${pixel}                            pixel
${open}                             open
${report}                           report
${clickthrough}                     clickthrough
${filereport}                       filereport
${reportconfig}                     reportconfig

${proxy_url}                    http://mbkproxy.fxdms.net:8080
${Main_TargetDateFormat}        %a, %d %b %Y %H:%M:%S %Z
${TargetDateFormatForDateRange}        %Y/%m/%d 12:00:00.000 AM
#${api_key}                      X2Na0QuHef3UFSe1xq2tdpejMolrJk87ll9vJxGg
${open_link_event_type_id}      8
${report_search_time_gap}       5 minutes
${loop_count}                       1

*** Keywords ***

#chrome

Config_Finalize the Executed Result
    ${myDate} =     Get Current Date    result_format=%Y%m%d%H%M%S
    #${project_name} =       Config_get XML element value    project-name
    Wait Until Keyword Succeeds     1 min   1 sec   move files      ${EXECDIR}/*.png      /Users/fxdmspmotestteam/JenkinsScreenshots/${ProjectFolderName}/screenshots/BuildNO-${BuildNumber}-${myDate}-${browser}
    Wait Until Keyword Succeeds     1 min   1 sec   Close All Applications

Download should be done
    [Arguments]    ${directory}
    [Documentation]    Verifies that the directory has only one folder and it is not a temp file.
    ...
    ...    Returns path to the file
    ${files}    List Files In Directory    ${directory}
    Length Should Be    ${files}    1    Should be only one file in the download folder
    Should Not Match Regexp    ${files[0]}    (?i).*\\.crdownload    Chrome is still downloading a file
    ${file}    Join Path    ${directory}    ${files[0]}
    Log    File was successfully downloaded to ${file}
    [Return]    ${file}

Config_Verify Successful Download of File
    [Arguments]    ${download_directory}
    ${file}    Wait Until Keyword Succeeds    1 min    2 sec    Download should be done    ${download_directory}
    log to console  \nFile Location : \n${file}
    [Return]    ${file}

Config_get unique id
    ${date} =	Get Current Date	    UTC	        + 10 hours
    ${timestamp} =	Replace String Using Regexp    ${date}      [-: .]    ${EMPTY}
    [Return]       ${timestamp}

Config_Save Screenshot
    [Arguments]    ${testnumber}    ${name}
    Wait Until Keyword Succeeds     1 min   1 sec   Capture Page Screenshot  ${browser}-${testnumber}-${name}.png

Config_get XML element value
    [Arguments]     ${param}
    ${root}=    Parse XML    ${XmlFile}
    Should Be Equal    ${root.tag}    credentials
    ${xml_node_value}    Set Variable
    ${xml_node_value}=      Get Element Text    ${root}    user-login[@environment='${envirement}'][@project='${project}'].${param}
    [Return]    ${xml_node_value}

