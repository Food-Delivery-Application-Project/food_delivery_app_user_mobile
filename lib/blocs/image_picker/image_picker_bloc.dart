import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/utils/media_utils.dart';

part 'image_picker_events_states.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitialState()) {
    on<ImagePickerPickImageEvent>((event, emit) async {
      try {
        final image = await MediaUtils.pickImage();
        // if user cancel the pick
        if (image == null) return;
        emit(ImagePickerPickedImageState(image: image));
      } catch (e) {
        emit(ImagePickerFailureState(message: e.toString()));
      }
    });

    on<ImagePickerRemoveImageEvent>((event, emit) async {
      try {
        emit(ImagePickerRemoveImageState());
      } catch (e) {
        emit(ImagePickerFailureState(message: e.toString()));
      }
    });
  }
}
