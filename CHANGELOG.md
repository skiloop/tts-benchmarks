# Changelog

## [1.0.0] - 2024-10-13

### New Features

#### ChatTTS Command Line Client (`chattts`)
- ✨ Complete command line interface supporting text-to-speech
- 📝 Support reading text from command line arguments or files
- 🎤 Support custom speaker (voice control)
- 🔧 Support adjusting temperature, Top-P, Top-K and other parameters
- ✨ Support text refinement to improve quality
- 💻 Support multiple devices: CPU, CUDA, MPS (Apple Silicon)
- 🚀 Support torch.compile acceleration
- 📊 Support custom sample rate
- 🐛 Detailed error handling and debug output

#### Performance Testing Tool (`perftest`)
- ⚡ Precise performance measurement using /usr/bin/time
- 📊 Support parallel testing of multiple commands
- 📈 Detailed statistics (average, min, max, standard deviation)
- 💾 Support JSON format output for test results
- 🎨 Colored terminal output with clear visualization
- 📝 Support loading tests from JSON configuration files
- 🔄 Support multiple iteration testing
- 🔍 **NEW: Memory and CPU usage monitoring**
  - Automatic GNU time -v detection and parsing (Linux)
  - Real-time resource monitoring with psutil (cross-platform)
  - Accurate memory usage tracking (peak RSS in MB)
  - CPU percentage monitoring (average and peak)
  - Smart fallback: GNU time > psutil > time-only
  - Platform-aware: Uses gtime on macOS, /usr/bin/time on Linux

### Documentation

- 📖 Complete README.md documentation (English)
- 🚀 QUICKSTART.md quick start guide (English)
- 💿 INSTALL.md detailed installation guide (English)
- 📋 CHANGELOG.md changelog (English)
- 📋 PROJECT_SUMMARY.md project summary (English)
- 📋 PERFTEST_FEATURES.md perftest features and usage guide
- 🌍 **All documentation fully translated to English**

### Examples

- 📁 `examples/simple_usage.sh` - Simple usage examples
- 📁 `examples/batch_process.sh` - Batch processing examples
- 📁 `examples/benchmark_comparison.sh` - Performance comparison examples
- 📁 `tts-benchmark-example.json` - Benchmark configuration example

### Tests

- ✅ `test_chattts.sh` - Complete functional test script

### Tools

- 🔧 `install.sh` - Automated installation script
- 📦 `requirements.txt` - Python dependency management
  - Added psutil>=5.9.0 for resource monitoring

### Project Structure

```
tts-benchmarks/
├── README.md                       # Main project documentation
├── QUICKSTART.md                   # Quick start guide
├── INSTALL.md                      # Installation guide
├── CHANGELOG.md                    # Changelog
├── PROJECT_SUMMARY.md              # Project summary
├── PERFTEST_FEATURES.md            # Perftest features guide
├── install.sh                      # Installation script
├── requirements.txt                # Python dependencies
├── test_chattts.sh                 # Test script
├── tts-benchmark-example.json      # Benchmark configuration example
├── .gitignore                      # Git ignore file
├── scripts/
│   ├── chattts                     # ChatTTS command line client
│   └── perftest                    # Performance testing tool with resource monitoring
└── examples/
    ├── README.md                   # Examples documentation
    ├── simple_usage.sh             # Simple usage example
    ├── batch_process.sh            # Batch processing example
    └── benchmark_comparison.sh     # Performance comparison example
```

### Technical Improvements

#### Resource Monitoring System
- **GNU Time Integration**: Full support for GNU time -v verbose output parsing
  - Extracts: User time, System time, Elapsed time, Max memory (RSS), CPU percentage
  - Handles multiple time formats: h:mm:ss.ss, m:ss.ss, 0:ss.ss
  - Platform detection: Uses gtime on macOS, /usr/bin/time on Linux
- **psutil Integration**: Real-time process monitoring (100ms sampling)
  - Memory tracking: Peak RSS in MB
  - CPU monitoring: Average and peak percentage
  - Background thread for continuous monitoring
- **Smart Fallback System**: Automatic detection and prioritization
  1. GNU time -v (most accurate, kernel-level)
  2. psutil (good fallback, real-time sampling)
  3. Time-only mode (basic timing)

#### Code Quality
- All code comments and documentation in English
- Enhanced error handling and user feedback
- Cross-platform compatibility (Linux, macOS)
- Comprehensive debug mode for troubleshooting

### Performance Metrics Output

#### Terminal Output
```
Name               Time           Memory       CPU        Relative  
--------------------------------------------------------------------
ChatTTS            2.35s ±0.04    449.9MB      95.0%      1.00x     
```

#### JSON Output
```json
{
  "avg_max_memory_mb": 449.9,
  "max_memory_mb": 451.3,
  "avg_cpu_percent": 95.0,
  "max_cpu_percent": 96.0
}
```

## Future Plans

### Short-term Plans (v1.1.0)
- [ ] Add command line clients for more TTS engines
- [ ] Support more audio formats (MP3, FLAC, etc.)
- [ ] Add audio post-processing features (noise reduction, normalization, etc.)
- [ ] Web interface support
- [x] Memory and CPU monitoring in perftest
- [x] GNU time integration
- [x] Full English documentation

### Mid-term Plans (v1.2.0)
- [ ] Extended GNU time metrics (I/O, page faults, context switches)
- [ ] GPU memory and usage monitoring
- [ ] Support streaming audio generation
- [ ] Add voice cloning features
- [ ] Docker containerization
- [ ] Historical performance comparison

### Long-term Plans (v2.0.0)
- [ ] Distributed testing support
- [ ] Automated CI/CD integration
- [ ] Detailed benchmark report generation
- [ ] Database storage for test results

## Contributors

- [@skiloop](https://github.com/skiloop) - Project creator and main maintainer

## Feedback and Suggestions

For any questions, suggestions, or feature requests:
1. Submit a GitHub Issue
2. Submit a Pull Request
3. Contact the maintainer

---

**Note**: This project follows [Semantic Versioning](https://semver.org/) specification.
