import 'dart:io';

import 'package:share_blog/features/blog/data/models/blog_model.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> createBlog(
    String title,
    String content,
    String status,
    File bannerImage,
    String accessToken,
  );
}
