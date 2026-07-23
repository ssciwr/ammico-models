# ammico-models
Repository hosting the docker setup for the models served for ammico.

Run the image locally using 
```
docker run --rm --gpus all -p 8000:8000 -p 8001:8001 --shm-size=8g -v ~/.cache/huggingface:/root/.cache/huggingface -e LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu:/usr/local/nvidia/lib64:/usr/local/cuda/lib64" ammico-models
```
