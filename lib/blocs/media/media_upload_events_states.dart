part of 'media_upload_bloc.dart';

// Events
class MediaUploadEvent {}

class MediaUploadStartedEvent extends MediaUploadEvent {
  final String userId;
  final File file;
  MediaUploadStartedEvent({required this.userId, required this.file});
}

// States
class MediaUploadState {}

class MediaUploadInitial extends MediaUploadState {}

class MediaUploadLoading extends MediaUploadState {}

class MediaUploadSuccess extends MediaUploadState {
  final ApiResponse<UploadPPModel> response;
  MediaUploadSuccess({required this.response});
}

class MediaUploadFailure extends MediaUploadState {
  final String error;
  MediaUploadFailure({required this.error});
}
