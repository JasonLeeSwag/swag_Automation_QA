# swag_Automation_QA\keyword\swag\page\register\Swag_Register.robot
*** Variables ***
&{Swag_Register}                   page_name=會員註冊頁
...                                url=register
...                                header_box=//*[@class="AuthenticateMethodSelect__Title-sc-a8spdu-6 hCqgcE"][contains(.,"免費建立帳號")]
...                                register_login_btn=//button[@data-element_id="button-signup"]
...                                register_btn=//button[@data-element_id='tab-signup' and text()='免費註冊']

...                                mail_input=//input[@data-element_id='input.email']
...                                birthday_input=//input[@data-element_id='button-birthday-change']
...                                referralcode_input=//input[@type='text' and @name='referralCode' and @placeholder='推薦碼（選填)']
...                                latest_news_txt=//button[contains(@class, 'EmailForm__CircleCheckbox')]//div[contains(@class, 'EmailForm__CheckboxWording') and text()='同意收到 SWAG 的最新消息']
...                                email_submit_btn=//button[@data-element_id='button-email-enter']

...                                verification_header=//header[contains(@class, 'EmailVerify__Header')]//h4[text()='輸入驗證碼']
...                                verification_input=//input[@data-element_id='input.email.pin']
...                                verification_btn=//button[@data-element_id='button-next']

...                                mailAlert_txt=//*[@class="EmailForm__Notice-sc-8u0c7e-5 esDDWP"][contains(.,"請填寫正確格式")]
...                                birthdayAlert_txt=//*[@class="DateOfBirthInput__ValidationMessage-sc-19v5e83-3 dMplmK"][contains(.,"年滿 18 歲才能進入網站")]
...                                referralcodeAlert_txt=//*[@class="InputComponent__Hint-sc-l1cmxu-5 InputComponent__ErrorHint-sc-l1cmxu-6 hpyeYJ iygvMr"][contains(.,"邀請碼失效")]

...                                phone_input=//input[@data-element_id="input.phone"]
...                                phone_submit_btn=//*[@data-element_id="button-phone-enter"]

...                                back_button=//button[@data-element_id='button-back']
...                                phone_pin_input=//input[@data-element_id='input.phone.pin']
...                                change_phone_number_button=//button[@data-element_id='button-change-phone-number']
...                                phone_numAleart_txt=//*[@class="PhoneForm__PhonePlaceHolder-sc-12ko3kb-8 juPhFW"][contains(.,"號碼格式不符")]

...                                phone_register_btn=//button[@data-element_id='button-login-phone']
...                                google_register_btn=//button[@data-element_id='button-login-google']
...                                mail_register_btn=//button[@data-element_id='button-login-mail']


...                                become_model_btn=//*[@data-element_id="button-become-a-model"]
...                                close_btn=//*[@data-element_id="button-close"]
...                                display_password_btn=//*[@data-element_id="button-display-password"]
...                                setting_login_btn=//*[@data-element_id="button-setting-login"][contains(., "登入")]
...                                tos_link=//*[@data-element_id="button-tos"][contains(., "條款")]
...                                next_btn=//*[@data-element_id="button-next"][contains(., "下一步")]



*** Keywords ***
檢查當前頁面為註冊頁
    Wait Until Element Is Visible  ${Swag_Register.header_box}
    Wait Until Element Is Visible  ${Swag_Register.register_btn}

確認生日欄已顯示
    Wait Until Element Is Visible  ${Swag_Register.birthday_input}

確認Email輸入欄已顯示
    Wait Until Element Is Visible  ${Swag_Register.mail_input}

確認推薦碼欄已顯示
    Wait Until Element Is Visible  ${Swag_Register.referralcode_input}

確認最新消息選項已顯示
    Wait Until Element Is Visible  ${Swag_Register.latest_news_txt}

確認信箱註冊提交按鈕已顯示
    Wait Until Element Is Visible  ${Swag_Register.email_submit_btn}

確認手機簡訊註冊按鈕已顯示
    Wait Until Element Is Visible  ${Swag_Register.phone_register_btn}

確認google註冊按鈕已顯示
    Wait Until Element Is Visible  ${Swag_Register.google_register_btn}

輸入信箱
    [Arguments]  ${mail}
    ${status} =  判斷帳號輸入欄清空按鍵是否顯示
    Run Keyword If  ${status}
    ...         點擊帳號輸入欄清空按鍵
    Clear And Input Text           ${Swag_Register.mail_input}  ${mail}

輸入手機電話
    [Arguments]  ${phone}
    Clear And Input Text           ${Swag_Register.phone_input}  ${phone}

輸入生日
    [Arguments]  ${BIRTHDAY}
    Clear And Input Text           ${Swag_Register.birthday_input}  ${BIRTHDAY}

輸入推薦碼
    [Arguments]  ${verification}
    Clear And Input Text           ${Swag_Register.referralcode_input}  ${verification}

點擊免費註冊提交按鈕
    Wait And Click Element         ${Swag_Register.email_submit_btn}

確認輸入mail驗證碼視窗已顯示
    Wait Until Element Is Visible  ${Swag_Register.verification_header}
    Wait Until Element Is Visible  ${Swag_Register.verification_input}
    Wait Until Element Is Visible  ${Swag_Register.verification_btn}

確認Mail錯誤提示已顯示
    Wait Until Element Is Visible  ${Swag_Register.mailAlert_txt}

確認未滿18歲警示已顯示
    Wait Until Element Is Visible  ${Swag_Register.birthdayAlert_txt}

確認邀請碼已失效已顯示
    Wait Until Element Is Visible  ${Swag_Register.referralcodeAlert_txt}

點擊手機簡訊註冊按鈕
    Wait And Click Element         ${Swag_Register.phone_register_btn}

確認手機輸入欄已顯示
    Wait Until Element Is Visible  ${Swag_Register.phone_input}

確認電子郵件註冊按鈕已顯示
    Wait Until Element Is Visible  ${Swag_Register.mail_register_btn}

確認手機註冊提交按鈕已顯示
    Wait Until Element Is Visible  ${Swag_Register.phone_submit_btn}

點擊手機註冊提交按鈕已顯示
    Wait And Click Element         ${Swag_Register.phone_submit_btn}

確認輸入手機簡訊驗證碼視窗已顯示
    Wait Until Element Is Visible  ${Swag_Register.back_button}
    Wait Until Element Is Visible  ${Swag_Register.phone_pin_input}
    Wait Until Element Is Visible  ${Swag_Register.change_phone_number_button}
    Wait Until Element Is Visible  ${Swag_Register.verification_btn}

確認手機電話錯誤提示已顯示
    Wait Until Element Is Visible  ${Swag_Register.phone_numAleart_txt}

點擊想註冊成為主播
    Wait And Click Element         ${Swag_Register.become_model_btn}

確認SWAG主播註冊頁面已顯示
    Wait Until Element Is Visible  ${Swag_Register.close_btn}
    Wait Until Element Is Visible  ${Swag_Register.display_password_btn}
    Wait Until Element Is Visible  ${Swag_Register.setting_login_btn}
    Wait Until Element Is Visible  ${Swag_Register.tos_link}
    Wait Until Element Is Visible  ${Swag_Register.next_btn}

判斷帳號輸入欄清空按鍵是否顯示
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  500ms
    ...                                              Element Should Be Visible  ${Swag_Register.accountClear_btn}
    RETURN  ${status}

判斷密碼輸入欄清空按鍵是否顯示
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  500ms
    ...                                              Element Should Be Visible  ${Swag_Register.pwdClear_btn}
    RETURN  ${status}

點擊密碼清空按鍵
    Wait And Click Element         ${Swag_Register.pwdClear_btn}

輸入密碼
    [Arguments]  ${pwd}
    ${status} =  判斷密碼輸入欄清空按鍵是否顯示
    Run Keyword If  ${status}
    ...         點擊密碼清空按鍵
    Input Password                 ${Swag_Register.password_input}  ${pwd}

判斷再次輸入密碼欄清空按鍵是否顯示
    ${status} =  Run Keyword And Return Status  Wait Until Keyword Succeeds  2x  500ms
    ...                                              Element Should Be Visible  ${Swag_Register.pwdAgainClear_btn}
    RETURN  ${status}

點擊再次輸入密碼清空按鍵
    Wait And Click Element         ${Swag_Register.pwdAgainClear_btn}

再次輸入密碼
    [Arguments]  ${pwd}
    ${status} =  判斷再次輸入密碼欄清空按鍵是否顯示
    Run Keyword If  ${status}
    ...         點擊再次輸入密碼清空按鍵
    Input Password                 ${Swag_Register.pwdAgain_input}  ${pwd}