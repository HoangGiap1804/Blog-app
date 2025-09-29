import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/like/domain/usecases/like_blog_usecase.dart';
import 'package:share_blog/features/like/presentation/bloc/like_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';

class LikeBlogPage extends StatefulWidget {
  const LikeBlogPage({super.key});

  @override
  State<LikeBlogPage> createState() => _LikeBlogPageState();
}

class _LikeBlogPageState extends State<LikeBlogPage> {
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
              LikeBlogEvent(
                userLikeBlogParams: UserLikeBlogParams(
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
              } else if (state is LikeBlogFailureState) {
                return Center(child: Text("Like fail ${state.message}"));
              } else if (state is LikeBlogSuccessState) {
                return Center(child: Text("Like thanh cong"));
              } else {
                return const Center(child: Text("Like blog"));
              }
            },
          ),
        ),
      ],
    );
  }
}
