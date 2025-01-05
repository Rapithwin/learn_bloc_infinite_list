part of 'post_bloc.dart';

/// Base event class
sealed class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// [PostFetched] event which informs the [PostBloc] that the posts are fetched
final class PostFetched extends PostEvent {}
