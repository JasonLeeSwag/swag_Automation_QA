# 使用 Playwright 作為基礎映像
FROM mcr.microsoft.com/playwright:focal

# 設定工作目錄
WORKDIR /app

# 安裝基本套件
RUN apt-get update && apt-get install -y \
    python3-pip \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# 複製 requirements.txt 檔案
COPY requirements.txt .

# 安裝 Python 相依套件
RUN pip3 install --no-cache-dir -r requirements.txt

# 複製專案所有檔案
COPY . .

# 設定虛擬顯示器環境變數
ENV DISPLAY=:99

# 設定預設的測試類型環境變數
ENV TEST_TYPE=bvt

# 設定容器啟動指令
# 使用 xvfb-run 執行無頭瀏覽器測試
# 測試類型可以透過環境變數 TEST_TYPE 進行覆寫
CMD xvfb-run --server-args='-screen 0 1920x1080x24' \
    robot \
    -V data.yaml \
    -V country.yaml \
    -V qat_domain.yaml \
    -i ${TEST_TYPE} \
    TestCase