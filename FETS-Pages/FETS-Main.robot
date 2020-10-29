*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library			  Collections
Library           String
Library			  Dialogs
Library           DateTime
Library           RequestsLibrary
Library           JSONLibrary
Library           CSVLib

*** Variables ***


*** Keywords ***

Main_get form if from file contents [${file_content}]
    @{words} =      split string    ${file_content}     ,
    [Return]   @{words}[4]

get api key
    ${api_key} =        Config_get XML element value        api-key
    [Return]    ${api_key}

Main_get client by envirement
    ${client_id} =      Config_get XML element value    client
    [Return]    ${client_id}

Main_get issuer by envirement
    ${issuer} =      Config_get XML element value    issuer
    [Return]    ${issuer}

Main_Get date time for from parameter [${day}]
    ${yesterday_date} =     get current date        result_format=${TargetDateFormatForDateRange}      increment=${day}
    [Return]    ${yesterday_date}

get tracking urls
    ${linktrackingV1_URL} =     Config_get XML element value     v1
    ${linktrackingV2_URL} =     Config_get XML element value     v2
    [Return]         ${linktrackingV1_URL}      ${linktrackingV2_URL}

# --------------------------------

Main_Create request issuer - id - client - template - url [${issuer}] [${unique_id}] [${clientID}] [${open_template}] [${url}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${req_url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${clientID}&id=${unique_id}&template=${open_template}&url=${url}&issuer=${issuer}
                        ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${clientID}&id=${unique_id}&template=${open_template}&url=${url}&issuer=${issuer}
    [Return]      ${req_url}

Main_Create request client - id - url- template [${clientID}] [${unique_id}] [${url}] [${open_template}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${req_url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${clientID}&id=${unique_id}&template=${open_template}&url=${url}
                        ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${clientID}&id=${unique_id}&template=${open_template}&url=${url}
    [Return]      ${req_url}

Main_Create request client - id - issuer- template [${client}] [${unique_id}] [${issuer}] [${template}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${client}&id=${unique_id}&issuer=${issuer}&template=${template}
                    ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${client}&id=${unique_id}&issuer=${issuer}&template=${template}
    [Return]      ${url}

Main_Create request issuer - id - url [${issuer}] [${unique_id}] [${url}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${req_url} =       set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?issuer=${issuer}&id=${unique_id}&url=${url}
                        ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?issuer=${issuer}&id=${unique_id}&url=${url}
    [Return]      ${req_url}

Main_Create request client - id - url [${client}] [${unique_id}] [${url}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${req_url} =       set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${client}&id=${unique_id}&url=${url}
                        ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${client}&id=${unique_id}&url=${url}
    [Return]      ${req_url}

Main_Create request client - id - template [${client}] [${unique_id}] [${template}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${client}&id=${unique_id}&template=${template}
                    ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${client}&id=${unique_id}&template=${template}
    [Return]      ${url}

Main_Create request client - id [${client}] [${unique_id}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?client=${client}&id=${unique_id}
                    ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?client=${client}&id=${unique_id}
    [Return]      ${url}

Main_Create request issuer - id [${issuer}] [${unique_id}] [${func_name}]
    ${linktrackingV1_URL}       ${linktrackingV2_URL}=     get tracking urls
    ${url} =        set variable if      '${v1}' == 'true'        ${linktrackingV1_URL}/${func_name}?issuer=${issuer}&id=${unique_id}
                    ...                  '${v2}' == 'true'        ${linktrackingV2_URL}/${func_name}?issuer=${issuer}&id=${unique_id}
    [Return]      ${url}

# --------------------------------

Main_Run request without headers [${url}] and check response status [${response_status}]
    ${data} =       call_Request_With_Headers       ${proxy_url}        ${url}      ${response_status}       GET      application/json       ${EMPTY}       ${EMPTY}
    sleep   3s
    should contain     ${data}      ${response_status}
    ${json_resp} =      convert string to JSON          ${data}
#    log to console      ${json_resp}
    ${Status} =	    Get From Dictionary	    ${json_resp}	    Status
    ${status_string} =      convert to string       ${Status}
    Should Be Equal       ${response_status}            ${status_string}
    [Return]       ${json_resp}


Main_create request form id - client [${form_id}] [${client}]
    ${url} =    set variable    https://fxforms2-tst.fxcst.net/forms/${form_id}?client=${client}
    [Return]    ${url}

Main_Validate the form details [${respond_values}]
    ${form_id} =        get from dictionary    ${respond_values}    formId
    log to console    Form ID : ${form_id}
    ${length} =     get length    ${respond_values.keys()}
    ${keys} =      get dictionary keys    ${respond_values}     sort_keys=True
    FOR    ${i}    IN RANGE     0   ${length}-2
        ${values} =      get from list    ${keys}     ${i}
        ${first_letter} =      get substring    ${values}   0    1
        log to console    Key: ${values}
        should be equal    ${first_letter}      O
    END

#--------------------------------------------------

Main_Run open request [${url}] and check response status [${response_status}]
    ${data} =       call_Request_Without_Headers       ${proxy_url}        ${url}      ${response_status}       GET      application/json
    sleep   3s
    ${json_data} =      convert string to JSON          ${data}
    ${resp} =    Get From Dictionary	    ${json_data}	    Status
    Should Be Equal       ${response_status}            ${resp}
    ${request_open_time} =	     Get From Dictionary	    ${json_data}	    Date
    [Return]      ${request_open_time}

Main_Get request time as converted datetime format [${request_open_time}]
    ${converted_datetime} =	Convert Date	${request_open_time}    	date_format=${Main_TargetDateFormat}
    [Return]      ${converted_datetime}

get request url
    ${Request_URL} =    Config_get XML element value    tracking-url
    [Return]    ${Request_URL}

Main_Create report request with parameters [${func_name}] [${param}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}/${param}
    [Return]      ${url}

Main_Create report request without parameters [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}
    [Return]      ${url}

Main_Create report request client [${client}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}/${client}
    [Return]      ${url}

Main_Create report request client - from date - to date [${client}] [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}
    [Return]      ${url}

Main_Create report request from date - to date [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?fromDate=${from_date}&toDate=${to_date}
    [Return]      ${url}

Main_Create report request client - from date [${client}] [${from_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}
    [Return]      ${url}

#Main_Create report request client - from date - to date [${client}] [${from_date}] [${to_date}] [${func_name}]
#    ${Request_URL} =        get request url
#    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}
#    [Return]      ${url}

Main_Create report request client - url - from date - to date [${client}] [${url}] [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}&url=${url}
    [Return]      ${url}

Main_Create report request client - issuer - from date - to date [${client}] [${issuer}] [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}&issuer=${issuer}
    [Return]      ${url}

Main_Create report request client - template - from date - to date [${client}] [${template}] [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}&template=${template}
    [Return]      ${url}

Main_Create report request client - event type - from date - to date [${client}] [${event_type}] [${from_date}] [${to_date}] [${func_name}]
    ${Request_URL} =        get request url
    ${url} =         set variable        ${Request_URL}/${func_name}?client=${client}&fromDate=${from_date}&toDate=${to_date}&eventType=${event_type}
    [Return]      ${url}

Main_Create report request [${client}] [${converted_datetime}]
    ${Request_URL} =        get request url
    ${fromDate} =	Subtract Time From Date	        ${converted_datetime}	    ${report_search_time_gap}
    ${str_fromDate} =	Replace String      	${fromDate}	    -	/
    ${toDate} =	    Add Time To Date	        ${converted_datetime}	    ${report_search_time_gap}
    ${str_toDate} =	Replace String      	${toDate}	    -	/
    ${url} =         set variable        ${Request_URL}/${report}?client=${client}&fromDate=${str_fromDate}&toDate=${str_toDate}
    [Return]      ${url}

Main_Run report request [${report_url}] and check response with bad request [${response_status}]
    #${resp} =       call_Report_Request     ${proxy_url}     ${report_url}      ${response_status}    ${api_key}
    ${api_key} =        get api key
    ${headers} =        Create Dictionary   x-api-key=${api_key}
    ${resp} =       call_Request_With_Headers       ${proxy_url}        ${report_url}      ${response_status}       GET      application/json       ${headers}       ${EMPTY}
    log to console    \n\t${resp}
    should contain     ${resp}      ${response_status}

Main_Run report config post request [${report_url}] and check response status [${response_status}] [${post_data}]
    ${api_key} =        get api key
    ${headers} =        Create Dictionary   x-api-key=${api_key}
    ${resp} =       call_Request_With_Headers       ${proxy_url}        ${report_url}      ${response_status}       POST      application/json       ${headers}       ${post_data}
#    ${reg_match} =      get regexp matches    ${resp}   \{(.*?)}
    ${status_code} =      remove string using regexp    ${resp}   \{(.*?)}\,
    should contain      ${status_code}    ${response_status}
    [Return]        ${resp}

Main_Run report config request [${report_url}] and check response status [${response_status}]
    ${api_key} =        get api key
    ${headers} =        Create Dictionary   x-api-key=${api_key}
    ${resp} =       call_Request_With_Headers       ${proxy_url}        ${report_url}      ${response_status}       GET      application/json       ${headers}       ${EMPTY}
#    ${reg_match} =      get regexp matches    ${resp}   \{(.*?)}
    ${status_code} =      remove string using regexp    ${resp}   \{(.*?)}\,
    should contain      ${status_code}    ${response_status}
    [Return]        ${resp}

Main_Run report request [${report_url}] and check response status [${response_status}]
    #${resp} =       call_Report_Request     ${proxy_url}     ${report_url}      ${response_status}    ${api_key}
    ${api_key} =        get api key
    ${headers} =        Create Dictionary   x-api-key=${api_key}
    ${resp} =       call_Request_With_Headers       ${proxy_url}        ${report_url}      ${response_status}       GET      application/json       ${headers}      ${EMPTY}
#    log to console    ${resp}
    ${json_resp} =      convert string to JSON          ${resp}
    ${Items} =	    Get From Dictionary	    ${json_resp}	    Items
    ${Count} =	    Get From Dictionary	    ${json_resp}	    Count
    ${Status} =	    Get From Dictionary	    ${json_resp}	    Status
    ${status_string} =      convert to string       ${Status}
    Should Be Equal       ${response_status}            ${status_string}
    [Return]        ${Items}        ${Count}

Main_Should display response details [${Items}]
    run keyword and ignore error    should contain    ${Items}      fieldsToBeReported
    run keyword and ignore error    should contain    ${Items}      uuid
    run keyword and ignore error    should contain    ${Items}      eventType
    run keyword and ignore error    should contain    ${Items}      eventdate
    run keyword and ignore error    should contain    ${Items}      formId
    run keyword and ignore error    should contain    ${Items}      formStatus
    run keyword and ignore error    should contain    ${Items}      expiryDate
    run keyword and ignore error    should contain    ${Items}      csvInputFilename
    run keyword and ignore error    should contain    ${Items}      ip
    run keyword and ignore error    should contain    ${Items}      userAgent
    run keyword and ignore error    should contain    ${Items}      url
    run keyword and ignore error    should contain    ${Items}      lastGeneratedAt
    run keyword and ignore error    should contain    ${Items}      s3Bucket
    run keyword and ignore error    should contain    ${Items}      client
    run keyword and ignore error    should contain    ${Items}      isEAConfig
    run keyword and ignore error    should contain    ${Items}      eventTypes
    run keyword and ignore error    should contain    ${Items}      createdAt
    run keyword and ignore error    should contain    ${Items}      destination
    run keyword and ignore error    should contain    ${Items}      timeInterval
    run keyword and ignore error    should contain    ${Items}      s3Key


Main_Should display all the open and click events for the given client and the date range [${Items}] [${Count}]
    log to console      \nevents count : ${Count}
    log to console      Event list : \n${Items}\n
    FOR    ${i}    IN RANGE    0    ${Count}
       Log  ${Items[${i}]}
       dictionary should contain key    ${Items[${i}]}      eventDate
       dictionary should contain key    ${Items[${i}]}      eventType
       dictionary should contain key    ${Items[${i}]}      ip
       dictionary should contain key    ${Items[${i}]}      uuid
       dictionary should contain key    ${Items[${i}]}      data
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      id
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      url
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      userAgent
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      template
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      issuer
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      geolocation_data
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      useragent_data
       run keyword and ignore error     dictionary should contain key    ${Items[${i}]}      formId
       run keyword and ignore error     dictionary should contain key    ${Items[${i}].data[0]}      name
       run keyword and ignore error     dictionary should contain key    ${Items[${i}].data[0]}      value
    END

Main_Check the request output [${Items}] [${id}] [${Count}]
    FOR    ${i}    IN RANGE    0    ${Count}
       Log  ${Items[${i}]}
       Main_Check attr in the list [${Items[${i}]}] [${id}]
    END

Main_Check attr in the list [${attribute_list}] [${id}]
    FOR   ${attr}   IN  ${attribute_list}
#       Log  ${attr}
       ${status}     ${get_id} =      Run keyword and ignore error        Set variable    ${attr['id']}
#       log to console    ${id}/${get_id}
       ${status}     ${get_event_type} =      Run keyword and ignore error        Set variable    ${attr['eventType']}
       ${status}     ${get_event_Date} =      Run keyword and ignore error        Set variable    ${attr['eventDate']}
       ${status}     ${issuer} =      Run keyword and ignore error         Set variable    ${attr['issuer']}
       ${status}     ${template} =      Run keyword and ignore error         Set variable    ${attr['template']}
       ${status}     ${url} =      Run keyword and ignore error         Set variable    ${attr['url']}
       ${status}     ${data} =      Run keyword and ignore error         Set variable    ${attr['data']}
       ${respond_values} =      run keyword if   '${id}' == '${get_id}'       create dictionary   id=${get_id}   eventType=${get_event_type}    eventDate=${get_event_Date}     issuer=${issuer}   template=${template}    url=${url}   data=${data}
       set global variable      ${respond_values}
       run keyword if   '${id}' == '${get_id}'      Exit for loop
    END

Main_validate url [${open_url}]
    log to console      \turl : ${open_url}

Main_validate report url [${open_url}]
    ${report_genarated_url} =      Get From Dictionary	    ${respond_values}	    url
    log to console      \turl : ${report_genarated_url}
    Should Be Equal     ${open_url}     ${report_genarated_url}            url is not matching

Main_validate created open template [${open_template}]
    log to console      \ttemplate : ${open_template}

Main_validate report template [${open_template}]
    ${report_genarated_template} =      Get From Dictionary	    ${respond_values}	    template
    log to console      \ttemplate : ${report_genarated_template}
    Should Be Equal     ${open_template}     ${report_genarated_template}            template is not matching

Main_validate report issuer [${open_issuer}]
    ${report_genarated_issuer} =      Get From Dictionary	    ${respond_values}	    issuer
    log to console      \tissuer : ${report_genarated_issuer}\n
    Should Be Equal     ${open_issuer}     ${report_genarated_issuer}            issuer is not matching

Main_created open issuer [${open_issuer}]
    log to console      \tissuer : ${open_issuer}

Main_Print open event header
    log to console      \nCreated event :

Main_Print report header
    log to console      \nReport output :

Main_validate report result for id [${open_link_id}]
    ${genarated_report_id} =      Get From Dictionary	    ${respond_values}	    id
    log to console      \tid : ${genarated_report_id}
    Should Be Equal     ${open_link_id}     ${genarated_report_id}            Id is not matching

Main_Created open event id [${open_link_id}]
     run keyword if   '${open_link_id}' == '${EMPTY}'       log to console      \tid : Blank
     run keyword if   '${open_link_id}' != '${EMPTY}'       log to console      \tid : ${open_link_id}
#     log to console      \tid : ${open_link_id}

Main_Created open event date [${date}]
    log to console      \tDate : ${date}

Main_validate report event type [${eventTypeId}]
    ${event_type_id} =      Get From Dictionary	    ${respond_values}	    eventType
    log to console      \teventType : ${event_type_id}
    Should Be Equal     ${eventTypeId}     ${event_type_id}            event type is not matching

Main_Created event type [${eventTypeId}]
    log to console      \teventType : ${eventTypeId}

Main_Created client id [${client_id}]
    run keyword if   '${client_id}' == '${EMPTY}'       log to console      \tclient : Blank
    run keyword if   '${client_id}' != '${EMPTY}'        log to console      \n\tclient : ${client_id}


Main_validate report client id [${client_id}]
    ${client_data} =      Get From Dictionary	    ${respond_values}	    data
    log to console      \n\tclient : ${client_data[0]}
    dictionary should contain value    ${client_data[0]}      ${client_id}

Main_validate open link and respond result for event date
    ${get_event_Date} =      Get From Dictionary	    ${respond_values}	    eventDate
    log to console      \tdate : ${get_event_Date}\n

Main_Open event should not be available
    ${value} =      get variable value      ${respond_values}
    log to console       \tItems : ${value}
    Should Be Equal     "None"     "${value}"         Contain items

Main_Click through event should not be available
    ${value} =      get variable value      ${respond_values}
    run keyword if   '${value}' == 'None'       log to console      \tItems : Blank
    run keyword if   '${value}' != 'None'       log to console      \tItems : ${value}
    Should Be Equal     "None"     "${value}"         Contain items

   