# swag_Automation_QA\keyword\swag\domain\Swag_LoginService.robot
*** Keywords ***
登入Swag By Mail
    [Arguments]  ${mail}=${SWAG.MAIL_USER.MAIL}  ${password}=${SWAG.MAIL_USER.PASSWORD}
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入  ${mail}  ${password}
    FOR  ${index}  IN RANGE  1  10
        ${login_status} =  檢查登入狀態  ${SWAG_BASE_URL}
        Run Keyword If  ${login_status} == ${False}
        ...         Run Keywords  Swag_Home.前往SWAG歡迎頁
        ...                  AND  Swag_Home.點擊免費註冊或登入案紐
        ...                  AND  Swag_Login.點擊登入按鈕
        ...                  AND  Swag_Login.檢查當前頁面為會員登入頁
        ...                  AND  Swag_Login.輸入信箱及密碼並登入  ${mail}  ${password}
        Exit For Loop If  ${login_status} == ${True}
    END
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.檢查當前頁面為SWAG首頁

登入Swag By Phone
    [Arguments]  ${area_code}=${COUNTRY.AMERICA.AREA_CODE}  ${phone_num}=${SWAG.PHONE_USER.PHONE}  ${password}=${SWAG.PHONE_USER.PASSWORD}
    Swag_Home.前往會員登入頁
    Swag_Home.檢查當前頁面為會員登入頁
    Swag_Home.檢查當前為"邮箱登录"頁籤
    Swag_Login.點擊"手机号登錄"按鈕
    Swag_Login.檢查當前為"手机号登錄"頁籤
    Swag_Login.輸入手機及密碼並登入  ${area_code}  ${phone_num}  ${password}
    FOR  ${index}  IN RANGE  1  10
        ${login_status} =  檢查登入狀態  ${SWAG_BASE_URL}
        Run Keyword If  ${login_status} == ${False}
        ...         Run Keywords  Swag_Login.前往會員登入頁
        ...                  AND  Swag_Login.檢查當前頁面為會員登入頁
        ...                  AND  Swag_Login.檢查當前為"手机号登錄"頁籤
        ...                  AND  Swag_Login.輸入手機及密碼並登入  ${area_code}  ${phone_num}  ${password}
        Exit For Loop If  ${login_status} == ${True}
    END
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.檢查當前頁面為SWAG首頁

登出Swag
    [Documentation]    優化的登出流程，減少等待時間但保持檢查驗證
    # 確保在首頁
    TRY
        Swag_Home.前往SWAG歡迎頁
        Swag_Home.檢查當前頁面為SWAG首頁
    EXCEPT
        Log    無法進入首頁    console=yes
        Return From Keyword
    END

    # 進入個人資訊頁
    TRY
        Swag_Home.點擊我的資訊頁
        Swag_MyProfile.檢查當前頁面為我的會員頁
    EXCEPT
        Log    無法進入個人資訊頁    console=yes
        Return From Keyword
    END

    # 進入設定頁
    TRY
        Swag_MyProfile.點擊設定按鈕
        Swag_Settings.檢查當前頁面為我的設定頁
    EXCEPT
        Log    無法進入設定頁    console=yes
        Return From Keyword
    END

    # 執行登出流程
    TRY
        Swag_Settings.點擊登出按鈕
        Swag_Settings.確認登出視窗已顯示
        Swag_Settings.點擊確認登出
        Swag_Settings.確認登出視窗已關閉
        Swag_Settings.點擊返回按鈕
        Swag_Home.檢查當前頁面為SWAG歡迎頁
        Log    登出流程完成    console=yes
    EXCEPT    AS    ${error}
        Log    登出流程失敗: ${error}    console=yes
        Capture Page Screenshot
    END

    # 驗證登出狀態
    TRY
        ${login_status}=    檢查登入狀態    ${SWAG_BASE_URL}
        Should Be Equal    ${login_status}    ${FALSE}    msg=登出失敗，使用者仍然處於登入狀態
        Log    登出狀態驗證成功    console=yes
    EXCEPT
        Log    登出狀態驗證失敗    console=yes
        Capture Page Screenshot
    END

    [Teardown]    Run Keyword And Ignore Error    Swag_Home.檢查並點擊關閉按鈕
