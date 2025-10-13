# Installation Guide

## System Requirements

- **Operating System**: Linux, macOS, or Windows (WSL)
- **Python**: 3.8 or higher
- **Disk Space**: At least 2GB (for model files)
- **Memory**: 4GB+ recommended

## Installation Steps

### 1. Clone or Download Project

```bash
git clone <repository-url> tts-benchmarks
cd tts-benchmarks
```

Or if you already have the project files:

```bash
cd tts-benchmarks
```

### 2. Install Python Dependencies

#### Method A: Using pip (Recommended)

```bash
pip install -r requirements.txt
```

#### Method B: Using Virtual Environment (Safer)

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
# Linux/macOS:
source venv/bin/activate
# Windows (WSL):
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

#### Method C: Using conda

```bash
# Create conda environment
conda create -n tts-bench python=3.10
conda activate tts-bench

# Install dependencies
pip install -r requirements.txt
```

### 3. Install Command Line Tools

#### Default Installation (Recommended)

```bash
./install.sh
```

This will install tools to `~/.local/bin/`

#### Custom Installation Path

```bash
# Install to /usr/local/bin/
sudo DST_PATH=/usr/local/bin ./install.sh

# Or install to other directory
DST_PATH=/path/to/bin ./install.sh
```

### 4. Configure PATH (If Needed)

If using the default installation path, ensure `~/.local/bin` is in your PATH:

```bash
# Check PATH
echo $PATH | grep -q "$HOME/.local/bin" && echo "Already in PATH" || echo "Need to add to PATH"

# If needed, edit configuration file
# For bash users:
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# For zsh users:
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 5. Verify Installation

```bash
# Check if commands are available
which chartts
which perftest

# View version and help
chartts --help
perftest --help
```

### 6. First Run (Download Models)

On first use, ChatTTS will automatically download model files (a few hundred MB):

```bash
# Perform a simple test
chartts -t "Test installation" -o test.wav -v
```

Models will be downloaded to one of the following locations:
- `~/.cache/huggingface/`
- `~/.cache/ChatTTS/`

## Optional Dependencies

### GPU Acceleration (Recommended)

If you have an NVIDIA GPU:

```bash
# Install CUDA version of PyTorch
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

If you're using Apple Silicon (M1/M2/M3):

```bash
# PyTorch has built-in MPS support, no additional installation needed
# Use --device mps parameter
```

### Accelerated Inference (Optional)

```bash
# Install additional optimization libraries
pip install transformers>=4.30.0
pip install accelerate>=0.20.0
```

## Troubleshooting

### Issue 1: Command Not Found

**Symptom**: `chartts: command not found`

**Solutions**:
1. Confirm successful installation: `ls -la ~/.local/bin/chartts`
2. Check PATH: `echo $PATH`
3. Reload configuration: `source ~/.bashrc` or `source ~/.zshrc`
4. Or use full path: `~/.local/bin/chartts -t "test" -o test.wav`

### Issue 2: Import Error

**Symptom**: `ImportError: No module named 'ChatTTS'`

**Solutions**:
```bash
# Verify pip installation
pip list | grep -i chattts

# If not found, reinstall
pip install ChatTTS --upgrade

# Or install from source
pip install git+https://github.com/2noise/ChatTTS.git
```

### Issue 3: Model Download Failed

**Symptom**: Cannot connect to huggingface.co

**Solutions**:
```bash
# Set mirror (for users in mainland China)
export HF_ENDPOINT=https://hf-mirror.com

# Then retry
chartts -t "Test" -o test.wav
```

Or manually download models:
```bash
# Download models from mirror sites to local
# See ChatTTS documentation for details
```

### Issue 4: CUDA Error

**Symptom**: `CUDA out of memory` or `CUDA not available`

**Solutions**:
```bash
# Use CPU mode
chartts -t "Test" -o test.wav --device cpu

# Or check CUDA installation
python3 -c "import torch; print(torch.cuda.is_available())"
```

### Issue 5: Permission Denied

**Symptom**: `Permission denied`

**Solutions**:
```bash
# Add execute permission to scripts
chmod +x ~/.local/bin/chartts
chmod +x ~/.local/bin/perftest

# Or rerun installation
./install.sh
```

### Issue 6: Virtual Environment Issues

**Symptom**: Commands not found outside virtual environment

**Solutions**:
```bash
# Ensure in correct virtual environment
which python3

# Activate virtual environment
source venv/bin/activate  # or your virtual environment path

# Then use commands
chartts -t "Test" -o test.wav
```

## Uninstallation

```bash
# Remove command line tools
rm ~/.local/bin/chartts
rm ~/.local/bin/perftest

# Uninstall Python dependencies (optional)
pip uninstall ChatTTS torch torchaudio -y

# Delete cached models (optional)
rm -rf ~/.cache/huggingface/
rm -rf ~/.cache/ChatTTS/

# Delete project directory
cd ..
rm -rf tts-benchmarks
```

## Update

```bash
# Enter project directory
cd tts-benchmarks

# Pull latest code
git pull

# Update dependencies
pip install -r requirements.txt --upgrade

# Reinstall tools
./install.sh
```

## Next Steps

- Read [Quick Start Guide](QUICKSTART.md)
- View [Complete Documentation](README.md)
- Run tests: `./test_chartts.sh`
- View examples: `ls examples/`

## Get Help

If you encounter other issues:

1. View detailed logs: `chartts -t "test" -o test.wav -v`
2. Check dependency versions: `pip list`
3. View system information: `python3 --version && uname -a`
4. Submit an Issue (include the above information)
