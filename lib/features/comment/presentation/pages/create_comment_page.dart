import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:share_blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';

class CreateCommentPage extends StatefulWidget {
  const CreateCommentPage({super.key});

  @override
  State<CreateCommentPage> createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  final TextEditingController _controller = TextEditingController();

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
                CreateCommentEvent(
                  userCreateCommentParams: UserCreateCommentParams(
                    blogId: "68c67b8c137409d27c27711c",
                    accessToken: accessToken!,
                    comment: _controller.text,
                  ),
                ),
              );
              _controller.clear();
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
              } else if (state is CommentCreateFailure) {
                return Center(child: Text(state.message));
              } else if (state is CommentCreateSuccess) {
                return Center(child: Text(state.commentEntity.commnent));
              } else {
                return const Center(child: Text("Create fail"));
              }
            },
          ),
        ),
      ],
    );
  }
}
