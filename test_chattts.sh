#!/bin/bash
# ChatTTS Command Line Client Test Script

set -e

echo "=================================="
echo "ChatTTS Command Line Client Tests"
echo "=================================="
echo

# Check if chattts is available
if ! command -v chattts &> /dev/null; then
    echo "Error: chattts command not available"
    echo "Please run: ./install.sh"
    exit 1
fi

# Create temporary directory
TEST_DIR="/tmp/chattts_test_$$"
mkdir -p "$TEST_DIR"
echo "Test directory: $TEST_DIR"
echo

# Test 1: Basic text to speech
echo "Test 1: Basic text to speech"
chattts -t "Hello World" -o "$TEST_DIR/test1.wav" -v
if [ -f "$TEST_DIR/test1.wav" ]; then
    echo "✓ Test 1 passed"
else
    echo "✗ Test 1 failed"
    exit 1
fi
echo

# Test 2: Read from file
echo "Test 2: Read text from file"
echo "This is a test text to verify the file reading feature." > "$TEST_DIR/input.txt"
chattts -f "$TEST_DIR/input.txt" -o "$TEST_DIR/test2.wav" -v
if [ -f "$TEST_DIR/test2.wav" ]; then
    echo "✓ Test 2 passed"
else
    echo "✗ Test 2 failed"
    exit 1
fi
echo

# Test 3: Specify speaker
echo "Test 3: Custom speaker"
chattts -t "Test different voice" -o "$TEST_DIR/test3.wav" --speaker 123 -v
if [ -f "$TEST_DIR/test3.wav" ]; then
    echo "✓ Test 3 passed"
else
    echo "✗ Test 3 failed"
    exit 1
fi
echo

# Test 4: Adjust parameters
echo "Test 4: Adjust generation parameters"
chattts -t "Test parameter adjustment" -o "$TEST_DIR/test4.wav" --temperature 0.5 --top-p 0.8 -v
if [ -f "$TEST_DIR/test4.wav" ]; then
    echo "✓ Test 4 passed"
else
    echo "✗ Test 4 failed"
    exit 1
fi
echo

echo "=================================="
echo "All tests passed!"
echo "=================================="
echo
echo "Generated audio files:"
ls -lh "$TEST_DIR"/*.wav
echo
echo "Cleaning up test files..."
rm -rf "$TEST_DIR"
echo "Done!"
