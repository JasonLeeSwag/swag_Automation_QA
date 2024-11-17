*** Keywords ***
開啟瀏覽器新分頁
    [Arguments]  ${url}
    Execute Javascript    window.open('${url}')

選擇瀏覽器新分頁
    [Arguments]  ${times}=2  ${delay_time}=1
    Wait Until Keyword Succeeds  ${times}x  ${delay_time}  Switch Window  NEW

關閉瀏覽器其餘分頁
    @{windows} =    Get Window Handles
    ${length} =     Get Length     ${windows}
    FOR  ${index}  IN RANGE  1  ${length}
        Switch Window  ${windows}[ ${index} ]
        Close Window
    END
    Switch Window   MAIN

關閉當前瀏覽器分頁
    Close Window
    Switch Window   MAIN

Select Pop Up Window
    [Arguments]  ${order}=1
    @{titles} =     Get Window Handles
    ${latest} =     Get Length  ${titles}
    ${latest} =     Evaluate  ${latest}-1
    Run Keyword If  '${order}'=='latest'  Switch Window  ${titles[${latest}]}  ELSE  Switch Window  ${titles[${order}]}

Close Window And Select Main Window
    # 只關一個
    @{titles} =     Get Window Handles
    ${latest} =     Get Length  ${titles}
    ${latest} =     Evaluate  ${latest} - 1
    Run Keyword If  '${latest}' > '0'  WindowAction.關閉當前瀏覽器分頁

Log Window Size
    ${width}  ${height} =  Get Window Size
    Log             window size : ${width} x ${height}
    Log To Console  window size : ${width} x ${height}