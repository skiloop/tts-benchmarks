# TTS Benchmarks

Text-to-Speech (TTS) project performance benchmarking toolkit.

## ✨ Features

- 🎯 **chartts**: ChatTTS command line client - Simple and easy-to-use CLI
- ⚡ **perftest**: Performance testing tool - Accurate comparison of different TTS engines
- 📊 Support for batch processing and automated testing
- 🔧 Rich configuration options and parameter tuning
- 📈 Detailed performance statistics and JSON output
- 🚀 Support for multiple devices: CPU/GPU/MPS

## Quick Start

```bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Install command line tools
./install.sh

# 3. Generate your first speech
chartts -t "Hello World" -o hello.wav

# 4. Run tests
./test_chartts.sh
```

For more information:
- 📖 [Installation Guide](INSTALL.md) - Detailed installation steps and troubleshooting
- 🚀 [Quick Start Guide](QUICKSTART.md) - Get started in 5 minutes
- 📁 [Example Scripts](examples/) - Practical examples collection

## Installation

### 1. Clone Repository

```bash
git clone <repository-url>
cd tts-benchmarks
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Install Command Line Tools

```bash
./install.sh
```

This will symlink all scripts to `~/.local/bin/` directory (ensure this directory is in your PATH).

You can also customize the installation path:

```bash
DST_PATH=/usr/local/bin ./install.sh
```

## Usage Guide

### ChatTTS Command Line Client

`chartts` provides a command line interface for ChatTTS, making it easy for benchmarking and batch processing.

#### Basic Usage

```bash
# Direct text input
chartts -t "Hello World" -o output.wav

# Read text from file
chartts -f input.txt -o output.wav

# Specify speaker (voice control)
chartts -t "Test speech" -o test.wav --speaker 123

# Adjust generation parameters
chartts -t "Test speech" -o test.wav --temperature 0.3 --top-p 0.7

# Use text refinement for better quality
chartts -t "High quality speech" -o high_quality.wav --refine

# Verbose output
chartts -t "Test" -o test.wav -v
```

#### Parameter Reference

**Input Arguments:**
- `-t, --text TEXT`: Text to convert
- `-f, --file FILE`: Input file containing text

**Output Arguments:**
- `-o, --output FILE`: Output audio file path (WAV format)

**ChatTTS Parameters:**
- `--speaker SEED`: Speaker seed for voice control (integer)
- `--temperature FLOAT`: Temperature parameter, controls randomness (default: 0.3)
- `--top-p FLOAT`: Top-P sampling parameter (default: 0.7)
- `--top-k INT`: Top-K sampling parameter (default: 20)
- `--refine`: Use text refinement to improve quality
- `--sample-rate INT`: Sample rate (default: 24000)

**Device Parameters:**
- `--device {auto,cpu,cuda,mps}`: Device to use (default: auto)
- `--compile`: Use torch.compile for acceleration (requires PyTorch 2.0+)

**Other Parameters:**
- `-v, --verbose`: Show verbose information

### Performance Testing Tool

`perftest` is used to test and compare the performance of multiple commands.

#### Basic Usage

```bash
# Test two commands
perftest -c "sleep 1" -c "sleep 0.5" -n 3

# Use configuration file
perftest -f config.json

# Create sample configuration file
perftest --sample-config perftest.json

# Specify command names
perftest -t "slow,sleep 1" -t "fast,sleep 0.5" -n 5 -v

# Save results
perftest -f config.json -o results.json
```

#### TTS Performance Benchmarking Example

Create a configuration file `tts-benchmark.json`:

```json
{
  "description": "TTS Engine Performance Benchmark",
  "iterations": 5,
  "tests": [
    {
      "name": "ChatTTS",
      "command": "chartts -t 'This is a test text' -o /tmp/chattts_test.wav"
    },
    {
      "name": "Other TTS Tool",
      "command": "other-tts -t 'This is a test text' -o /tmp/other_test.wav"
    }
  ]
}
```

Run the benchmark:

```bash
perftest -f tts-benchmark.json -o results.json
```

#### Parameter Reference

**Input Arguments:**
- `-c, --command CMD`: Command to test (can be specified multiple times)
- `-t, --test "NAME,CMD"`: Named test, format: "name,command" (can be specified multiple times)
- `-f, --config FILE`: Load tests from JSON configuration file

**Execution Parameters:**
- `-n, --iterations N`: Number of times to run each command (default: 3)
- `-v, --verbose`: Verbose output for each run
- `--debug`: Debug mode, show raw time command output

**Output Parameters:**
- `-o, --output FILE`: Save results to JSON file
- `--no-color`: Disable colored output

**Other Parameters:**
- `--sample-config FILE`: Create sample configuration file

## Development

### Adding New TTS Clients

1. Create a new executable script in the `scripts/` directory
2. Follow the interface design similar to `chartts`
3. Run `./install.sh` to install

### Project Structure

```
tts-benchmarks/
├── install.sh          # Installation script
├── requirements.txt    # Python dependencies
├── README.md          # This document
└── scripts/
    ├── chartts        # ChatTTS command line client
    └── perftest       # Performance testing tool
```

## Dependencies

- Python 3.8+
- PyTorch 2.0+
- ChatTTS
- torchaudio

See `requirements.txt` for details.

## License

[Add license information]

## Contributing

Issues and Pull Requests are welcome!

## Troubleshooting

### ChatTTS Model Download Issues

On first run, ChatTTS will automatically download model files (a few hundred MB). If network is poor:

1. Use a proxy
2. Manually download models to specified directory
3. Use domestic mirror sources

### Device Not Supported

If you encounter CUDA or MPS unavailable errors, force CPU mode with `--device cpu`:

```bash
chartts -t "Test" -o test.wav --device cpu
```

### Out of Memory

For large text segments:

1. Process in chunks
2. Use smaller batch sizes
3. Use CPU instead of GPU

## Related Links

- [ChatTTS GitHub](https://github.com/2noise/ChatTTS)
- [PyTorch](https://pytorch.org/)
