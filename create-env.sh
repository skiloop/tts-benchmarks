#!/usr/bin/env bash

# create different environments for different models with conda
. /usr/local/etc/profile.d/conda.sh
envs_path=${CONDA_PATH:-/usr/local/envs/}
neutts-air_path=${NEUTTS_AIR_PATH:-/content/neutts-air}
apt-get install -y espeak time

conda create -y -n chartts python=3.12 
$envs_path/chartts/bin/pip install
conda create -y -n coqui-tts python=3.10 
$envs_path/coqui-tts/bin/pip install TTS
# env for neutts-air and edge-tts
conda create -y -n neutts-air python=3.12 edge-tts fish-speech ffmpeg onnxruntime llama-cpp-python
$envs_path/neutts-air/bin/pip install -r ${neutts-air_path}/requirements.txt