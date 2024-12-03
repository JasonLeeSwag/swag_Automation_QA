*** Variables ***
&{SHARED_TESTDATA_DIRECTORY}    Windows=\\\\xx.xxx.x.xx${/}test_data
...                             Linux=NONE
...                             Darwin=/Volumes/test_data

*** Keywords ***
Check Download File
    [Arguments]  ${path}  ${time}=1 min
    Log  This KW "Check Download File" is Deprecated, use build-in KW Wait Until Created instead  WARN
    Wait Until Created  ${path}  ${time}

Remove Download File
    [Arguments]  ${path}
    Remove File  ${path}

Get Download File
    [Arguments]  ${path}
    ${file}=  Get File  ${path}
    RETURN  ${file}

Get Shared File
    [Documentation]  取得共享資料夾 test_data 的檔案
    [Arguments]  ${file_name}
    ${test_data_folder}=  Get Shared Path of System OS
    ${file}=  Get File  ${test_data_folder}${/}${file_name}
    RETURN  ${file}

Remove Shared File
    [Documentation]  刪除共享資料夾 test_data 的檔案
    [Arguments]  ${file_name}
    ${test_data_folder}=  Get Shared Path of System OS
    Remove File  ${test_data_folder}${/}${file_name}

Create Shared File
    [Documentation]  建立共享資料夾 test_data 的檔案
    [Arguments]  ${file_name}
    ${test_data_folder}=  Get Shared Path of System OS
    Create File  ${test_data_folder}${/}${file_name}  encoding=UTF-8

Append To Shared File
    [Documentation]  新增共享資料夾 test_data 的檔案內容
    [Arguments]  ${file_name}  ${file_content}
    ${test_data_folder}=  Get Shared Path of System OS
    Append To File  ${test_data_folder}${/}${file_name}  ${file_content}  encoding=UTF-8

Choose Shared File
    [Documentation]  選擇共享資料夾 test_data 的檔案
    [Arguments]  ${file_input}  ${file_name}
    ${test_data_folder}=  Get Shared Path of System OS
    Choose File  ${file_input}  ${test_data_folder}${/}${file_name}

Get System OS
    [Documentation]  Darwin 為 Mac OS
    ${system}=    Evaluate    platform.system()    platform
    RETURN  ${system}

Get Shared Path of System OS
    [Documentation]  各作業系統的共享資料夾不同，因此要先取得是何種作業系統
    ${system}=  FileUtils.Get System OS
    ${test_data_folder}=  Set Variable  ${SHARED_TESTDATA_DIRECTORY["${system}"]}
    RETURN  ${test_data_folder}