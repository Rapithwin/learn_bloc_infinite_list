part of 'post_bloc.dart';

enum PostStatus { inital, success, failure }

final class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  const PostState({
    this.status = PostStatus.inital,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

// Implemented ```copyWith``` so that we can copy an instance of PostSuccess
// and update zero or more properties conveniently (this will come in handy later).
  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];
}
