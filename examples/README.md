# Example Scripts

This directory contains various example scripts demonstrating the usage of `chartts` and `perftest`.

## 📁 File List

### 1. simple_usage.sh
**Simple Usage Examples**

Demonstrates basic features of chartts:
- Basic text-to-speech
- Different speakers (voices)
- Parameter adjustment
- High-quality generation

**Usage:**
```bash
cd examples
./simple_usage.sh
```

### 2. batch_process.sh
**Batch Processing Example**

Demonstrates batch conversion of multiple text files:
- Auto-create test files
- Batch conversion
- Organize output files

**Usage:**
```bash
cd examples
./batch_process.sh
```

### 3. benchmark_comparison.sh
**Performance Comparison Example**

Demonstrates how to use perftest for performance benchmarking:
- Create test configuration
- Run performance tests
- Parse and display results

**Usage:**
```bash
cd examples
./benchmark_comparison.sh
```

## 🎯 Usage Tips

### 1. Select Best Speaker

Different speaker seeds produce different voices. You can test multiple:

```bash
for i in {1..10}; do
    speaker=$((RANDOM % 1000))
    chartts -t "Test voice" -o "voice_${speaker}.wav" --speaker $speaker
    echo "Generated speaker $speaker"
done
```

### 2. Batch Convert All Text Files in Directory

```bash
find /path/to/texts -name "*.txt" | while read file; do
    output="${file%.txt}.wav"
    chartts -f "$file" -o "$output"
done
```

### 3. Use Pipes for Processing

```bash
echo "This is a text" | while read line; do
    chartts -t "$line" -o "output.wav"
done
```

### 4. Parallel Processing (Acceleration)

```bash
# Using GNU parallel (if installed)
parallel -j 4 'chartts -f {} -o {.}.wav' ::: *.txt

# Or using xargs
ls *.txt | xargs -P 4 -I {} bash -c 'chartts -f "$1" -o "${1%.txt}.wav"' _ {}
```

### 5. Monitor Progress

```bash
total=$(ls *.txt | wc -l)
current=0

for file in *.txt; do
    ((current++))
    echo "[$current/$total] Processing: $file"
    chartts -f "$file" -o "${file%.txt}.wav"
done
```

### 6. Error Handling

```bash
for file in *.txt; do
    output="${file%.txt}.wav"
    if chartts -f "$file" -o "$output" 2>/dev/null; then
        echo "✓ $file"
    else
        echo "✗ $file failed" >&2
    fi
done
```

## 🔧 Custom Examples

### Create Your Own Benchmark Script

```bash
#!/bin/bash
# my_benchmark.sh

# Define test texts
texts=(
    "Short text test"
    "This is a medium length test text for evaluating performance"
    "This is a longer test text with more characters and complex sentence structures for comprehensive TTS system performance evaluation"
)

# Test different parameters
for temp in 0.1 0.3 0.5; do
    for i in "${!texts[@]}"; do
        echo "Testing: temp=$temp, text_length=${#texts[$i]}"
        chartts -t "${texts[$i]}" \
                -o "output_${temp}_${i}.wav" \
                --temperature $temp \
                -v
    done
done
```

### Integrate into CI/CD

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

## 📊 Result Analysis

### Analyze Results Using Python

```python
#!/usr/bin/env python3
import json
import matplotlib.pyplot as plt

# Read test results
with open('results.json') as f:
    data = json.load(f)

# Extract data
names = [r['name'] for r in data['results'] if r['success']]
times = [r['avg_real'] for r in data['results'] if r['success']]

# Create chart
plt.figure(figsize=(10, 6))
plt.bar(names, times)
plt.xlabel('Test Configuration')
plt.ylabel('Average Time (seconds)')
plt.title('TTS Performance Comparison')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig('benchmark_chart.png')
print("Chart saved to benchmark_chart.png")
```

## 🤝 Contributing New Examples

If you have useful example scripts, contributions are welcome!

1. Fork the project
2. Create your example script
3. Add to this README
4. Submit a Pull Request

## 📝 Notes

1. **Permissions**: Ensure scripts have execute permission (`chmod +x script.sh`)
2. **Paths**: Some examples may require path adjustments
3. **Resources**: Batch processing may require considerable time and disk space
4. **Cleanup**: Remember to clean up temporary files generated during testing

## 🔗 Related Links

- [Main Documentation](../README.md)
- [Quick Start Guide](../QUICKSTART.md)
- [Installation Guide](../INSTALL.md)
