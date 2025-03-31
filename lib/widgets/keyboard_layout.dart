import 'package:flutter/material.dart';
import '../themes/app_themes.dart';

class KeyboardLayout extends StatefulWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;
  final VoidCallback onEnter;
  final VoidCallback onSpacePressed;
  final VoidCallback onSwitchToSymbols;
  final VoidCallback onSwitchToLetters;
  final VoidCallback onSwitchLanguage;
  final VoidCallback onVoiceInput;
  final bool isSymbolKeyboard;

  const KeyboardLayout({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
    required this.onKeyPressed,
    required this.onBackspace,
    required this.onEnter,
    required this.onSpacePressed,
    required this.onSwitchToSymbols,
    required this.onSwitchToLetters,
    required this.onSwitchLanguage,
    required this.onVoiceInput,
    this.isSymbolKeyboard = false,
  }) : super(key: key);

  @override
  State<KeyboardLayout> createState() => _KeyboardLayoutState();
}

class _KeyboardLayoutState extends State<KeyboardLayout> {
  bool _isCapsLockEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.keyboardTheme.backgroundColor.withOpacity(widget.opacity),
      child: widget.isSymbolKeyboard ? _buildSymbolKeyboard() : _buildLetterKeyboard(),
    );
  }

  Widget _buildLetterKeyboard() {
    return Column(
      children: [
        _buildKeyRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),
        _buildKeyRow(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l']),
        Row(
          children: [
            _buildSpecialKey(
              flex: 1,
              child: Icon(
                Icons.keyboard_capslock,
                color: _isCapsLockEnabled
                    ? widget.keyboardTheme.aiReplyTextColor
                    : widget.keyboardTheme.keyTextColor,
                size: 20,
              ),
              onTap: () {
                setState(() {
                  _isCapsLockEnabled = !_isCapsLockEnabled;
                });
              },
            ),
            ..._buildKeyList(['z', 'x', 'c', 'v', 'b', 'n', 'm']),
            _buildSpecialKey(
              flex: 1,
              child: Icon(
                Icons.backspace,
                color: widget.keyboardTheme.keyTextColor,
                size: 20,
              ),
              onTap: widget.onBackspace,
              onLongPress: widget.onBackspace,
              isRepeatable: true,
            ),
          ],
        ),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildSymbolKeyboard() {
    return Column(
      children: [
        _buildKeyRow(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']),
        _buildKeyRow(['@', '#', '$', '%', '&', '*', '-', '+', '(', ')']),
        _buildKeyRow(['!', '"', '\'', ':', ';', '/', '?', ',', '.', '_']),
        _buildBottomRow(isSymbolKeyboard: true),
      ],
    );
  }

  Widget _buildKeyRow(List<String> keys) {
    return Row(
      children: _buildKeyList(keys),
    );
  }

  List<Widget> _buildKeyList(List<String> keys) {
    return keys.map((key) => _buildKey(key)).toList();
  }

  Widget _buildKey(String text) {
    final displayText = _isCapsLockEnabled ? text.toUpperCase() : text;
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onKeyPressed(_isCapsLockEnabled ? text.toUpperCase() : text),
              borderRadius: BorderRadius.circular(8),
              child: Ink(
                decoration: BoxDecoration(
                  color: widget.keyboardTheme.keyBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: widget.keyboardTheme.borderColor),
                ),
                child: Center(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: widget.keyboardTheme.keyTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey({
    required Widget child,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    int flex = 1,
    bool isRepeatable = false,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              decoration: BoxDecoration(
                color: widget.keyboardTheme.keyBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.keyboardTheme.borderColor),
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomRow({bool isSymbolKeyboard = false}) {
    return Row(
      children: [
        _buildSpecialKey(
          child: Text(
            isSymbolKeyboard ? 'ABC' : '?123',
            style: TextStyle(
              color: widget.keyboardTheme.keyTextColor,
              fontSize: 14,
            ),
          ),
          onTap: isSymbolKeyboard ? widget.onSwitchToLetters : widget.onSwitchToSymbols,
        ),
        _buildSpecialKey(
          child: Icon(
            Icons.language,
            color: widget.keyboardTheme.keyTextColor,
            size: 20,
          ),
          onTap: widget.onSwitchLanguage,
        ),
        _buildSpecialKey(
          child: Icon(
            Icons.mic,
            color: widget.keyboardTheme.keyTextColor,
            size: 20,
          ),
          onTap: widget.onVoiceInput,
          flex: 1,
        ),
        _buildSpecialKey(
          child: Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
              color: widget.keyboardTheme.keyBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: widget.onSpacePressed,
          flex: 4,
        ),
        _buildSpecialKey(
          child: Icon(
            Icons.keyboard_return,
            color: widget.keyboardTheme.keyTextColor,
            size: 20,
          ),
          onTap: widget.onEnter,
          flex: 1,
        ),
      ],
    );
  }
}