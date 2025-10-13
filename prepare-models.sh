#!/usr/bin/env bash

# Set environment variables for test text and reference files
TEST_TEXT="My name is Dave, and um, I'm from London"
REF_AUDIO=./samples/dave.wav
REF_TEXT="./samples/dave.txt"
REF_CODES="samples/dave.pt"

# Test with different configurations
conda activate neutts-air
python -m examples.onnx_example \
  --input_text $TEST_TEXT \
  --ref_codes $REF_CODES \
  --ref_text $REF_TEXT \
  --backbone neuphonic/neutts-air-q4-gguf
python -m examples.basic_example \
  --input_text $TEST_TEXT \
  --ref_audio $REF_AUDIO \
  --ref_text $REF_TEXT \
  --backbone neuphonic/neutts-air-q4-gguf
python -m examples.basic_example \
  --input_text $TEST_TEXT \
  --ref_audio $REF_AUDIO \
  --ref_text $REF_TEXT
python -m examples.onnx_example --input_text $TEST_TEXT --ref_audio $REF_AUDIO --ref_text $REF_TEXT --ref_codes $REF_CODES
conda activate chartts
chartts -t $TEST_TEXT -o output.wav
# coqui tts
conda activate coqui-tts
tts --text "$TEST_TEXT" --out_path output.wav
tts --test "$TEST_TEXT" --out_path output.wav --speaker_wav $REF_AUDIO --model_name tts_models/multilingual/multi-dataset