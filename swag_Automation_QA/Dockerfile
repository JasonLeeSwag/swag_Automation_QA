# 使用官方 Selenium Chrome 映像
FROM selenium/standalone-chrome:latest

# 切換到 root 用戶進行安裝
USER root

# 安裝 Python 和必要的工具
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-full \
    && rm -rf /var/lib/apt/lists/*

# 設置工作目錄
WORKDIR /app

# 創建並啟用虛擬環境
ENV VIRTUAL_ENV=/app/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 複製需要的檔案
COPY swag_Automation_QA /app/swag_Automation_QA

# 在虛擬環境中安裝依賴
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    selenium \
    requests \
    beautifulsoup4 \
    cryptography \
    httpx \
    pillow \
    psutil

# 設定環境變數
ENV PYTHONPATH=/app/swag_Automation_QA/keyword/swag
ENV DISPLAY=:99.0

# 切換回 seluser 用戶
USER seluser

# 設定啟動命令
CMD ["python", "-m", "robot", \
     "--variable", "BROWSER:chrome", \
     "--outputdir", "/app/results", \
     "--pythonpath", "/app/swag_Automation_QA/keyword/swag", \
     "--variablefile", "/app/swag_Automation_QA/data.yaml", \
     "--variablefile", "/app/swag_Automation_QA/qat_domain.yaml", \
     "--variablefile", "/app/swag_Automation_QA/country.yaml", \
     "-i", "login", "/app/swag_Automation_QA/TestCase"]