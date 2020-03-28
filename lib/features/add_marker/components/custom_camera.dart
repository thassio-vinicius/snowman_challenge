import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomCamera extends StatefulWidget {
  @override
  _CustomCameraState createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  _setCurrentImage() async {
    ImageSource source =
        Provider.of<ImagePickerProvider>(context, listen: false).imageSource;

    File image = await ImagePicker.pickImage(source: source);

    Provider.of<ImagePickerProvider>(context, listen: false).setImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select your image source',
        style: TextStyle(
          fontFamily: CustomFonts.nunitoBold,
          fontSize: 20,
          color: HexColor('#111236'),
        ),
      ),
      actions: <Widget>[
        CustomButton(
            onTap: () async {
              Provider.of<ImagePickerProvider>(context, listen: false)
                  .setImageSource(ImageSource.camera);

              await _setCurrentImage();

              Navigator.pop(context);
            },
            label: 'Camera',
            percentageWidth: 0.20),
        CustomButton(
            onTap: () async {
              Provider.of<ImagePickerProvider>(context, listen: false)
                  .setImageSource(ImageSource.gallery);

              await _setCurrentImage();

              Navigator.pop(context);
            },
            label: 'Gallery',
            percentageWidth: 0.20),
      ],
    );
  }
}
