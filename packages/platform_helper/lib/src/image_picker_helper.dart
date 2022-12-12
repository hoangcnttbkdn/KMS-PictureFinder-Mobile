import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static final _picker = ImagePicker();

  static Future<String?> pickImageFromSource(
    ImageSource source, {
    int imageQuality = 60,
  }) async {
    try {
      final imageXFile =
          await _picker.pickImage(source: source, imageQuality: imageQuality);
      return imageXFile?.path;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> pickVideoFromSource(ImageSource source) async {
    try {
      final videoXFile = await _picker.pickVideo(source: source);
      return videoXFile?.path;
    } catch (e) {
      return null;
    }
  }
}
