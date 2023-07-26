import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitial()) {
    on<StoryEvent>((event, emit) async {
      if (event is AddStory) {
        try {
          emit(StoryLoading());
        } catch (e) {
          emit(StoryFailed(e.toString()));
        }
      }
    });
  }
}
