# swag_Automation_QA/robotframework/browser/BrowserAction.robot
*** Keywords ***
Performance Log
    [Documentation]  預設會從 Tags 中找出 TestCase 編號命名檔案
    Log  ${TEST TAGS}
    ${TEST_CASE_ID}=  Get Matches  ${TEST_TAGS}  regexp=C\\d{5}
    ${S2L}=  Get Library Instance  SeleniumLibrary
    ${WebDriver}=  Call Method  ${S2l}  _current_browser
    Get Performance Log  ${WebDriver}  ${OUTPUT DIR}  @{TEST_CASE_ID}[0]_Log
