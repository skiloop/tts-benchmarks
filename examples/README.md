# 示例脚本

这个目录包含了各种使用 `chartts` 和 `perftest` 的示例脚本。

## 📁 文件列表

### 1. simple_usage.sh
**简单使用示例**

演示 chartts 的基本功能：
- 基本文本转语音
- 不同说话人（音色）
- 参数调整
- 高质量生成

**使用方法：**
```bash
cd examples
./simple_usage.sh
```

### 2. batch_process.sh
**批量处理示例**

演示如何批量转换多个文本文件：
- 自动创建测试文件
- 批量转换
- 组织输出文件

**使用方法：**
```bash
cd examples
./batch_process.sh
```

### 3. benchmark_comparison.sh
**性能对比示例**

演示如何使用 perftest 进行性能测评：
- 创建测试配置
- 运行性能测试
- 解析和显示结果

**使用方法：**
```bash
cd examples
./benchmark_comparison.sh
```

## 🎯 使用技巧

### 1. 选择最佳说话人

不同的说话人种子会产生不同的音色，你可以测试多个：

```bash
for i in {1..10}; do
    speaker=$((RANDOM % 1000))
    chartts -t "测试音色" -o "voice_${speaker}.wav" --speaker $speaker
    echo "生成了说话人 $speaker"
done
```

### 2. 批量转换目录中的所有文本文件

```bash
find /path/to/texts -name "*.txt" | while read file; do
    output="${file%.txt}.wav"
    chartts -f "$file" -o "$output"
done
```

### 3. 使用管道处理

```bash
echo "这是一段文本" | while read line; do
    chartts -t "$line" -o "output.wav"
done
```

### 4. 并行处理（加速）

```bash
# 使用 GNU parallel（如果安装了）
parallel -j 4 'chartts -f {} -o {.}.wav' ::: *.txt

# 或使用 xargs
ls *.txt | xargs -P 4 -I {} bash -c 'chartts -f "$1" -o "${1%.txt}.wav"' _ {}
```

### 5. 监控进度

```bash
total=$(ls *.txt | wc -l)
current=0

for file in *.txt; do
    ((current++))
    echo "[$current/$total] 处理: $file"
    chartts -f "$file" -o "${file%.txt}.wav"
done
```

### 6. 错误处理

```bash
for file in *.txt; do
    output="${file%.txt}.wav"
    if chartts -f "$file" -o "$output" 2>/dev/null; then
        echo "✓ $file"
    else
        echo "✗ $file 失败" >&2
    fi
done
```

## 🔧 自定义示例

### 创建自己的测评脚本

```bash
#!/bin/bash
# my_benchmark.sh

# 定义测试文本
texts=(
    "短文本测试"
    "这是一个中等长度的测试文本，用于评估性能"
    "这是一个更长的测试文本，包含了更多的字符和更复杂的句子结构，用于全面评估TTS系统的性能表现"
)

# 测试不同参数
for temp in 0.1 0.3 0.5; do
    for i in "${!texts[@]}"; do
        echo "测试: temp=$temp, text_length=${#texts[$i]}"
        chartts -t "${texts[$i]}" \
                -o "output_${temp}_${i}.wav" \
                --temperature $temp \
                -v
    done
done
```

### 集成到CI/CD

```yaml
# .github/workflows/tts-test.yml
name: TTS Performance Test

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          ./install.sh
      - name: Run benchmark
        run: |
          perftest -f tts-benchmark-example.json -o results.json
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: benchmark-results
          path: results.json
```

## 📊 结果分析

### 使用Python分析结果

```python
#!/usr/bin/env python3
import json
import matplotlib.pyplot as plt

# 读取测试结果
with open('results.json') as f:
    data = json.load(f)

# 提取数据
names = [r['name'] for r in data['results'] if r['success']]
times = [r['avg_real'] for r in data['results'] if r['success']]

# 绘制图表
plt.figure(figsize=(10, 6))
plt.bar(names, times)
plt.xlabel('测试配置')
plt.ylabel('平均时间 (秒)')
plt.title('TTS性能对比')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig('benchmark_chart.png')
print("图表已保存到 benchmark_chart.png")
```

## 🤝 贡献新示例

如果你有有用的示例脚本，欢迎贡献！

1. Fork 项目
2. 创建你的示例脚本
3. 添加到这个 README
4. 提交 Pull Request

## 📝 注意事项

1. **权限**: 确保脚本有执行权限（`chmod +x script.sh`）
2. **路径**: 某些示例可能需要调整路径
3. **资源**: 批量处理可能需要较多时间和磁盘空间
4. **清理**: 记得清理测试生成的临时文件

## 🔗 相关链接

- [主文档](../README.md)
- [快速入门](../QUICKSTART.md)
- [安装说明](../INSTALL.md)

