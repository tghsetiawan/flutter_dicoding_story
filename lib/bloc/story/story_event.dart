part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class AddStory extends StoryEvent {
  final AddStory data;
  const AddStory(this.data);

  @override
  List<Object> get props => [data];
}
