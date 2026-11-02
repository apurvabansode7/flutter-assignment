
import 'package:flutter/material.dart';
import 'journal_notebook_cover.dart';

class JournalCard extends StatefulWidget {
  const JournalCard({
    super.key,
    this.userName = 'Saniya',
    this.signName = 'Libra',
    this.signGlyph,
    this.isEditable = true,
    this.onTap,
    this.onNameChanged,
  });

  final String userName;
  final String signName;
  final String? signGlyph;
  final bool isEditable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onNameChanged;

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  Future<void> _handleTap() async {
    if (widget.onTap == null || _controller.isAnimating) return;

    await _controller.forward();
    await _controller.reverse();

    if (!mounted) return;

    widget.onTap!();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        child: Hero(
          tag: 'journal_notebook_cover',
          child: JournalNotebookCover(
            userName: widget.userName,
            signName: widget.signName,
            signGlyph: widget.signGlyph,
            isEditable: widget.isEditable,
            onTap: null,
            onNameChanged: widget.onNameChanged,
          ),
        ),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}
