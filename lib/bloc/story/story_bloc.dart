import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dicoding_story/services/story_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/response_getstory_model.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitial()) {
    on<StoryEvent>((event, emit) async {
      if (event is AddStory) {
        try {
          emit(StoryLoading());

          await StoryService().addStoryDio(event.pathImage, event.description,
              event.latitude, event.longitude);

          emit(StorySuccess());
        } catch (e) {
          emit(StoryFailed(e.toString()));
        }
      }

      if (event is GetStoryLocation) {
        try {
          emit(StoryLoading());

          final res = await StoryService().getAllStoryWithLocation1(1, 20);

          emit(StorySuccessGet(res));
        } catch (e) {
          emit(StoryFailed(e.toString()));
        }
      }
    });
  }
}
