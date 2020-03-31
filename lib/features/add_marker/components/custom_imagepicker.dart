import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomImagePicker extends StatefulWidget {
  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  _setCurrentImage() async {
    ImageSource source =
        Provider.of<ImagePickerProvider>(context, listen: false).imageSource;

    File image = await ImagePicker.pickImage(source: source);

    Provider.of<ImagePickerProvider>(context, listen: false).image = image;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Where's your image coming from?",
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: HexColor('#111236'),
          ),
        ),
      ),
      actions: <Widget>[
        CustomButton(
            onTap: () => _onTap(ImageSource.camera),
            label: 'Camera',
            percentageWidth: 0.20),
        CustomButton(
            onTap: () => _onTap(ImageSource.gallery),
            label: 'Gallery',
            percentageWidth: 0.20),
      ],
    );
  }

  _onTap(ImageSource source) async {
    Provider.of<ImagePickerProvider>(context, listen: false).imageSource =
        source;

    await _setCurrentImage();

    Navigator.pop(context);
  }
}
