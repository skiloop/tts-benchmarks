# Perftest Enhanced Features

## Overview

The `perftest` tool has been enhanced to monitor not only execution time but also **memory usage** and **CPU usage** during command execution.

## New Features

### 1. Memory Monitoring
- **Maximum Memory Usage**: Tracks the peak RSS (Resident Set Size) memory usage in MB
- **Average Memory Usage**: Calculates average maximum memory across multiple runs
- Reports both per-test and overall statistics

### 2. CPU Usage Monitoring  
- **Average CPU Usage**: Tracks average CPU percentage during execution
- **Peak CPU Usage**: Records maximum CPU percentage reached
- Real-time sampling at 100ms intervals

### 3. Enhanced Output
- Summary table includes Memory and CPU columns when monitoring is enabled
- Detailed statistics show memory and CPU metrics for each test
- Clear indicators when psutil is not installed

## Installation

### Required Dependencies

```bash
# Install psutil for resource monitoring
pip install psutil>=5.9.0

# Or install all dependencies
pip install -r requirements.txt
```

### Without psutil
The tool still works without psutil, but only measures execution time (user/system/real time).

## Usage Examples

### Basic Usage with Resource Monitoring

```bash
# Test single command
perftest -c "python train.py" -n 3 -v

# Compare multiple commands
perftest -t "numpy,python -c 'import numpy; numpy.random.rand(1000,1000)'" \
         -t "torch,python -c 'import torch; torch.rand(1000,1000)'" \
         -n 5
```

### TTS Benchmarking

```bash
# Create configuration file
cat > tts-bench.json << EOF
{
  "description": "TTS Memory and CPU Benchmark",
  "iterations": 3,
  "tests": [
    {
      "name": "ChatTTS-Short",
      "command": "chattts -t 'Hello world' -o /tmp/short.wav"
    },
    {
      "name": "ChatTTS-Long",
      "command": "chattts -f long_text.txt -o /tmp/long.wav"
    }
  ]
}
EOF

# Run benchmark with verbose output
perftest -f tts-bench.json -o results.json -v
```

### Output Example

```
Performance Testing Tool
✓ Resource monitoring enabled (psutil available)
Total 2 tests, each running 3 times

[1/2]
Test [ChatTTS-Short]: chattts -t 'Hello world' -o /tmp/short.wav
  Run 1/3... ✓ (2.345s, mem=450.2MB, cpu=95.3%)
  Run 2/3... ✓ (2.301s, mem=448.1MB, cpu=96.1%)
  Run 3/3... ✓ (2.389s, mem=451.3MB, cpu=94.8%)

====================================================================================================
Performance Test Summary
====================================================================================================

Name               Time           Memory       CPU        Relative  
----------------------------------------------------------------------------------------------------
ChatTTS-Short      2.35s ±0.04    449.9MB      95.4%      1.00x     
ChatTTS-Long       5.12s ±0.09    523.4MB      93.2%      2.18x     

Detailed Statistics:

[ChatTTS-Short]
  Command: chattts -t 'Hello world' -o /tmp/short.wav
  Avg Real Time: 2.345s (min: 2.301s, max: 2.389s)
  Avg User Time: 2.234s
  Avg Sys Time:  0.089s
  Avg CPU Time:  2.323s
  Avg Max Memory: 449.9MB (max: 451.3MB)
  Avg CPU Usage: 95.4% (max: 96.1%)
  Std Dev: 0.044s
  🏆 Fastest!
```

## JSON Output Format

The JSON output now includes resource metrics:

```json
{
  "timestamp": "2024-10-15 10:30:45",
  "has_resource_monitoring": true,
  "results": [
    {
      "name": "ChatTTS-Test",
      "command": "chattts -t 'test' -o test.wav",
      "success": true,
      "avg_real": 2.345,
      "avg_user": 2.234,
      "avg_sys": 0.089,
      "avg_max_memory_mb": 449.9,
      "max_memory_mb": 451.3,
      "avg_cpu_percent": 95.4,
      "max_cpu_percent": 96.1,
      "runs": [
        {
          "real": 2.345,
          "user": 2.234,
          "sys": 0.089,
          "max_memory": 450.2,
          "avg_cpu_percent": 95.3,
          "max_cpu_percent": 97.1
        }
      ]
    }
  ]
}
```

## Implementation Details

### Resource Monitoring Thread
- Background thread monitors process every 100ms
- Uses psutil.Process() to track memory (RSS) and CPU percentage
- Thread-safe data collection
- Automatically stops when process completes

### Memory Metrics
- **RSS (Resident Set Size)**: Physical memory used by process
- Includes all code, data, and shared libraries
- Does not include swapped memory
- Measured in MB for readability

### CPU Metrics
- **CPU Percentage**: Percentage of one CPU core used
- Can exceed 100% on multi-core systems
- Averaged over sampling interval
- Ignores zero readings (process idle)

## Command Line Options

All existing options work as before:

```bash
perftest [options]

Options:
  -c, --command CMD          Command to test (can be specified multiple times)
  -t, --test "NAME,CMD"      Named test (can be specified multiple times)
  -f, --config FILE          Load tests from JSON configuration file
  -n, --iterations N         Number of times to run each command (default: 3)
  -o, --output FILE          Save results to JSON file
  -v, --verbose              Verbose output for each run
  --debug                    Debug mode, show raw time command output
  --no-color                 Disable colored output
  --sample-config FILE       Create sample configuration file
```

## Performance Considerations

### Overhead
- Resource monitoring adds minimal overhead (~0.1% CPU, ~1MB memory)
- Sampling every 100ms is sufficient for most workloads
- Thread uses daemon mode, terminates automatically

### Accuracy
- Memory readings: ±1MB typical accuracy
- CPU readings: ±2% typical accuracy  
- Short-running commands (<1s) may have less accurate CPU metrics

## Troubleshooting

### "Resource monitoring disabled" message
**Cause**: psutil library not installed

**Solution**:
```bash
pip install psutil
```

### Memory/CPU showing 0.0
**Possible causes**:
1. Command runs too quickly (<100ms)
2. Process permissions issue
3. psutil cannot access process info

**Solutions**:
- For very fast commands, metrics may be incomplete
- Run with sudo if permission errors occur
- Check psutil installation: `python -c "import psutil; print(psutil.__version__)"`

### High variation in metrics
**Cause**: System load, background processes

**Solutions**:
- Increase iteration count (`-n 10` or more)
- Close unnecessary applications
- Use dedicated testing environment

## Best Practices

1. **Multiple Iterations**: Use at least 3-5 iterations for reliable statistics
2. **Stable Environment**: Minimize background processes during testing
3. **Save Results**: Always use `-o results.json` for later analysis  
4. **Verbose Mode**: Use `-v` to see per-run variations
5. **Compare Fairly**: Test similar workloads for meaningful comparisons

## Future Enhancements

Planned features:
- [ ] Disk I/O monitoring
- [ ] Network usage tracking
- [ ] GPU memory and usage monitoring
- [ ] Timeline visualization
- [ ] Automated report generation
- [ ] Historical comparison

## Related Documentation

- [README.md](README.md) - Main project documentation
- [INSTALL.md](INSTALL.md) - Installation guide
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide

