# TTS Benchmarks

TTS（Text-to-Speech）项目性能测评工具集。

## 功能

- **chartts**: ChatTTS 命令行客户端
- **perftest**: 性能测试工具，用于比较不同TTS引擎的性能

## 安装

### 1. 克隆仓库

```bash
git clone <repository-url>
cd tts-benchmarks
```

### 2. 安装依赖

```bash
pip install -r requirements.txt
```

### 3. 安装命令行工具

```bash
./install.sh
```

这会将所有脚本链接到 `~/.local/bin/` 目录（确保该目录在你的 PATH 中）。

你也可以自定义安装路径：

```bash
DST_PATH=/usr/local/bin ./install.sh
```

## 使用说明

### ChatTTS 命令行客户端

`chartts` 提供了 ChatTTS 的命令行接口，方便测评和批量处理。

#### 基本用法

```bash
# 直接输入文本
chartts -t "你好世界" -o output.wav

# 从文件读取文本
chartts -f input.txt -o output.wav

# 指定说话人（控制音色）
chartts -t "测试语音" -o test.wav --speaker 123

# 调整生成参数
chartts -t "测试语音" -o test.wav --temperature 0.3 --top-p 0.7

# 使用文本优化提高质量
chartts -t "高质量语音" -o high_quality.wav --refine

# 详细输出
chartts -t "测试" -o test.wav -v
```

#### 参数说明

**输入参数：**
- `-t, --text TEXT`: 要转换的文本
- `-f, --file FILE`: 包含文本的输入文件

**输出参数：**
- `-o, --output FILE`: 输出音频文件路径（WAV格式）

**ChatTTS 参数：**
- `--speaker SEED`: 说话人种子，用于控制音色（整数）
- `--temperature FLOAT`: 温度参数，控制生成的随机性（默认: 0.3）
- `--top-p FLOAT`: Top-P采样参数（默认: 0.7）
- `--top-k INT`: Top-K采样参数（默认: 20）
- `--refine`: 使用refine文本以提高质量
- `--sample-rate INT`: 采样率（默认: 24000）

**设备参数：**
- `--device {auto,cpu,cuda,mps}`: 使用的设备（默认: auto）
- `--compile`: 使用torch.compile加速（需要PyTorch 2.0+）

**其他参数：**
- `-v, --verbose`: 显示详细信息

### 性能测试工具

`perftest` 用于测试和比较多个命令的性能。

#### 基本用法

```bash
# 测试两个命令
perftest -c "sleep 1" -c "sleep 0.5" -n 3

# 使用配置文件
perftest -f config.json

# 创建示例配置文件
perftest --sample-config perftest.json

# 指定命令名称
perftest -t "slow,sleep 1" -t "fast,sleep 0.5" -n 5 -v

# 保存结果
perftest -f config.json -o results.json
```

#### TTS 性能测评示例

创建一个配置文件 `tts-benchmark.json`:

```json
{
  "description": "TTS引擎性能测评",
  "iterations": 5,
  "tests": [
    {
      "name": "ChatTTS",
      "command": "chartts -t '这是一个测试文本' -o /tmp/chattts_test.wav"
    },
    {
      "name": "其他TTS工具",
      "command": "other-tts -t '这是一个测试文本' -o /tmp/other_test.wav"
    }
  ]
}
```

运行测评：

```bash
perftest -f tts-benchmark.json -o results.json
```

#### 参数说明

**输入参数：**
- `-c, --command CMD`: 要测试的命令（可多次指定）
- `-t, --test "NAME,CMD"`: 命名测试，格式: "名称,命令"（可多次指定）
- `-f, --config FILE`: 从 JSON 配置文件加载测试

**运行参数：**
- `-n, --iterations N`: 每个命令运行的次数（默认: 3）
- `-v, --verbose`: 详细输出每次运行的结果
- `--debug`: 调试模式，显示 time 命令的原始输出

**输出参数：**
- `-o, --output FILE`: 保存结果到 JSON 文件
- `--no-color`: 禁用彩色输出

**其他参数：**
- `--sample-config FILE`: 创建示例配置文件

## 开发

### 添加新的TTS客户端

1. 在 `scripts/` 目录创建新的可执行脚本
2. 遵循类似 `chartts` 的接口设计
3. 运行 `./install.sh` 安装

### 项目结构

```
tts-benchmarks/
├── install.sh          # 安装脚本
├── requirements.txt    # Python依赖
├── README.md          # 本文档
└── scripts/
    ├── chartts        # ChatTTS命令行客户端
    └── perftest       # 性能测试工具
```

## 依赖

- Python 3.8+
- PyTorch 2.0+
- ChatTTS
- torchaudio

详见 `requirements.txt`

## 许可证

[添加许可证信息]

## 贡献

欢迎提交 Issue 和 Pull Request！

## 故障排除

### ChatTTS 模型下载问题

首次使用时，ChatTTS 会自动下载模型。如果网络不佳，可以：

1. 使用代理
2. 手动下载模型到指定目录
3. 使用国内镜像源

### 设备不支持问题

如果遇到CUDA或MPS不可用的错误，使用 `--device cpu` 强制使用CPU：

```bash
chartts -t "测试" -o test.wav --device cpu
```

### 内存不足

对于大段文本，可以：

1. 分段处理
2. 使用更小的batch size
3. 使用CPU而非GPU

## 相关链接

- [ChatTTS GitHub](https://github.com/2noise/ChatTTS)
- [PyTorch](https://pytorch.org/)

