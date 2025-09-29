import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/like/domain/usecases/like_blog_usecase.dart';
import 'package:share_blog/features/like/domain/usecases/unlike_blog_usecase.dart';
import 'package:share_blog/features/like/presentation/bloc/like_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';

class UnlikeBlogPage extends StatefulWidget {
  const UnlikeBlogPage({super.key});

  @override
  State<UnlikeBlogPage> createState() => _UnlikeBlogPageState();
}

class _UnlikeBlogPageState extends State<UnlikeBlogPage> {
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

            context.read<LikeBloc>().add(
              UnlikeBlogEvent(
                userUnlikeBlogParams: UserUnlikeBlogParams(
                  blogId: "68c67b8c137409d27c27711c",
                  accessToken: accessToken!,
                ),
              ),
            );
            _controller.clear();
          },
          child: const Text("Send"),
        ),
        const Divider(),
        Expanded(
          child: BlocBuilder<LikeBloc, LikeState>(
            builder: (context, state) {
              if (state is LikeLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is UnlikeBlogFailureState) {
                return Center(child: Text("Unlike fail ${state.message}"));
              } else if (state is UnlikeBlogSuccessState) {
                return Center(child: Text("Unlike thanh cong"));
              } else {
                return const Center(child: Text("Unlike blog"));
              }
            },
          ),
        ),
      ],
    );
  }
}
