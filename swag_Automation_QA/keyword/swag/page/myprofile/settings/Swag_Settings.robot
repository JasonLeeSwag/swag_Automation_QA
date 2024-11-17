# swag_Automation_QA\keyword\swag\page\myprofile\settings\Swag_Settings.robot
*** Variables ***
&{Swag_Settings}                   page_name=SWAG設定頁
#導航按鈕
...                                back_btn=//*[@data-element_id="button-back"]
...                                refresh_btn=//button[@class="Settings__HeaderButton-sc-tq7np5-2 Settings__RefreshButton-sc-tq7np5-4 cOsgHp cVGMqQ"][@title="Refresh"]

#設定按鈕
...                                vip_level_edit_btn=//*[@data-element_id="vip-level-edit"][contains(., "帳號等級")]
...                                push_notifications_btn=//*[@data-element_id="button-push-notifications"][contains(., "通知設定")]
...                                manage_profile_btn=//*[@data-element_id="button-manage-profile"][contains(., "管理個人資料")]
...                                diamond_shop_btn=//*[@data-element_id="button-diamond-shop"][contains(., "購買鑽石")]
...                                exchange_btn=//*[@data-element_id="button-exchange"][contains(., "序號兌換")]
...                                get_reward_btn=//*[@data-element_id="button-get-reward"][contains(., "領取免費鑽石")]

#關於
...                                become_a_model_btn=//*[@data-element_id="button-become-a-model"][contains(., "我要成為創作者")]
...                                swag_opening_btn=//*[@data-element_id="button-swag-opening"][contains(., "工作機會")]
...                                swag_blog_btn=//*[@data-element_id="button-swag-blog"][contains(., "SWAG 部落格")]

#登出
...                                logout_btn=//*[@data-element_id="button-setting-logout"][contains(., "登出")]

#底部導航連結
...                                tos_btn=//*[@data-element_id="button-tos"][contains(., "服務條款")]
...                                privacy_policy_btn=//*[@data-element_id="button-privacy-policy"][contains(., "隱私權政策")]
...                                about_swag_btn=//*[@data-element_id="button-about-swag"][contains(., "關於 SWAG")]
...                                faq_btn=//*[@data-element_id="button-faq"][contains(., "常見問答")]
...                                contact_support_btn=//*[@data-element_id="button-contact-support"][contains(., "聯繫客服")]
...                                career_btn=//*[@data-element_id="button-career"][contains(., "工作機會")]
...                                swag_affiliate_program_btn=//*[@data-element_id="button-swag-affiliate-program"][contains(., "聯盟夥伴計畫")]
...                                mail_to_marketing_btn=//*[@data-element_id="button-mail-to-marketing"][contains(., "業務合作洽談")]
...                                become_creator_btn=//*[@data-element_id="button-become-creator"][contains(., "我要成為創作者")]
...                                swag_blog_btn=//*[@data-element_id="button-swag-blog"][contains(., "SWAG 部落格")]
...                                swag_select_btn=//*[@data-element_id="button-swag-select"][contains(., "SWAG 周邊商品")]
...                                language_btn=//*[@data-element_id="button-language"]

#登出確認彈窗
...                                logout_Alert=//*[@data-element_id="button-logout"][contains(., "登出")]
...                                cancel_Alert=//*[@data-element_id="button-cancel"][contains(., "取消")]
...                                close_btn=//button[contains(@class, "PwaSafariToast__CloseButton-sc-1npydf8-10")][img[contains(@src, "data:image/svg+xml")]]


*** Keywords ***
檢查當前頁面為我的設定頁
    檢查並點擊關閉按鈕
    Wait Until Element Is Visible        ${Swag_Settings.back_btn}
    Wait Until Element Is Visible        ${Swag_Settings.refresh_btn}
    Wait Until Element Is Visible        ${Swag_Settings.vip_level_edit_btn}
    Wait Until Element Is Visible        ${Swag_Settings.push_notifications_btn}
    Wait Until Element Is Visible        ${Swag_Settings.manage_profile_btn}
    Wait Until Element Is Visible        ${Swag_Settings.diamond_shop_btn}
    Wait Until Element Is Visible        ${Swag_Settings.exchange_btn}
    Wait Until Element Is Visible        ${Swag_Settings.get_reward_btn}
    Wait Until Element Is Visible        ${Swag_Settings.become_a_model_btn}
    Wait Until Element Is Visible        ${Swag_Settings.swag_opening_btn}
    Wait Until Element Is Visible        ${Swag_Settings.swag_blog_btn}
    Wait Until Element Is Visible        ${Swag_Settings.logout_btn}
    Wait Until Element Is Visible        ${Swag_Settings.tos_btn}
    Wait Until Element Is Visible        ${Swag_Settings.privacy_policy_btn}
    Wait Until Element Is Visible        ${Swag_Settings.about_swag_btn}
    Wait Until Element Is Visible        ${Swag_Settings.faq_btn}
    Wait Until Element Is Visible        ${Swag_Settings.contact_support_btn}
    Wait Until Element Is Visible        ${Swag_Settings.career_btn}
    Wait Until Element Is Visible        ${Swag_Settings.swag_affiliate_program_btn}
    Wait Until Element Is Visible        ${Swag_Settings.mail_to_marketing_btn}
    Wait Until Element Is Visible        ${Swag_Settings.become_creator_btn}
    Wait Until Element Is Visible        ${Swag_Settings.swag_blog_btn}
    Wait Until Element Is Visible        ${Swag_Settings.swag_select_btn}
    Wait Until Element Is Visible        ${Swag_Settings.language_btn}

點擊登出按鈕
    檢查並點擊關閉按鈕
    Wait And Click Element               ${Swag_Settings.logout_btn}

確認登出視窗已顯示
    Wait Until Element Is Visible        ${Swag_Settings.logout_Alert}
    Wait Until Element Is Visible        ${Swag_Settings.cancel_Alert}

點擊確認登出
    Wait And Click Element               ${Swag_Settings.logout_Alert}

確認登出視窗已關閉
    Wait Until Element Is Not Visible    ${Swag_Settings.logout_Alert}
    Wait Until Element Is Not Visible    ${Swag_Settings.cancel_Alert}

點擊返回按鈕
    檢查並點擊關閉按鈕
    Wait And Click Element               ${Swag_Settings.back_btn}
