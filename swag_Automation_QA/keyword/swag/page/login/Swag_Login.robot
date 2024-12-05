# swag_Automation_QA\keyword\swag\page\login\Swag_Login.robot
*** Variables ***
&{Swag_Login}                      page_name=會員登入頁
...                                url=login
...                                login_btn=//button[@data-element_id='tab-login'][contains(., "登入")]
...                                username_or_email_input=//input[@data-element_id='input.username_or_email']
...                                password_input=//input[@id='password-form' and @type='password' and @placeholder='密碼']
...                                display_password_btn=//button[@data-element_id='button-display-password']
...                                hide_password_btn=//*[@data-element_id="button-display-password"]
...                                forgot_password_btn=//button[@data-element_id='button-forgot-password']
...                                google_login_btn=//button[@data-element_id='button-login-google'][@title="Google"]
...                                mail_login_btn=//button[@data-element_id='button-login-mail']
...                                phone_login_btn=//button[@data-element_id='button-login-phone']
...                                webauthn_login_btn=//button[@data-element_id='button-login-webauthn']
...                                email_submit_btn=//button[@data-element_id='button-login' and @type='submit' and text()='登入']
...                                mailAlert_txt=//div[contains(@class, 'UsernamePasswordForm__InputHint') and contains(text(), '帳號/密碼錯誤')]
...                                err429Alert_txt=//*[@class='UniversalAnchor_Toastr']
...                                password_input_txt=//input[@type="text" and @id="password-form" and @name="password" and @placeholder="密碼"]
...                                login_apple_btn=//*[@data-element_id="button-login-apple"][contains(@title, "Apple")]



#忘記密碼
...                                back_button=//*[@data-element_id="button-back"][contains(., "忘記密碼")]
...                                switch_to_phone_number_btn=//*[@data-element_id="switch-to-phone-number"][contains(., "切換成手機號碼")]
...                                email_next_btn=//*[@data-element_id="button-email-enter"][contains(., "下一步")]
...                                switch_to_phone_btn=//*[@data-element_id="switch-to-phone-number"][contains(., "切換成手機號碼")]
...                                close_btn=//*[@data-element_id="button-close"]
...                                back_btn=//*[@data-element_id="button-back"]
...                                switch_to_email_btn=//*[@data-element_id="switch-to-email"][contains(., "切換成電子郵件")]
...                                email_enter_btn=//*[@data-element_id="button-email-enter"][contains(., "下一步")]


#「Sign in with Google」
...                                sign_in_title=//h1[@id='headingText']
...                                email_or_phone_input=//input[@id='identifierId' and @type='email' and @name='identifier']
...                                forgot_email_btn=//button[@jsname='Cuz2Ue' and @type='button']
...                                create_account_btn=//button[@jsname='LgbsSe' and @type='button' and .//span[text()='建立帳戶']]
...                                next_btn=//button[@jsname='LgbsSe' and @type='button' and ancestor::div[@id='identifierNext']]

#「Sign in with Apple」
...                                apple_account_title=//div[@class='ac-localnav-title']
...                                apple_account_signin_text=//h1[contains(@class, 'si-container-title')]
...                                email_or_phone_input_label=//input[@type='text' and @can-field='accountName' and @aria-labelledby='apple_id_field_label']
...                                continue_btn=//button[@id='sign-in']
...                                apple_forgot_btn=//a[contains(@href, 'iforgot.apple.com')]

#「Sign in with Mail」
...                                email_login_btn=//*[@data-element_id="button-email-enter"][contains(., "登入")]
...                                email_notice_text=//div[@class="EmailForm__Notice-sc-8u0c7e-5 bQXugp"][contains(., "將寄送給你驗證信一鍵登入 SWAG")]

#「Sign in with Phone」
...                                phone_input=//*[@data-element_id="input.phone"]
...                                phone_notice_text=//div[@class="PhoneForm__PhonePlaceHolder-sc-12ko3kb-8 fwpXEQ"][contains(., "驗證碼將傳送到你的手機")]


*** Keywords ***
點擊登入按鈕
    Wait And Click Element               ${Swag_Login.login_btn}

檢查當前頁面為會員登入頁
    Wait Until Element Is Visible        ${Swag_Login.username_or_email_input}
    Wait Until Element Is Visible        ${Swag_Login.display_password_btn}
    Wait Until Element Is Visible        ${Swag_Login.forgot_password_btn}
    Wait Until Element Is Visible        ${Swag_Login.google_login_btn}
    Wait Until Element Is Visible        ${Swag_Login.mail_login_btn}
    Wait Until Element Is Visible        ${Swag_Login.phone_login_btn}
    Wait Until Element Is Visible        ${Swag_Login.webauthn_login_btn}
    Wait Until Element Is Visible        ${Swag_Login.email_submit_btn}
    Wait Until Element Is Visible        ${Swag_Login.password_input}

輸入信箱
    [Arguments]  ${mail}
    Clear And Input Text                 ${Swag_Login.username_or_email_input}  ${mail}
    Log  ${mail}

確認Mail或密碼錯誤或嘗試次數過多提示已顯示
    ${err429_error}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Swag_Login.err429Alert_txt}    timeout=5s
    ${mail_error}=      Run Keyword And Return Status    Wait Until Element Is Visible    ${Swag_Login.mailAlert_txt}    timeout=5s
    Run Keyword If    ${err429_error}    Log    "嘗試次數過多，顯示 '429 Too Many Requests' 錯誤提示"
    Run Keyword If    ${mail_error}      Log    "帳號或密碼錯誤，顯示 '帳號/密碼錯誤' 提示"
    Run Keyword Unless    ${err429_error} or ${mail_error}    Fail    "未顯示任何錯誤提示"

確認密碼錯誤提示已顯示
    Wait Until Element Is Visible  ${Swag_Login.pwdLengthAlert_txt}

判斷密碼輸入欄清空按鍵是否顯示
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  500ms
    ...                                              Element Should Be Visible  ${Swag_Login.pwdClear_btn}
    RETURN  ${status}

點擊密碼清空按鍵
    Wait And Click Element               ${Swag_Login.pwdClear_btn}

輸入密碼
    [Arguments]  ${pwd}
    ${status} =  判斷密碼輸入欄清空按鍵是否顯示
    Run Keyword If  ${status}
    ...         點擊密碼清空按鍵
    Input Password                       ${Swag_Login.password_input}  ${pwd}
    Log  ${pwd}

點擊登入提交按鈕
    Wait And Click Element         ${Swag_Login.email_submit_btn}

輸入手機及密碼並登入
    [Arguments]  ${phone_num}  ${pwd}
    # 選擇國碼  ${area_code}
    輸入電話  ${phone_num} TAB
    輸入密碼  ${pwd}
    點擊登入提交按鈕

輸入信箱及密碼並登入
    [Arguments]  ${mail}  ${pwd}
    輸入信箱  ${mail}
    輸入密碼  ${pwd}
    點擊登入提交按鈕

點擊查看密碼
    Wait And Click Element         ${Swag_Login.hide_password_btn}

確認密碼已顯示
    Wait Until Element Is Visible        ${Swag_Login.password_input_txt}


點擊忘記密碼按鈕
    Wait And Click Element         ${Swag_Login.forgot_password_btn}

確認電子郵件忘記密碼視窗已顯示
    Wait Until Element Is Visible        ${Swag_Login.back_button}
    Wait Until Element Is Visible        ${Swag_Login.switch_to_phone_number_btn}
    Wait Until Element Is Visible        ${Swag_Login.email_next_btn}

點擊切換成手機號碼
    Wait And Click Element         ${Swag_Login.switch_to_phone_btn}

確認手機號碼忘記密碼視窗已顯示
    Wait Until Element Is Visible        ${Swag_Login.close_btn}
    Wait Until Element Is Visible        ${Swag_Login.back_btn}
    Wait Until Element Is Visible        ${Swag_Login.switch_to_email_btn}
    Wait Until Element Is Visible        ${Swag_Login.email_enter_btn}

點擊Google登入按鈕
    Wait And Click Element         ${Swag_Login.google_login_btn}

確認Google登入頁面已顯示
    Wait Until Element Is Visible        ${Swag_Login.sign_in_title}
    Wait Until Element Is Visible        ${Swag_Login.email_or_phone_input}
    Wait Until Element Is Visible        ${Swag_Login.forgot_email_btn}
    Wait Until Element Is Visible        ${Swag_Login.create_account_btn}
    Wait Until Element Is Visible        ${Swag_Login.next_btn}

點擊Apple登入按鈕
    Wait And Click Element         ${Swag_Login.login_apple_btn}

確認Apple登入頁面已顯示
    Wait Until Element Is Visible        ${Swag_Login.apple_account_title}
    Wait Until Element Is Visible        ${Swag_Login.apple_account_signin_text}
    Wait Until Element Is Visible        ${Swag_Login.email_or_phone_input_label}
    Wait Until Element Is Visible        ${Swag_Login.continue_btn}
    Wait Until Element Is Visible        ${Swag_Login.apple_forgot_btn}

點擊電子郵件登入按鈕
    Wait And Click Element         ${Swag_Login.mail_login_btn}

確認電子郵件登入頁面已顯示
    Wait Until Element Is Visible        ${Swag_Login.email_login_btn}
    Wait Until Element Is Visible        ${Swag_Login.email_notice_text}

點擊手機簡訊登入按鈕
    Wait And Click Element         ${Swag_Login.phone_login_btn}

確認手機簡訊登入頁面已顯示
    Wait Until Element Is Visible        ${Swag_Login.phone_input}
    Wait Until Element Is Visible        ${Swag_Login.phone_notice_text}



點擊快速登入按鈕
    Wait And Click Element    ${Swag_Login.webauthn_login_btn}
    Sleep    3s

處理Windows安全性視窗
    Press Keys    None    ESC
    Press Keys    None    ESC
