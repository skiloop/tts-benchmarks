# 安装说明

## 系统要求

- **操作系统**: Linux, macOS, 或 Windows (WSL)
- **Python**: 3.8 或更高版本
- **磁盘空间**: 至少 2GB（用于模型文件）
- **内存**: 推荐 4GB+

## 安装步骤

### 1. 克隆或下载项目

```bash
git clone <repository-url> tts-benchmarks
cd tts-benchmarks
```

或者如果你已经有项目文件：

```bash
cd tts-benchmarks
```

### 2. 安装Python依赖

#### 方法 A: 使用pip（推荐）

```bash
pip install -r requirements.txt
```

#### 方法 B: 使用虚拟环境（更安全）

```bash
# 创建虚拟环境
python3 -m venv venv

# 激活虚拟环境
# Linux/macOS:
source venv/bin/activate
# Windows (WSL):
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt
```

#### 方法 C: 使用conda

```bash
# 创建conda环境
conda create -n tts-bench python=3.10
conda activate tts-bench

# 安装依赖
pip install -r requirements.txt
```

### 3. 安装命令行工具

#### 默认安装（推荐）

```bash
./install.sh
```

这会将工具安装到 `~/.local/bin/`

#### 自定义安装路径

```bash
# 安装到 /usr/local/bin/
sudo DST_PATH=/usr/local/bin ./install.sh

# 或安装到其他目录
DST_PATH=/path/to/bin ./install.sh
```

### 4. 配置PATH（如果需要）

如果使用默认安装路径，确保 `~/.local/bin` 在你的 PATH 中：

```bash
# 检查PATH
echo $PATH | grep -q "$HOME/.local/bin" && echo "已在PATH中" || echo "需要添加到PATH"

# 如果需要添加，编辑配置文件
# 对于bash用户：
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 对于zsh用户：
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 5. 验证安装

```bash
# 检查命令是否可用
which chartts
which perftest

# 查看版本和帮助
chartts --help
perftest --help
```

### 6. 首次运行（下载模型）

首次使用时，ChatTTS会自动下载模型文件（约几百MB）：

```bash
# 进行一次简单测试
chartts -t "测试安装" -o test.wav -v
```

模型会被下载到以下位置之一：
- `~/.cache/huggingface/`
- `~/.cache/ChatTTS/`

## 可选依赖

### GPU加速（推荐）

如果你有NVIDIA GPU：

```bash
# 安装CUDA版本的PyTorch
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

如果你使用Apple Silicon (M1/M2/M3):

```bash
# PyTorch已内置MPS支持，无需额外安装
# 使用 --device mps 参数即可
```

### 加速推理（可选）

```bash
# 安装额外的优化库
pip install transformers>=4.30.0
pip install accelerate>=0.20.0
```

## 故障排除

### 问题1: 找不到命令

**症状**: `chartts: command not found`

**解决方案**:
1. 确认安装成功：`ls -la ~/.local/bin/chartts`
2. 检查PATH：`echo $PATH`
3. 重新加载配置：`source ~/.bashrc` 或 `source ~/.zshrc`
4. 或使用完整路径：`~/.local/bin/chartts -t "test" -o test.wav`

### 问题2: 导入错误

**症状**: `ImportError: No module named 'ChatTTS'`

**解决方案**:
```bash
# 确认pip安装成功
pip list | grep -i chattts

# 如果没有，重新安装
pip install ChatTTS --upgrade

# 或从源码安装
pip install git+https://github.com/2noise/ChatTTS.git
```

### 问题3: 模型下载失败

**症状**: 无法连接到 huggingface.co

**解决方案**:
```bash
# 设置镜像（中国大陆用户）
export HF_ENDPOINT=https://hf-mirror.com

# 然后重试
chartts -t "测试" -o test.wav
```

或者手动下载模型：
```bash
# 从镜像站下载模型到本地
# 详见 ChatTTS 文档
```

### 问题4: CUDA错误

**症状**: `CUDA out of memory` 或 `CUDA not available`

**解决方案**:
```bash
# 使用CPU模式
chartts -t "测试" -o test.wav --device cpu

# 或检查CUDA安装
python3 -c "import torch; print(torch.cuda.is_available())"
```

### 问题5: 权限错误

**症状**: `Permission denied`

**解决方案**:
```bash
# 给脚本添加执行权限
chmod +x ~/.local/bin/chartts
chmod +x ~/.local/bin/perftest

# 或重新运行安装
./install.sh
```

### 问题6: 虚拟环境问题

**症状**: 在虚拟环境外找不到命令

**解决方案**:
```bash
# 确保在正确的虚拟环境中
which python3

# 激活虚拟环境
source venv/bin/activate  # 或你的虚拟环境路径

# 然后使用命令
chartts -t "测试" -o test.wav
```

## 卸载

```bash
# 删除命令行工具
rm ~/.local/bin/chartts
rm ~/.local/bin/perftest

# 卸载Python依赖（可选）
pip uninstall ChatTTS torch torchaudio -y

# 删除缓存的模型（可选）
rm -rf ~/.cache/huggingface/
rm -rf ~/.cache/ChatTTS/

# 删除项目目录
cd ..
rm -rf tts-benchmarks
```

## 更新

```bash
# 进入项目目录
cd tts-benchmarks

# 拉取最新代码
git pull

# 更新依赖
pip install -r requirements.txt --upgrade

# 重新安装工具
./install.sh
```

## 下一步

- 阅读 [快速入门指南](QUICKSTART.md)
- 查看 [完整文档](README.md)
- 运行测试：`./test_chartts.sh`
- 查看示例：`ls examples/`

## 获取帮助

如果遇到其他问题：

1. 查看详细日志：`chartts -t "test" -o test.wav -v`
2. 检查依赖版本：`pip list`
3. 查看系统信息：`python3 --version && uname -a`
4. 提交Issue（包含以上信息）

