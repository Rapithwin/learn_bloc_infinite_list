import 'package:infinite_list/posts/models/post.dart';
import 'package:infinite_list/posts/posts_api/posts_api.dart';

/// The repository layer which is a wrapper around the data provider.
/// The Bloc communicates with this layer.
class PostsRepository {
  final PostsApi postsApi;

  PostsRepository({required this.postsApi});

  Future<List<Post>> getPosts(int startIndex) async {
    final List<Post> posts = await postsApi.fetchPost(startIndex: startIndex);
    return posts;
  }
}
