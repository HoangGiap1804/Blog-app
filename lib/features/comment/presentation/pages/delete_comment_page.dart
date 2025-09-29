import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:share_blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';

class DeleteCommentPage extends StatefulWidget {
  const DeleteCommentPage({super.key});

  @override
  State<DeleteCommentPage> createState() => _DeleteCommentPageState();
}

class _DeleteCommentPageState extends State<DeleteCommentPage> {
  final TextEditingController _controller = TextEditingController(
    text: "68d17642b4445f738a51a44c",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter comment",
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final text = _controller.text.trim();

            String? accessToken = await TokenStorage.getAccessToken();

            if (accessToken == null) print("AccessToken null");

            if (text.isNotEmpty) {
              context.read<CommentBloc>().add(
                DeleteCommentEvent(
                  userDeleteCommentParams: UserDeleteCommentParams(
                    commentId: _controller.text,
                    accessToken: accessToken!,
                  ),
                ),
              );
            }
          },
          child: const Text("Send"),
        ),
        const Divider(),
        Expanded(
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is DeleteCommentFailure) {
                return Center(child: Text(state.message));
              } else if (state is DeleteCommentSuccess) {
                return Center(child: Text("Xoa thanh cong"));
              } else {
                return const Center(child: Text("test delete"));
              }
            },
          ),
        ),
      ],
    );
  }
}
