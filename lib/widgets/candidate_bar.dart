import 'package:flutter/material.dart';
import '../themes/app_themes.dart';

class CandidateBar extends StatefulWidget {
  final KeyboardTheme keyboardTheme;
  final double opacity;
  final List<String> candidates;
  final Function(String) onCandidateSelected;

  const CandidateBar({
    Key? key,
    required this.keyboardTheme,
    required this.opacity,
    required this.candidates,
    required this.onCandidateSelected,
  }) : super(key: key);

  @override
  State<CandidateBar> createState() => _CandidateBarState();
}

class _CandidateBarState extends State<CandidateBar> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(widget.opacity),
        border: Border(
          bottom: BorderSide(color: widget.keyboardTheme.borderColor),
        ),
      ),
      child: Stack(
        children: [
          ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.candidates.length,
            separatorBuilder: (context, index) => const SizedBox(width: 24),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => widget.onCandidateSelected(widget.candidates[index]),
                child: Center(
                  child: Text(
                    widget.candidates[index],
                    style: TextStyle(
                      color: widget.keyboardTheme.candidateTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
          if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(0),
                      widget.keyboardTheme.candidateBarBackgroundColor.withOpacity(widget.opacity),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}