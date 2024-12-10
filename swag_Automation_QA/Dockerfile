# 基於官方的 Python 映像
FROM python:3.12-slim

# 安裝基礎依賴和 Chrome 瀏覽器
RUN apt-get update && apt-get install -y \
    wget unzip xvfb google-chrome-stable libnss3 libxss1 libgconf-2-4 \
    && apt-get clean

# 安裝 ChromeDriver
RUN CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE") && \
    wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip

# 設定虛擬環境
WORKDIR /swag_Automation_QA
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# 複製檔案並安裝依賴
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製專案檔案
COPY . .

# 預設執行指令
ENTRYPOINT ["/bin/bash"]
