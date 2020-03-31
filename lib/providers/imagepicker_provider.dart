import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File _image;
  ImageSource _imageSource;
  String _imageUrl;
  int imageCounter = 0;
  bool _isImageSelected = false;

  bool get isImageSelected => _isImageSelected;
  File get image => _image;
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

  set image(File image) {
    _image = image;
    isImageSelected = true;

    notifyListeners();
  }

  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;

    notifyListeners();
  }

  uploadImage({File image}) async {
    imageCounter++;

    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('spotPictures/${image.path + imageCounter.toString()}');
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;
    print('uploaded');
    reference.getDownloadURL().then((value) => _imageUrl = value);
  }
}
