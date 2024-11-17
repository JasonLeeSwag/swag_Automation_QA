# swag_Automation_QA\keyword\swag\component\Swag_Footer.robot*** Variables ***
*** Variables ***
&{Swag_Footer}                    component_name=footer

&{PWA_Toast}
...    component_name=PWA安裝提示彈窗
...    main_div=//div[contains(@class, "PwaSafariToast__StyledPwaSafariToast-sc-1npydf8-0")]
...    title=//div[contains(@class, "PwaSafariToast__Title")][text()="免下載安裝 SWAG"]
...    close_btn=//button[contains(@class, "PwaSafariToast__CloseButton-sc-1npydf8-10")]

*** Keywords ***
智慧關閉PWA彈窗
    [Documentation]    快速檢查並關閉PWA安裝提示彈窗，沒有找到則忽略
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${PWA_Toast.main_div}    timeout=0.3s

    Run Keyword If    ${status}    Run Keywords
    ...    Click Element    ${PWA_Toast.close_btn}    AND
    ...    Wait Until Element Is Not Visible    ${PWA_Toast.main_div}    timeout=0.3s