# swag_Automation_QA\keyword\swag\page\video\Swag_Video.robot
*** Variables ***
&{Swag_Video}                      page_name=影片頁
#頁面上方區塊
...                                url=https://swag.live/video?lang=zh-TW
...                                leaderboard_btn=//*[@data-element_id="tab-button-leaderboard"]
...                                create_btn=//*[@data-element_id="tab-button-create"]
...                                notification_btn=//*[@data-element_id="button-notification-center"]
...                                diamond_shop_btn=//*[@data-element_id="button-diamond-shop"]
...                                header_title=//div[@class="NavHeader__HeaderTitle-sc-5pjv6x-1 bEKLnZ"][contains(., "影片")]
...                                search_input=//input[@type="text" and @placeholder="搜尋"]
...                                diamond_count=//div[contains(@class, "HamburgerMenuUserDiamondValue-sc-d5q7nw-0")]/div/span

#官方嚴選影片
...                                official_video_url=https://swag.live/flix-categories/post_video_57a42a779f22bb6bcc434520?sorting=desc%3Aunlocked_2w&ui=flix&lang=zh-TW
...                                goback_btn=//button[contains(@class, "DiscoverFlixMore__GoBack-sc-1a70758c-5")]
...                                official_title=//h1[contains(@class, "DiscoverFlixMore__Title-sc-1a70758c-2") and contains(., "官方嚴選")]

# 影片觀看頁
...                                look_btn=//button[@data-element_id="button-unlock" and contains(., "觀看完整影片")]
...                                like_btn=//button[@data-element_id="button-like"]
...                                dislike_btn=//button[@data-element_id="button-dislike"]
...                                chat_btn=//button[@data-element_id="button-chat" and contains(., "聊天")]
...                                gift_btn=//button[@data-element_id="button-gift" and contains(., "送禮")]
...                                copyshare_btn=//button[@data-element_id="button-share" and contains(., "複製連結")]
...                                videoinfo_btn=//a[@data-element_id="button-info" and contains(., "影片資訊")]
...                                related_video_btn=//a[@data-element_id="button-related-video" and contains(., "推薦相關影片")]
...                                video_back_btn=//button[@data-element_id="button-back"]
...                                video_unlock_diamond=//button[@data-element_id="button-unlock"]
...                                video_aleart_close=//*[@class="PwaSafariToast__CloseButton-sc-40ccd049-10 dFIaAf"]

# 彈窗相關定位器
...                                pwa_alert_close=//button[contains(@class, "PwaSafariToast__CloseButton")]
...                                notification_dialog=//div[contains(@class, "NotificationAsker__AskerWrapper-sc-11443dfd-1")]
...                                notification_deny_btn=//button[contains(@class, "NotificationAsker__TextButton-sc-11443dfd-7") and @iscomponenthandled="1"]
...                                notification_allow_btn=//button[contains(@class, "NotificationAsker__FilledButton-sc-11443dfd-6") and @iscomponenthandled="1"]

# 新增 DRM 彈窗相關定位器
...                                drm_alert_dialog=//div[contains(@class, "DrmNotSupportAlert__StyledDrmNotSupportAlert")]
...                                drm_continue_btn=//button[@data-element_id="button-unlock" and contains(text(), "繼續進行")]
...                                video_unlock_diamond=//button[@data-element_id="button-unlock"]
...                                drm_alert_dialog=//div[contains(@class, "DrmNotSupportAlert__StyledDrmNotSupportAlert")]
...                                drm_confirm_btn=//button[@data-element_id="button-close" and contains(text(), "我知道了")]



*** Keywords ***
前往影片頁
    Go To                          ${Swag_Video.url}
    智慧關閉PWA彈窗

確認當前頁面為影片頁
    智慧關閉PWA彈窗
    Location Should Contain              ${Swag_Video.url}
    Wait Until Element Is Visible        ${Swag_Video.leaderboard_btn}
    Wait Until Element Is Visible        ${Swag_Video.create_btn}
    Wait Until Element Is Visible        ${Swag_Video.notification_btn}
    Wait Until Element Is Visible        ${Swag_Video.diamond_shop_btn}
    Wait Until Element Is Visible        ${Swag_Video.header_title}
    Wait Until Element Is Visible        ${Swag_Video.search_input}


查看並記錄當前會員錢包裡的鑽石數量
    [Documentation]    檢查並記錄會員錢包中的鑽石數量，包含重試機制和更完善的錯誤處理
    [Arguments]    ${max_retries}=3    ${retry_interval}=2s
    # 確保頁面已完全加載
    Wait Until Page Contains Element    ${Swag_Video.diamond_shop_btn}    timeout=20s
    Sleep    2s    # 給予額外時間讓動態內容加載
    FOR    ${retry}    IN RANGE    ${max_retries}
        ${status}    ${value}=    Run Keyword And Ignore Error    嘗試獲取鑽石數量
        # 如果成功獲取數量
        IF    '${status}' == 'PASS'
            Set Global Variable    ${CURRENT_DIAMOND_COUNT}    ${value}
            Log To Console    \n=== 鑽石數量檢查成功 ===
            Log To Console    現在的鑽石數量為: ${CURRENT_DIAMOND_COUNT}
            Log To Console    ====================\n
            RETURN
        END
        # 如果不是最後一次重試，則等待後重試
        IF    ${retry} < ${max_retries} - 1
            Log To Console    第 ${retry + 1} 次嘗試獲取鑽石數量失敗，等待後重試...
            Sleep    ${retry_interval}
            # 嘗試重新整理頁面
            Reload Page
            Sleep    2s
        END
    END
    # 如果所有重試都失敗，則失敗並提供詳細資訊
    Fail    無法獲取鑽石數量。已重試 ${max_retries} 次。請檢查：\n1. 頁面是否正確加載\n2. 使用者是否已登入\n3. 網路連線狀況\n4. 元素定位器是否正確

嘗試獲取鑽石數量
    [Documentation]    嘗試多種方式獲取鑽石數量
    # 檢查元素是否存在並可見
    Wait Until Element Is Visible    ${Swag_Video.diamond_count}    timeout=10s
    # 嘗試不同的定位策略獲取鑽石數量
    ${diamond_count}=    Get Text    ${Swag_Video.diamond_count}
    # 如果第一次嘗試失敗，使用備用定位器
    IF    '${diamond_count}' == '${EMPTY}'
        ${diamond_count}=    Get Text    //div[contains(@class, "HamburgerMenuUserDiamondValue")]//span
    END
    # 如果還是失敗，再試一次完整路徑
    IF    '${diamond_count}' == '${EMPTY}'
        ${diamond_count}=    Get Text    //div[contains(@class, "HamburgerMenuUserDiamondValue-sc-d5q7nw-0")]//div//span
    END
    # 驗證獲取的值
    Should Not Be Empty    ${diamond_count}    無法獲取鑽石數量，所有嘗試都失敗了
    # 移除可能的空白字元和特殊符號
    ${cleaned_count}=    Remove String    ${diamond_count}    ${SPACE}    \n    \t    ,
    # 驗證數值的有效性
    Should Match Regexp    ${cleaned_count}    ^\\d+$    獲取的鑽石數量 "${cleaned_count}" 不是有效的數字
    RETURN    ${cleaned_count}

前往官方嚴選頁面
    Go To                          ${Swag_Video.official_video_url}

確認當前頁面為官方嚴選頁面
    Location Should Contain              ${Swag_Video.official_video_url}
    Wait Until Element Is Visible        ${Swag_Video.goback_btn}
    Wait Until Element Is Visible        ${Swag_Video.official_title}

前往影片觀看頁
    [Arguments]    ${video_url}
    Go To                          ${video_url}
    確認無彈窗存在

確認當前頁面為影片觀看頁
    確認無彈窗存在
    Wait Until Element Is Visible        ${Swag_Video.look_btn}
    Wait Until Element Is Visible        ${Swag_Video.like_btn}
    Wait Until Element Is Visible        ${Swag_Video.dislike_btn}
    Wait Until Element Is Visible        ${Swag_Video.chat_btn}
    Wait Until Element Is Visible        ${Swag_Video.gift_btn}
    Wait Until Element Is Visible        ${Swag_Video.copyshare_btn}
    Wait Until Element Is Visible        ${Swag_Video.videoinfo_btn}
    Wait Until Element Is Visible        ${Swag_Video.related_video_btn}

記錄當前影片解鎖所需要的鑽石數量
    確認無彈窗存在
    Wait Until Element Is Visible    ${Swag_Video.video_unlock_diamond}    timeout=20s
    ${unlock_diamond}=    Get Text    ${Swag_Video.video_unlock_diamond}
    Log To Console    原始文字: ${unlock_diamond}
    # 使用 Get Regexp Matches 直接提取數字
    ${diamond_number}=    Get Regexp Matches    ${unlock_diamond}    \\d+
    ${cleaned_value}=    Set Variable    ${diamond_number}[0]
    Should Not Be Empty    ${cleaned_value}    解鎖所需鑽石數量為空，請檢查 XPath 或是 影片已經被解鎖了。
    Set Global Variable    ${CURRENT_UNLOCK_DIAMOND}    ${cleaned_value}
    Log To Console    當前影片解鎖所需的鑽石數量為: ${CURRENT_UNLOCK_DIAMOND}

智慧關閉彈窗
    [Documentation]    智慧處理各種彈窗，包括 PWA 彈窗、系統推播通知彈窗和 DRM 警告彈窗
    [Arguments]    ${retry_count}=3    ${retry_interval}=1s    ${recursion_count}=0
    # 防止無限遞迴
    IF    ${recursion_count} >= 3
        Log To Console    警告：已達最大遞迴次數，停止重試
        RETURN    False
    END

    # 增加等待時間，確保頁面完全加載
    Sleep    2s

    FOR    ${index}    IN RANGE    ${retry_count}
        # 首先處理 PWA Safari Toast
        ${pwa_toast_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${Swag_Video.pwa_alert_close}    timeout=5s
        IF    ${pwa_toast_visible}
            # 增加重試機制來關閉 PWA Toast
            FOR    ${retry}    IN RANGE    3
                ${click_status}=    Run Keyword And Return Status
                ...    Click Element    ${Swag_Video.pwa_alert_close}
                IF    ${click_status}
                    Log To Console    已成功關閉 PWA Toast
                    Sleep    1s
                    BREAK
                END
                Sleep    1s
            END
        END
        # 處理系統推播通知彈窗
        ${notification_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${Swag_Video.notification_dialog}    timeout=3s
        IF    ${notification_visible}
            Log To Console    檢測到系統推播通知彈窗
            ${deny_btn_visible}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    ${Swag_Video.notification_deny_btn}    timeout=2s
            IF    ${deny_btn_visible}
                Wait Until Element Is Enabled    ${Swag_Video.notification_deny_btn}    timeout=2s
                Sleep    0.5s
                Click Element    ${Swag_Video.notification_deny_btn}
                Log To Console    已點擊"暫時不要"按鈕
                Sleep    1s
            END
        END
        # 處理 PWA 彈窗
        ${pwa_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${Swag_Video.pwa_alert_close}    timeout=3s
        IF    ${pwa_visible}
            Click Element    ${Swag_Video.pwa_alert_close}
            Log To Console    已關閉 PWA 彈窗
            Sleep    1s
        END
        # 驗證彈窗是否都已關閉
        ${all_clear}=    Run Keyword And Return Status    確認無彈窗存在
        IF    ${all_clear}
            Log To Console    所有彈窗已成功關閉
            RETURN    True
        END
        
        IF    ${index} < ${retry_count} - 1
            Log To Console    第 ${index + 1} 次嘗試關閉彈窗後仍有彈窗存在，等待後重試...
            Sleep    ${retry_interval}
            # 嘗試刷新頁面
            Reload Page
            Sleep    2s
        END
    END
    Log To Console    當前嘗試未能完全關閉彈窗，進行第 ${recursion_count + 1} 次完整重試...
    Sleep    2s
    RETURN    智慧關閉彈窗    retry_count=${retry_count}    retry_interval=${retry_interval}    recursion_count=${recursion_count + 1}

確認無彈窗存在
    [Documentation]    檢查是否還存在任何彈窗
    ${notification_gone}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    ${Swag_Video.notification_dialog}
    ${pwa_gone}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    ${Swag_Video.pwa_alert_close}
    ${drm_gone}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    ${Swag_Video.drm_alert_dialog}
    ${pwa_toast_gone}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    //div[contains(@class, "PwaSafariToast__StyledPwaSafariToast")]
    
    ${all_clear}=    Evaluate    ${notification_gone} and ${pwa_gone} and ${drm_gone} and ${pwa_toast_gone}
    
    IF    not ${all_clear}
        Log To Console    仍有彈窗存在，準備重新執行關閉流程...
        Sleep    2s
    ELSE
        Log To Console    確認所有彈窗已清除
    END
    RETURN    ${all_clear}

查看我錢包裡的鑽石數量及查看要解鎖影片的鑽石價格
    [Documentation]    顯示錢包餘額和影片解鎖所需鑽石數量的比較資訊
    確認無彈窗存在
    # 檢查兩個全域變數是否已經設置
    Variable Should Exist    ${CURRENT_DIAMOND_COUNT}    錢包鑽石數量尚未取得，請先執行查看並記錄當前會員錢包裡的鑽石數量
    Variable Should Exist    ${CURRENT_UNLOCK_DIAMOND}    解鎖所需鑽石數量尚未取得，請先執行記錄當前影片解鎖所需要的鑽石數量
    Log To Console    \n=== 鑽石數量資訊 ===
    Log To Console    錢包餘額: ${CURRENT_DIAMOND_COUNT}
    Log To Console    解鎖金額: ${CURRENT_UNLOCK_DIAMOND}
    Log To Console    ===================\n
    # 設定全域變數供後續使用
    Set Global Variable    ${WALLET_DIAMOND_AMOUNT}    ${CURRENT_DIAMOND_COUNT}
    Set Global Variable    ${UNLOCK_DIAMOND_AMOUNT}    ${CURRENT_UNLOCK_DIAMOND}

點擊影片解鎖按鈕
    [Documentation]    點擊解鎖按鈕並處理可能出現的 DRM 警告彈窗
    # 點擊解鎖按鈕
    Wait And Click Element    ${Swag_Video.video_unlock_diamond}
    Sleep    1s    # 等待可能的彈窗出現
    # 檢查是否出現 DRM 警告彈窗
    ${drm_alert_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${Swag_Video.drm_alert_dialog}    timeout=5s
    IF    ${drm_alert_visible}
        Log To Console    檢測到 DRM 警告彈窗
        # 檢查並點擊"繼續進行"按鈕
        ${continue_btn_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${Swag_Video.drm_continue_btn}    timeout=3s
        IF    ${continue_btn_visible}
            Wait Until Element Is Enabled    ${Swag_Video.drm_continue_btn}    timeout=3s
            Log To Console    點擊"繼續進行"按鈕
            Click Element    ${Swag_Video.drm_continue_btn}
            Sleep    1s    # 等待彈窗關閉
        ELSE
            Log To Console    警告：無法找到"繼續進行"按鈕
        END
    ELSE
        Log To Console    未檢測到 DRM 警告彈窗，繼續執行
    END
    # 確保彈窗已關閉
    ${drm_alert_gone}=    Run Keyword And Return Status
    ...    Wait Until Page Does Not Contain Element    ${Swag_Video.drm_alert_dialog}    timeout=5s
    Should Be True    ${drm_alert_gone}    DRM 警告彈窗未能正確關閉

驗證彈窗是否已關閉
    [Documentation]    確認 DRM 警告彈窗是否已經關閉
    ${drm_alert_exists}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    ${Swag_Video.drm_alert_dialog}
    RETURN    ${drm_alert_exists}

確認影片已解鎖
    [Documentation]    確認影片是否已經解鎖，通過驗證解鎖按鈕是否消失來判斷
    [Arguments]    ${timeout}=10s
    # 等待解鎖按鈕消失
    ${unlock_button_gone}=    Run Keyword And Return Status
    ...    Wait Until Page Does Not Contain Element    ${Swag_Video.video_unlock_diamond}    timeout=${timeout}
    IF    ${unlock_button_gone}
        Log To Console    \n=== 影片解鎖狀態檢查 ===
        Log To Console    ✅ 確認影片已成功解鎖
        Log To Console    =======================\n
        RETURN    True
    ELSE
        Log To Console    \n=== 影片解鎖狀態檢查 ===
        Log To Console    ❌ 影片未解鎖，解鎖按鈕仍然存在
        Log To Console    =======================\n
        Fail    影片解鎖失敗：解鎖按鈕仍然存在於頁面上
    END

驗證影片解鎖狀態
    [Documentation]    額外的檢查方法，可用於更嚴格的驗證
    [Arguments]    ${timeout}=5s
    # 檢查解鎖按鈕是否消失
    ${button_status}=    Run Keyword And Return Status
    ...    Page Should Not Contain Element    ${Swag_Video.video_unlock_diamond}
    # 如果按鈕還在，再等待一下再檢查一次（防止延遲）
    IF    not ${button_status}
        Sleep    2s
        ${button_status}=    Run Keyword And Return Status
        ...    Page Should Not Contain Element    ${Swag_Video.video_unlock_diamond}
    END
    RETURN    ${button_status}

驗證解鎖後錢包剩餘的鑽石數量
    [Documentation]    驗證解鎖影片後錢包餘額是否正確扣除鑽石數量
    智慧關閉彈窗
    # 確保有之前所需的全域變數
    Variable Should Exist    ${WALLET_DIAMOND_AMOUNT}    未找到原始錢包餘額
    Variable Should Exist    ${UNLOCK_DIAMOND_AMOUNT}    未找到解鎖使用金額
    # 計算預期剩餘金額
    ${expected_remaining}=    Evaluate    ${WALLET_DIAMOND_AMOUNT} - ${UNLOCK_DIAMOND_AMOUNT}
    # 重新檢查當前錢包餘額
    Click Element    ${Swag_Video.video_back_btn}
    Sleep    2s    # 等待頁面加載
    智慧關閉彈窗
    Wait Until Element Is Visible    ${Swag_Video.diamond_shop_btn}    timeout=20s
    點擊我的資訊頁
    查看並記錄當前會員錢包裡的鑽石數量
    ${actual_remaining}=    Convert To Integer    ${CURRENT_DIAMOND_COUNT}
    # 準備驗證資訊
    ${verification_info}=    Catenate    SEPARATOR=\n
    ...    ========== 鑽石扣款驗證結果 ==========
    ...    解鎖前餘額:\t${WALLET_DIAMOND_AMOUNT} 鑽石
    ...    扣除金額:\t${UNLOCK_DIAMOND_AMOUNT} 鑽石
    ...    預期餘額:\t${expected_remaining} 鑽石
    ...    實際餘額:\t${actual_remaining} 鑽石

    # 驗證結果
    ${is_balance_correct}=    Evaluate    ${actual_remaining} == ${expected_remaining}
    IF    ${is_balance_correct}
        ${result_info}=    Set Variable    ✅ 驗證通過：鑽石扣款金額正確
    ELSE
        ${difference}=    Evaluate    ${actual_remaining} - ${expected_remaining}
        ${result_info}=    Set Variable    ❌ 驗證失敗：鑽石扣款金額不符\n差額: ${difference} 鑽石
        IF    ${difference} > 0
            ${result_info}=    Catenate    SEPARATOR=\n    ${result_info}    狀況：扣款金額小於預期
        ELSE
            ${result_info}=    Catenate    SEPARATOR=\n    ${result_info}    狀況：扣款金額大於預期
        END
    END

    ${verification_info}=    Catenate    SEPARATOR=\n
    ...    ${verification_info}
    ...    ${result_info}
    ...    ====================================

    # 打印到控制台
    Log To Console    \n${verification_info}
    # 保存到文件
    ${timestamp}=    Get Time    epoch
    ${report_path}=    Set Variable    ${EXECDIR}/reports/diamond_verification_${timestamp}.txt
    Create File    ${report_path}    ${verification_info}
    Log To Console    \n報告已保存至: ${report_path}
    # 最終驗證
    Should Be Equal As Numbers    ${actual_remaining}    ${expected_remaining}
    ...    msg=鑽石扣款驗證失敗！預期餘額：${expected_remaining}，實際餘額：${actual_remaining}，差額：${actual_remaining - ${expected_remaining}}