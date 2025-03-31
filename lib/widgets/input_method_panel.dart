import 'package:flutter/material.dart';
import '../themes/app_themes.dart';
import 'ai_reply_bar.dart';
import 'candidate_bar.dart';
import 'keyboard_layout.dart';
import 'emoji_keyboard.dart';
import 'function_switch_bar.dart';

class InputMethodPanel extends StatefulWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;

  const InputMethodPanel({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
  }) : super(key: key);

  @override
  State<InputMethodPanel> createState() => _InputMethodPanelState();
}

class _InputMethodPanelState extends State<InputMethodPanel> {
  final TextEditingController _textController = TextEditingController();
  bool _isSymbolKeyboard = false;
  String _currentLanguage = '中';
  String _inputText = '';
  InputMode _currentMode = InputMode.keyboard;
  
  // 模拟候选词列表
  List<String> _candidates = ['你好', '您好', '你们好', '你们', '你好吗', '你们都', '你好啊', '你们好吗'];
  
  // 模拟AI推荐回复
  List<String> _aiReplies = [
    '好的，没问题',
    '稍等，我马上处理',
    '谢谢你的信息',
    '我明白了，我会尽快回复',
    '需要更多细节吗？',
    '这个问题我需要进一步了解'
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleKeyPressed(String key) {
    setState(() {
      _inputText += key;
      _updateCandidates();
    });
  }

  void _handleBackspace() {
    if (_inputText.isNotEmpty) {
      setState(() {
        _inputText = _inputText.substring(0, _inputText.length - 1);
        _updateCandidates();
      });
    }
  }

  void _handleEnter() {
    // 在实际应用中，这里会触发发送消息
    print('发送消息: $_inputText');
    setState(() {
      _inputText = '';
      _candidates = [];
    });
  }

  void _handleSpacePressed() {
    setState(() {
      _inputText += ' ';
    });
  }

  void _handleSwitchToSymbols() {
    setState(() {
      _isSymbolKeyboard = true;
    });
  }

  void _handleSwitchToLetters() {
    setState(() {
      _isSymbolKeyboard = false;
    });
  }

  void _handleSwitchLanguage() {
    setState(() {
      _currentLanguage = _currentLanguage == '中' ? 'EN' : '中';
    });
  }

  void _handleVoiceInput() {
    // 在实际应用中，这里会启动语音输入
    print('启动语音输入');
  }

  void _handleCandidateSelected(String candidate) {
    setState(() {
      _inputText = candidate;
      _candidates = [];
    });
  }

  void _handleReplySelected(String reply) {
    setState(() {
      _inputText = reply;
      _candidates = [];
    });
  }

  void _updateCandidates() {
    // 在实际应用中，这里会根据输入更新候选词
    // 这里使用模拟数据
    if (_inputText.isEmpty) {
      _candidates = [];
    } else if (_inputText.startsWith('n')) {
      _candidates = ['你好', '您好', '你们好', '你们', '你好吗', '你们都', '你好啊', '你们好吗'];
    } else if (_inputText.startsWith('w')) {
      _candidates = ['我', '我们', '我的', '我是', '我要', '我想', '我们的', '我们要'];
    } else {
      _candidates = ['测试1', '测试2', '测试3', '测试4', '测试5'];
    }
  }

  // 处理表情选择
  void _handleEmojiSelected(String emoji) {
    setState(() {
      _inputText += emoji;
    });
  }

  // 处理输入模式切换
  void _handleModeChanged(InputMode mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.keyboardTheme.backgroundColor.withOpacity(widget.opacity),
        border: Border(
          top: BorderSide(color: widget.keyboardTheme.borderColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 输入预览区
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(widget.opacity),
              border: Border(
                bottom: BorderSide(color: widget.keyboardTheme.borderColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _inputText,
                    style: TextStyle(
                      color: widget.keyboardTheme.keyTextColor,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: widget.keyboardTheme.aiReplyBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _currentLanguage,
                    style: TextStyle(
                      color: widget.keyboardTheme.aiReplyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 功能切换栏
          FunctionSwitchBar(
            keyboardTheme: widget.keyboardTheme,
            opacity: widget.opacity,
            currentMode: _currentMode,
            onModeChanged: _handleModeChanged,
          ),
          
          // AI推荐回复区
          if (_aiReplies.isNotEmpty && _currentMode == InputMode.keyboard)
            AIReplyBar(
              keyboardTheme: widget.keyboardTheme,
              opacity: widget.opacity,
              replies: _aiReplies,
              onReplySelected: _handleReplySelected,
            ),
          
          // 候选词区
          if (_candidates.isNotEmpty && _currentMode == InputMode.keyboard)
            CandidateBar(
              keyboardTheme: widget.keyboardTheme,
              opacity: widget.opacity,
              candidates: _candidates,
              onCandidateSelected: _handleCandidateSelected,
            ),
          
          // 根据当前模式显示不同的输入面板
          if (_currentMode == InputMode.keyboard)
            KeyboardLayout(
              keyboardTheme: widget.keyboardTheme,
              opacity: widget.opacity,
              isSymbolKeyboard: _isSymbolKeyboard,
              onKeyPressed: _handleKeyPressed,
              onBackspace: _handleBackspace,
              onEnter: _handleEnter,
              onSpacePressed: _handleSpacePressed,
              onSwitchToSymbols: _handleSwitchToSymbols,
              onSwitchToLetters: _handleSwitchToLetters,
              onSwitchLanguage: _handleSwitchLanguage,
              onVoiceInput: _handleVoiceInput,
            )
          else if (_currentMode == InputMode.emoji)
            EmojiKeyboard(
              keyboardTheme: widget.keyboardTheme,
              opacity: widget.opacity,
              onEmojiSelected: _handleEmojiSelected,
              onKeyboardToggle: () => _handleModeChanged(InputMode.keyboard),
              onBackspace: _handleBackspace,
            ),
        ],
      ),
    );
  }
}