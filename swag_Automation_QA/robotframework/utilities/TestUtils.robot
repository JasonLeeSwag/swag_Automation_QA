*** Keywords ***
取得符合正規式之Tag名稱
    [Documentation]  正規表示預設匹配為ST開頭數字結尾,預設為第一筆
    [Arguments]  ${regExp}=^ST-+\\d{2}-+\\d{3}
    @{emptyList} =  Create List
    @{testTags} =   Get Variable Value  @{TEST TAGS}  @{emptyList}
    FOR  ${tag}  IN  @{testTags}
      ${match} =   Get Regexp Matches  ${tag}  ${regExp}
      Return From Keyword If  ${match} != []  ${tag}
    END
    RETURN  ${EMPTY}

取得Suite檔案名稱
    ${suiteName} =  Replace String  ${SUITE NAME}  ${SPACE}  _
    Log  ${suiteName}
    @{dirNames} =   Split String    ${suiteName}  .
    Log  ${dirNames}
    RETURN  @{dirNames}[ -1 ]

判斷前次測試是否失敗
    ${failed} =  Set Variable If  "${PREV TEST STATUS}" == "FAIL"  ${True}  ${False}
    RETURN  ${failed}

判斷前次測試是否通過
    ${passed} =  Set Variable If  "${PREV TEST STATUS}" == "PASS"  ${True}  ${False}
    RETURN  ${passed}

##### Teardown #####
TestCase Teardown
    [Documentation]     可用以下參數控制 pass 時是否要關閉其餘分頁或瀏覽器
    ...                 fail_log_performance 是在 fail 時會去紀錄 network log
    ...                 fail 必定會關閉瀏覽器
    [Arguments]  ${close_browser}=${false}  ${fail_log_performance}=${false}  ${close_all_pop_window}=${false}
    Run Keyword If Test Passed  TestUtils.TestCase Passed  close_browser=${close_browser}  close_all_pop_window=${close_all_pop_window}
    Run Keyword If Test Failed  TestUtils.TestCase Failed  fail_log_performance=${fail_log_performance}

TestCase Passed
    [Arguments]  ${close_browser}=${false}  ${close_all_pop_window}=${false}
    Run Keyword If  ${close_browser}            Close All Browsers
    Run Keyword If  ${close_all_pop_window}     WindowAction.關閉瀏覽器其餘分頁

TestCase Failed
    [Arguments]  ${fail_log_performance}=${false}
    FOR  ${i}  IN RANGE  1  2
      Run Keyword If Timeout Occurred  Close All Browsers
      Run Keyword If Timeout Occurred  Exit For Loop
      TestUtils.Teardown Handle Alert
      Log Location
      ${cookies}=  Get Cookies
      Log  ${cookies}
      Log Source
      Run Keyword If  ${fail_log_performance}  NetworkLog.Performance Log
      Close All Browsers
    END

Teardown Handle Alert
    ${Alert_Status}    ${Message}=  Run Keyword And Ignore Error  Handle Alert  action=LEAVE  timeout=1 sec
    Run Keyword If  "${Alert_Status}"=="PASS"  Retry Handle Alert To Fail