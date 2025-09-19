import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:share_blog/core/routes/app_pages.dart';
import 'package:share_blog/core/widgets/app_dialog.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/usecases/get_list_blog_usecase.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:share_blog/features/blog/presentation/widgets/custom_card.dart';
import 'package:share_blog/services/token/token_storage.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class GetListBlogPage extends StatefulWidget {
  const GetListBlogPage({super.key});

  @override
  State<GetListBlogPage> createState() => _GetListBlogPageState();
}

class _GetListBlogPageState extends State<GetListBlogPage>
    with AutomaticKeepAliveClientMixin {
  List<String> titles = [];
  List<Widget> images = [];
  List<BlogEntity> blogs = [];
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
            GetListBlogEvent(
              userGetListBlogPramas: UserGetListBlogPramas(
                limit: 10,
                offset: 0,
                accessToken: snapshot.data!,
              ),
            ),
          );

          return BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state is BlogLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetListBlogSuccess) {
                for (BlogEntity blog in state.listBlogEntity) {
                  titles.add('');
                  images.add(
                    CustomCard(title: blog.title, url: blog.bannerUrl ?? ""),
                  );
                  blogs.add(blog);
                }

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        child: VerticalCardPager(
                          titles: titles, // required
                          images: images, // required
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ), // optional
                          onPageChanged: (page) {
                            // optional
                          },
                          onSelectedItem: (index) {
                            Get.toNamed(Routes.blog, arguments: blogs[index]);
                          },
                          initialPage: 0, // optional
                          align: ALIGN.RIGHT, // optional
                          physics: ClampingScrollPhysics(), // optional
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GetListBlogFailure) {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
