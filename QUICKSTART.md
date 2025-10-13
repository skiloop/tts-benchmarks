# 快速入门指南

## 1. 安装依赖

```bash
# 安装Python依赖
pip install -r requirements.txt

# 安装命令行工具
./install.sh
```

## 2. 基本使用

### 快速测试 ChatTTS

```bash
# 最简单的使用
chartts -t "你好，这是一个测试" -o test.wav

# 查看生成的文件
ls -lh test.wav
```

### 指定说话人（音色）

```bash
# 使用不同的种子值会产生不同的音色
chartts -t "测试不同音色" -o voice1.wav --speaker 100
chartts -t "测试不同音色" -o voice2.wav --speaker 200
chartts -t "测试不同音色" -o voice3.wav --speaker 300
```

### 从文件批量生成

```bash
# 创建文本文件
echo "这是第一段要转换的文本。" > input1.txt
echo "这是第二段要转换的文本。" > input2.txt

# 批量转换
for i in input*.txt; do
    output="${i%.txt}.wav"
    chartts -f "$i" -o "$output"
    echo "生成: $output"
done
```

## 3. 性能测评

### 运行基准测试

```bash
# 使用示例配置
perftest -f tts-benchmark-example.json -o benchmark-results.json

# 查看结果
cat benchmark-results.json
```

### 自定义测评

创建你自己的配置文件 `my-benchmark.json`:

```json
{
  "description": "我的TTS测评",
  "iterations": 5,
  "tests": [
    {
      "name": "短文本",
      "command": "chartts -t '你好' -o /tmp/short.wav"
    },
    {
      "name": "中等文本",
      "command": "chartts -t '这是一段中等长度的测试文本，用于评估性能。' -o /tmp/medium.wav"
    },
    {
      "name": "长文本",
      "command": "chartts -f long_text.txt -o /tmp/long.wav"
    }
  ]
}
```

运行测评：

```bash
perftest -f my-benchmark.json -v -o my-results.json
```

## 4. 运行测试

```bash
# 运行完整的测试套件
./test_chartts.sh
```

## 5. 高级用法

### 优化生成质量

```bash
# 使用文本优化
chartts -t "需要高质量的语音输出" -o high_quality.wav --refine

# 调整温度参数（越低越稳定）
chartts -t "稳定的语音" -o stable.wav --temperature 0.1

# 组合使用
chartts -t "最佳质量" -o best.wav --refine --temperature 0.2 --speaker 42
```

### 指定设备

```bash
# 强制使用CPU
chartts -t "测试" -o test.wav --device cpu

# 使用GPU（如果可用）
chartts -t "测试" -o test.wav --device cuda

# 使用Apple Silicon GPU
chartts -t "测试" -o test.wav --device mps

# 自动选择最佳设备（默认）
chartts -t "测试" -o test.wav --device auto
```

### 加速生成

```bash
# 使用torch.compile加速（需要PyTorch 2.0+）
chartts -t "测试" -o test.wav --compile
```

## 6. 常见问题

### 首次运行很慢

首次运行时，ChatTTS需要下载模型文件（约几百MB），这是正常的。后续运行会快很多。

### 内存不足

如果遇到内存问题，可以：

1. 使用CPU模式：`--device cpu`
2. 分段处理长文本
3. 关闭其他占用内存的程序

### 找不到命令

确保 `~/.local/bin` 在你的 PATH 中：

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# 重新加载配置
source ~/.bashrc  # 或 source ~/.zshrc
```

## 7. 脚本集成

在你自己的脚本中使用：

```bash
#!/bin/bash

# 文本转语音函数
text_to_speech() {
    local text="$1"
    local output="$2"
    
    if chartts -t "$text" -o "$output" 2>/dev/null; then
        echo "成功: $output"
        return 0
    else
        echo "失败: $text" >&2
        return 1
    fi
}

# 使用示例
text_to_speech "你好世界" "output.wav"
```

## 8. Python集成

如果需要在Python中使用：

```python
import subprocess
import sys

def generate_speech(text, output_path, **kwargs):
    """使用chartts生成语音"""
    cmd = ['chartts', '-t', text, '-o', output_path]
    
    # 添加可选参数
    if 'speaker' in kwargs:
        cmd.extend(['--speaker', str(kwargs['speaker'])])
    if 'temperature' in kwargs:
        cmd.extend(['--temperature', str(kwargs['temperature'])])
    if kwargs.get('refine', False):
        cmd.append('--refine')
    
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"错误: {e.stderr}", file=sys.stderr)
        return False

# 使用示例
if generate_speech("你好世界", "output.wav", speaker=42, temperature=0.3):
    print("生成成功！")
```

## 9. 下一步

- 查看完整文档：[README.md](README.md)
- 了解性能测试工具：`perftest --help`
- 了解ChatTTS客户端：`chartts --help`
- 探索更多配置选项
- 比较不同TTS引擎的性能

## 10. 获取帮助

```bash
# 查看chartts帮助
chartts --help

# 查看perftest帮助
perftest --help

# 详细输出（用于调试）
chartts -t "测试" -o test.wav -v
```

