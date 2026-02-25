FROM python:3.11-slim

WORKDIR /app

# 安装 Chromium 与运行时依赖（供 Playwright/Nodriver 在 Docker 中使用）
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-common \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcairo2 \
    libatspi2.0-0 \
    libgtk-3-0 \
    ca-certificates \
    fonts-liberation \
    fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# 预装 Playwright Chromium，避免运行时动态下载
RUN python -m playwright install chromium

COPY . .

EXPOSE 8000

CMD ["python", "main.py"]
