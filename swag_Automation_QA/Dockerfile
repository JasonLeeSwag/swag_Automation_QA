# 使用官方 Selenium Chrome 映像
FROM selenium/standalone-chrome:latest

# 切換到 root 用戶進行安裝
USER root

# 安裝 Python 和必要的工具
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# 設置工作目錄
WORKDIR /app

# 複製需要的檔案
COPY swag_Automation_QA/requirements.txt /app/requirements.txt

# 創建並啟用虛擬環境，安裝依賴
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    selenium

# 創建必要的目錄結構
RUN mkdir -p /app/swag_Automation_QA/keyword/swag/

# 建立 Swag.sources.robot 文件
RUN echo '*** Settings ***\n\
Library    SeleniumLibrary\n\
\n\
*** Keywords ***\n\
開啟Chrome瀏覽器\n\
    ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()\n\
    Call Method    ${chrome_options}    add_argument    --no-sandbox\n\
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage\n\
    Create Webdriver    Chrome    chrome_options=${chrome_options}\n\
    Set Window Size    1920    1080\n\
\n\
關閉所有瀏覽器\n\
    Close All Browsers' > /app/swag_Automation_QA/keyword/swag/Swag.sources.robot

# 切換回 seluser 用戶
USER seluser

# 設定環境變數
ENV PYTHONPATH=/app/swag_Automation_QA/keyword/swag
ENV DISPLAY=:99.0

# 設定容器啟動命令
CMD ["robot", "--version"]