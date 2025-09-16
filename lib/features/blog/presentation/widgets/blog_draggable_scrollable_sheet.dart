import 'package:flutter/material.dart';
import 'package:share_blog/core/themes/app_pallete.dart';

class BlogDraggableScrollableSheet extends StatelessWidget {
  final List<Widget> children;
  const BlogDraggableScrollableSheet({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black87,
                AppPallete.backgroundColor,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent, // trên cùng trong suốt
                  Colors.black, // chính giữa rõ
                  Colors.black, // dưới cùng rõ
                  Colors.transparent, // dưới cùng trong suốt
                ],
                stops: [0.04, 0.05, 0.9, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  //shrinkWrap: true,
                  //padding: const EdgeInsets.all(16),
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
