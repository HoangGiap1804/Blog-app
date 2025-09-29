import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/core/themes/theme.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_action_button.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_draggable_scrollable_sheet.dart';

class BlogPage extends StatefulWidget {
  final BlogEntity blog;
  const BlogPage({super.key, required this.blog});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                widget.blog.bannerUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[300], // nền fallback
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPallete.transparentColor, // trên cùng trong suốt
                      Colors.black54, // giữa mờ
                      AppPallete.backgroundColor, // dưới cùng đen hẳn
                    ],
                    stops: [0.0, 0.5, 1.0], // chỗ nào bắt đầu chuyển màu
                  ),
                ),
              ),
            ),

            BlogDraggableScrollableSheet(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    widget.blog.title,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    BlogActionButton(
                      text: "${widget.blog.likesCount}",
                      icon: Icons.thumb_up,
                    ),
                    SizedBox(width: 50),
                    BlogActionButton(
                      text: "${widget.blog.commentCount}",
                      icon: Icons.comment,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MarkdownBody(
                  data: widget.blog.content,
                  styleSheet: MarkdownThemes.darkTheme,
                ),
                SizedBox(height: 200), // content dài để thử scroll
              ],
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            widget.blog.userName ?? 'NULL',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: AppPallete.gradient3,
                          maxRadius: 25,
                          child: Text(
                            (widget.blog.userName ?? 'NULL')[0].toUpperCase(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
