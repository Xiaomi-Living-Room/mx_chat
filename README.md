# 智能输入法App UI设计

这是基于需求文档设计的智能输入法App UI实现，使用Flutter框架开发。

## 项目结构

```
flutter_ui_design/
  ├── lib/                  # 源代码目录
  │   ├── main.dart         # 应用入口
  │   ├── screens/          # 屏幕页面
  │   │   ├── keyboard_screen.dart    # 键盘主界面
  │   │   └── settings_screen.dart    # 设置界面
  │   ├── widgets/          # 可复用组件
  │   │   ├── keyboard_widget.dart    # 键盘组件
  │   │   ├── candidate_bar.dart      # 候选词区域
  │   │   └── ai_reply_bar.dart       # AI推荐回复区域
  │   └── themes/           # 主题相关
  │       └── app_themes.dart         # 应用主题定义
  ├── assets/               # 资源文件
  │   └── images/           # 图片资源
  └── pubspec.yaml          # 项目依赖配置
```

## 功能特点

- 基础输入法键盘布局（QWERTY、九宫格）
- 候选词区域，支持左右滑动
- AI推荐回复区域，支持多条回复切换
- 多种预设主题（明亮、暗黑、蓝色、粉色等）
- 自定义主题设置
- 键盘设置（透明度、振动反馈等）
- AI助手设置（回复风格、数量等）

## 如何运行

1. 确保已安装Flutter开发环境
2. 克隆本仓库
3. 运行 `flutter pub get` 安装依赖
4. 运行 `flutter run` 启动应用

## 预览

可以通过运行应用查看UI设计效果，包括键盘布局、AI推荐回复、主题切换等功能。#   m x _ c h a t  
 #   m x _ c h a t  
 