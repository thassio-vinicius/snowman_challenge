import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  PickedFile _image;
  ImageSource _imageSource;
  String _imageUrl;
  int _imageCounter = 0;
  bool _isImageSelected = false;

  bool get isImageSelected => _isImageSelected;
  PickedFile get image => _image;
  ImageSource get imageSource => _imageSource;
  String get imageUrl => _imageUrl;

  set isImageSelected(bool value) {
    _isImageSelected = value;

    notifyListeners();
  }

  set imageSource(ImageSource source) {
    _imageSource = source;

    notifyListeners();
  }

  set image(PickedFile image) {
    _image = image;
    isImageSelected = true;

    notifyListeners();
  }

  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;

    notifyListeners();
  }

  uploadImage({PickedFile image}) async {
    _imageCounter++;

    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('spotPictures/${image.path + _imageCounter.toString()}');
    StorageUploadTask uploadTask = reference.putFile(File(image.path));
    await uploadTask.onComplete;
    print('uploaded');
    reference.getDownloadURL().then((value) => _imageUrl = value);
  }
}
