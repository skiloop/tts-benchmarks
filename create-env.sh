#!/usr/bin/env bash

# create different environments for different models with conda
. /usr/local/etc/profile.d/conda.sh
envs_path=${CONDA_PATH:-/usr/local/envs/}
neutts_air_path=${NEUTTS_AIR_PATH:-/content/neutts-air}
apt-get install -y espeak time

conda create -y -n chattts python=3.12 
$envs_path/chattts/bin/pip install ChatTTS transformers==4.53.2
conda create -y -n coqui-tts python=3.9
$envs_path/coqui-tts/bin/pip install TTS transformers==4.53.2
# env for neutts-air and edge-tts
conda create -y -n neutts-air python=3.12 ffmpeg onnxruntime llama-cpp-python pyaudio
$envs_path/neutts-air/bin/pip install -r ${neutts_air_path}/requirements.txt
$envs_path/neutts-air/bin/pip install edge-tts fish-speech