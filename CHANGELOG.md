# 更新日志

## [1.0.0] - 2024-10-13

### 新增功能

#### ChatTTS 命令行客户端 (`chartts`)
- ✨ 完整的命令行接口，支持文本转语音
- 📝 支持从命令行参数或文件读取文本
- 🎤 支持自定义说话人（音色控制）
- 🔧 支持调整温度、Top-P、Top-K等参数
- ✨ 支持文本优化（refine）提高质量
- 💻 支持多种设备：CPU、CUDA、MPS（Apple Silicon）
- 🚀 支持torch.compile加速
- 📊 支持自定义采样率
- 🐛 详细的错误处理和调试输出

#### 性能测试工具 (`perftest`)
- ⚡ 使用 /usr/bin/time 进行精确的性能测量
- 📊 支持多个命令的并行测试
- 📈 详细的统计信息（平均、最小、最大、标准差）
- 💾 支持JSON格式输出测试结果
- 🎨 彩色终端输出，清晰的可视化
- 📝 支持从JSON配置文件加载测试
- 🔄 支持多次迭代测试

### 文档

- 📖 完整的 README.md 文档
- 🚀 QUICKSTART.md 快速入门指南
- 💿 INSTALL.md 详细安装说明
- 📋 CHANGELOG.md 更新日志

### 示例

- 📁 `examples/simple_usage.sh` - 简单使用示例
- 📁 `examples/batch_process.sh` - 批量处理示例
- 📁 `examples/benchmark_comparison.sh` - 性能对比示例
- 📁 `tts-benchmark-example.json` - 测评配置示例

### 测试

- ✅ `test_chartts.sh` - 完整的功能测试脚本

### 工具

- 🔧 `install.sh` - 自动安装脚本
- 📦 `requirements.txt` - Python依赖管理

### 项目结构

```
tts-benchmarks/
├── README.md                       # 项目主文档
├── QUICKSTART.md                   # 快速入门指南
├── INSTALL.md                      # 安装说明
├── CHANGELOG.md                    # 更新日志
├── install.sh                      # 安装脚本
├── requirements.txt                # Python依赖
├── test_chartts.sh                 # 测试脚本
├── tts-benchmark-example.json      # 测评配置示例
├── .gitignore                      # Git忽略文件
├── scripts/
│   ├── chartts                     # ChatTTS命令行客户端
│   └── perftest                    # 性能测试工具
└── examples/
    ├── simple_usage.sh             # 简单使用示例
    ├── batch_process.sh            # 批量处理示例
    └── benchmark_comparison.sh     # 性能对比示例
```

## 未来计划

### 短期计划 (v1.1.0)
- [ ] 添加更多TTS引擎的命令行客户端
- [ ] 支持更多音频格式（MP3、FLAC等）
- [ ] 添加音频后处理功能（降噪、标准化等）
- [ ] Web界面支持

### 中期计划 (v1.2.0)
- [ ] 支持流式音频生成
- [ ] 添加语音克隆功能
- [ ] 多语言支持
- [ ] Docker容器化

### 长期计划 (v2.0.0)
- [ ] 分布式测试支持
- [ ] 自动化CI/CD集成
- [ ] 详细的测评报告生成
- [ ] 数据库存储测试结果

## 贡献者

- [@skiloop](https://github.com/skiloop) - 项目创建者和主要维护者

## 反馈和建议

如有任何问题、建议或功能请求，欢迎：
1. 提交 GitHub Issue
2. 提交 Pull Request
3. 联系维护者

---

**注**: 本项目遵循[语义化版本](https://semver.org/)规范。

