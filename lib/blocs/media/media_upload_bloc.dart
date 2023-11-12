import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/controllers/media/media_controller.dart';
import 'package:food_delivery_app/models/api_response.dart';
import 'package:food_delivery_app/models/upload_media/upload_pp_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'media_upload_events_states.dart';

class MediaUploadBloc extends Bloc<MediaUploadEvent, MediaUploadState> {
  MediaUploadBloc() : super(MediaUploadInitial()) {
    // handle events
    on<MediaUploadStartedEvent>((event, emit) async {
      emit(MediaUploadLoading());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          var response = await MediaController.uploadUserProfilePic(
            event.userId,
            event.file,
          );
          emit(MediaUploadSuccess(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(MediaUploadFailure(error: e.toString()));
      }
    });
  }
}
