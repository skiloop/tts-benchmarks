#!/bin/bash
# Performance Benchmark Comparison Example

set -e

# Test text
TEST_TEXT="This is a text for performance testing, with sufficient length to accurately measure processing time."

echo "=== TTS Performance Comparison Test ==="
echo "Test text: $TEST_TEXT"
echo

# Create temporary directory
TEMP_DIR="/tmp/tts_benchmark_$$"
mkdir -p "$TEMP_DIR"

echo "Temporary directory: $TEMP_DIR"
echo

# Test different configurations for performance
echo "Creating test configuration..."
cat > "$TEMP_DIR/benchmark.json" << EOF
{
  "description": "ChatTTS Performance Comparison",
  "iterations": 5,
  "tests": [
    {
      "name": "Default Config",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/default.wav"
    },
    {
      "name": "Low Temperature",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/low_temp.wav --temperature 0.1"
    },
    {
      "name": "High Temperature",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/high_temp.wav --temperature 0.5"
    },
    {
      "name": "With Refine",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/refine.wav --refine"
    },
    {
      "name": "CPU Mode",
      "command": "chartts -t '$TEST_TEXT' -o $TEMP_DIR/cpu.wav --device cpu"
    }
  ]
}
EOF

# Run performance test
echo "Running performance test..."
perftest -f "$TEMP_DIR/benchmark.json" -o "$TEMP_DIR/results.json" -v

echo
echo "Results saved to: $TEMP_DIR/results.json"
echo

# Display result summary
if [ -f "$TEMP_DIR/results.json" ]; then
    echo "=== Result Summary ==="
    python3 << 'PYTHON'
import json
import sys

try:
    with open(sys.argv[1], 'r') as f:
        data = json.load(f)
    
    print(f"Test time: {data['timestamp']}")
    print(f"\n{'Name':<20} {'Avg Time':<15} {'Min Time':<15} {'Max Time':<15}")
    print("-" * 70)
    
    for result in sorted(data['results'], key=lambda x: x['avg_real']):
        if result['success']:
            name = result['name'][:18] + '..' if len(result['name']) > 20 else result['name']
            print(f"{name:<20} {result['avg_real']:.3f}s {' '*8} {result['min_real']:.3f}s {' '*8} {result['max_real']:.3f}s")
    
except Exception as e:
    print(f"Cannot parse results: {e}", file=sys.stderr)
PYTHON
    python3 - "$TEMP_DIR/results.json"
fi

# Cleanup (optional)
echo
read -p "Delete temporary files? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$TEMP_DIR"
    echo "Temporary files cleaned up"
else
    echo "Temporary files kept in: $TEMP_DIR"
fi
