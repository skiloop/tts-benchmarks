# Quick Start Guide

## 1. Install Dependencies

```bash
# Install Python dependencies
pip install -r requirements.txt

# Install command line tools
./install.sh
```

## 2. Basic Usage

### Quick Test ChatTTS

```bash
# Simplest usage
chartts -t "Hello, this is a test" -o test.wav

# View generated file
ls -lh test.wav
```

### Specify Speaker (Voice)

```bash
# Different seed values will produce different voices
chartts -t "Test different voices" -o voice1.wav --speaker 100
chartts -t "Test different voices" -o voice2.wav --speaker 200
chartts -t "Test different voices" -o voice3.wav --speaker 300
```

### Batch Generate from Files

```bash
# Create text files
echo "This is the first text to be converted." > input1.txt
echo "This is the second text to be converted." > input2.txt

# Batch conversion
for i in input*.txt; do
    output="${i%.txt}.wav"
    chartts -f "$i" -o "$output"
    echo "Generated: $output"
done
```

## 3. Performance Benchmarking

### Run Benchmark Tests

```bash
# Use example configuration
perftest -f tts-benchmark-example.json -o benchmark-results.json

# View results
cat benchmark-results.json
```

### Custom Benchmarking

Create your own configuration file `my-benchmark.json`:

```json
{
  "description": "My TTS Benchmark",
  "iterations": 5,
  "tests": [
    {
      "name": "Short Text",
      "command": "chartts -t 'Hello' -o /tmp/short.wav"
    },
    {
      "name": "Medium Text",
      "command": "chartts -t 'This is a medium length test text for evaluating performance.' -o /tmp/medium.wav"
    },
    {
      "name": "Long Text",
      "command": "chartts -f long_text.txt -o /tmp/long.wav"
    }
  ]
}
```

Run the benchmark:

```bash
perftest -f my-benchmark.json -v -o my-results.json
```

## 4. Run Tests

```bash
# Run complete test suite
./test_chartts.sh
```

## 5. Advanced Usage

### Optimize Generation Quality

```bash
# Use text refinement
chartts -t "Need high quality speech output" -o high_quality.wav --refine

# Adjust temperature parameter (lower is more stable)
chartts -t "Stable speech" -o stable.wav --temperature 0.1

# Combined usage
chartts -t "Best quality" -o best.wav --refine --temperature 0.2 --speaker 42
```

### Specify Device

```bash
# Force CPU usage
chartts -t "Test" -o test.wav --device cpu

# Use GPU (if available)
chartts -t "Test" -o test.wav --device cuda

# Use Apple Silicon GPU
chartts -t "Test" -o test.wav --device mps

# Auto-select best device (default)
chartts -t "Test" -o test.wav --device auto
```

### Accelerate Generation

```bash
# Use torch.compile for acceleration (requires PyTorch 2.0+)
chartts -t "Test" -o test.wav --compile
```

## 6. Common Issues

### First Run is Slow

On first run, ChatTTS needs to download model files (a few hundred MB), which is normal. Subsequent runs will be much faster.

### Device Not Supported

If you encounter CUDA or MPS unavailable errors, use `--device cpu` to force CPU mode:

```bash
chartts -t "Test" -o test.wav --device cpu
```

### Out of Memory

If you encounter memory issues:

1. Use CPU mode: `--device cpu`
2. Process long text in segments
3. Close other memory-intensive programs

### Command Not Found

Ensure `~/.local/bin` is in your PATH:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# Reload configuration
source ~/.bashrc  # or source ~/.zshrc
```

## 7. Script Integration

Use in your own scripts:

```bash
#!/bin/bash

# Text-to-speech function
text_to_speech() {
    local text="$1"
    local output="$2"
    
    if chartts -t "$text" -o "$output" 2>/dev/null; then
        echo "Success: $output"
        return 0
    else
        echo "Failed: $text" >&2
        return 1
    fi
}

# Usage example
text_to_speech "Hello World" "output.wav"
```

## 8. Python Integration

If you need to use in Python:

```python
import subprocess
import sys

def generate_speech(text, output_path, **kwargs):
    """Generate speech using chartts"""
    cmd = ['chartts', '-t', text, '-o', output_path]
    
    # Add optional parameters
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
        print(f"Error: {e.stderr}", file=sys.stderr)
        return False

# Usage example
if generate_speech("Hello World", "output.wav", speaker=42, temperature=0.3):
    print("Generation successful!")
```

## 9. Next Steps

### For Beginners
1. Read [QUICKSTART.md](QUICKSTART.md)
2. Run `./test_chartts.sh`
3. Try `./examples/simple_usage.sh`

### For Intermediate Users
1. Read the complete [README.md](README.md) documentation
2. Customize `tts-benchmark-example.json`
3. Write your own batch processing scripts

### For Advanced Users
1. Study `scripts/chartts` source code
2. Integrate into your own projects
3. Contribute new features or examples

## 10. Get Help

```bash
# View chartts help
chartts --help

# View perftest help
perftest --help

# Verbose output (for debugging)
chartts -t "Test" -o test.wav -v
```
