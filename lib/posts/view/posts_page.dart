import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/posts/bloc/post_bloc.dart';
import 'package:infinite_list/posts/posts_api/posts_api.dart';
import 'package:infinite_list/posts/posts_api/posts_repository.dart';

import 'package:http/http.dart' as http;
import 'package:infinite_list/posts/view/posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostsRepository repo =
        PostsRepository(postsApi: PostsApi(httpClient: http.Client()));
    return Scaffold(
      body: BlocProvider(
        create: (_) => PostBloc(repo)..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
