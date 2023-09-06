part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class AddStory extends StoryEvent {
  final XFile pathImage;
  final String description;
  final double latitude;
  final double longitude;
  const AddStory(
      this.pathImage, this.description, this.latitude, this.longitude);

  @override
  List<Object> get props => [pathImage, description, latitude, longitude];
}
