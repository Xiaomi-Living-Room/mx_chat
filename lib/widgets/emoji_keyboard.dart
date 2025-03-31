import 'package:flutter/material.dart';
import '../themes/app_themes.dart';

class EmojiKeyboard extends StatefulWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;
  final Function(String) onEmojiSelected;
  final VoidCallback onKeyboardToggle;
  final VoidCallback onBackspace;

  const EmojiKeyboard({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
    required this.onEmojiSelected,
    required this.onKeyboardToggle,
    required this.onBackspace,
  }) : super(key: key);

  @override
  State<EmojiKeyboard> createState() => _EmojiKeyboardState();
}

class _EmojiKeyboardState extends State<EmojiKeyboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // 表情符号分类
  final List<String> _categories = ['常用', '表情', '手势', '人物', '动物', '食物', '活动', '旅行', '物品', '符号'];
  
  // 模拟表情数据
  final Map<String, List<String>> _emojis = {
    '常用': ['😀', '😁', '😂', '🤣', '😃', '😄', '😅', '😆', '😉', '😊', '😋', '😎', '😍', '😘', '🥰', '😗', '😙', '😚', '🙂', '🤗'],
    '表情': ['😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣', '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰', '😘', '😗', '😙', '😚'],
    '手势': ['👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙', '👈', '👉', '👆', '👇', '☝️', '✋', '🤚', '🖐', '🖖', '👋', '🤏', '✍️'],
    '人物': ['👶', '👧', '🧒', '👦', '👩', '🧑', '👨', '👵', '🧓', '👴', '👲', '👳‍♀️', '👳‍♂️', '🧕', '👮‍♀️', '👮‍♂️', '👷‍♀️', '👷‍♂️', '💂‍♀️', '💂‍♂️'],
    '动物': ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼', '🐨', '🐯', '🦁', '🐮', '🐷', '🐸', '🐵', '🙈', '🙉', '🙊', '🐒', '🐔'],
    '食物': ['🍏', '🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇', '🍓', '🍈', '🍒', '🍑', '🥭', '🍍', '🥥', '🥝', '🍅', '🍆', '🥑', '🥦'],
    '活动': ['⚽️', '🏀', '🏈', '⚾️', '🥎', '🎾', '🏐', '🏉', '🥏', '🎱', '🏓', '🏸', '🏒', '🏑', '🥍', '🏏', '⛳️', '🏹', '🎣', '🥊'],
    '旅行': ['🚗', '🚕', '🚙', '🚌', '🚎', '🏎', '🚓', '🚑', '🚒', '🚐', '🚚', '🚛', '🚜', '🛴', '🚲', '🛵', '🏍', '🚨', '🚔', '🚍'],
    '物品': ['⌚️', '📱', '📲', '💻', '⌨️', '🖥', '🖨', '🖱', '🖲', '🕹', '🗜', '💽', '💾', '💿', '📀', '📼', '📷', '📸', '📹', '🎥'],
    '符号': ['❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '♥️', '💔', '❣️', '💕', '💞', '💓', '💗', '💖', '💘', '💝', '💟', '☮️', '✝️'],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: widget.keyboardTheme.backgroundColor.withOpacity(widget.opacity),
      child: Column(
        children: [
          // 表情分类标签栏
          Container(
            decoration: BoxDecoration(
              color: widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(widget.opacity),
              border: Border(
                bottom: BorderSide(color: widget.keyboardTheme.borderColor),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: widget.keyboardTheme.aiReplyTextColor,
              unselectedLabelColor: widget.keyboardTheme.keyTextColor,
              indicatorColor: widget.keyboardTheme.aiReplyTextColor,
              tabs: _categories.map((category) => Tab(text: category)).toList(),
            ),
          ),
          
          // 表情内容区
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: _emojis[category]!.length,
                  itemBuilder: (context, index) {
                    return _buildEmojiItem(_emojis[category]![index]);
                  },
                );
              }).toList(),
            ),
          ),
          
          // 底部功能栏
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(widget.opacity),
              border: Border(
                top: BorderSide(color: widget.keyboardTheme.borderColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.keyboard,
                    color: widget.keyboardTheme.keyTextColor,
                    size: 20,
                  ),
                  onPressed: widget.onKeyboardToggle,
                  tooltip: '切换回键盘',
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: widget.keyboardTheme.keyTextColor,
                    size: 20,
                  ),
                  onPressed: widget.onBackspace,
                  tooltip: '删除表情',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiItem(String emoji) {
    return InkWell(
      onTap: () => widget.onEmojiSelected(emoji),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: widget.keyboardTheme.keyBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}