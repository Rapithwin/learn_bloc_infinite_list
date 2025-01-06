import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list/posts/models/post.dart';
import 'package:infinite_list/posts/posts_api/posts_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDropable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// Business logic layer. Responsible to respond to input from the presentation layer
/// with new states.
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;
  PostBloc(this.repository) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDropable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.inital) {
        // TODO
      }
      final posts = await repository.getPosts(state.posts.length);
      emit(
        posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
