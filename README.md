# SWAG 自動化測試專案

此專案使用 Robot Framework 實現 SWAG 平台的自動化測試，包含 Web UI 測試和 API 測試。

作者：Jason Lee\
聯絡方式：crazy85128x@gmail.com

## 目錄

- [環境需求](#環境需求)
- [安裝說明](#安裝說明)
- [專案結構](#專案結構)
- [執行測試](#執行測試)
- [測試撰寫規範](#測試撰寫規範)
- [常見問題](#常見問題)
- [參考資料](#參考資料)

## 環境需求

### 作業系統支援
- Windows 10/11
- macOS 10.15+
- Linux (Ubuntu 20.04+)

### 基礎環境
- Python 3.12.x 或以上
- pip (Python 套件管理工具)
- Chrome 瀏覽器 (最新版本)
- Git

### 框架與套件版本
- Robot Framework 6.1.1
- robotframework-seleniumlibrary 6.1.3
- robotframework-requests 0.9.5
- robotframework-databaselibrary 1.2.4
- robotframework-pabot 2.16.0
- robotframework-faker 5.0.0
- robotframework-jsonlibrary 0.5
- robotframework-excellib 2.0.1
- robotframework-browser 17.5.2
- robotframework-pythonlibcore 4.3.0
- robotframework-stacktrace 0.4.1

### Python 相關套件
- selenium 4.15.2
- requests 2.31.0
- PyYAML 6.0.1
- python-dotenv 1.0.0
- cryptography 41.0.5
- pytest 7.4.3
- allure-pytest 2.13.2
- webdriver_manager 4.0.1

## 安裝說明

### Windows 安裝步驟
```bash
# 1. 安裝 Python 3.12.x
# 從 https://www.python.org/downloads/ 下載並安裝

# 2. 克隆專案
git clone https://github.com/crazy85128x/SWAG-Automation-QA
cd swag_Automation_QA

# 3. 建立虛擬環境
python -m venv venv
.\venv\Scripts\activate

# 4. 安裝依賴套件
pip install -r requirements.txt
```

### macOS/Linux 安裝步驟
```bash
# 1. 安裝 Python 3.12.x
# macOS: 
brew install python@3.12
# Linux: 
sudo apt-get install python3.12

# 2. 克隆專案
git clone https://github.com/crazy85128x/SWAG-Automation-QA
cd swag_Automation_QA

# 3. 建立虛擬環境
python3 -m venv venv
source venv/bin/activate

# 4. 安裝依賴套件
pip install -r requirements.txt
```

# 專案結構
```
swag_Automation_QA/
├── TestCase/                          # 測試案例
│   ├── login/                         # 登入相關測試
│   │   ├── Login.robot               # UI 登入測試
│   │   └── Login_API.robot           # API 登入測試
│   ├── myprofile/                     # 個人資料相關測試
│   │   └── Myprofile.robot
│   ├── register/                      # 註冊相關測試
│   │   ├── Register.robot            # UI 註冊測試
│   │   └── Register_API.robot        # API 註冊測試
│   └── video/                         # 影片相關測試
│       └── Video.robot
│
├── keyword/                           # 關鍵字定義
│   └── swag/
│       ├── Swag.sources.robot        # 共用資源定義
│       ├── component/                # 共用元件
│       │   └── Swag_Footer.robot
│       ├── domain/                   # 領域服務
│       │   └── Swag_LoginService.robot
│       └── page/                     # 頁面物件
│           ├── Swag_Home.robot
│           ├── login/
│           │   └── Swag_Login.robot
│           ├── myprofile/
│           │   └── settings/
│           │       └── Swag_Settings.robot
│           ├── register/
│           │   └── Swag_Register.robot
│           └── video/
│               └── Swag_Video.robot
│
├── robotframework/                     # 框架核心組件
│   ├── API/                          # API 測試框架
│   │   ├── API.robot
│   │   └── api_sources.robot
│   ├── browser/                      # 瀏覽器操作相關
│   │   ├── AlertAction.robot
│   │   ├── BrowserAction.robot
│   │   └── ... (其他瀏覽器相關操作)
│   ├── robot_lib/                    # Python 自定義庫
│   │   ├── Calculate.py
│   │   ├── Chrome.py
│   │   └── ... (其他 Python 模組)
│   └── utilities/                    # 工具類庫
│       ├── FileUtils.robot
│       ├── StringUtils.robot
│       └── ... (其他工具類)
│
├── reports/                           # 測試報告
│   ├── login_api_report_*.txt
│   └── register_api_report_*.txt
│
├── TestData/                          # 測試資料
│   ├── test_data01.jpg
│   └── test_data02.jpg
│
├── data/                              # 測試資料目錄
├── country.yaml                       # 國家設定
├── data.yaml                          # 基礎測試資料
├── qat_domain.yaml                    # 測試環境配置
├── requirements.txt                   # 依賴套件清單
└── README.md                          # 專案說明文件
```


### 目錄說明

#### TestCase/
- 存放所有測試案例檔案
- 依功能模組分類組織
- 每個測試檔案對應一個具體功能模組的測試

#### keyword/swag/
- **component/**: 存放可重用的頁面元件
- **page/**: 依照頁面功能分類的頁面物件
- **domain/**: 業務邏輯相關的服務層
- **Swag.sources.robot**: 共用資源定義

#### data/
- **test_data/**: 測試所需的資料檔案
- **config/**: 環境配置相關檔案
- **api/**: API測試相關資料

#### resources/
- **drivers/**: 瀏覽器驅動程式
- **scripts/**: 輔助腳本檔案

#### results/
- **logs/**: 測試執行日誌
- **reports/**: 測試報告
- **screenshots/**: 測試失敗時的截圖

### 檔案命名規範

1. 測試案例檔案：使用功能名稱，如 `Login.robot`
2. 頁面物件檔案：加上 `Swag_` 前綴，如 `Swag_Login.robot`
3. 共用元件檔案：同樣加上 `Swag_` 前綴，如 `Swag_Footer.robot`
4. 設定檔案：使用小寫字母，如 `data.yaml`

### 重要檔案說明
- **requirements.txt**: 列出所有 Python 依賴套件
- **README.md**: 專案說明文件
- **.gitignore**: Git 版本控制忽略規則

## 執行測試

### 測試影片Demo
- [登入-測試影片](https://drive.google.com/file/d/1UJWWOGw0MIaYVYnrk23Huhf0ENFYWoLt/view?usp=drive_link)
- [註冊-測試影片](https://drive.google.com/file/d/12dQ7HmiLFW_3jb9x1QmaEzOCihKLGyD6/view?usp=drive_link)
- [解鎖影片(含Bonus)-測試影片](https://drive.google.com/file/d/11Aut5KEqlWZpN5R3ZmYzH9uMdjf0G5GT/view?usp=drive_link)
- [全部測試流程(含Bonus)-測試影片](https://drive.google.com/file/d/1PzmL_lP_5LHWFfmbJbUl6El9-VHZOdMP/view?usp=drive_link)

### 測試報告檔案(UI/API)
- [詳細測試報告(含Bonus)](https://drive.google.com/drive/folders/1XO6iYtLLHyAO1-pvGGjM7VZFntu2SSPz?usp=sharing)


### 基本執行命令
```bash
# 執行特定 API 測試標籤的測試
robot TestCase/login/Login_API.robot
# 執行全部 API 測試標籤的測試
robot -i api TestCase/
# or 執行全部檔案名稱內有包含 _API 的測試
robot TestCase/**/[*_API]*.robot

# 執行特定測試檔案
robot -V data.yaml -V country.yaml -V qat_domain.yaml -i login TestCase 
robot -V data.yaml -V country.yaml -V qat_domain.yaml -i register TestCase
robot -V data.yaml -V country.yaml -V qat_domain.yaml -i video TestCase
# 執行全部測試檔案
robot -V data.yaml -V country.yaml -V qat_domain.yaml -i bvt TestCase
```

### 環境變數配置
測試執行時需要配置以下 YAML 檔案：
- data.yaml: 基本測試資料
- country.yaml: 國家/地區設定
- qat_domain.yaml: 測試環境網域設定

## 測試撰寫規範

### Page Object 模式實作原則
1. 頁面元素定位統一管理
2. 關鍵字應具有良好的抽象層級
3. 測試案例應保持獨立性
4. 避免硬編碼測試數據

### 元素命名規範
- 頁面 URL: `url`
- 頁面標題: `title`
- 頁面標題文字: `page_heading`
- 按鈕元素: `xxx_btn`
- 連結元素: `xxx_link`
- 輸入欄位: `xxx_input`

### 關鍵字命名規則

#### 基本動作命名
- 點擊動作: `點擊xxx` (例如：點擊登入按鈕、點擊選單)
- 選擇動作: `點選xxx` (用於選項類操作，例如：點選性別選項、點選國家)
- 輸入動作: `輸入xxx` (例如：輸入帳號、輸入密碼)
- 清除動作: `清除xxx` (例如：清除輸入欄位、清除搜尋框)

#### 驗證相關命名
- 檢查動作: `檢查xxx` (檢查特定元素或狀態，例如：檢查頁面標題、檢查錯誤訊息)
- 確認動作: `確認xxx` (確認特定條件或結果，例如：確認登入成功、確認訂單成立)
- 驗證動作: `驗證xxx` (較嚴謹的檢查，例如：驗證表單資料、驗證計算結果)
- 判斷動作: `判斷xxx是否xxx` (回傳布林值，例如：判斷按鈕是否可點擊、判斷元素是否存在)

#### 頁面操作命名
- 前往動作: `前往xxx頁面` (例如：前往首頁、前往設定頁面)
- 切換動作: `切換至xxx` (例如：切換至新視窗、切換至iframe)
- 捲動動作: `捲動至xxx` (例如：捲動至頁面底部、捲動至特定元素)
- 重整動作: `重整xxx` (例如：重整頁面、重整資料)

#### 資料處理命名
- 取得動作: `取得xxx` (例如：取得表格資料、取得使用者資訊)
- 設定動作: `設定xxx` (例如：設定預設值、設定測試環境)
- 儲存動作: `儲存xxx` (例如：儲存表單資料、儲存設定)
- 刪除動作: `刪除xxx` (例如：刪除測試資料、刪除暫存檔)

#### 等待相關命名
- 等待動作: `等待xxx` (例如：等待頁面載入、等待元素出現)
- 暫停動作: `暫停xxx秒` (明確的等待時間，例如：暫停3秒)

#### 複合動作命名
- 登入相關: `執行xxx登入` (例如：執行一般會員登入、執行管理者登入)
- 登出相關: `執行登出` (例如：執行系統登出、執行強制登出)
- 流程相關: `完成xxx流程` (例如：完成註冊流程、完成購物流程)

#### 命名規範注意事項
1. 保持一致性：相同類型的操作使用相同的動詞
2. 具體明確：清楚描述動作的目的和對象
3. 適當抽象：避免過於具體的實作細節
4. 使用中文：統一使用繁體中文命名
5. 避免縮寫：除非是普遍認可的縮寫，否則使用完整名稱

### 範例說明

#### 登入相關關鍵字
```robotframework
執行一般會員登入
    輸入帳號    ${USERNAME}
    輸入密碼    ${PASSWORD}
    點擊登入按鈕
    確認登入成功
```

#### 表單操作關鍵字
```robotframework
填寫個人資料表單
    輸入姓名    ${NAME}
    點選性別選項    男
    輸入生日    ${BIRTHDAY}
    點擊送出按鈕
    確認資料更新成功
```

#### 驗證相關關鍵字
```robotframework
判斷元素是否存在
    [Arguments]    ${element}
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
    [Return]    ${status}
```

這樣的命名規則更加系統化和完整，可以幫助團隊成員：
1. 更容易理解每個關鍵字的用途
2. 保持程式碼風格的一致性
3. 提高測試案例的可讀性和可維護性
4. 降低撰寫新測試案例的學習曲線

## 常見問題

### 執行測試時的 WebDriver 問題
如遇到 WebDriver 相關問題，請確認：
1. Chrome 瀏覽器版本是否最新
2. WebDriver 版本是否與 Chrome 版本匹配
3. WebDriver 是否已正確安裝在系統路徑中

### 測試執行失敗排查
1. 檢查網路連接狀態
2. 確認測試環境是否正常
3. 查看詳細的測試報告和日誌

## 參考資料

### XPath 相關資源
- [XPath 語法完整指南](https://www.w3schools.com/xml/xpath_intro.asp)
- [XPath Axes 軸向使用指南](https://www.w3schools.com/xml/xpath_axes.asp)
- [XPath 常用函數](https://www.w3schools.com/xml/xpath_functions.asp)

### XPath 選擇器參考

#### 基本選擇器
```xpath
//div[@class='example']                    # 使用 class 屬性
//input[@id='username']                    # 使用 id 屬性
//button[contains(@class, 'btn')]          # 使用 contains 函數
```

#### 進階選擇器
```xpath
//div[contains(@class, 'card')][position()=1]           # 使用位置函數
//table//tr[./td[contains(text(), '數據')]]            # 使用文字內容
//[contains(@data-test-id, 'submit')]                  # 使用自訂屬性
```

#### 相對路徑選擇器
```xpath
.//div[contains(@class, 'child')]                      # 當前節點下搜尋
../div[contains(@class, 'sibling')]                    # 同層節點搜尋
```

#### 組合條件選擇器
```xpath
//div[@class='parent' and @id='main']                  # AND 條件
//div[@class='item' or @class='card']                  # OR 條件
```

#### 動態元素處理
```xpath
//div[starts-with(@id, 'dynamic-')]                    # ID 開頭匹配
//div[ends-with(@class, '-container')]                 # 類別結尾匹配
```

### Robot Framework 相關
- [Robot Framework 官方文件](https://robotframework.org/)
- [Robot Framework User Guide](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [SeleniumLibrary 文件](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [Robot Framework 最佳實踐指南](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst)
- [Robot Framework 測試資料驅動](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#data-driven-testing)
- [Robot Framework 變數使用指南](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#variables)

### 測試自動化最佳實踐
- [Page Object Pattern](https://martinfowler.com/bliki/PageObject.html)
- [測試自動化金字塔](https://martinfowler.com/articles/practical-test-pyramid.html)
- [測試自動化策略](https://codesensegroup.github.io/code-study/cicd-2.0/chapter10)
- [測試自動化框架設計](https://www.zentao.net/blog/81542.html)

### Selenium 相關
- [Selenium 官方文件](https://www.selenium.dev/documentation/)
- [Selenium WebDriver 指南](https://www.selenium.dev/documentation/webdriver/)
- [Selenium 等待機制說明](https://www.selenium.dev/documentation/webdriver/waits/)
- [Selenium 定位策略](https://www.selenium.dev/documentation/webdriver/elements/locators/)
- [Selenium Grid 使用指南](https://www.selenium.dev/documentation/grid/)

### API 測試相關
- [RESTinstance Library](https://github.com/asyrjasalo/RESTinstance)
- [RequestsLibrary 文件](https://github.com/MarketSquare/robotframework-requests)
- [API 測試最佳實踐](https://ithelp.ithome.com.tw/articles/10362097)
- [RESTful API 測試策略](https://www.guru99.com/testing-rest-api-manually.html)

### 效能測試相關
- [Robot Framework 效能測試](https://github.com/robotframework/robotframework/blob/master/doc/userguide/src/ExtendingRobotFramework/ListenerInterface.rst)
- [JMeter 與 Robot Framework 整合](https://blog.csdn.net/mukeke/article/details/75356316)

### 持續整合/持續部署 (CI/CD)
- [Jenkins 與 Robot Framework 整合](https://plugins.jenkins.io/robot/)
- [GitLab CI 與 Robot Framework](https://pradappandiyan.medium.com/running-a-robot-framework-test-on-gitlab-and-deploying-the-report-db2ea18cc082)
- [Docker 容器化測試環境](https://hub.docker.com/r/ppodgorsek/robot-framework)

### 報告與日誌分析
- [Robot Framework 報告客製化](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-custom-reports)
- [測試報告最佳實踐](https://blog.testproject.io/2020/07/15/test-reporting-best-practices/)
- [Allure 報告框架](https://docs.qameta.io/allure/)

### 其他實用資源
- [CSS Selector 指南](https://www.w3schools.com/cssref/css_selectors.asp)
- [正則表達式教學](https://regex101.com/)
- [Git 版本控制最佳實踐](https://www.atlassian.com/git/tutorials/comparing-workflows)
- [Python 測試自動化](https://realpython.com/python-testing/)
- [敏捷測試方法論](https://www.agilealliance.org/agile101/agile-testing/)