import 'package:flutter/material.dart';
import '../themes/app_themes.dart';

class FunctionSwitchBar extends StatelessWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;
  final Function(InputMode) onModeChanged;
  final InputMode currentMode;

  const FunctionSwitchBar({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
    required this.onModeChanged,
    required this.currentMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: keyboardTheme.backgroundColor.withOpacity(opacity),
        border: Border(
          top: BorderSide(color: keyboardTheme.borderColor),
          bottom: BorderSide(color: keyboardTheme.borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildModeButton(
            icon: Icons.keyboard,
            label: '键盘',
            mode: InputMode.keyboard,
          ),
          _buildModeButton(
            icon: Icons.gesture,
            label: '手势',
            mode: InputMode.gesture,
          ),
          _buildModeButton(
            icon: Icons.emoji_emotions,
            label: '表情',
            mode: InputMode.emoji,
          ),
          _buildModeButton(
            icon: Icons.mic,
            label: '语音',
            mode: InputMode.voice,
          ),
          _buildModeButton(
            icon: Icons.settings,
            label: '设置',
            mode: InputMode.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton({
    required IconData icon,
    required String label,
    required InputMode mode,
  }) {
    final isSelected = currentMode == mode;
    return InkWell(
      onTap: () => onModeChanged(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: isSelected
            ? BoxDecoration(
                color: keyboardTheme.aiReplyBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? keyboardTheme.aiReplyTextColor
                  : keyboardTheme.keyTextColor,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? keyboardTheme.aiReplyTextColor
                    : keyboardTheme.keyTextColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum InputMode { keyboard, gesture, emoji, voice, settings }