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

*** Variables ***
${Main_TargetDateFormat}          %a, %d %b %Y %I:%M:%S %Z

*** Keywords ***
Main_Create open request [${client}] [${template}]
    ${id} =     Config_get unique id
    Create Session      linkTracking         ${Request_URL}     verify=true
    ${params} =          Create Dictionary   client=${client}     id=${id}       template=${template}
    [return]      ${params}     ${id}

Main_Run open request [${params}] and check response status [${response_status}]
    ${resp}=                Get Request    linkTracking        /open      params=${params}
    Status Should Be        ${response_status}            ${resp}
    ${request_open_time} =	    Get From Dictionary	    ${resp.headers}	    date
    [return]      ${request_open_time}

Main_Get request time as converted datetime format [${request_open_time}]
    ${converted_datetime} =	Convert Date	${request_open_time}    	date_format=${Main_TargetDateFormat}        
    [return]      ${converted_datetime} 

Main_Create report request [${client}] [${converted_datetime}]
    ${headers} =        Create Dictionary   x-api-key=${api_key}     Content-Type=${content_type} 
    Create Session      linkTracking         ${Request_URL}     headers=${headers}      verify=true
    log      ${converted_datetime}
    ${fromDate} =	Subtract Time From Date	        ${converted_datetime}	    ${report_search_time_gap}
    ${str_fromDate} =	Replace String      	${fromDate}	    -	/
    ${toDate} =	    Add Time To Date	        ${converted_datetime}	    ${report_search_time_gap}
    ${str_toDate} =	Replace String      	${toDate}	    -	/
    ${params} =         Create Dictionary   client=${client}     fromDate=${str_fromDate}    toDate=${str_toDate}
    [return]      ${params}

Main_Run report request [${params}] and check response status [${response_status}]
    ${resp}=                Get Request    linkTracking        /report      params=${params}
    Status Should Be        ${response_status}            ${resp}
    log     ${resp.json()}
    ${Items} =	    Get From Dictionary	    ${resp.json()}	    Items
    ${Count} =	    Get From Dictionary	    ${resp.json()}	    Count
    [return]        ${Items}        ${Count}

Main_Check the request output [${Items}] [${id}] [${Count}] [${request_open_time}]
    FOR    ${i}    IN RANGE    0    ${Count}
       Log  ${Items[${i}]}
       Main_Check attr in the list [${Items[${i}]}] [${id}] [${request_open_time}]
    END

Main_Check attr in the list [${attribute_list}] [${id}] [${request_open_time}]
    FOR   ${attr}   IN  ${attribute_list}
       Log  ${attr}
       ${get_id} =  Set variable    ${attr['id']}
       ${get_event_type} =  Set variable    ${attr['eventType']}
       ${get_event_Date} =  Set variable    ${attr['eventDate']}
       run keyword if   '${id}' == '${get_id}'      Main_validate open link and respond result as [${id}] [${get_id}] [${get_event_type}] [${get_event_Date}] [${request_open_time}]
    END

Main_validate open link and respond result as [${open_link_id}] [${created_report_id}] [${event_type_id}] [${get_event_Date}] [${request_open_time}]
    log to console      \n\nOpen link id: ${open_link_id}
    log to console      Genarated report id : ${created_report_id}
    log to console      Genarated report event type number : ${event_type_id}
    log to console      Open link created date: ${request_open_time}
    log to console      Genarated report created date : ${get_event_Date} \n
    Should Be Equal     ${open_link_id}     ${created_report_id}        
    Should Be Equal     ${event_type_id}     ${open_link_event_type_id}         Event type is not matching

   