# swag_Automation_QA\TestCase\login\Login.robot
*** Settings ***
Resource        ${EXECDIR}/keyword/swag/Swag.sources.robot
Library         Process
Library         OperatingSystem
Suite Setup     開啟Chrome瀏覽器
Test Setup      Run Keywords  前往SWAG歡迎頁
...                      AND  檢查當前頁面為SWAG歡迎頁
# Test Teardown   Run Keywords
# ...            Run Keyword If Test Failed    Capture Page Screenshot
# ...    AND     Run Keyword And Ignore Error    登出Swag
# ...    AND     Run Keyword And Ignore Error    Swag_Home.檢查並點擊關閉按鈕
Suite Teardown  關閉所有瀏覽器
Force Tags      bvt  login
*** Test Cases ***
[ST-02-001] Login Check - normally
    [Tags]  ST-02-001
    #輸入正確的mail跟密碼
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱  ${SWAG.MAIL_USER_測試.MAIL}
    Swag_Login.輸入密碼  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Login.點擊登入提交按鈕
    Swag_Home.檢查當前頁面為SWAG首頁
    登出Swag

# [ST-02-002] Login Check - errMail
#     [Tags]  ST-02-002
#     # 輸入錯誤的mail或是嘗試太多次
#     Swag_Home.點擊免費註冊或登入案紐
#     Swag_Login.點擊登入按鈕
#     Swag_Login.檢查當前頁面為會員登入頁
#     Swag_Login.輸入信箱  !9#$s%+,.-=
#     Swag_Login.輸入密碼  ${SWAG.MAIL_USER_測試.PASSWORD}
#     Swag_Login.點擊登入提交按鈕
#     Swag_Login.確認Mail或密碼錯誤或嘗試次數過多提示已顯示

[ST-02-003] Login Check - View password
    [Tags]  ST-02-003
    #查看密碼功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱  ${SWAG.MAIL_USER_測試.MAIL}
    Swag_Login.輸入密碼  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Login.點擊查看密碼
    Swag_Login.確認密碼已顯示

# [ST-02-004] Login Check - errPassword
#     [Tags]  ST-02-004
#     # 輸入錯誤的密碼
#     Swag_Home.點擊免費註冊或登入案紐
#     Swag_Login.點擊登入按鈕
#     Swag_Login.檢查當前頁面為會員登入頁
#     Swag_Login.輸入信箱  ${SWAG.MAIL_USER_測試.MAIL}
#     Swag_Login.輸入密碼  !@#$%^&f43
#     Swag_Login.點擊登入提交按鈕
#     Swag_Login.確認Mail或密碼錯誤或嘗試次數過多提示已顯示

[ST-02-005] Login Check - forget the password
    [Tags]  ST-02-005
    #忘記密碼功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱  ${SWAG.MAIL_USER_測試.MAIL}
    Swag_Login.點擊忘記密碼按鈕
    Swag_Login.確認電子郵件忘記密碼視窗已顯示
    Swag_Login.點擊切換成手機號碼
    Swag_Login.確認手機號碼忘記密碼視窗已顯示

[ST-02-006] Login Check - Sign in with Google
    [Tags]  ST-02-006
    #使用google登入功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.點擊Google登入按鈕
    Swag_Login.確認Google登入頁面已顯示

[ST-02-007] Login Check - Sign in with Apple
    [Tags]  ST-02-007
    #使用Apple登入功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.點擊Apple登入按鈕
    Swag_Login.確認Apple登入頁面已顯示

[ST-02-008] Login Check - Sign in with mail
    [Tags]  ST-02-008
    #使用mail登入功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.點擊電子郵件登入按鈕
    Swag_Login.確認電子郵件登入頁面已顯示

[ST-02-009] Login Check - Sign in with phone
    [Tags]  ST-02-009
    #使用phone登入功能
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.點擊手機簡訊登入按鈕
    Swag_Login.確認手機簡訊登入頁面已顯示

[ST-02-010] Login Check - Sign in with fast
    [Tags]  ST-02-010
    [Documentation]    使用快速登入功能，但選擇取消生物識別
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.點擊快速登入按鈕
    Swag_Login.處理Windows安全性視窗
