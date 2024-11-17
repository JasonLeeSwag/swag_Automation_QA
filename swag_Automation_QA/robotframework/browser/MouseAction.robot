*** Variables ***
${delay_for_loading_page}  10 s

*** Keywords ***
Mouse Over Then Click Element
    [Arguments]    ${menu}   ${menu_button}
    Mouse Over     ${menu}
    Set Focus To Element     ${menu_button}
    Wait And Click Element   ${menu_button}  2s

Wait And Click Element
    [Documentation]  中間會有 Mouse Over，如不想要 Mouse Over 請使用 'Wait And Click Element Without Mouse Over'
    [Arguments]  ${locate}  ${time_to_wait}=${delay_for_loading_page}  ${click_delay}=0s
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${locate}  ${time_to_wait}
    Wait Until Keyword Succeeds  2x  100ms  Mouse Over  ${locate}
    Sleep  ${click_delay}
    Wait Until Keyword Succeeds  2x  100ms  Click Element  ${locate}

Wait And Click Element Without Mouse Over
    [Documentation]  等待並點擊 Element
    [Arguments]  ${locate}  ${time_to_wait}=${delay_for_loading_page}
    Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${locate}  ${time_to_wait}
    Wait Until Keyword Succeeds  2x  100ms  Click Element  ${locate}

Wait And Get Text
    [Arguments]  ${locate}  ${time_to_wait}=${delay_for_loading_page}  ${get_delay}=0s
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${locate}  ${time_to_wait}
    Sleep  ${get_delay}
    ${text} =  Get Text  ${locate}
    RETURN  ${text}

Wait And Mouse Over
    [Arguments]  ${element}  ${time_to_wait}=${delay_for_loading_page}  ${mouse_over_delay}=0s
    Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${element}  ${time_to_wait}
    Sleep  ${mouse_over_delay}
    Wait Until Keyword Succeeds  2x  100ms  Mouse Over  ${element}

Wait And Mouse Out
    [Arguments]  ${element}  ${time_to_wait}=${delay_for_loading_page}  ${mouse_over_delay}=0s
    Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${element}  ${time_to_wait}
    Sleep  ${mouse_over_delay}
    Wait Until Keyword Succeeds  2x  100ms  Mouse Out  ${element}

Wait And Select Element
    [Arguments]  ${element}  ${value}
    Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${element}
    Wait Until Keyword Succeeds  2x  100ms  Select From List By Value  ${element}  ${value}

Click Element And Select Pop Up Window
    [Arguments]  ${locate}
    Wait And Click Element  ${locate}
    選擇瀏覽器新分頁

Select Checkbox And Check
    [Arguments]  ${element}  ${retry_times}=2x  ${retry_delay_time}=100ms
    Select Checkbox  ${element}
    # 偶爾會因反應過慢導致 fail，所以增加 Retry
    Wait Until Keyword Succeeds  ${retry_times}  ${retry_delay_time}
    ...  Checkbox Should Be Selected  ${element}

Unselect Checkbox And Check
    [Arguments]  ${element}  ${retry_times}=2x  ${retry_delay_time}=100ms
    Unselect Checkbox  ${element}
    # 偶爾會因反應過慢導致 fail，所以增加 Retry
    Wait Until Keyword Succeeds  ${retry_times}  ${retry_delay_time}
    ...  Checkbox Should Not Be Selected  ${element}

清除該元素底下的所有多選框
    [Arguments]  ${element}
    ${input_element}=  Set Variable  ${element}//input[@type="checkbox"]
    ${input_count}=  Get Element Count  ${input_element}
    :FOR  ${index}  IN RANGE  1  ${input_count} + 1
    \  Unselect Checkbox  (${input_element})[${index}]

Select Checkbox By Options
    [Arguments]  ${locator}  ${input}  @{options}
    Wait Until Keyword Succeeds  2x  100ms  Wait Until Element Is Visible  ${locator}
    Run keyword If  "${input}" in @{options}
    ...    Select Checkbox             ${locator}
    ...  ELSE
    ...    Unselect Checkbox           ${locator}


Move Mouse To Coordinates
    [Arguments]  ${x_coordinate}  ${y_coordinate}
    ${result} =  Execute Python    import pyautogui; pyautogui.moveTo(${x_coordinate}, ${y_coordinate})
    Log  Mouse moved to (${x_coordinate}, ${y_coordinate})

Click At Coordinates
    [Arguments]  ${x_coordinate}  ${y_coordinate}
    ${result} =  Execute Python    import pyautogui; pyautogui.click(${x_coordinate}, ${y_coordinate})
    Log  Mouse clicked at (${x_coordinate}, ${y_coordinate})
