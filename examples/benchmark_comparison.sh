#!/bin/bash
# 性能对比测试示例

set -e

# 测试文本
TEST_TEXT="这是一段用于性能测试的文本，包含足够的长度以便准确测量处理时间。"

echo "=== TTS性能对比测试 ==="
echo "测试文本: $TEST_TEXT"
echo

# 创建临时目录
TEMP_DIR="/tmp/tts_benchmark_$$"
mkdir -p "$TEMP_DIR"

echo "临时目录: $TEMP_DIR"
echo

# 测试不同配置的性能
echo "创建测试配置..."
cat > "$TEMP_DIR/benchmark.json" << EOF
{
  "description": "ChatTTS性能对比",
  "iterations": 5,
  "tests": [
    {
      "name": "默认配置",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/default.wav"
    },
    {
      "name": "低温度",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/low_temp.wav --temperature 0.1"
    },
    {
      "name": "高温度",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/high_temp.wav --temperature 0.5"
    },
    {
      "name": "使用refine",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/refine.wav --refine"
    },
    {
      "name": "CPU模式",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/cpu.wav --device cpu"
    }
  ]
}
EOF

# 运行性能测试
echo "运行性能测试..."
perftest -f "$TEMP_DIR/benchmark.json" -o "$TEMP_DIR/results.json" -v

echo
echo "结果已保存到: $TEMP_DIR/results.json"
echo

# 显示结果摘要
if [ -f "$TEMP_DIR/results.json" ]; then
    echo "=== 结果摘要 ==="
    python3 << 'PYTHON'
import json
import sys

try:
    with open(sys.argv[1], 'r') as f:
        data = json.load(f)
    
    print(f"测试时间: {data['timestamp']}")
    print(f"\n{'名称':<20} {'平均时间':<15} {'最小时间':<15} {'最大时间':<15}")
    print("-" * 70)
    
    for result in sorted(data['results'], key=lambda x: x['avg_real']):
        if result['success']:
            name = result['name'][:18] + '..' if len(result['name']) > 20 else result['name']
            print(f"{name:<20} {result['avg_real']:.3f}s {' '*8} {result['min_real']:.3f}s {' '*8} {result['max_real']:.3f}s")
    
except Exception as e:
    print(f"无法解析结果: {e}", file=sys.stderr)
PYTHON
    python3 - "$TEMP_DIR/results.json"
fi

# 清理（可选）
echo
read -p "是否删除临时文件？(y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$TEMP_DIR"
    echo "已清理临时文件"
else
    echo "临时文件保留在: $TEMP_DIR"
fi

