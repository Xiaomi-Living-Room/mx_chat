import 'package:flutter/material.dart';
import '../themes/app_themes.dart';
import '../widgets/input_method_panel.dart';

class ChatDemoScreen extends StatefulWidget {
  const ChatDemoScreen({Key? key}) : super(key: key);

  @override
  State<ChatDemoScreen> createState() => _ChatDemoScreenState();
}

class _ChatDemoScreenState extends State<ChatDemoScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: '你好，最近在忙什么？',
      isMe: false,
      time: '10:30',
    ),
    ChatMessage(
      text: '我在研究一个新的AI项目，很有意思',
      isMe: true,
      time: '10:31',
    ),
    ChatMessage(
      text: '听起来不错！能详细说说吗？',
      isMe: false,
      time: '10:32',
    ),
  ];

  final ThemeProvider _themeProvider = ThemeProvider();
  bool _showKeyboard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('智能输入法演示'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 在实际应用中，这里会导航到设置页面
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 聊天消息列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(_messages[index]);
              },
            ),
          ),
          
          // 底部输入区域
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {},
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showKeyboard = !_showKeyboard;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _showKeyboard ? '点击关闭键盘' : '点击打开键盘',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic_none),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // 输入法面板
          if (_showKeyboard)
            InputMethodPanel(
              keyboardTheme: _themeProvider.keyboardTheme,
              opacity: _themeProvider.keyboardOpacity,
            ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) _buildAvatar(false),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: message.isMe ? Colors.blue.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (message.isMe) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isMe) {
    return CircleAvatar(
      backgroundColor: isMe ? Colors.blue.shade200 : Colors.grey.shade400,
      child: Text(
        isMe ? '我' : '对',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class ThemeProvider {
  ThemeData _themeData = AppThemes.lightTheme;
  KeyboardTheme _keyboardTheme = AppThemes.lightKeyboardTheme;
  double _keyboardOpacity = 1.0;

  ThemeData get themeData => _themeData;
  KeyboardTheme get keyboardTheme => _keyboardTheme;
  double get keyboardOpacity => _keyboardOpacity;
}