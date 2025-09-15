import 'package:flutter/material.dart';
import 'package:share_blog/core/themes/app_pallete.dart';

class AuthGradientButton extends StatefulWidget {
  final String content;
  final VoidCallback onPressed;
  final bool isLoading;
  const AuthGradientButton({
    super.key,
    required this.content,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<AuthGradientButton> createState() => _AuthGradientButtonState();
}

class _AuthGradientButtonState extends State<AuthGradientButton> {
  bool isChangeWidget = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      width: (widget.isLoading) ? 55 : 700,
      height: (widget.isLoading) ? 55 : 55,
      onEnd: () => setState(() {
        if (widget.isLoading) {
          isChangeWidget = true;
        } else {
          isChangeWidget = false;
        }
      }),
      child: (isChangeWidget && widget.isLoading) ? _loading() : _button(),
    );
  }

  Widget _button() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          //fixedSize: Size(395, 55),
          minimumSize: Size(0, 75),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: FittedBox(
          child: Text(
            widget.content,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
