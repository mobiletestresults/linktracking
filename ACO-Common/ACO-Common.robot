*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           RequestsLibrary
Library           Collections
Library           String

*** Variables ***
${Request_URL}                  https://fxforms2-tst.fxcst.net
${api_key}                      DRF30J1k8aaWxG1EJ5Xdm99stxIiMOWA8g7yx9XF
${content_type}                 application/json
${open_link_event_type_id}      8
${report_search_time_gap}       5 minutes       

*** Keywords ***
Config_get unique id
    ${date} =	Get Current Date	    UTC	        + 10 hours
    ${timestamp} =	Replace String Using Regexp    ${date}      [-: .]    ${EMPTY}
    [return]       ${timestamp}  


