# Changelog

## [1.0.0] - 2024-10-13

### New Features

#### ChatTTS Command Line Client (`chartts`)
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

### Documentation

- 📖 Complete README.md documentation
- 🚀 QUICKSTART.md quick start guide
- 💿 INSTALL.md detailed installation guide
- 📋 CHANGELOG.md changelog

### Examples

- 📁 `examples/simple_usage.sh` - Simple usage examples
- 📁 `examples/batch_process.sh` - Batch processing examples
- 📁 `examples/benchmark_comparison.sh` - Performance comparison examples
- 📁 `tts-benchmark-example.json` - Benchmark configuration example

### Tests

- ✅ `test_chartts.sh` - Complete functional test script

### Tools

- 🔧 `install.sh` - Automated installation script
- 📦 `requirements.txt` - Python dependency management

### Project Structure

```
tts-benchmarks/
├── README.md                       # Main project documentation
├── QUICKSTART.md                   # Quick start guide
├── INSTALL.md                      # Installation guide
├── CHANGELOG.md                    # Changelog
├── install.sh                      # Installation script
├── requirements.txt                # Python dependencies
├── test_chartts.sh                 # Test script
├── tts-benchmark-example.json      # Benchmark configuration example
├── .gitignore                      # Git ignore file
├── scripts/
│   ├── chartts                     # ChatTTS command line client
│   └── perftest                    # Performance testing tool
└── examples/
    ├── simple_usage.sh             # Simple usage example
    ├── batch_process.sh            # Batch processing example
    └── benchmark_comparison.sh     # Performance comparison example
```

## Future Plans

### Short-term Plans (v1.1.0)
- [ ] Add command line clients for more TTS engines
- [ ] Support more audio formats (MP3, FLAC, etc.)
- [ ] Add audio post-processing features (noise reduction, normalization, etc.)
- [ ] Web interface support

### Mid-term Plans (v1.2.0)
- [ ] Support streaming audio generation
- [ ] Add voice cloning features
- [ ] Multi-language support
- [ ] Docker containerization

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
