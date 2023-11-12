import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaUtils {
  // a static method that will pick and image and will return it
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // var status = await Permission.photos.status;

    // if (!status.isGranted) {
    //   status = await Permission.photos.request();
    //   if (!status.isGranted) {
    //     return null;
    //   } else {
    //     print("Hello hi bye bye");
    //   }
    // }

    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (image == null) return null;
      // convert XFile to File
      return File(image.path);
    } catch (error) {
      return null;
    }
  }
}
