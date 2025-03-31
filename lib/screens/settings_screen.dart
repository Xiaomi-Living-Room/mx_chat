import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;
  KeyboardTheme _keyboardTheme = AppThemes.lightKeyboardTheme;
  double _keyboardOpacity = 1.0;
  bool _vibrationEnabled = true;
  double _vibrationIntensity = 0.5;
  bool _soundEnabled = true;
  double _soundVolume = 0.5;

  ThemeData get themeData => _themeData;
  KeyboardTheme get keyboardTheme => _keyboardTheme;
  double get keyboardOpacity => _keyboardOpacity;
  bool get vibrationEnabled => _vibrationEnabled;
  double get vibrationIntensity => _vibrationIntensity;
  bool get soundEnabled => _soundEnabled;
  double get soundVolume => _soundVolume;

  void setTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        _themeData = AppThemes.lightTheme;
        _keyboardTheme = AppThemes.lightKeyboardTheme;
        break;
      case ThemeType.dark:
        _themeData = AppThemes.darkTheme;
        _keyboardTheme = AppThemes.darkKeyboardTheme;
        break;
      case ThemeType.blue:
        _themeData = AppThemes.blueTheme;
        _keyboardTheme = AppThemes.blueKeyboardTheme;
        break;
      case ThemeType.pink:
        _themeData = AppThemes.pinkTheme;
        _keyboardTheme = AppThemes.pinkKeyboardTheme;
        break;
    }
    notifyListeners();
  }

  void setKeyboardOpacity(double opacity) {
    _keyboardOpacity = opacity;
    notifyListeners();
  }

  void setVibrationEnabled(bool enabled) {
    _vibrationEnabled = enabled;
    notifyListeners();
  }

  void setVibrationIntensity(double intensity) {
    _vibrationIntensity = intensity;
    notifyListeners();
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    notifyListeners();
  }

  void setSoundVolume(double volume) {
    _soundVolume = volume;
    notifyListeners();
  }
}

enum ThemeType { light, dark, blue, pink }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '基本设置'),
            Tab(text: 'AI助手'),
            Tab(text: '主题'),
            Tab(text: '关于'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const BasicSettingsTab(),
          const AIAssistantTab(),
          const ThemeSettingsTab(),
          const AboutTab(),
        ],
      ),
    );
  }
}

class BasicSettingsTab extends StatelessWidget {
  const BasicSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SectionTitle(title: '输入设置'),
        SettingsCard(
          title: '输入模式',
          subtitle: '全拼',
          onTap: () {},
        ),
        SettingsCard(
          title: '键盘布局',
          subtitle: 'QWERTY',
          onTap: () {},
        ),
        SettingsCard(
          title: '自动纠错',
          subtitle: '已启用',
          onTap: () {},
        ),
        SettingsCard(
          title: '手势输入',
          subtitle: '已启用',
          onTap: () {},
        ),
        const SectionTitle(title: '词库设置'),
        SettingsCard(
          title: '自定义词库',
          subtitle: '管理您的自定义词库',
          onTap: () {},
        ),
        SettingsCard(
          title: '用户词频学习',
          subtitle: '已启用',
          onTap: () {},
        ),
      ],
    );
  }
}

class AIAssistantTab extends StatelessWidget {
  const AIAssistantTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SectionTitle(title: 'AI设置'),
        SettingsCard(
          title: '豆包API设置',
          subtitle: '配置API密钥和参数',
          onTap: () {},
        ),
        SettingsCard(
          title: '回复风格设置',
          subtitle: '正式、友好、幽默、简洁',
          onTap: () {},
        ),
        SettingsCard(
          title: '推荐回复数量',
          subtitle: '3条（可调整1-5条）',
          onTap: () {},
        ),
        const SectionTitle(title: '隐私与安全'),
        SettingsCard(
          title: '对话历史保存',
          subtitle: '保存最近10条对话',
          onTap: () {},
        ),
        SettingsCard(
          title: '隐私设置',
          subtitle: '数据加密与隐私保护',
          onTap: () {},
        ),
        SettingsCard(
          title: '应用黑/白名单',
          subtitle: '设置需要分析的应用',
          onTap: () {},
        ),
      ],
    );
  }
}

class ThemeSettingsTab extends StatelessWidget {
  const ThemeSettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SectionTitle(title: '预设主题'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ThemeOption(
              title: '明亮',
              color: Colors.blue,
              backgroundColor: Colors.white,
              isSelected: themeProvider.themeData == AppThemes.lightTheme,
              onTap: () => themeProvider.setTheme(ThemeType.light),
            ),
            ThemeOption(
              title: '暗黑',
              color: Colors.white,
              backgroundColor: const Color(0xFF212121),
              isSelected: themeProvider.themeData == AppThemes.darkTheme,
              onTap: () => themeProvider.setTheme(ThemeType.dark),
            ),
            ThemeOption(
              title: '蓝色',
              color: Colors.blue,
              backgroundColor: const Color(0xFFE3F2FD),
              isSelected: themeProvider.themeData == AppThemes.blueTheme,
              onTap: () => themeProvider.setTheme(ThemeType.blue),
            ),
            ThemeOption(
              title: '粉色',
              color: Colors.pink,
              backgroundColor: const Color(0xFFFCE4EC),
              isSelected: themeProvider.themeData == AppThemes.pinkTheme,
              onTap: () => themeProvider.setTheme(ThemeType.pink),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const SectionTitle(title: '键盘设置'),
        SettingsSlider(
          title: '键盘透明度',
          value: themeProvider.keyboardOpacity,
          min: 0.5,
          max: 1.0,
          divisions: 5,
          label: '${(themeProvider.keyboardOpacity * 100).round()}%',
          onChanged: (value) => themeProvider.setKeyboardOpacity(value),
        ),
        SwitchSettingsCard(
          title: '振动反馈',
          value: themeProvider.vibrationEnabled,
          onChanged: (value) => themeProvider.setVibrationEnabled(value),
        ),
        if (themeProvider.vibrationEnabled)
          SettingsSlider(
            title: '振动强度',
            value: themeProvider.vibrationIntensity,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: '${(themeProvider.vibrationIntensity * 100).round()}%',
            onChanged: (value) => themeProvider.setVibrationIntensity(value),
          ),
        SwitchSettingsCard(
          title: '按键音效',
          value: themeProvider.soundEnabled,
          onChanged: (value) => themeProvider.setSoundEnabled(value),
        ),
        if (themeProvider.soundEnabled)
          SettingsSlider(
            title: '音量',
            value: themeProvider.soundVolume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: '${(themeProvider.soundVolume * 100).round()}%',
            onChanged: (value) => themeProvider.setSoundVolume(value),
          ),
      ],
    );
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(Icons.keyboard, size: 80, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  '智能输入法',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('版本 1.0.0'),
              ],
            ),
          ),
        ),
        const SectionTitle(title: '关于应用'),
        SettingsCard(
          title: '用户协议',
          onTap: () {},
        ),
        SettingsCard(
          title: '隐私政策',
          onTap: () {},
        ),
        SettingsCard(
          title: '检查更新',
          onTap: () {},
        ),
        SettingsCard(
          title: '反馈问题',
          onTap: () {},
        ),
      ],
    );
  }
}

// 通用组件
class SectionTitle extends StatelessWidget {
  final String title;
  
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  
  const SettingsCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class SwitchSettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  
  const SwitchSettingsCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: SwitchListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class SettingsSlider extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;
  
  const SettingsSlider({
    Key? key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: divisions,
                    label: label,
                    onChanged: onChanged,
                  ),
                ),
                Text(label),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeOption extends StatelessWidget {
  final String title;
  final Color color;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onTap;
  
  const ThemeOption({
    Key? key,
    required this.title,
    required this.color,
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 20,
                  color: color,
                ),
                if (isSelected)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}