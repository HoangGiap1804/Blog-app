import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_action_button.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_draggable_scrollable_sheet.dart';

class CreateBlogPage extends StatefulWidget {
  final bool isView;
  const CreateBlogPage({super.key, required this.isView});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  static const String markdownData = """
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
##### H5 Heading
###### H6 Heading

---

**In đậm**  
*In nghiêng*  
~~Gạch ngang~~

---

Đây là một [link](https://flutter.dev)  
Đây là một hình ảnh:  
![Flutter Logo](https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png)

---

Danh sách không thứ tự:
- Item 1
- Item 2
  - Sub Item 2.1
  - Sub Item 2.2
- Item 3

Danh sách có thứ tự:
1. Bước 1
2. Bước 2
3. Bước 3

---

Trích dẫn:
> Đây là một quote  
> Có thể xuống dòng

---

Code inline: \`print("Hello")\`  

Code block:
```dart
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  } 

""";

  final titleController = TextEditingController();
  final contentController = TextEditingController(text: markdownData);

  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: _image == null
              ? Text("Chưa chọn ảnh")
              : Image.file(
                  _image!,
                  fit: BoxFit.cover, // ảnh phủ kín
                  width: double.infinity, // ngang hết màn hình
                  height: double.infinity, // dọc hết màn hình
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
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: widget.isView ? -100 : 40,
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.gradient3,
              fixedSize: const Size(50, 50), // để tính toán căn giữa
              shape: const CircleBorder(),
            ),
            child: Icon(Icons.add, color: AppPallete.borderColor),
          ),
        ),

        BlogDraggableScrollableSheet(
          children: [
            SizedBox(height: 20),
            (widget.isView)
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: SelectableText(
                      titleController.text,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )
                : TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Nhập văn bản...",
                      border: OutlineInputBorder(),
                    ),
                  ),
            SizedBox(height: 20),
            Divider(thickness: 4, color: AppPallete.gradient3),
            SizedBox(height: 20),
            (widget.isView)
                ? MarkdownBody(data: contentController.text)
                : TextField(
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // cho nhập nhiều dòng không giới hạn
                    minLines: 1, // bắt đầu từ 1 dòng
                    decoration: InputDecoration(
                      hintText: "Nhập văn bản...",
                      border: OutlineInputBorder(),
                    ),
                  ),
            SizedBox(height: 200), // content dài để thử scroll
          ],
        ),
      ],
    );
  }
}
