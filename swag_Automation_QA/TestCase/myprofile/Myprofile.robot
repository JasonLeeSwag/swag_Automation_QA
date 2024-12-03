*** Settings ***
Resource        ${EXECDIR}/keyword/swag/Swag.sources.robot
Library         Process
Library         OperatingSystem
Suite Setup     開啟Chrome瀏覽器
Test Setup      Run Keywords  前往SWAG歡迎頁
...                      AND  檢查當前頁面為SWAG歡迎頁
Test Teardown   Run Keywords
...            Run Keyword If Test Failed    Capture Page Screenshot
...    AND     Run Keyword And Ignore Error    登出Swag
...    AND     Run Keyword And Ignore Error    Swag_Home.檢查並點擊關閉按鈕
Suite Teardown  關閉所有瀏覽器
Force Tags      bvt  myprofile
*** Test Cases ***
[ST-04-001] myprofile Check - ui
    [Tags]  ST-04-001
    #查看我的頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入    ${SWAG.MAIL_USER_測試.MAIL}  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Home.檢查當前頁面為SWAG首頁
    Swag_Home.點擊我的資訊頁
    Swag_MyProfile.檢查當前頁面為我的會員頁