import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/usecases/get_list_blog_usecase.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/blog/presentation/widgets/grid_blog.dart';
import 'package:share_blog/services/token/token_storage.dart';

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
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool firstLoading = true;
  int offset = 0;
  final int limit = 8;

  String? token;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // kéo gần cuối
        loadMoreBlogs();
      }
    });

    loadToken();
  }

  void loadToken() async {
    token = await TokenStorage.getAccessToken();
    context.read<BlogBloc>().add(
      GetListBlogEvent(
        userGetListBlogPramas: UserGetListBlogPramas(
          limit: limit,
          offset: offset,
          accessToken: token!, // thay bằng token
        ),
      ),
    );
  }

  void loadMoreBlogs() {
    offset += limit;
    context.read<BlogBloc>().add(
      GetListBlogEvent(
        userGetListBlogPramas: UserGetListBlogPramas(
          limit: limit,
          offset: offset,
          accessToken: token!, // thay bằng token
        ),
      ),
    );
    print("Load more blog");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is GetListBlogSuccess) {
          setState(() {
            blogs.addAll(state.listBlogEntity);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridBlog(listBlogs: blogs, scrollController: _scrollController),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
