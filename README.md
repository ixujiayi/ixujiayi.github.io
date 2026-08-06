# ixujiayi.github.io

我的个人主页：**光影足迹** —— 可点击的中国省市交互摄影地图（基于 ECharts）。

## 本地预览

```powershell
# 方式一：Python
python -m http.server 8000

# 方式二：Node
npx serve .
```

浏览器打开 `http://localhost:8000` 即可。

## 目录结构

- `index.html` — 主页面（摄影地图 + 成长相册）
- `assets/growth/` — 成长相册图片（已压缩，懒加载）
- `scripts/backup.ps1` — 一键备份脚本（提交并推送当前改动）

## 技术说明

- ECharts 5.4.3 + 省市地图数据，CDN 优先 jsDelivr、npmmirror 兜底，增强国内访问稳定性
- 深色 / 浅色主题自动跟随系统，支持手动切换并记住偏好
- 相册图片懒加载，仓库内图片已压缩以加快页面打开速度
- 相册弹窗支持 Esc 关闭、焦点管理等无障碍细节

## 备份

运行 `scripts/backup.ps1` 会把当前改动提交（独立备份提交）并推送到 GitHub：

```powershell
powershell -ExecutionPolicy Bypass -File scripts\backup.ps1
```
