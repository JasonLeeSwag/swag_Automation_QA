*** Variables ***
# system arguments  user can use headless mode with --variable DEFAULT_CHROME_OPTIONS:"--lang=zh-tw --headless --disable-gpu --window-size=1920,1080"
${DEFAULT_CHROME_OPTIONS}  --lang=en-US --disable-gpu --no-sandbox --start-maximized
&{DEFAULT_PREFS}
...                        download.default_directory=${EMPTY}
...                        download.prompt_for_download=${False}
...                        download.directory_upgrade=${True}

&{DEFAULT_TIMEOUT}
...                        qat=10 sec
...                        prod=5 sec

${DEFAULT_DOWNLOAD_DIR}    ${EXECDIR}${/}TestData${/}Download

# 環境變數
@{ENV_NAMES}               prod  uat  qat  dev
${ENV}                     ${EMPTY}
${PROXY_SERVER}            ${EMPTY}

# remote arguments
${REMOTE_URL}              ${EMPTY}

*** Keywords ***
檢查環境名稱已設定
    Run Keyword If  "${ENV}" not in @{ENV_NAMES}
    ...  Fail       請確認環境名稱 ${ENV} 是否正確

判斷是否為Qat執行環境
    Return From Keyword If  "${ENV}" == "qat"  ${True}
    RETURN  ${False}

判斷是否為Production執行環境
    Return From Keyword If  "${ENV}" == "prod"  ${True}
    RETURN  ${False}

判斷瀏覽器是否已開啟
    ${kw} =         Register Keyword To Run On Failure  NOTHING
    ${status} =     Run Keyword And Return Status       Get Window Handles
    Register Keyword To Run On Failure                  ${kw}
    RETURN   ${status}

初始化Chrome瀏覽器
    # [Arguments]  ${performance_log}=${False}  ${timeout}=${DEFAULT_TIMEOUT.${ENV}}
    # [Arguments]  ${timeout}=${DEFAULT_TIMEOUT.${ENV}}
    檢查環境名稱已設定
    ${isOpen} =     判斷瀏覽器是否已開啟
    Run Keyword If  ${isOpen} == ${False}
    ...                 開啟Chrome瀏覽器  #${performance_log}
    # Run Keyword If  "${ENV}" == "prod"
    # ...             Set Selenium Timeout  ${DEFAULT_TIMEOUT.prod}
    # ...       ELSE
    # ...             Set Selenium Timeout  ${DEFAULT_TIMEOUT.qat}
    # Set Selenium Timeout  ${timeout}
    Log Window Size
    
開啟Chrome瀏覽器
    # [Arguments]  ${performance_log}=${False}
    # ${chrome_options} =  Set Chrome Options       #${download_dir}
    # ${capabilities} =    Set Chrome Capabilities  ${performance_log}
    Get Chromedriver Path
    ${chrome_options} =  Set Chrome Options
    ${capabilities} =    Set Chrome Capabilities
    Run Keyword If  "${REMOTE_URL}" == "${EMPTY}"
    # ...    Create Webdriver  Chrome  desired_capabilities=${capabilities}  chrome_options=${chrome_options}
    ...    Create Webdriver  Chrome    options=${chrome_options}
    ...  ELSE
    ...    Run Keywords  Log  REMOTE_URL : ${REMOTE_URL}
    ...             AND  Open Browser  url=about:blank  browser=chrome  remote_url=${REMOTE_URL}  desired_capabilities=${capabilities}

選擇當前瀏覽器
    Switch Browser  1

關閉所有瀏覽器
    Close All Browsers

關閉當前瀏覽器
    Close Browser

# Chrome 設定
Set Chrome Options
    # [Arguments]  ${download_dir}
    ${chromeOptions} =      Evaluate    sys.modules["selenium.webdriver"].ChromeOptions()   sys, selenium.webdriver
    ${mobile emulation} =   Create Dictionary    deviceName=iPhone X
    # Set To Dictionary       ${mobile emulation}  download.default_directory=${DEFAULT_DOWNLOAD_DIR}  #${download_dir}
    Log                     Chrome preferences : ${mobile emulation}
    Call Method    ${chromeOptions}    add_experimental_option    mobileEmulation    ${mobile emulation}
    # Chrome option args
    ${arg_list} =           Split String      ${DEFAULT_CHROME_OPTIONS}
    FOR  ${arg}  IN  @{arg_list}
        Call Method          ${chromeOptions}  add_argument  ${arg}
    END
    RETURN  ${chrome_options}

Set Chrome Options - Web
    # [Arguments]  ${download_dir}
    ${chromeOptions} =      Evaluate          sys.modules["selenium.webdriver"].ChromeOptions()   sys, selenium.webdriver
    # Download File Path
    ${prefs} =              Copy Dictionary   ${DEFAULT_PREFS}
    Set To Dictionary       ${prefs}          download.default_directory=${DEFAULT_DOWNLOAD_DIR}  #${download_dir}
    Log                     Chrome preferences : ${prefs}
    Call Method             ${chromeOptions}  add_experimental_option  prefs  ${prefs}
    # Chrome option args
    ${arg_list} =           Split String      ${DEFAULT_CHROME_OPTIONS}
    FOR  ${arg}  IN  @{arg_list}
        Call Method          ${chromeOptions}  add_argument  ${arg}
    END
    RETURN  ${chrome_options}

Set Chrome Capabilities
#    [Arguments]  ${performance_log}=${False}
   ${dc} =                  Evaluate  sys.modules[ "selenium.webdriver" ].DesiredCapabilities.CHROME  sys, selenium.webdriver
#    Set To Dictionary  ${dc}  pageLoadStrategy  normal
   ${proxySetting} =        Create Dictionary  proxyType=manual  httpProxy=${PROXY_SERVER}  sslProxy=${PROXY_SERVER}
   Run Keyword If  not "${PROXY_SERVER}" == "${EMPTY}"
   ...  Set To Dictionary   ${dc}  proxy=${proxySetting}
#    ${loggingPrefs} =        Create Dictionary  performance=ALL
#    Run Keyword If  ${performance_log}
#    ...  Set To Dictionary   ${dc}  loggingPrefs=${loggingPrefs}
   RETURN  ${dc}
