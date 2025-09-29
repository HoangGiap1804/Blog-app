import 'dart:io';

import 'package:share_blog/features/blog/data/datasources/blog_data_source.dart';
import 'package:share_blog/features/blog/data/models/blog_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:share_blog/features/blog/data/models/list_blog_response.dart';

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
  Future<BlogResponse> createBlog(
    @Part(name: "title") String title,
    @Part(name: "content") String content,
    @Part(name: "status") String status,
    @Part(name: "banner_image") File bannerImage,
    @Header("Authorization") String accessToken,
  );

  @override
  @GET("/blogs/slug/{slug}")
  Future<BlogResponse> getBlogBySlug(
    @Path("slug") String slug,
    @Header("Authorization") String accessToken,
  );

  @override
  @GET("/blogs/")
  Future<ListBlogResponse> getListBlog(
    @Query("limit") int limit,
    @Query("offset") int offset,
    @Header("Authorization") String accessToken,
  );
}
