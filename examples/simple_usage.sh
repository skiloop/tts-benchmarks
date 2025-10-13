#!/bin/bash
# ChatTTS 简单使用示例

# 基本使用
echo "=== 基本使用 ==="
chartts -t "你好，欢迎使用ChatTTS命令行工具" -o demo1.wav -v
echo

# 不同的说话人（音色）
echo "=== 不同说话人 ==="
for speaker in 42 100 200; do
    echo "说话人 $speaker:"
    chartts -t "这是说话人${speaker}的声音" -o "speaker_${speaker}.wav" --speaker $speaker
done
echo

# 不同的参数设置
echo "=== 不同参数设置 ==="
chartts -t "稳定的声音" -o stable.wav --temperature 0.1
chartts -t "多样的声音" -o diverse.wav --temperature 0.5
echo

# 使用refine提高质量
echo "=== 高质量生成 ==="
chartts -t "这是高质量的语音输出" -o high_quality.wav --refine -v
echo

echo "完成！生成的文件："
ls -lh *.wav

