swag_Automation_QA\TestCase\register\Register.robot
*** Settings ***
Resource        ${EXECDIR}/keyword/swag/Swag.sources.robot
Suite Setup     開啟Chrome瀏覽器
Test Setup      Run Keywords  前往SWAG歡迎頁
...                      AND  檢查當前頁面為SWAG歡迎頁
Suite Teardown  關閉所有瀏覽器
Force Tags      bvt  register
*** Test Cases ***
[ST-01-001] Sign Up - mail註冊頁
    [Tags]  ST-01-001
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.確認Email輸入欄已顯示
    Swag_Register.確認生日欄已顯示
    Swag_Register.確認推薦碼欄已顯示
    Swag_Register.確認最新消息選項已顯示
    Swag_Register.確認信箱註冊提交按鈕已顯示
    Swag_Register.確認手機簡訊註冊按鈕已顯示
    Swag_Register.確認google註冊按鈕已顯示

[ST-01-002] Sign Up - 輸入正確信箱
    [Tags]  ST-01-002
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.輸入信箱  ${SWAG.MAIL_USER_前綴.MAIL}
    Swag_Register.輸入生日  28/01/1996
    Swag_Register.點擊免費註冊提交按鈕
    Swag_Register.確認輸入mail驗證碼視窗已顯示

[ST-01-003] Sign Up - 輸入錯誤信箱
    [Tags]  ST-01-003
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.輸入信箱  ${SWAG.WRONG_MAIL_USER.MAIL}
    Swag_Register.確認Mail錯誤提示已顯示

[ST-01-004] Birthday - 輸入錯誤生日(未滿18歲)
    [Tags]  ST-01-004
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.輸入信箱  ${SWAG.MAIL_USER_前綴.MAIL}
    Swag_Register.輸入生日  28/01/2024
    Swag_Register.點擊免費註冊提交按鈕
    Swag_Register.確認未滿18歲警示已顯示

[ST-01-005] Referral code - 錯誤推薦碼
    [Tags]  ST-01-005
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.輸入信箱  ${SWAG.MAIL_USER_前綴.MAIL}
    Swag_Register.輸入生日  28/01/1996
    Swag_Register.輸入推薦碼  ${SWAG.VERIFICATION_CODE}
    Swag_Register.點擊免費註冊提交按鈕
    Swag_Register.確認邀請碼已失效已顯示


[ST-01-006] Phone Sign Up - 手機註冊頁
    [Tags]  ST-01-006
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊手機簡訊註冊按鈕
    Swag_Register.確認手機輸入欄已顯示
    Swag_Register.確認生日欄已顯示
    Swag_Register.確認推薦碼欄已顯示
    Swag_Register.確認手機註冊提交按鈕已顯示
    Swag_Register.確認電子郵件註冊按鈕已顯示
    Swag_Register.確認google註冊按鈕已顯示

[ST-01-007] Phone Sign Up - 輸入手機電話
    [Tags]  ST-01-007
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊手機簡訊註冊按鈕
    Swag_Register.輸入手機電話  ${SWAG.PHONE_USER.PHONE}
    Swag_Register.輸入生日  28/01/1990
    Swag_Register.點擊手機註冊提交按鈕已顯示
    Swag_Register.確認輸入手機簡訊驗證碼視窗已顯示

[ST-01-008] Phone Number - 輸入錯誤手機電話
    [Tags]  ST-01-008
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊手機簡訊註冊按鈕
    Swag_Register.輸入手機電話  ${SWAG.WRONG_PHONE_USER.PHONE_NUM}
    Swag_Register.確認手機電話錯誤提示已顯示

[ST-01-009] Birthday - 手機註冊輸入錯誤生日(未滿18歲)
    [Tags]  ST-01-009
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊手機簡訊註冊按鈕
    Swag_Register.輸入手機電話  ${SWAG.PHONE_USER.PHONE}
    Swag_Register.輸入生日  28/01/2023
    Swag_Register.點擊手機註冊提交按鈕已顯示
    Swag_Register.確認未滿18歲警示已顯示

[ST-01-010] Wrong referral code - 錯誤推薦碼
    [Tags]  ST-01-010
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊手機簡訊註冊按鈕
    Swag_Register.輸入手機電話  ${SWAG.PHONE_USER.PHONE}
    Swag_Register.輸入生日  28/01/1990
    Swag_Register.輸入推薦碼  ${SWAG.VERIFICATION_CODE}
    Swag_Register.點擊手機註冊提交按鈕已顯示
    Swag_Register.確認邀請碼已失效已顯示

[ST-01-011] Sign Up - 主播註冊
    [Tags]  ST-01-011
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Register.檢查當前頁面為註冊頁
    Swag_Register.點擊想註冊成為主播
    Swag_Register.確認SWAG主播註冊頁面已顯示

*** Keywords ***
取得測試信箱帳號
    [Arguments]  ${mail}=${SWAG.MAIL_USER_前綴.MAIL}
    ${tag} =         取得符合正規式之Tag名稱
    ${random_str} =  Get Random Number With Alphabet
    Set Test Variable    ${TEST_MAIL}  ${tag}_${random_str}_${mail}
    RETURN  ${TEST_MAIL}

取得測試手機號
    ${random_str} =  Get Random Number  14
    Set Test Variable    ${TEST_PHONE}  ${random_str}
    RETURN  ${TEST_PHONE}