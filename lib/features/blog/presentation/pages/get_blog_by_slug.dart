import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/core/themes/theme.dart';
import 'package:share_blog/core/widgets/app_dialog.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/usecases/get_blog_by_slug_usecase.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_action_button.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_draggable_scrollable_sheet.dart';
import 'package:share_blog/services/token/token_storage.dart';

class GetBlogBySlug extends StatefulWidget {
  const GetBlogBySlug({super.key});

  @override
  State<GetBlogBySlug> createState() => _GetBlogBySlugState();
}

class _GetBlogBySlugState extends State<GetBlogBySlug>
    with AutomaticKeepAliveClientMixin {
  final String slug = "markdown-tje30cvndpb";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: TokenStorage.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // đang loading
        } else if (snapshot.hasError) {
          return Text("Lỗi: ${snapshot.error}"); // có lỗi
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Text("Token null");
          }

          context.read<BlogBloc>().add(
            GetBlogBySlugEvent(
              userGetBlogBySlugParams: UserGetBlogBySlugParams(
                slug: slug,
                accessToken: snapshot.data!,
              ),
            ),
          );

          return BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetBlogSuccess) {
                return getBlog(state.blogEntity);
              } else if (state is GetBlogFailure) {
                //setState(() => isLoading = false);
                AppDialog.showError(context, desc: state.message);
                return Text("Blog null");
              } else {
                return Text("Blog null");
              }
            },
          );
        } else {
          return Text("Token null");
        }
      },
    );
  }

  Widget getBlog(BlogEntity blog) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.network(
            blog.bannerUrl!,
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
                blog.title,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                BlogActionButton(
                  text: "${blog.likesCount}",
                  icon: Icons.thumb_up,
                ),
                SizedBox(width: 50),
                BlogActionButton(
                  text: "${blog.commentCount}",
                  icon: Icons.comment,
                ),
              ],
            ),
            SizedBox(height: 20),
            MarkdownBody(
              data: blog.content,
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
                        blog.userName ?? "",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppPallete.gradient3,
                      maxRadius: 25,
                      child: Text("G", style: TextStyle(fontSize: 25)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
