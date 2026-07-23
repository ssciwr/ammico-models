#!/bin/bash
set -e

vllm serve Qwen/Qwen2.5-VL-3B-Instruct \
  --port 8000 --max-model-len 32768 --gpu-memory-utilization 0.65 &

# stagger start: let vllm claim its memory fraction before whisper loads,
# avoids both processes profiling against the full 16GB at once
sleep 15

cd /opt/speaches
source .venv/bin/activate

CUDNN_LIB=$(python -c "import nvidia.cudnn as m; print(list(m.__path__)[0])")/lib
CUBLAS_LIB=$(python -c "import nvidia.cublas as m; print(list(m.__path__)[0])")/lib
export LD_LIBRARY_PATH="${CUDNN_LIB}:${CUBLAS_LIB}:${LD_LIBRARY_PATH}"

WHISPER__MODEL=Systran/faster-whisper-large-v3 \
WHISPER__INFERENCE_DEVICE=cuda \
PRELOAD_MODELS='["Systran/faster-whisper-large-v3"]' \
  uvicorn --factory --host 0.0.0.0 --port 8001 speaches.main:create_app &

wait -n
exit $?
