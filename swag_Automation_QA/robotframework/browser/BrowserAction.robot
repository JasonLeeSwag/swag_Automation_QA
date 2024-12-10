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
    ${mobile emulation}=    Create Dictionary    deviceName=iPhone X
    Log    Chrome preferences : ${mobile emulation}
    Call Method    ${chromeOptions}    add_experimental_option    mobileEmulation    ${mobile emulation}
    
    # 基本 Chrome 選項
    ${base_args}=    Split String    ${DEFAULT_CHROME_OPTIONS}
    FOR    ${arg}    IN    @{base_args}
        Call Method    ${chromeOptions}    add_argument    ${arg}
    END
    
    # 在 CI 環境中添加無頭模式選項
    IF    ${is_ci}
        Call Method    ${chromeOptions}    add_argument    --headless=new
        Call Method    ${chromeOptions}    add_argument    --window-size=1920,1080
        Call Method    ${chromeOptions}    add_argument    --disable-dev-shm-usage
    END
    
    RETURN    ${chromeOptions}

Set Chrome Options - Web
    ${is_ci}=    Is CI Environment
    
    ${chromeOptions}=    Evaluate    sys.modules["selenium.webdriver"].ChromeOptions()    sys, selenium.webdriver
    ${prefs}=    Copy Dictionary    ${DEFAULT_PREFS}
    Set To Dictionary    ${prefs}    download.default_directory=${DEFAULT_DOWNLOAD_DIR}
    Log    Chrome preferences : ${prefs}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    
    # 基本 Chrome 選項
    ${base_args}=    Split String    ${DEFAULT_CHROME_OPTIONS}
    FOR    ${arg}    IN    @{base_args}
        Call Method    ${chromeOptions}    add_argument    ${arg}
    END
    
    # 在 CI 環境中添加無頭模式選項
    IF    ${is_ci}
        Call Method    ${chromeOptions}    add_argument    --headless=new
        Call Method    ${chromeOptions}    add_argument    --window-size=1920,1080
        Call Method    ${chromeOptions}    add_argument    --disable-dev-shm-usage
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
    
    Run Keyword If    "${REMOTE_URL}" == "${EMPTY}"
    ...    Create Webdriver    Chrome    options=${chrome_options}
    ...    ELSE
    ...    Run Keywords
    ...    Log    REMOTE_URL : ${REMOTE_URL}    AND
    ...    Open Browser    url=about:blank    browser=chrome    remote_url=${REMOTE_URL}    desired_capabilities=${capabilities}

關閉所有瀏覽器
    Close All Browsers