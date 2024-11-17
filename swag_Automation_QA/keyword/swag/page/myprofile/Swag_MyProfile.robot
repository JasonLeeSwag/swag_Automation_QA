# swag_Automation_QA\keyword\swag\page\myprofile\Swag_MyProfile.robot
*** Variables ***
&{Swag_MyProfile}                  page_name=我的會員頁
...                                diamond_shop_button=//*[@data-element_id="button-diamond-shop"][contains(., "購買鑽石")]
...                                get_reward_button=//*[@data-element_id="button-get-reward"][contains(., "領取免費鑽石")]
...                                exchange_button=//*[@data-element_id="button-exchange"][contains(., "序號兌換")]
...                                journal_button=//*[@data-element_id="button-journal"][contains(., "日誌")]
...                                archived_button=//*[@data-element_id="button-hamburger-archived"][contains(., "解鎖項目")]
...                                settings_button=//*[@data-element_id="button-settings"][contains(., "設定")]
...                                swag_opening_button=//*[@data-element_id="button-swag-opening"][contains(., "工作機會")]
...                                become_a_model_button=//*[@data-element_id="button-become-a-model"][contains(., "我要成為創作者")]
...                                language_button=//*[@data-element_id="button-language"][contains(., "語言")]




*** Keywords ***
檢查當前頁面為我的會員頁
    智慧關閉PWA彈窗
    Wait Until Element Is Visible        ${Swag_MyProfile.diamond_shop_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.get_reward_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.exchange_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.journal_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.archived_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.settings_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.swag_opening_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.become_a_model_button}
    Wait Until Element Is Visible        ${Swag_MyProfile.language_button}

點擊設定按鈕
    智慧關閉PWA彈窗
    Wait And Click Element               ${Swag_MyProfile.settings_button}


    