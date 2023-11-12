part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent {}

class ImagePickerPickImageEvent extends ImagePickerEvent {}

abstract class ImagePickerState {}

class ImagePickerInitialState extends ImagePickerState {}

class ImagePickerPickedImageState extends ImagePickerState {
  final File? image;
  ImagePickerPickedImageState({required this.image});
}

class ImagePickerFailureState extends ImagePickerState {
  final String message;
  ImagePickerFailureState({required this.message});
}
