import 'dart:io';

import 'package:share_blog/features/blog/data/datasources/blog_data_source.dart';
import 'package:share_blog/features/blog/data/models/blog_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'blog_api_data_source.g.dart';

@RestApi(
  baseUrl: "http://192.168.1.176:12000/api/v1/",
  parser: Parser.JsonSerializable,
)
abstract class BlogApiDataSource implements BlogDataSource {
  factory BlogApiDataSource(Dio dio) = _BlogApiDataSource;

  @override
  @POST("/blogs")
  @MultiPart()
  Future<BlogModel> createBlog(
    @Part(name: "title") String title,
    @Part(name: "content") String content,
    @Part(name: "status") String status,
    @Part(name: "banner_image") File bannerImage,
    @Header("Authorization") String accessToken,
  );
}
