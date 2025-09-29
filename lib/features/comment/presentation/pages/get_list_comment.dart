import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_blog/features/comment/domain/usecases/get_list_comments_usecase.dart';
import 'package:share_blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';

class GetListComment extends StatelessWidget {
  const GetListComment({super.key});

  final String blogId = "68c67b8c137409d27c27711c";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TokenStorage.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR");
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Text("Token null");
          }
          context.read<CommentBloc>().add(
            GetListCommentEvent(
              userGetListCommentParams: UserGetListCommentParams(
                blogId: "68c67b8c137409d27c27711c",
                accessToken: snapshot.data!,
              ),
            ),
          );
          return BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetListCommentSuccess) {
                return ListView.builder(
                  itemCount: state.commentEntitys.length,
                  itemBuilder: (context, index) {
                    final c = state.commentEntitys[index];
                    return ListTile(
                      title: Text(c.blogId),
                      subtitle: Text(c.commnent),
                    );
                  },
                );
              } else if (state is GetListCommentFailure) {
                return Center(child: Text("Comment Error: ${state.message}"));
              }
              return const SizedBox();
            },
          );
        }
        return Text("Token null");
      },
    );
  }
}
