import 'package:flutter/material.dart';

class AnimationChangeWidget extends StatelessWidget {
  final bool isChange;
  final Widget firstWidget;
  final Widget secondWidget;
  const AnimationChangeWidget({
    super.key,
    required this.isChange,
    required this.firstWidget,
    required this.secondWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.1, 0.0), // trượt nhẹ từ dưới lên
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: isChange ? firstWidget : secondWidget,
    );
  }
}
