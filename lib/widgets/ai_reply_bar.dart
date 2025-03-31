import 'package:flutter/material.dart';
import '../themes/app_themes.dart';

class AIReplyBar extends StatefulWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;
  final List<String> replies;
  final Function(String) onReplySelected;

  const AIReplyBar({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
    required this.replies,
    required this.onReplySelected,
  }) : super(key: key);

  @override
  State<AIReplyBar> createState() => _AIReplyBarState();
}

class _AIReplyBarState extends State<AIReplyBar> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: widget.keyboardTheme.aiReplyBarBackgroundColor.withOpacity(widget.opacity),
        border: Border(
          bottom: BorderSide(color: widget.keyboardTheme.borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'AI推荐回复：',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: (widget.replies.length / 2).ceil(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          _buildReplyItem(startIndex),
                          const SizedBox(width: 8),
                          if (startIndex + 1 < widget.replies.length)
                            _buildReplyItem(startIndex + 1),
                        ],
                      ),
                    );
                  },
                ),
                if (_currentPage > 0)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: _buildNavigationButton(Icons.chevron_left, () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }),
                  ),
                if (_currentPage < (widget.replies.length / 2).ceil() - 1)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: _buildNavigationButton(Icons.chevron_right, () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyItem(int index) {
    if (index >= widget.replies.length) {
      return Expanded(child: Container());
    }
    
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onReplySelected(widget.replies[index]),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.keyboardTheme.aiReplyBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.keyboardTheme.borderColor),
          ),
          child: Center(
            child: Text(
              widget.replies[index],
              style: TextStyle(
                color: widget.keyboardTheme.aiReplyTextColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}