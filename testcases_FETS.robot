*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          library_test.robot
Resource          FETS-Common/FETS-Common.robot
Test Teardown     Close All Browsers
Suite Teardown    Config_Finalize the Executed Result


*** Test Cases ***

FxForm-001
    [Documentation]     investigating 404 error in SIT URL
    [Tags]    fxform
    FxForm_execute all the links [${loop_count}]

FETS_293
    [Documentation]     Click Event - Create click event with issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      293     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =    Main_Create click through event with issuer- url - unique id [${issuer}] [${req_url}] [${unique_id}]
    ${url} =    Main_Create request issuer - id - url [${issuer}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_created open issuer [${issuer}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_validate report result for id [${unique_id}]
    Main_validate report issuer [${issuer}]
    Main_validate report event type [17]
    Main_validate report url [${req_url}]
    Main_validate open link and respond result for event date

FETS_218
    [Documentation]     Click Event - Create click event without a client
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      218     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =    Main_get client by envirement
    ${empty_client} =       Set variable    ${EMPTY}
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =    Main_Create click through event with mandatory [${empty_client}] [${req_url}] [${unique_id}]
    ${url} =   Main_Create request client - id - url [${empty_client}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_Open event should not be available

FETS_217
    [Documentation]     Click Event - Create click event without an issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      217     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${empty_issuer} =     Set variable    ${EMPTY}
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =    Main_Create click through event with issuer- url - unique id [${empty_issuer}] [${req_url}] [${unique_id}]
    ${url} =    Main_Create request issuer - id - url [${empty_issuer}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_Open event should not be available

FETS_216
    [Documentation]     Click Event - Create click event with client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      216     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =     Main_Create click through event with mandatory [${client_id}] [${req_url}] [${unique_id}]
    ${url} =    Main_Create request client - id - url [${client_id}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report url [${req_url}]
    Main_validate open link and respond result for event date

FETS_215
    [Documentation]     Click Event - Create click event with issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      215     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =    Main_Create click through event with issuer- url - unique id [${issuer}] [${req_url}] [${unique_id}]
    ${url} =    Main_Create request issuer - id - url [${issuer}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report url [${req_url}]
    Main_validate open link and respond result for event date

FETS_214
    [Documentation]     Pixel Event - Create pixel event with all the details
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      214     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${open_template} =     Set variable    test
#    ${url} =     Main_Create pixel request for client - id - issuer- template [${client_id}] [${unique_id}] [${issuer}] [${open_template}]
    ${url} =     Main_Create request client - id - issuer- template [${client_id}] [${unique_id}] [${issuer}] [${open_template}] [${pixel}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate created open template [${open_template}]
    Main_Print report header
    Main_validate report event type [8]
    Main_validate report template [${open_template}]
    Main_validate open link and respond result for event date

FETS_190
    [Documentation]     Pixel Event - Create pixel event with client
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      190     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
#    ${url} =     Main_Create pixel request for client and id [${client_id}] [${unique_id}]
    ${url} =     Main_Create request client - id [${client_id}] [${unique_id}] [${pixel}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_validate report event type [8]
    Main_validate open link and respond result for event date

FETS_191
    [Documentation]     Pixel Event - Create pixel event without an issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      191     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${empty_issuer} =      set variable    ${EMPTY}
#    ${url} =     Main_Create pixel request for issuer and id [${empty_issuer}] [${unique_id}]
    ${url} =     Main_Create request issuer - id [${empty_issuer}] [${unique_id}] [${pixel}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Open event should not be available

FETS_192
    [Documentation]     Pixel Event - Create pixel event without a client
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      192     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${empty_client} =      set variable    ${EMPTY}
#    ${url} =     Main_Create pixel request for client and id [${empty_client}] [${unique_id}]
    ${url} =     Main_Create request client - id [${empty_client}] [${unique_id}] [${pixel}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Open event should not be available

FETS_193
    [Documentation]     Report - Search all events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      193     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${report_url} =    Main_Create report request client - from date - to date [${client_id}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_194
    [Documentation]     Report - Search all open events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      194     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${event_type} =     Set variable    8
    ${report_url} =       Main_Create report request client - event type - from date - to date [${client_id}] [${event_type}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_195
    [Documentation]     Report - Search all click events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      195     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${event_type} =     Set variable    17
    ${report_url} =       Main_Create report request client - event type - from date - to date [${client_id}] [${event_type}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_196
    [Documentation]     Open Event - Create open event with issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      196     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${issuer} =     Main_get issuer by envirement
    ${client_id} =  Main_get client by envirement
#    ${url} =    Main_Create open request with issuer and without client [${issuer}] [${unique_id}]
    ${url} =    Main_Create request issuer - id [${issuer}] [${unique_id}] [${open}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created open event id [${unique_id}]
    Main_created open issuer [${issuer}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_validate report event type [8]
    Main_validate report issuer [${issuer}]
    Main_validate open link and respond result for event date

FETS_197
    [Documentation]     Report - Search all events for a given client, date range and a url
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      197     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
    ${report_url} =       Main_Create report request client - url - from date - to date [${client_id}] [${req_url}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_198
    [Documentation]     Report - Search all events for a given client, date range and a template
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      198     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${template} =     Set variable    test
    ${client_id} =  Main_get client by envirement
    ${report_url} =       Main_Create report request client - template - from date - to date [${client_id}] [${template}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_199
    [Documentation]     Report - Search all events for a given client, date range and an issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      199     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${report_url} =       Main_Create report request client - issuer - from date - to date [${client_id}] [${issuer}] [${yesterday_date}] [${tomorrow_date}] [${report}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_200
    [Documentation]     Report - Search events without providing a client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      200     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${report_url} =    Main_Create report request from date - to date [${yesterday_date}] [${tomorrow_date}] [${report}]
    Main_Run report request [${report_url}] and check response with bad request [400]

FETS_202
    [Documentation]     Create Report Config - Create a new report configuration
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      202     SMTC    v2
    ${issuer} =     Main_get issuer by envirement
    ${post_data} =      set variable    { "createdAt": "2020-10-14 01:45:00", "fieldsToBeReported": ["uuid","eventType","eventdate","formId","formStatus","expiryDate","csvInputFilename","ip","userAgent","url"],"eventTypes": [8,17,20],"timeInterval": 4,"destination": ["S3","FRS"],"s3Bucket": "tracking-tst.fxdmscst.net","s3Key": "Core360Sync","isEAConfig": true }
    ${report_url} =      Main_Create report request with parameters [${reportconfig}] [${issuer}]
    ${Items} =      Main_Run report config post request [${report_url}] and check response status [200] [${post_data}]
    log to console    \nResponse details:\t${Items}
    Main_Should display response details [${Items}]

FETS_203
    [Documentation]     Create Report Config - Update an existing report configuration
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      203     SMTC    v2
    ${issuer} =     set variable    issuerNew
    ${post_data} =      set variable    { "createdAt": "2020-10-14 01:45:00", "fieldsToBeReported": ["uuid","eventType","eventdate","formId","formStatus","expiryDate","csvInputFilename","ip","userAgent","url"],"eventTypes": [8,17,20],"timeInterval": 4,"destination": ["S3","FRS"],"s3Bucket": "tracking-tst.fxdmscst.net","s3Key": "Core360Sync","isEAConfig": true }
    ${report_url} =      Main_Create report request with parameters [${reportconfig}] [${issuer}]
    ${Items} =      Main_Run report config post request [${report_url}] and check response status [200] [${post_data}]
    log to console    \nResponse details:\t${Items}
    Main_Should display response details [${Items}]

FETS_204
    [Documentation]     Click Event - Create click event with all the details
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      204     SMTC    v1
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
    ${open_template} =     Set variable    test
#    ${url} =     Main_Create click through event with all details with issuer [${client_id}] [${open_template}] [${req_url}] [${unique_id}] [${issuer}]
    ${url} =     Main_Create request issuer - id - client - template - url [${issuer}] [${unique_id}] [${client_id}] [${open_template}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_validate created open template [${open_template}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report url [${req_url}]
    Main_validate report template [${open_template}]
    Main_validate open link and respond result for event date

FETS_205
    [Documentation]     File Report - Search all events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      205     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${report_url} =       Main_Create report request client - from date - to date [${client_id}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_206
    [Documentation]     File Report - Search all open events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      206     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${event_type} =     Set variable    8
    ${report_url} =       Main_Create report request client - event type - from date - to date [${client_id}] [${event_type}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_207
    [Documentation]     File Report - Search all click events for a given client and a date range
    ...    [Created] Supun    [Updated] None    [Reviewed] None
    [Tags]      CT      207     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${event_type} =     Set variable    17
    ${report_url} =       Main_Create report request client - event type - from date - to date [${client_id}] [${event_type}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_208
    [Documentation]     File Report - Search all events for a given client, date range and an issuer
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      208     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${report_url} =       Main_Create report request client - issuer - from date - to date [${client_id}] [${issuer}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_210
    [Documentation]     File Report - Search all events for a given client, given date range and a url
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      210     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
    ${report_url} =       Main_Create report request client - url - from date - to date [${client_id}] [${req_url}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_211
    [Documentation]     File Report - Search all events for a given client, given date range and a template
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      211     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${tomorrow_date} =     Main_Get date time for from parameter [1 day]
    ${template} =     Set variable    test
    ${client_id} =  Main_get client by envirement
    ${report_url} =       Main_Create report request client - template - from date - to date [${client_id}] [${template}] [${yesterday_date}] [${tomorrow_date}] [${filereport}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]

FETS_212
    [Documentation]     File Report - Search events without providing the client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      212     SMTC    v2
    ${yesterday_date} =     Main_Get date time for from parameter [-1 day]
    ${client_id} =  set variable    ${EMPTY}
    ${report_url} =    Main_Create report request client - from date [${client_id}] [${yesterday_date}] [${filereport}]
    Main_Run report request [${report_url}] and check response with bad request [400]

FETS_213
    [Documentation]     File Report - Search events without providing the from date
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      213     SMTC    v2
    ${yesterday_date} =     set variable    ${EMPTY}
    ${client_id} =  Main_get client by envirement
    ${report_url} =    Main_Create report request client - from date [${client_id}] [${yesterday_date}] [${filereport}]
    Main_Run report request [${report_url}] and check response with bad request [400]

FETS_219
    [Documentation]     Report Config - Search all report configurations
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      219     SMTC    v2
    ${report_url} =      Main_Create report request without parameters [${reportconfig}]
    ${Items} =      Main_Run report config request [${report_url}] and check response status [200]
    log to console    \nResponse details:\t${Items}
    Main_Should display response details [${Items}]

FETS_220
    [Documentation]     Report Config - Client - Search report configuration for a client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      220     SMTC    v2
    ${client_id} =  Main_get client by envirement
    ${report_url} =      Main_Create report request client [${client_id}] [${reportconfig}]
    ${Items} =      Main_Run report config request [${report_url}] and check response status [200]
    log to console    \nResponse details:\t${Items}
    Main_Should display response details [${Items}]


FETS_222
    [Documentation]     Open Event - Create open event with mandatory details
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      222     SMTC        v2
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
#    ${url} =     Main_Create open request for client and id [${client_id}] [${unique_id}]
    ${url} =     Main_Create request client - id [${client_id}] [${unique_id}] [${open}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate open link and respond result for event date

FETS_223
    [Documentation]     Open Event - Create open event with all the details
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      223     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${issuer} =     Main_get issuer by envirement
    ${open_template} =     Set variable    test
#    ${url} =     Main_Create open request with issuer [${client_id}] [${open_template}] [${issuer}] [${unique_id}]
    ${url} =     Main_Create request client - id - issuer- template [${client_id}] [${unique_id}] [${issuer}] [${open_template}] [${open}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate created open template [${open_template}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report template [${open_template}]
    Main_validate open link and respond result for event date


FETS_276
    [Documentation]     Click Event - Create click event with mandatory details
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      276     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =     Main_Create click through event with mandatory [${client_id}] [${req_url}] [${unique_id}]
    ${url} =     Main_Create request client - id - url [${client_id}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report url [${req_url}]
    Main_validate open link and respond result for event date

FETS_277
    [Documentation]     Click Event - Create click event with all the details
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      277     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
    ${open_template} =     Set variable    test
#    ${url} =     Main_Create click through event with all details [${client_id}] [${open_template}] [${req_url}] [${unique_id}]
    ${url} =     Main_Create request client - id - url- template [${client_id}] [${unique_id}] [${req_url}] [${open_template}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_validate url [${req_url}]
    Main_validate created open template [${open_template}]
    Main_Print report header
    Main_validate report client id [${client_id}]
    Main_validate report result for id [${unique_id}]
    Main_validate report event type [8]
    Main_validate report url [${req_url}]
    Main_validate report template [${open_template}]
    Main_validate open link and respond result for event date

FETS_278
    [Documentation]     Open Event - Create open event without a client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      278     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${empty_clientID} =  Set variable    ${EMPTY}
    ${client_id} =  Main_get client by envirement
    ${open_template} =     Set variable    ${EMPTY}
#    ${url} =     Main_Create open request [${empty_clientID}] [${open_template}] [${unique_id}]
    ${url} =     Main_Create request client - id - template [${empty_clientID}] [${unique_id}] [${open_template}] [${open}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${empty_clientID}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Open event should not be available

FETS_279
    [Documentation]     Open Event - Create open event without an id
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      279     SMTC    v2
    ${unique_id} =     Set variable    ${EMPTY}
    ${client_id} =  Main_get client by envirement
    ${open_template} =     Set variable    ${EMPTY}
#    ${url} =     Main_Create open request [${client_id}] [${open_template}] [${unique_id}]
    ${url} =     Main_Create request client - id - template [${client_id}] [${unique_id}] [${open_template}] [${open}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Open event should not be available

FETS_280
    [Documentation]     Click Event - Create click event without a client
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      280     SMTC    v2
    ${unique_id} =     Config_get unique id
    ${empty_clientID} =   Set variable    ${EMPTY}
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
#    ${url} =     Main_Create click through event with mandatory [${empty_clientID}] [${req_url}] [${unique_id}]
    ${url} =     Main_Create request client - id - url [${empty_clientID}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${empty_clientID}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Click through event should not be available

FETS_281
    [Documentation]     Click Event - Create click event without an id
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      281     SMTC    v2
    ${unique_id} =     Set variable    ${EMPTY}
    ${client_id} =  Main_get client by envirement
    ${req_url} =     Set variable    https://www.yahoo.com
    ${url} =     Main_Create request client - id - url [${client_id}] [${unique_id}] [${req_url}] [${clickthrough}]
    ${request_open_time} =      Main_Run open request [${url}] and check response status [200]
    ${converted_datetime} =      Main_Get request time as converted datetime format [${request_open_time}]
    ${report_url} =     Main_Create report request [${client_id}] [${converted_datetime}]
    ${Items}    ${Count} =      Main_Run report request [${report_url}] and check response status [200]
    Main_Check the request output [${Items}] [${unique_id}] [${Count}]
    Main_Print open event header
    Main_Created client id [${client_id}]
    Main_Created open event id [${unique_id}]
    Main_Created open event date [${converted_datetime}]
    Main_Print report header
    Main_Click through event should not be available

FETS_284
    [Documentation]     Data Preloading - Verify the test data gets loaded to the DB
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      284     SMTC    v2      f2
    ${DOWNLOAD_DIRECTORY} =     AWSLogin_Open Chrome Browser To Login Page
    AWSLogin_enter account alias [fxdmssharedservices]
    Config_Save Screenshot    FETS-284    enter account alias [fxdmssharedservices]
    AWSLogin_login to AWS console
    Config_Save Screenshot    FETS-284    login to AWS console
    AWSHome_switch user role
    Config_Save Screenshot    FETS-284    switch user role
    AWSSwitchRole_fill switch role form
    Config_Save Screenshot    FETS-284    fill switch role form
    AWSSwitchRole_click switch role button
    Config_Save Screenshot    FETS-284    click switch role button
    AWSSwitchRole_Search for S3 service in Find services search box
    Config_Save Screenshot    FETS-284    Search for S3 service in Find services search box
    AWSBucket_Search for the respective S3 bucket
    Config_Save Screenshot    FETS-284    Search for the respective S3 bucket
    AWSBucket_Click on the searched S3 bucket
    Config_Save Screenshot    FETS-284    Click on the searched S3 bucket
    AWSBucket_Click on -FormData- folder
    Config_Save Screenshot    FETS-284    Click on -FormData- folder
    AWSBucket_Click on -In- folder
    Config_Save Screenshot    FETS-284    Click on -In- folder
    AWSBucket_Click on upload button
    Config_Save Screenshot    FETS-284      Click on upload button
    ${filename} =       AWSBucket_Prepair file to be uploaded
    Config_Save Screenshot    FETS-284      Prepair file to be uploaded
    AWSBucket_read CSV file contents [${filename}]
    log to console    \nUploaded file name : ${filename}
    AWSBucket_upload timestamp attached file [${filename}]
    Config_Save Screenshot    FETS-284      upload timestamp attached file [${filename}]
    AWSBucket_Click on next button
    Config_Save Screenshot    FETS-284      Click on next button
    AWSBucket_Click on next button
    Config_Save Screenshot    FETS-284      Click on next2 button
    AWSBucket_Select -Amazon S3 master-key- under Encryption section
    Config_Save Screenshot    FETS-284      Select -Amazon S3 master-key- under Encryption section
    AWSBucket_Click on next button
    Config_Save Screenshot    FETS-284      Click on next3 button
    AWSBucket_Click on upload on popup
    Config_Save Screenshot    FETS-284      Click on upload on popup
    AWSBucket_remove timespan added csv file from Res folder [${filename}]
    Config_Save Screenshot    FETS-284      remove timespan added csv file from Res folder [${filename}]
    AWSBucket_Click on form data link on top navigation
    Config_Save Screenshot    FETS-284      Click on form data link on top navigation
    AWSBucket_Click on -out- folder
    Config_Save Screenshot    FETS-284      Click on -out- folder
    AWSBucket_search created ack file in the table [${filename}]
    Config_Save Screenshot    FETS-284      search created ack file in the table [${filename}]
    AWSBucket_create and click download file link [${filename}]
    Config_Save Screenshot    FETS-284      create and click download file link [${filename}]
    AWSBucket_Click on file download button
    Config_Save Screenshot    FETS-284      Click on file download button
    ${file} =   Config_Verify Successful Download of File   ${DOWNLOAD_DIRECTORY}
    Config_Save Screenshot    FETS-284      Verify Successful Download of File
    AWSBucket_read ack text file contents [${file}]
    Config_Save Screenshot    FETS-284      read ack text file contents

FETS_177
    [Documentation]     Retrieve Form Data (Open) - Retrieve form data
    ...    [Created] Supun    [Updated] None    [Reviewed] Supun
    [Tags]      CT      177     SMTC    v2      f2
    ${test_var_file_content_tmp} =      set variable        id,formId,expiryDate,status 1000000001,GVCnBPL,29/10/2020,SUCCESS
#    log to console   suit : ${suit_var_file_content}
    ${form_id} =    Main_get form if from file contents [${test_var_file_content_tmp}]
    ${client} =     set variable    fxforms2-tst
    ${url} =    Main_create request form id - client [${form_id}] [${client}]
    ${respond_values} =     Main_Run request without headers [${url}] and check response status [200]
    Main_Validate the form details [${respond_values}]