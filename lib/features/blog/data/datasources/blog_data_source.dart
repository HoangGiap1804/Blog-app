import 'dart:io';

import 'package:share_blog/features/blog/data/models/blog_response.dart';
import 'package:share_blog/features/blog/data/models/list_blog_response.dart';

abstract interface class BlogDataSource {
  Future<BlogResponse> createBlog(
    String title,
    String content,
    String status,
    File bannerImage,
    String accessToken,
  );

  Future<BlogResponse> getBlogBySlug(String slug, String accessToken);
  Future<ListBlogResponse> getListBlog(
    int limit,
    int offset,
    String accessToken,
  );
}
