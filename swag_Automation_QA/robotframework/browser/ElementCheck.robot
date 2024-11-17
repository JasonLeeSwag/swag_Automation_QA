*** Keywords ***
Check And Finish Element
    [Arguments]  ${element}
    Wait Until Keyword Succeeds  2x  10ms  Wait Until Element Is Visible      ${element}
    Wait Until Keyword Succeeds  2x  10ms  Wait Until Element Is Not Visible  ${element}

Check And Finish Text
    [Arguments]  ${text}
    Wait Until Keyword Succeeds  2x  10ms  Wait Until Page Contains             ${text}
    Wait Until Keyword Succeeds  2x  10ms  Wait Until Page Does Not Contain     ${text}

Get Random Element Number
    [Documentation]  從此 Element Count 中隨機取一個 Number 達到隨機選取的作用
    [Arguments]  ${element}  ${errorMsg}
    Run Keyword And Ignore Error  Wait Until Element Is Visible  ${element}
    ${element_count}=  Get Element Count  ${element}
    Run Keyword If  ${element_count} < 1  Capture Page Screenshot
    Run Keyword If  ${element_count} < 1  Fail  ${errorMsg}
    ${Random_Num}=  NumberUtils.Get Random One Number  start=1  end=${element_count}
    RETURN  ${Random_Num}

Wait Until Element Count Smaller
    [Arguments]  ${element}  ${conut}  ${retry_times}=5x  ${retry_delay_time}=1s
    ${status}  ${error_msg}=  Run Keyword And Ignore Error
    ...  Wait Until Keyword Succeeds  ${retry_times}  ${retry_delay_time}
    ...  ElementCheck.Element Count Should Smaller  ${element}  ${conut}
    Run Keyword If  "${status}" == "FAIL"  Capture Page Screenshot
    Run Keyword If  "${status}" == "FAIL"  Fail  ${error_msg}

Element Count Should Smaller
    [Arguments]  ${element}  ${conut}
    ${element_count}=  Get Element Count  ${element}
    Should Be True  ${conut} > ${element_count}

Get Text And Wait For Stable
    [Arguments]    ${el}    ${repeat_num}=3    ${max_try}=10    ${interval}=1sec
    Set Test Variable    ${count}    ${0}
    ${result}=    Set Variable    None
    ${pre_result}=    Set Variable    None
    :FOR    ${num}    IN RANGE    ${max_try}
    \    Log    "-------------" ${num} "------------"
    \    ${result}=    Get Text    ${el}
    \    Log    Get result: ${result}
    \    Run Keyword If    '${result}' == '${pre_result}'   Set Test Variable  ${count}  ${count + 1}
    \    Run Keyword Unless    '${result}' == '${pre_result}'    Set Test Variable  ${count}    ${1}
    \    Log    "count=" ${count}
    \    ${pre_result}=    Set Variable    ${result}
    \    Return From Keyword If    ${count} >= ${repeat_num}     ${result}
    \    Sleep     ${interval}
    Return From Keyword    None

Reload And Wait for Element is Visible
    [Arguments]    ${el}    ${reload_times}=3    ${timeout}=15    ${interval}=0sec
    :FOR    ${num}    IN RANGE    ${reload_times}
    \    Log    "-------------" ${num} "------------"
    \    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${el}    ${timeout}
    \    Run Keyword If    ${status}    Exit For Loop 
    \    Sleep     ${interval}
    \    Reload Page

Element Attribute Value Should Be
    [Arguments]  ${locator}  ${attribute}  ${expected}
    ${_GetAttribute}=  Get Element Attribute  ${locator}  ${attribute}
    Run Keyword If  "${expected}" != "${_GetAttribute}"  Run Keywords  
    ...  Capture Page Screenshot
    ...    AND
    ...  Fail  Attribute Not Equal： ${expected} != ${_GetAttribute}

Return Exist Xpath Elements
    [Arguments]  @{elements}
    Log  'Return Exist Xpath Elements' 將棄用，請改用 'Wait Until Element Is Visible From List' + 'Return Visible Elements'  WARN
    Wait Until Element Is Visible From List  @{elements}
    ${exist_elements}=  Return Visible Elements  @{elements}
    RETURN  ${exist_elements}

Wait Until Element Is Visible From List
    [Documentation]  當下最好只能顯示單筆 element
    ...              因為找到多筆時，第一筆如果沒有顯示就會造成 fail
    ...              請考慮是否改用 'Wait Until Page Contains Element From List'
    [Arguments]  @{elements}
    ${wait_elements}=  Catenate  SEPARATOR=${SPACE}|${SPACE}  @{elements}
    Wait Until Keyword Succeeds  2x  10ms
    ...  Wait Until Element Is Visible  ${wait_elements}

Wait Until Page Contains Element From List
    [Documentation]  只要有一筆 element 存在就 PASS
    [Arguments]  @{elements}
    ${wait_elements}=  Catenate  SEPARATOR=${SPACE}|${SPACE}  @{elements}
    Wait Until Keyword Succeeds  2x  10ms
    ...  Wait Until Page Contains Element  ${wait_elements}

Return Visible Elements
    [Arguments]  @{elements}
    @{exist_elements}=  Create List
    # 將 Register Keyword To Run On Failure 暫時移除，避免造成大量照片或 error log
    ${previous_kw}=  Register Keyword To Run On Failure  NONE
    :FOR  ${element}  IN  @{elements}
    \  ${element_status}=  Run Keyword And Return Status  Element Should Be Visible  ${element}
    \  Run Keyword If  ${element_status}  Append To List  ${exist_elements}  ${element}
    # 將 Register Keyword To Run On Failure 復原
    Register Keyword To Run On Failure  ${previous_kw}
    RETURN  ${exist_elements}
    
Loop Element And Check Text
    [Arguments]  ${elements_locate}  ${verify_text}
    @{web_object}=  Get Webelements  ${elements_locate}
    :FOR    ${element}    IN    @{web_object}
    \    ${get_text}=  Get Text  ${element}
    \    Should Be Equal  ${verify_text}  ${get_text}

判斷多組HTML元素是否已顯示
    [Documentation]  Not Visible 將不會拍照, 只是利用此動作取得當前 elements 狀態
    [Arguments]  @{elements}
    ${previous_kw}  Register Keyword To Run On Failure  NONE
    @{elements_status}  Create List
    :FOR  ${element}  IN  @{elements}
    \  ${element_status}  Run Keyword And Return Status  Element Should Be Visible  ${element}
    \  Append To List  ${elements_status}  ${element_status}
    RETURN  @{elements_status}
    [Teardown]  Register Keyword To Run On Failure  ${previous_kw}

判斷HTML元素是否已顯示
    [Documentation]  Not Visible 將不會拍照, 只是利用此動作取得當前 elements 狀態
    [Arguments]  ${element}
    @{elements_status}  ElementCheck.判斷多組HTML元素是否已顯示  ${element}
    RETURN  @{elements_status}[0]
