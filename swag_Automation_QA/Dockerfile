# 基於多架構支持的 Selenium 映像
FROM seleniarm/standalone-chrome:latest

# 安裝 Python 及其工具
RUN apt-get update && \
    apt-get install -y python3 python3-venv python3-pip && \
    pip install --upgrade pip setuptools

# 設定工作目錄
WORKDIR /app

# 複製項目文件到容器
COPY . /app

# 安裝 Python 依賴
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install robotframework-seleniumlibrary && \
    pip install -r swag_Automation_QA/requirements.txt

# 預設執行測試命令
CMD ["robot", \
     "-V", "swag_Automation_QA/data.yaml", \
     "-V", "swag_Automation_QA/qat_domain.yaml", \
     "-V", "swag_Automation_QA/country.yaml", \
     "--pythonpath", "swag_Automation_QA/keyword", \
     "-i", "login", \
     "swag_Automation_QA/TestCase"]