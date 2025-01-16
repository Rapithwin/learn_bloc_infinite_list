import 'package:flutter/material.dart';
import 'package:infinite_list/posts/models/post.dart';

class PostItemList extends StatelessWidget {
  const PostItemList({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          "${post.id}",
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          post.title,
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
