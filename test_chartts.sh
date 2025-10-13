#!/bin/bash
# ChatTTS 命令行客户端测试脚本

set -e

echo "=================================="
echo "ChatTTS 命令行客户端测试"
echo "=================================="
echo

# 检查 chartts 是否可用
if ! command -v chartts &> /dev/null; then
    echo "错误: chartts 命令不可用"
    echo "请先运行: ./install.sh"
    exit 1
fi

# 创建临时目录
TEST_DIR="/tmp/chartts_test_$$"
mkdir -p "$TEST_DIR"
echo "测试目录: $TEST_DIR"
echo

# 测试1: 基本文本转语音
echo "测试1: 基本文本转语音"
chartts -t "你好世界" -o "$TEST_DIR/test1.wav" -v
if [ -f "$TEST_DIR/test1.wav" ]; then
    echo "✓ 测试1通过"
else
    echo "✗ 测试1失败"
    exit 1
fi
echo

# 测试2: 从文件读取
echo "测试2: 从文件读取文本"
echo "这是一段测试文本，用于验证从文件读取功能。" > "$TEST_DIR/input.txt"
chartts -f "$TEST_DIR/input.txt" -o "$TEST_DIR/test2.wav" -v
if [ -f "$TEST_DIR/test2.wav" ]; then
    echo "✓ 测试2通过"
else
    echo "✗ 测试2失败"
    exit 1
fi
echo

# 测试3: 指定说话人
echo "测试3: 指定说话人"
chartts -t "测试不同的音色" -o "$TEST_DIR/test3.wav" --speaker 123 -v
if [ -f "$TEST_DIR/test3.wav" ]; then
    echo "✓ 测试3通过"
else
    echo "✗ 测试3失败"
    exit 1
fi
echo

# 测试4: 调整参数
echo "测试4: 调整生成参数"
chartts -t "测试参数调整" -o "$TEST_DIR/test4.wav" --temperature 0.5 --top-p 0.8 -v
if [ -f "$TEST_DIR/test4.wav" ]; then
    echo "✓ 测试4通过"
else
    echo "✗ 测试4失败"
    exit 1
fi
echo

echo "=================================="
echo "所有测试通过！"
echo "=================================="
echo
echo "生成的音频文件："
ls -lh "$TEST_DIR"/*.wav
echo
echo "清理测试文件..."
rm -rf "$TEST_DIR"
echo "完成！"

