#!/bin/bash
# ChatTTS Simple Usage Examples

# Basic usage
echo "=== Basic Usage ==="
chattts -t "Hello, welcome to ChatTTS command line tool" -o demo1.wav -v
echo

# Different speakers (voices)
echo "=== Different Speakers ==="
for speaker in 42 100 200; do
    echo "Speaker $speaker:"
    chattts -t "This is the voice of speaker ${speaker}" -o "speaker_${speaker}.wav" --speaker $speaker
done
echo

# Different parameter settings
echo "=== Different Parameter Settings ==="
chattts -t "Stable voice" -o stable.wav --temperature 0.1
chattts -t "Diverse voice" -o diverse.wav --temperature 0.5
echo

# Use refine for better quality
echo "=== High Quality Generation ==="
chattts -t "This is high quality speech output" -o high_quality.wav --refine -v
echo

echo "Done! Generated files:"
ls -lh *.wav
