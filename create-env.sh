#!/usr/bin/env bash

# create different environments for different models with conda
neutts-air_path=${NEUTTS_AIR_PATH:-/content/neutts-air}
apt-get install -y espeak time

conda init
conda create -y -n chartts python=3.12 ChatTTS

conda create -y -n coqui-tts python=3.10 TTS

# env for neutts-air and edge-tts
conda create -y -n neutts-air python=3.12 edge-tts fish-speech ffmpeg onnxruntime llama-cpp-python
conda activate neutts-air
pip install $neutts-air_path/requirements.txt