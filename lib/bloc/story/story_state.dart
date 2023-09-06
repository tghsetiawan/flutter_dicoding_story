part of 'story_bloc.dart';

abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryFailed extends StoryState {
  final String e;
  const StoryFailed(this.e);

  @override
  List<Object> get props => [e];
}

class StorySuccess extends StoryState {}

class StorySuccessGet extends StoryState {
  final ResponseGetStory data;
  const StorySuccessGet(this.data);

  @override
  List<Object> get props => [data];
}
