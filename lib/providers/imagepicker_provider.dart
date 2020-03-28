import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File _image;
  ImageSource _imageSource;

  File get image => _image;
  ImageSource get imageSource => _imageSource;

  void setImageSource(ImageSource source) {
    _imageSource = source;

    notifyListeners();
  }

  void setImage(File image) {
    _image = image;

    notifyListeners();
  }
}
