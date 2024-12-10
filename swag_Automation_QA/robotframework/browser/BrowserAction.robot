*** Variables ***
# system arguments
${DEFAULT_CHROME_OPTIONS}    --lang=en-US --disable-gpu --no-sandbox --start-maximized
${HEADLESS_MODE}            ${EMPTY}

&{DEFAULT_PREFS}
...                         download.default_directory=${EMPTY}
...                         download.prompt_for_download=${False}
...                         download.directory_upgrade=${True}

&{DEFAULT_TIMEOUT}
...                         qat=10 sec
...                         prod=5 sec

${DEFAULT_DOWNLOAD_DIR}     ${EXECDIR}${/}TestData${/}Download

# 環境變數
@{ENV_NAMES}                prod  uat  qat  dev
${ENV}                      ${EMPTY}
${PROXY_SERVER}             ${EMPTY}

# remote arguments
${REMOTE_URL}               ${EMPTY}

*** Keywords ***
Is CI Environment
    ${ci_env}=    Get Environment Variable    CI    ${EMPTY}
    ${is_ci}=    Set Variable If    "${ci_env}" != "${EMPTY}"    ${TRUE}    ${FALSE}
    RETURN    ${is_ci}

Set Chrome Options
    ${is_ci}=    Is CI Environment
    
    ${chromeOptions}=    Evaluate    sys.modules["selenium.webdriver"].ChromeOptions()    sys, selenium.webdriver
    
    # 移動設備模擬
    ${mobile emulation}=    Create Dictionary    deviceName=iPhone X
    Call Method    ${chromeOptions}    add_experimental_option    mobileEmulation    ${mobile emulation}
    
    # 在 CI 環境中設置無頭模式
    IF    ${is_ci}
        ${options}=    Create List
        ...    --headless
        ...    --disable-gpu
        ...    --no-sandbox
        ...    --disable-dev-shm-usage
        ...    --window-size=1920,1080
        FOR    ${option}    IN    @{options}
            Call Method    ${chromeOptions}    add_argument    ${option}
        END
    ELSE
        # 非 CI 環境的基本設置
        ${options}=    Create List    
        ...    --start-maximized
        ...    --disable-gpu
        ...    --no-sandbox
        FOR    ${option}    IN    @{options}
            Call Method    ${chromeOptions}    add_argument    ${option}
        END
    END
    
    RETURN    ${chromeOptions}

Set Chrome Capabilities
    ${dc}=    Evaluate    sys.modules["selenium.webdriver"].DesiredCapabilities.CHROME    sys, selenium.webdriver
    ${proxySetting}=    Create Dictionary    proxyType=manual    httpProxy=${PROXY_SERVER}    sslProxy=${PROXY_SERVER}
    Run Keyword If    not "${PROXY_SERVER}" == "${EMPTY}"
    ...    Set To Dictionary    ${dc}    proxy=${proxySetting}
    RETURN    ${dc}

開啟Chrome瀏覽器
    Get Chromedriver Path
    ${chrome_options}=    Set Chrome Options
    ${capabilities}=    Set Chrome Capabilities
    
    # 檢查並記錄 Chrome 設置
    Log    Chrome options: ${chrome_options}
    
    Run Keyword If    "${REMOTE_URL}" == "${EMPTY}"
    ...    Create Webdriver    Chrome    options=${chrome_options}
    ...    ELSE
    ...    Run Keywords
    ...    Log    REMOTE_URL : ${REMOTE_URL}    AND
    ...    Open Browser    url=about:blank    browser=chrome    remote_url=${REMOTE_URL}    desired_capabilities=${capabilities}

關閉所有瀏覽器
    Close All Browsers