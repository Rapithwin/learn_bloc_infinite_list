import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_list/posts/models/post.dart';
import 'package:infinite_list/posts/posts_api/posts_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

/// `throttleDropable` ensures that events are throttled to one event every `duration` perdiod
/// and any events that come in while the handler is still processing are dropped.
///
/// This approach is beneficial when handling events that could overwhelm the system fi processed too frequently.
EventTransformer<E> throttleDropable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(
      // events.throttle(duration): This limits how often events are processed. If multiple events are emitted in quick succession,
      // only the first event within each duration window is processed. Other events within the duration window are ignored.
      events.throttle(duration),
      mapper,
    );
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
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      final posts = await repository.getPosts(state.posts.length);

      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: [...state.posts, ...posts],
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
