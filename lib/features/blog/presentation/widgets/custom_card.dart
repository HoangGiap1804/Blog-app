import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String url;
  const CustomCard({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isResize = constraints.maxHeight < 250;

        double? bottomTitle = isResize ? 0 : 250;
        double? widthTitle = isResize ? 200 : 800;
        double? heightTitle = isResize ? 800 : 800;

        double? widthImage = isResize ? 100 : 400;
        double? heightImage = isResize ? 100 : 600;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // bo góc
          ),
          elevation: 4, // đổ bóng
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: 0,
                  right: 0,
                  width: widthImage,
                  height: heightImage,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  top: bottomTitle,
                  width: widthTitle,
                  height: heightTitle,
                  child: Container(
                    color: (isResize) ? Colors.transparent : Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!isResize) Text("User name"),
                          Text(title),
                        ],
                      ),
                    ),
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
