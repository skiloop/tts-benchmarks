#!/bin/bash
# 批量处理文本文件

set -e

# 创建示例文本文件
mkdir -p input_texts
cat > input_texts/text1.txt << 'EOF'
这是第一段测试文本。欢迎使用ChatTTS进行语音合成。
EOF

cat > input_texts/text2.txt << 'EOF'
这是第二段测试文本。它演示了如何批量处理多个文件。
EOF

cat > input_texts/text3.txt << 'EOF'
这是第三段测试文本。批量处理可以大大提高工作效率。
EOF

# 创建输出目录
mkdir -p output_audio

# 批量转换
echo "开始批量转换..."
counter=0
for input_file in input_texts/*.txt; do
    filename=$(basename "$input_file" .txt)
    output_file="output_audio/${filename}.wav"
    
    echo "处理: $input_file -> $output_file"
    chartts -f "$input_file" -o "$output_file"
    
    ((counter++))
done

echo
echo "完成！共处理 $counter 个文件"
echo "输出文件："
ls -lh output_audio/*.wav

# 清理（可选）
# rm -rf input_texts output_audio

