*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          library_test.robot

*** Test Cases ***

ACO_304
    [Documentation]     Save open event with mandatory details
    [Tags]      CT      SMOKE
    ${clientID} =  Set variable    fxforms2-tst
    ${params}       ${id} =     Main_Create open request [${clientID}] [test]
    ${request_open_time} =      Main_Run open request [${params}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_params} =     Main_Create report request [${clientID}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_params}] and check response status [200]
    Main_Check the request output [${Items}] [${id}] [${Count}] [${converted_datetime}]








