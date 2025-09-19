import 'package:flutter/material.dart';

/// 兼容 flutter Scrollbar 的 thumbVisibility 语义
enum ScrollbarThumbVisibility {
  always,
  scrolling,
}

class BottomScrollbar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double thickness;
  final Color? thumbColor;
  final ScrollbarThumbVisibility? thumbVisibility;

  const BottomScrollbar({
    required this.child,
    required this.controller,
    this.thickness = 3,
    this.thumbColor,
    this.thumbVisibility,
    super.key,
  });

  @override
  State<BottomScrollbar> createState() => _BottomScrollbarState();
}

class _BottomScrollbarState extends State<BottomScrollbar> {
  double _thumbOffset = 0;
  double _thumbWidth = 0;
  bool _showThumb = false;

  void _updateThumb() {
    final maxScroll = widget.controller.position.maxScrollExtent;
    final viewport = widget.controller.position.viewportDimension;
    if (maxScroll <= 0) {
      setState(() {
        _thumbOffset = 0;
        _thumbWidth = viewport;
      });
      return;
    }
    final ratio = viewport / (maxScroll + viewport);
    final thumbWidth = viewport * ratio;
    final thumbOffset = (widget.controller.offset / maxScroll) * (viewport - thumbWidth);
    setState(() {
      _thumbOffset = thumbOffset;
      _thumbWidth = thumbWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateThumb);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateThumb());
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateThumb);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool alwaysShow = widget.thumbVisibility == ScrollbarThumbVisibility.always;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (alwaysShow) return false;
        if (notification is ScrollStartNotification) {
          if (!_showThumb) setState(() => _showThumb = true);
        } else if (notification is ScrollEndNotification) {
          if (_showThumb) setState(() => _showThumb = false);
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final show = alwaysShow ? true : _showThumb;
          return Stack(
            children: [
              widget.child,
              Positioned(
                left: _thumbOffset,
                bottom: 2,
                child: AnimatedOpacity(
                  opacity: show ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.ease,
                  child: Container(
                    width: _thumbWidth,
                    height: widget.thickness,
                    decoration: BoxDecoration(
                      color: widget.thumbColor ?? Colors.black.withValues(alpha: .4),
                      borderRadius: BorderRadius.circular(widget.thickness / 2),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
