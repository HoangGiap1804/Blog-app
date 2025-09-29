import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:share_blog/core/routes/app_pages.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';

class GridBlog extends StatelessWidget {
  List<BlogEntity> listBlogs;
  ScrollController scrollController;
  GridBlog({
    super.key,
    required this.listBlogs,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: listBlogs.length,
      itemBuilder: (context, index) {
        if (index == listBlogs.length) {
          // loading indicator cuối cùng
          return Center(child: CircularProgressIndicator());
        }

        final blog = listBlogs[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.blog, arguments: blog);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    blog.bannerUrl ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
