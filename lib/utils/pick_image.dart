import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source, imageQuality: 10);

  if (file != null) {
    return await file.readAsBytes();
  }
  print('no images selected');
}
