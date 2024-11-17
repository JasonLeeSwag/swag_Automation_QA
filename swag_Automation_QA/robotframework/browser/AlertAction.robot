*** Keywords ***
Dismiss Alert If Exist
    ${result} =                Run Keyword And Return Status  AlertAction.記錄Alert訊息
    Run Keyword If  ${result}  Run Keyword And Ignore Error   Handle Alert  action=DISMISS  timeout=1

Accept Alert If Exist
    ${result} =                Run Keyword And Return Status  AlertAction.記錄Alert訊息
    Run Keyword If  ${result}  Run Keyword And Ignore Error   Handle Alert  action=ACCEPT   timeout=1

Retry Handle Alert To Fail
    :FOR  ${i}  IN RANGE  1  999
    \  ${Alert_Status}  ${Message} =  Run Keyword And Ignore Error  Handle Alert  action=LEAVE  timeout=1 sec
    \  Exit For Loop If  "${Alert_Status}"=="FAIL"
    \  Sleep  100ms

記錄Alert訊息
    ${message} =               Handle Alert  action=LEAVE  timeout=1
    ${testCaseId} =            TestUtils.取得符合正規式之Tag名稱
    Run Keyword If  '${message}'
    ...  Run Keywords          Log To Console  \n${testCaseId} alert message : ${message}
    ...           AND          Log             ${testCaseId} alert message : ${message}
