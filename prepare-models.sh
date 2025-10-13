#!/usr/bin/env bash

# Set environment variables for test text and reference files
. /usr/local/etc/profile.d/conda.sh
PATH=$PATH:$HOME/.local/bin
TEST_TEXT="My name is Dave, and um, I'm from London"
REF_AUDIO=./samples/dave.wav
REF_TEXT="./samples/dave.txt"
REF_CODES="samples/dave.pt"
envs_path=${CONDA_PATH:-/usr/local/envs/}
# Test with different configurations
$envs_path/neutts-air/bin/python -m examples.onnx_example \
  --input_text "$TEST_TEXT" \
  --ref_codes $REF_CODES \
  --ref_text $REF_TEXT \
  --backbone neuphonic/neutts-air-q4-gguf
$envs_path/neutts-air/bin/python -m examples.basic_example \
  --input_text "$TEST_TEXT" \
  --ref_audio $REF_AUDIO \
  --ref_text $REF_TEXT \
  --backbone neuphonic/neutts-air-q4-gguf
$envs_path/neutts-air/bin/python -m examples.basic_example \
  --input_text "$TEST_TEXT" \
  --ref_audio $REF_AUDIO \
  --ref_text $REF_TEXT
$envs_path/neutts-air/bin/python -m examples.onnx_example --input_text "$TEST_TEXT" --ref_audio $REF_AUDIO --ref_text $REF_TEXT --ref_codes $REF_CODES
chartts -t "$TEST_TEXT" -o output.wav
# coqui tts
$envs_path/coqui-tts/bin/tts --text "$TEST_TEXT" --out_path output.wav
$envs_path/coqui-tts/bin/tts --test "$TEST_TEXT" --out_path output.wav --speaker_wav $REF_AUDIO --model_name tts_models/multilingual/multi-dataset