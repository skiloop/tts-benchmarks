#!/usr/bin/env bash

# create different environments for different models with conda
neutts-air_path=${NEUTTS_AIR_PATH:-/content/neutts-air}

conda create -n chartts python=3.12
conda activate chartts
pip install ChatTTS

conda create -n coqui-tts python=3.10
conda activate coqui-tts
pip install TTS

# env for neutts-air and edge-tts
conda create -n neutts-air python=3.12
conda activate neutts-air
apt-get install -y espeak time ffmpeg
pip install $neutts-air/requirements.txt
pip install llama-cpp-python onnxruntime edge-tts