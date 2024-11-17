# swag_Automation_QA\keyword\swag\page\Swag_Home.robot
*** Variables ***
&{Swag_Home}                       page_name=SWAG歡迎頁
...                                url=register
...                                header_box=//*[@class="LandingContent__Header-sc-eiz103-5 cySmxZ"]
...                                register_btn=//*[@data-element_id="button-signup"][contains(.,"免費註冊/登入")]
...                                free_watch_btn=//button[@data-element_id="landing-page-cta"][contains(.,"立即免費觀看")]
...                                guide_below_btn=//div[contains(@class, 'LandingContent__DropDownWrapper')]//a[@href='#section-area' and img[contains(@src, 'data:image/svg+xml')]]
...                                maintitle_txt=//h1[@class="LandingContent__MainTitle-sc-eiz103-11 esgSWz"][contains(.,"亞洲最大成人品牌")]

...                                search_btn=//*[@data-element_id="tab-button-search"]
...                                leaderboard_btn=//*[@data-element_id="tab-button-leaderboard"]
...                                create_btn=//*[@data-element_id="tab-button-create"]
...                                notification_btn=//*[@data-element_id="button-notification-center"]
...                                diamond_shop_btn=//*[@data-element_id="button-diamond-shop"]

...                                explore_tab=//*[@data-element_id="tab-explore"][contains(., "探索")]
...                                following_tab=//*[@data-element_id="tab-following"][contains(., "追蹤中")]
...                                category_tab=//*[@data-element_id="tab-category"][contains(., "分類")]
...                                search_bar=//input[@type="text" and @placeholder="搜尋"]

...                                user_event_button=//*[@data-element_id="button-user-event"]
...                                backpack_button=//*[@data-element_id="button-backpack"]

...                                home_page_btn=//*[@data-element_id="tab-button-home"][contains(., "主頁")]
...                                video_btn=//*[@data-element_id="tab-button-discover"][contains(., "影片")]
...                                shorts_btn=//*[@data-element_id="tab-button-shorts"][contains(., "短影音")]
...                                chat_btn=//*[@data-element_id="tab-button-chat"][contains(., "聊天")]
...                                my_profile_btn=//*[@data-element_id="tab-button-hamburger"][contains(., "我的")]

...                                close_btn=//button[contains(@class, "PwaSafariToast__CloseButton-sc-1npydf8-10")][img[contains(@src, "data:image/svg+xml")]]


*** Keywords ***
檢查並點擊關閉按鈕
    # 加入更多的錯誤處理
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${Swag_Settings.close_btn}    timeout=3s
    Run Keyword If    ${status}
    ...    Run Keyword And Ignore Error    點擊關閉按鈕

點擊關閉按鈕
    # 加入等待和錯誤處理
    Wait Until Element Is Visible    ${Swag_Settings.close_btn}    timeout=5s
    ${status}=    Run Keyword And Return Status    Click Element    ${Swag_Settings.close_btn}
    Run Keyword If    '${status}' == 'FAIL'    Log    關閉按鈕點擊失敗，可能已經自動關閉    WARN

前往SWAG歡迎頁
    Go To                          ${SWAG_BASE_URL}

檢查當前頁面為SWAG歡迎頁
    智慧關閉PWA彈窗
    Wait Until Element Is Visible  ${Swag_Home.header_box}
    Wait Until Element Is Visible  ${Swag_Home.register_btn}
    Wait Until Element Is Visible  ${Swag_Home.maintitle_txt}
    Wait Until Element Is Visible  ${Swag_Home.free_watch_btn}
    Wait Until Element Is Visible  ${Swag_Home.guide_below_btn}

點擊免費註冊或登入案紐
    Wait And Click Element         ${Swag_Home.register_btn}


檢查當前頁面為SWAG首頁
    智慧關閉PWA彈窗
    Wait Until Element Is Visible  ${Swag_Home.home_page_btn}
    Wait Until Element Is Visible  ${Swag_Home.video_btn}
    Wait Until Element Is Visible  ${Swag_Home.shorts_btn}
    Wait Until Element Is Visible  ${Swag_Home.chat_btn}
    Wait Until Element Is Visible  ${Swag_Home.my_profile_btn}
    Wait Until Element Is Visible  ${Swag_Home.search_btn}
    Wait Until Element Is Visible  ${Swag_Home.leaderboard_btn}
    Wait Until Element Is Visible  ${Swag_Home.create_btn}
    Wait Until Element Is Visible  ${Swag_Home.notification_btn}
    Wait Until Element Is Visible  ${Swag_Home.diamond_shop_btn}
    Wait Until Element Is Visible  ${Swag_Home.explore_tab}
    Wait Until Element Is Visible  ${Swag_Home.following_tab}
    Wait Until Element Is Visible  ${Swag_Home.category_tab}
    Wait Until Element Is Visible  ${Swag_Home.search_bar}
    Wait Until Element Is Visible  ${Swag_Home.user_event_button}
    Wait Until Element Is Visible  ${Swag_Home.backpack_button}
    檢查並點擊關閉按鈕

點擊我的資訊頁
    智慧關閉PWA彈窗
    Wait And Click Element         ${Swag_Home.my_profile_btn}


點擊影片頁
    智慧關閉PWA彈窗
    Wait And Click Element         ${Swag_Home.video_btn}
