# swag_Automation_QA/robotframework/browser/BrowserAction.robot
*** Keywords ***
Clear And Input Text
    [Documentation]  清除途徑上文字並輸入文字
    [Arguments]  ${locator}  ${input_text}
    Wait Until Keyword Succeeds    2x  100ms   Wait Until Element Is Visible  ${locator}
    Clear Element Text             ${locator}
    Input Text                     ${locator}  ${input_text}

Clear And Input Password
    [Documentation]  清除途徑上文字並輸入密碼
    [Arguments]  ${text_id}  ${input_text}
    Wait Until Element Is Visible  ${text_id}
    Clear Element Text  ${text_id}
    Run Keyword If  "${input_text}" != ""
    ...  Input Password  ${text_id}  ${input_text}

Press Backspace Key
    [Arguments]  ${text_id}  ${count}=1
    Repeat Keyword  ${count}  Press Key  ${text_id}  \\08

Press Del Key
    [Arguments]  ${text_id}  ${count}=1
    Repeat Keyword  ${count}  Press Key  ${text_id}  \\127

Press Enter Key
    [Arguments]  ${text_id}  ${count}=1
    Repeat Keyword  ${count}  Press Key  ${text_id}  \\13
