# common
Robot Framework Library

## Page、element 分類方式
- 每個網頁可定義為 page class 檔案，存放至 page 分類資料夾下
- 每一 page 檔案可在開頭宣告一個 dictionary ( 與 page 檔案同名 ) 存放該 page 定位用的 element name / xpath( 或其他定位方式 ex : CSS )
- 為避免與 page 同名的 dictionary 過於膨脹，應把 element 以所屬區塊、元件作為區別進行分類標示，分屬到有良好命名的不同 dictionary。例如 : 網頁上的彈出視窗可在 page 檔案裡獨立定義一個 dictionary、頁首或頁尾也可在 page 檔案裡分別定義一個 dictionary
- 若一個元件 ( 區塊 ) 會在多頁裡顯示或共用，則應該把此元件 ( 區塊 ) 獨立成檔，存放至 component 分類資料夾下

## Page 通用 element 命名
- 網頁 URL 統一取做 url
- 網頁 ```<title>``` 統一取做 title
- 網頁標題 統一取做 page_heading
- 網頁中文名稱屬性 統一取做 page_name ( 宣告用，方便中文 keyword 參考 )
- 一個區塊或元件的 container 統一取做 box ( 通常判斷整個元件是否已顯示 )
- 表格內每一列 container 統一取做 rows
- "看起來"像超連結的 element，統一取做 XXX_link
- "看起來"像 button 的 element，統一取做 XXX_btn

## Form element 命名
- 需要輸入唯一值的欄位，統一取做 XXX_input
- 可進行選擇 ( 不管單選複選 ) 操作的 element，統一取做 XXX_option
- 確定送出表單資料的 button，統一取做 submit_btn ( 不管 btn 上的顯示文字 )
- 如果依照上述 dictionary 分類規則進行實作，一個 dictionary 應該只會有一個 submit_btn

## 中文命名相關
- Click Element 的動作，中文動詞統一使用 點擊
- Click Element 來進行選擇的動作，中文動詞統一使用 點選 ( 不管是 checkbox 或 radio button )
- 常用中文動詞： 前往 ( Go To )、取得 ( Get )、設定 ( Set )、檢查 ( Check )、確認 ( Confirm )、
- 回傳布林值的 keyword，統一取名格式為 : 判斷...是否...

## 實作 Page Object 模式的原則
- 各 page keyword 目前認識的 Global 常數只有 Domain 的 BASE_URL 和辨認環境用的 ENV，由指令將 yaml 設定檔帶入
- 各 page keyword 內不應有其他特定測試情境資料的預設輸入 ( 僅上述的 BASE_URL 和 ENV 可直接存在於 page 檔案內 )
- page 檔案裡的 element 應該只會在該 page 檔案裡使用，對檔案外的使用一律由 keyword 存取
- 避免在 page 層次使用 Set Test Variable、Set Suite Variable、Set Global Variable

## Keyword 實作相關
- 盡量參數化為原則，使用變數取代 hard coding
- 考慮此 keyword 的實作內容和使用層次，命名須適當的抽象化
- 對 element 進行操作前應先確定已有 Wait 動作，確認該 element 已載入 or 已顯示 ( 盡量用等的 Wait Until...， 而不是 Sleep )
- 帶有換頁功能的 keyword 命名應盡量把換頁資訊帶出來
- 實作會對頁面顯示或狀態造成影響的功能 keyword 時，需考量是否該讓此 keyword 負擔驗證的責任，例如使用 Wait Until Element Is Not Visible, Wait Until Page Does Not Contain Element, etc. 確保此 keyword 回傳前執行結果 ( 結果可能是 component 已關閉、未顯示或網頁已換頁 ) 是符合預期的 
- 也就是說須妥善處理測試與測試 ( keyword 與 keyword ) 之間的分界，盡可能達成若是功能測試 fail，則測試報告變紅色的項目就是對應到執行此功能的 keyword，而不是"完全"交由問題發生後的下一個接續執行 keyword 來偵測狀態不如預期

## Test Case 實作相關
- 需要測試資料或情境，請在 Test Setup 建立與 Test Teardown 刪除 ( 恢復 ) 資料，盡量不要讓 test cases 有相依性
- Setup 與 Teardown 不擇手段成功即可，並不一定要透過 UI 操作來達成
- 如果測試在特定環境無法執行請加上 Tag ( notProduction、notStaging、notDev )
- Test case 層級的命名以 Tell what, not how 為原則
- 讓 Test Case 的步驟有自我描述的能力，非必要不使用 document/comment
- 使用 Set Test Variable、Set Suite Variable 所設定的變數，請先宣告在檔案 Variable 區塊

## 參考資料
- [Xpath Wiki](https://zh.wikipedia.org/wiki/XPath)
- [Martin Fowler, __*Page Object*__ ](https://martinfowler.com/bliki/PageObject.html) ( [簡中翻譯](http://huangbowen.net/blog/2013/09/17/page-object/) )
- [Dale H. Emery, __*Writing Maintainable Automated Acceptance Tests*__](http://dhemery.com/pdf/writing_maintainable_automated_acceptance_tests.pdf)
- [Robot Framework User Guide](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [How to write good test cases using Robot Framework](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst)
- [推薦部落格](http://teddy-chen-tw.blogspot.com/2013/07/bdd1.html)
