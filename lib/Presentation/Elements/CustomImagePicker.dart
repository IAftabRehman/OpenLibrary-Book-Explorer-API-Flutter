import 'dart:io';

import 'package:image_picker/image_picker.dart';


class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the specified source (gallery or camera).
  /// Returns a File object if an image is selected, otherwise returns null.
  Future<File?> pickImage({required ImageSource source}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024, // Optional: Reduce size for performance
        maxHeight: 1024,
        imageQuality: 85, // Optional: Balance quality and size
      );

      if (image == null) return null; // User cancelled the picker

      return File(image.path);
    } catch (e) {
      // Handle errors (e.g., permission denied)
      // AppLogger.error('');
      print("ImagePickerService Error: $e");
      return null;
    }
  }

  /// Picks an image from the gallery.
  Future<File?> pickImageFromGallery() async {
    return pickImage(source: ImageSource.gallery);
  }

  /// Picks an image from the camera.
  Future<File?> pickImageFromCamera() async {
    return pickImage(source: ImageSource.camera);
  }


}