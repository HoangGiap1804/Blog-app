class BlogEntity {
  final String id;
  final String title;
  final String content;
  final String status;
  final String? bannerUrl;
  final int? width;
  final int? height;
  final String? idAuth;
  final String? userName;
  final int? viewsCount;
  final int? likesCount;
  final int? commentCount;
  final String? slug;
  final String? publishedAt;
  final String? updateAt;
  BlogEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    this.bannerUrl,
    this.width,
    this.height,
    this.idAuth,
    this.userName,
    this.viewsCount,
    this.likesCount,
    this.commentCount,
    this.slug,
    this.publishedAt,
    this.updateAt,
  });
}
