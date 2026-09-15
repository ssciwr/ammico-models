FROM vllm/vllm-openai:v0.15.1

RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

RUN git clone https://github.com/speaches-ai/speaches.git /opt/speaches
WORKDIR /opt/speaches
RUN uv python install && uv venv && uv sync
RUN uv pip install nvidia-cudnn-cu12 nvidia-cublas-cu12

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
