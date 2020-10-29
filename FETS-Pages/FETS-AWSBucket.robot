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

${AWSBucket_txtFilterbox}                      xpath=//input[@id="get-filter-value"]
${AWSBucket_linkReachResult}                      xpath=//a[text()="fxforms2-tst.fxcst.net-storage"]
${AWSBucket_linkFormDataFolder}                      xpath=//a[text()=' FormData ']
${AWSBucket_linkInFolder}                      xpath=//a[text()=' in ']
${AWSBucket_linkOutFolder}                      xpath=//a[text()=' out ']
${AWSBucket_inputFileUpload}                      xpath=//input[@id='uploadInput']
${AWSBucket_btnUpload}                      xpath=//button/span[2][text()='Upload']
${AWSBucket_btnNext}                      xpath=//button/span[text()='Next']
${AWSBucket_btnUploadOnPopup}                      xpath=//button/span[1][text()='Upload']
${AWSBucket_rbS3MasterKey}                      xpath=//span[text()='Amazon S3 master-key']
${AWSBucket_linkFormData}                      xpath=//a[text()='FormData']
${AWSBucket_linkAckGenaratedFile}                      xpath=//a[text()=' ACK_FILE ']
${AWSBucket_btnFileDownload}                      xpath=//button/span[text()='Download']

*** Keywords ***

AWSBucket_read ack text file contents [${txt_file}]
    ${text_file_content} =      get file    ${txt_file}
    log to console    Acknowledged file contents :
    log to console    ${text_file_content}
    set suite variable     ${suit_var_file_content}    ${text_file_content}

AWSBucket_Click on file download button
    wait until page contains element    ${AWSBucket_btnFileDownload}
    click element       ${AWSBucket_btnFileDownload}

AWSBucket_create and click download file link [${csv_file_name}]
    ${txt_file} =     get txt file name [${csv_file_name}]
    log to console    Genarated file name: ${txt_file}
    ${link_ack_file} =      replace string    ${AWSBucket_linkAckGenaratedFile}      ACK_FILE    ${txt_file}
    wait until page contains element    ${link_ack_file}
    click element       ${link_ack_file}

get txt file name [${csv_file_name}]
    ${txt_file} =      replace string    ${csv_file_name}      .csv    _ack.txt
    [Return]    ${txt_file}

AWSBucket_search created ack file in the table [${file_name}]
    sleep    5s
    ${txt_file} =     get txt file name [${file_name}]
    Enter filter value [${txt_file}]
    press keys      ${AWSBucket_txtFilterbox}      ENTER

AWSBucket_Click on -out- folder
    wait until page contains element    ${AWSBucket_linkOutFolder}
    click element       ${AWSBucket_linkOutFolder}

AWSBucket_Click on form data link on top navigation
    wait until page contains element    ${AWSBucket_linkFormData}
    click element       ${AWSBucket_linkFormData}

AWSBucket_Click on upload on popup
    wait until page contains element    ${AWSBucket_btnUploadOnPopup}
    click element       ${AWSBucket_btnUploadOnPopup}

AWSBucket_remove timespan added csv file from Res folder [${csv_file_name}]
    remove file    ${EXECDIR}/FETS-Res/${csv_file_name}

AWSBucket_Select -Amazon S3 master-key- under Encryption section
    wait until page contains element    ${AWSBucket_rbS3MasterKey}
    click element       ${AWSBucket_rbS3MasterKey}

AWSBucket_Click on next button
    wait until page contains element    ${AWSBucket_btnNext}
    click element       ${AWSBucket_btnNext}

AWSBucket_upload timestamp attached file [${filename}]
    choose file     ${AWSBucket_inputFileUpload}    ${EXECDIR}/FETS-Res/${filename}

AWSBucket_Prepair file to be uploaded
    ${timestamp} =     Config_get unique id
    ${filename_with_Timestamp}      set variable    fxform2-${timestamp}_test.csv
    copy file    ${EXECDIR}/FETS-Res/fxform2_test.csv   ${EXECDIR}/FETS-Res/${filename_with_Timestamp}
    [Return]    ${filename_with_Timestamp}

AWSBucket_read CSV file contents [${file_name}]
    ${list} =       read csv as list     ${EXECDIR}/FETS-Res/${file_name}
    log to console    ${list}

AWSBucket_Click on upload button
    wait until page contains element    ${AWSBucket_btnUpload}
    click element       ${AWSBucket_btnUpload}

AWSBucket_Click on -In- folder
    wait until page contains element    ${AWSBucket_linkInFolder}
    click element       ${AWSBucket_linkInFolder}

AWSBucket_Click on -FormData- folder
    wait until page contains element    ${AWSBucket_linkFormDataFolder}
    click element       ${AWSBucket_linkFormDataFolder}

AWSBucket_Click on the searched S3 bucket
    wait until page contains element    ${AWSBucket_linkReachResult}
    click element       ${AWSBucket_linkReachResult}

AWSBucket_Search for the respective S3 bucket
    Enter filter value [fxforms2-tst.fxcst.net-storage]

Enter filter value [${filter_txt}]
    wait until page contains element    ${AWSBucket_txtFilterbox}
    input text    ${AWSBucket_txtFilterbox}    ${filter_txt}