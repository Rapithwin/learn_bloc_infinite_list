import 'dart:convert';

import 'package:infinite_list/posts/models/post.dart';
import 'package:http/http.dart' as http;

const _postLimit = 20;

/// Data provider. Connects to the JSONPlaceholder API
class PostsApi {
  final http.Client httpClient;

  PostsApi({required this.httpClient});

  Future<List<Post>> fetchPost({required int startIndex}) async {
    final response = await httpClient.get(
      Uri.https(
        "jsonplaceholder.typicode.com",
        "/posts",
        <String, String>{
          "_start": "$startIndex",
          "_limit": "$_postLimit",
        },
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map(
        (dynamic json) {
          final map = json as Map<String, dynamic>;
          return Post(
            id: map['id'] as int,
            title: map['title'] as String,
            body: map['body'] as String,
          );
        },
      ).toList();
    }
    throw Exception("Error fetching posts");
  }
}
