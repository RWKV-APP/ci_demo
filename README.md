# ci_demo

A demo project for CI/CD testing with Flutter.

## CI/CD Workflows

本项目配置了 GitHub Actions 来自动构建多平台应用：

### 构建平台

1. **Android APK** (`.github/workflows/build-android.yml`)
   - 自动构建 Release APK
   - 支持分支：main, master, dev
   - 支持手动触发 (workflow_dispatch)

2. **macOS 应用** (`.github/workflows/build-macos.yml`)
   - 自动构建 macOS .app 和 .dmg
   - 支持分支：main, master, dev
   - 支持手动触发 (workflow_dispatch)

3. **Windows EXE** (`.github/workflows/build-windows.yml`)
   - 自动构建 Windows 可执行文件
   - 支持分支：main, master, dev
   - 支持手动触发 (workflow_dispatch)

### 本地依赖处理

项目使用本地路径依赖 `rwkv_mobile_flutter`（位于 `../rwkv_mobile_flutter`），原因：
- 开发方便，可以快速迭代
- 远端依赖包含大量二进制文件（约 5-6GB），Git 仓库过大

在 CI/CD 环境中，workflow 会自动将本地 `path` 依赖转换为 `git` 依赖，使用：
- Git URL: `https://github.com/MollySophia/rwkv_mobile_flutter`
- 分支: `dev`

### 构建产物

所有构建产物会自动上传到 GitHub Actions Artifacts，保留 30 天。

### 手动触发构建

在 GitHub 仓库的 Actions 页面，可以选择对应的 workflow 并点击 "Run workflow" 手动触发构建。
