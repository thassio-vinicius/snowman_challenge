import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_backbutton.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_colorpicker.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_textbox.dart';
import 'package:snowmanchallenge/image_select.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/providers/pincolor_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class NewSpotModal extends StatefulWidget {
  const NewSpotModal();

  @override
  _NewSpotModalState createState() => _NewSpotModalState();
}

class _NewSpotModalState extends State<NewSpotModal> {
  TextEditingController _categoriesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  PinColorProvider _colorProvider;
  TextEditingController _pinController;

  @override
  void didChangeDependencies() {
    _colorProvider = Provider.of<PinColorProvider>(context, listen: false);
    _pinController =
        TextEditingController(text: _colorProvider.getHexColorCurrentValue());
    super.didChangeDependencies();
  }

  _onBackTapped() {
    var imageProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    imageProvider.isImageSelected = false;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: CustomBackButton(
                onTap: () => _onBackTapped(),
                icon: Icons.arrow_back,
              ),
            ),
            Container(
              child: Theme(
                data: ThemeData.light(),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: HexColor('#D8D8D8'),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Consumer<ImagePickerProvider>(
                        builder: (context, provider, child) {
                      if (!provider.isImageSelected) {
                        return ImageSelect();
                      } else {
                        return Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child:
                                  Image.file(provider.image, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 15,
                              left: 15,
                              child: InkWell(
                                onTap: () => provider.isImageSelected = false,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      shape: BoxShape.circle),
                                  width: 25,
                                  height: 25,
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                  content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomTextBox(
                            controller: _nameController, label: 'Name'),
                        CustomTextBox(
                            controller: _categoriesController,
                            label: 'Category'),
                        CustomTextBox(
                          controller: _locationController,
                          label: 'Location',
                          isLocationTextBox: true,
                          onLocationBoxSubmitted: () =>
                              _getLatLng(_locationController.text),
                        ),
                        CustomTextBox(
                          controller: _pinController,
                          label: 'Pin Color',
                          onColorBoxTap: () => _colorPicker(),
                          isColorPicker: true,
                        ),
                        CustomButton(
                          onTap: () => _addMarker(),
                          percentageWidth: 0.70,
                          label: 'Add Spot',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _colorPicker() {
    return showDialog(
      context: context,
      child: CustomColorPicker(),
    );
  }

  _getLatLng(String position) async {
    /*
    var p = PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyCNw5Rdu6Ai7Nk_m8-oyLu6Bv0fPqTbYoM',
        mode: Mode.overlay,
        language: 'pt');


     */
    return await Geolocator()
        .placemarkFromAddress(position, localeIdentifier: 'pt_BR');
  }

  _addMarker() async {
    LocationOptions(forceAndroidLocationManager: true);

    var position = await Geolocator().placemarkFromAddress(
      _locationController.text,
      localeIdentifier: 'pt_BR',
    );

    String markerId =
        (position.first.position.latitude + position.first.position.longitude)
            .toString();

    String owner = Provider.of<UserProvider>(context, listen: false).user.uid;

    var imageProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    if (imageProvider.image.existsSync()) {
      await imageProvider.uploadImage(image: imageProvider.image);
    }

    TouristSpot newSpot = TouristSpot(
      title: _nameController.text,
      location: _locationController.text,
      owner: owner,
      id: markerId,
      rating: 0,
      isFavorite: false,
      mainPicture: imageProvider.imageUrl,
      category: _categoriesController.text,
      pinColor: _colorProvider.getHexColorCurrentValue(),
    );

    Provider.of<FireStoreProvider>(context, listen: false)
        .addSpot(newSpot.toJson());

    imageProvider.isImageSelected = false;

    Navigator.pop(context);
  }
}
