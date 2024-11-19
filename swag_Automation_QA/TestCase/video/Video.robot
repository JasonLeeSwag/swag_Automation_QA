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
Force Tags      bvt  video
*** Test Cases ***
[ST-03-001] video Check - ui
    [Tags]  ST-03-001
    #查看影片頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入    ${SWAG.MAIL_USER_測試.MAIL}  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Home.檢查當前頁面為SWAG首頁
    Swag_Home.點擊影片頁
    Swag_Video.確認當前頁面為影片頁

[ST-03-002] watch video - Diamond quantity
    [Tags]  ST-03-002
    #查看當前鑽石數量
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入    ${SWAG.MAIL_USER_測試.MAIL}  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Home.檢查當前頁面為SWAG首頁
    Swag_Home.點擊我的資訊頁
    Swag_Video.查看並記錄當前會員錢包裡的鑽石數量

[ST-03-003] watch video - Video price
    [Tags]  ST-03-003
    #查看影片需要的解鎖鑽石數量
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入    ${SWAG.MAIL_USER_測試.MAIL}  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Home.檢查當前頁面為SWAG首頁
    Swag_Home.點擊影片頁
    Swag_Video.確認當前頁面為影片頁
    Swag_Video.前往官方嚴選頁面
    Swag_Video.確認當前頁面為官方嚴選頁面
    # 要放未解鎖的影片連結
    ${new_video_url}=    Set Variable    https://swag.live/post/62fb7825b8f950a758e399da?lang=zh-TW
    Swag_Video.前往影片觀看頁    ${new_video_url}
    Swag_Video.確認當前頁面為影片觀看頁
    Swag_Video.記錄當前影片解鎖所需要的鑽石數量

[ST-03-004] watch video - Video Unlock（Bonus）
    [Tags]  ST-03-004
    #影片解鎖-進階要求（Bonus）
    Swag_Home.前往SWAG歡迎頁
    Swag_Home.點擊免費註冊或登入案紐
    Swag_Login.點擊登入按鈕
    Swag_Login.檢查當前頁面為會員登入頁
    Swag_Login.輸入信箱及密碼並登入    ${SWAG.MAIL_USER_測試.MAIL}  ${SWAG.MAIL_USER_測試.PASSWORD}
    Swag_Home.檢查當前頁面為SWAG首頁
    Swag_Home.點擊我的資訊頁
    Swag_Video.查看並記錄當前會員錢包裡的鑽石數量
    # 要放未解鎖的影片連結
    ${new_video_url}=    Set Variable    https://swag.live/post/62fb7825b8f950a758e399da?lang=zh-TW
    Swag_Video.前往影片觀看頁    ${new_video_url}
    Swag_Video.確認當前頁面為影片觀看頁
    Swag_Video.記錄當前影片解鎖所需要的鑽石數量
    Swag_Video.查看我錢包裡的鑽石數量及查看要解鎖影片的鑽石價格
    Swag_Video.點擊影片解鎖按鈕
    Swag_Video.確認影片已解鎖
    Swag_Video.驗證解鎖後錢包剩餘的鑽石數量