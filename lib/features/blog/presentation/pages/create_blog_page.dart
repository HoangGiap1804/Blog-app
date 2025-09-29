import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/core/themes/theme.dart';
import 'package:share_blog/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/blog/presentation/widgets/animation_change_widget.dart';
import 'package:share_blog/features/blog/presentation/widgets/blog_draggable_scrollable_sheet.dart';
import 'package:share_blog/services/token/token_storage.dart';

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({super.key});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage>
    with AutomaticKeepAliveClientMixin {
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
  bool isView = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: _image == null
              ? Text("Select image", style: TextStyle(fontSize: 30))
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
          top: isView ? -100 : 40,
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
            AnimationChangeWidget(
              isChange: isView,
              firstWidget: Align(
                alignment: Alignment.centerLeft,
                child: SelectableText(
                  titleController.text,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              secondWidget: TextField(
                controller: titleController,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Nhập văn bản...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 4, color: AppPallete.gradient3),
            SizedBox(height: 20),
            AnimationChangeWidget(
              isChange: isView,
              firstWidget: MarkdownBody(
                key: ValueKey("markdown"),
                data: contentController.text,
                styleSheet: MarkdownThemes.darkTheme,
              ),
              secondWidget: TextField(
                key: ValueKey("textfield"),
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                  labelText: "Content",
                  hintText: "Nhập văn bản...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 200), // content dài để thử scroll
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SpeedDial(
              icon: Icons.menu,
              activeIcon: Icons.close,
              backgroundColor: AppPallete.gradient3,
              foregroundColor: AppPallete.backgroundColor,
              overlayOpacity: 0.4,
              direction: SpeedDialDirection.up, // bung nút lên trên
              children: [
                SpeedDialChild(
                  child: Icon(Icons.subdirectory_arrow_left),
                  label: 'Submit',
                  onTap: () async {
                    String? accessToken = await TokenStorage.getAccessToken();
                    if (accessToken == null || _image == null) return;
                    context.read<BlogBloc>().add(
                      CreateBlogEvent(
                        userCreateBlogParams: UserCreateBlogParams(
                          title: titleController.text,
                          content: contentController.text,
                          status: "draft",
                          accessToken: accessToken,
                          bannerImge: _image!,
                        ),
                      ),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon((isView) ? Icons.edit : Icons.remove_red_eye),
                  label: (isView) ? "Edit" : 'Show view',
                  onTap: () {
                    setState(() {
                      isView = !isView;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
