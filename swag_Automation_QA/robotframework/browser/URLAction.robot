*** Keywords ***
Get Location And Split String
    [Arguments]  ${separator}  ${index}
    ${url}=     Get Location
    @{word}=    Split String    ${url}  ${separator}
    ${url}=     Set Variable    ${word}[${index}]
    RETURN    ${url}

# 複數 domain 使用
檢查URL包含
    [Arguments]     ${domainList}   ${url_path}
    ${result} =     判斷URL是否包含  ${domainList}  ${url_path}
    Should Be True  ${result}

判斷URL是否包含
    [Arguments]  ${domainList}  ${url_path}  ${caseInsensitive}=${True}
    ${currentURL} =  Get Location
    ${currentURL} =  Run Keyword If   ${caseInsensitive}  Convert To Lowercase  ${currentURL}
    ${url_path} =    Run Keyword If   ${caseInsensitive}  Convert To Lowercase  ${url_path}
    Log  ${currentURL} | ${url_path}
    ${baseURL} =     Fetch From Left  ${currentURL}       ${url_path}
    ${result} =      Set Variable If  "${baseURL}" in "${domainList}"  ${True}  ${False}
    RETURN         ${result}

取得BaseURL
    ${EXCHANGE_BASE_URL} =  Get Location
    RETURN  ${EXCHANGE_BASE_URL}

設定BASE_URL
    ${EXCHANGE_BASE_URL} =  取得BaseURL
    Set Suite Variable  ${EXCHANGE_BASE_URL}

判斷當前頁面是否為首頁
    [Arguments]  ${base_url}
    Wait Until Page Contains Element           //title
    Sleep  5s
    ${pageTitle} =          Get Title
    ${isRightTitle} =       Set Variable If      "向上股票" in "${pageTitle}"  ${True}  ${False}
    # ${isCorrectURL} =       判斷URL是否包含       ${base_url}  ${titile}
    # ${isIndexPage} =        Run Keyword And Return Status    Run Keywords    Should Be True  ${isRightTitle} == ${isCorrectURL}
    # ...                                                               AND    Should Be True  ${isCorrectURL} == ${True}
    ${isIndexPage} =        Run Keyword And Return Status    Should Be True  ${isRightTitle} == ${True}
    RETURN  ${isIndexPage}  ${base_url}

確認登入成功
    [Arguments]  ${base_url}
    ${isIndexPage}  ${base_url} =    判斷當前頁面是否為首頁  ${base_url}
    Should Be True           ${isIndexPage}
    Location Should Contain  ${base_url}

檢查登入狀態
    [Arguments]  ${base_url}
    ${login_status} =  Run Keyword And Return Status  確認登入成功  ${base_url}
    RETURN  ${login_status}
