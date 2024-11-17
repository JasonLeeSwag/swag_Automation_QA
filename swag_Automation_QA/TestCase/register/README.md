# SWAG 註冊 API 自動化測試框架

## 專案概述
這是一個使用 Robot Framework 開發的自動化測試框架，主要用於測試 SWAG 平台的用戶註冊 API。該框架提供了完整的註冊流程驗證，包括郵箱註冊、手機號碼註冊、數據驗證以及安全性測試。

## 目錄結構
swag_Automation_QA/
├── TestCase/
│ └── register/
│ └── Register_API.robot
├── data.yaml
├── qat_domain.yaml
├── country.yaml
├── reports/
└── README.md

## 環境要求
- Python 3.12.x
- Robot Framework 6.1.1+
- 相關 Python 套件：
  - robotframework-requests
  - robotframework-jsonlibrary
  - pyyaml

## 安裝步驟

### Windows
bash
安裝 Python 3.12.x
從 https://www.python.org/downloads/ 下載並安裝
安裝所需套件
pip install robotframework
pip install robotframework-requests
pip install robotframework-jsonlibrary
pip install pyyaml
### macOS
bash
使用 Homebrew 安裝 Python
brew install python@3.12
安裝所需套件
pip3 install robotframework
pip3 install robotframework-requests
pip3 install robotframework-jsonlibrary
pip3 install pyyaml
### Linux
bash
Ubuntu/Debian
sudo apt-get update
sudo apt-get install python3.12
安裝所需套件
pip3 install robotframework
pip3 install robotframework-requests
pip3 install robotframework-jsonlibrary
pip3 install pyyaml

## 配置文件說明
專案需要以下配置文件：
- `data.yaml`: 包含測試數據
- `qat_domain.yaml`: 包含域名配置
- `country.yaml`: 包含國家代碼配置

## 運行測試
bash
基本運行命令
robot TestCase/register/Register_API.robot
帶調試信息的運行命令
robot --loglevel DEBUG TestCase/register/Register_API.robot
指定輸出目錄
robot --outputdir results TestCase/register/Register_API.robot

## 測試案例說明

### 1. 郵箱格式驗證 [API-01-001]
- 驗證各種有效的郵箱格式
- 測試數據包括：gmail、yahoo、hotmail 等常見郵箱

### 2. 重複郵箱測試 [API-01-002]
- 驗證系統對重複郵箱的處理
- 確保已註冊的郵箱無法重複註冊

### 3. 手機號碼註冊測試 [API-01-003]
- 測試不同國家的手機號碼格式
- 包括香港、日本、美國等地區的號碼格式

### 4. 密碼驗證測試 [API-01-004]
- 測試密碼強度要求
- 驗證規則：
  - 最少 8 個字符
  - 必須包含大小寫字母
  - 必須包含數字

### 5. 用戶名驗證測試 [API-01-005]
- 測試用戶名格式要求
- 驗證規則：
  - 最少 3 個字符
  - 只允許字母、數字和下劃線
  - 不允許特殊字符和空格

### 6. 安全性測試 [API-01-006]
- SQL 注入防護測試
- 特殊字符處理測試

## 輸出結果
測試完成後會生成以下文件：
1. `output.xml`: 詳細的測試結果數據
2. `log.html`: 可視化的測試日誌
3. `report.html`: 測試報告摘要
4. `reports/register_api_report_[timestamp].txt`: 自定義測試報告

## 自定義報告內容
測試報告包含：
- 測試執行時間
- 測試案例總數
- 通過/失敗數量
- 性能指標
  - 平均響應時間
  - 最大/最小響應時間
  - 90th 百分位數據
- 安全性檢查結果

## 故障排除
常見問題：
1. 找不到配置文件
   - 確保 `data.yaml`、`qat_domain.yaml` 和 `country.yaml` 在正確路徑
2. 依賴項安裝失敗
   - 使用 `pip install -r requirements.txt` 重新安裝
3. 測試執行失敗
   - 檢查網絡連接
   - 確認 API 端點可訪問
   - 查看詳細日誌輸出

## 開發指南
如需添加新的測試案例：
1. 在 `Register_API.robot` 文件中添加新的測試案例
2. 遵循現有的命名規範 [API-XX-XXX]
3. 添加適當的標籤和文檔說明
4. 確保添加相應的驗證邏輯

## 維護說明
- 定期更新依賴項
- 檢查並更新測試數據
- 維護測試報告格式
- 根據 API 變化更新測試案例

## 注意事項
- 請勿在生產環境執行測試
- 確保測試數據的安全性
- 定期備份測試報告
- 遵循 Robot Framework 最佳實踐

## 聯繫方式
如有問題請聯繫Jason：crazy85128x@gmail.com

## 參考資料

### Robot Framework 官方資源
- [Robot Framework 官方文檔](https://robotframework.org/)
- [Robot Framework 用戶指南](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework API 測試庫](https://github.com/MarketSquare/robotframework-requests)

### API 測試相關資源
- [RESTful API 測試最佳實踐](https://www.soapui.org/learn/api/api-testing-101/)
- [API 測試完整指南](https://www.guru99.com/api-testing.html)
- [Postman Learning Center](https://learning.postman.com/)

### Robot Framework API 測試教學
- [Robot Framework 與 API 測試入門](https://testersdock.com/robot-framework-api-testing/)
- [使用 Robot Framework 進行 REST API 測試](https://medium.com/swlh/robot-framework-the-basics-dfeadc025bef)
- [RequestsLibrary 詳細使用指南](https://github.com/MarketSquare/robotframework-requests#readme)

### 實用工具和擴展
- [RESTinstance - Robot Framework REST API 測試庫](https://github.com/asyrjasalo/RESTinstance)
- [JSONLibrary 文檔](https://github.com/robotframework-thailand/robotframework-jsonlibrary)
- [Robot Framework 擴展集合](https://robotframework.org/#libraries)

### 社群資源
- [Robot Framework Slack 社群](https://robotframework.slack.com/)
- [Stack Overflow - Robot Framework 標籤](https://stackoverflow.com/questions/tagged/robot-framework)
- [GitHub - Robot Framework 組織](https://github.com/robotframework)

### 中文資源
- [Robot Framework 測試自動化入門](https://iter01.com/560889.html)
- [Robot Framework 中文教程](https://www.jianshu.com/p/3142d7c52d7e)
- [測試人社區 - Robot Framework 專欄](https://testerhome.com/topics/node78)