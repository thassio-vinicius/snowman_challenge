import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_colorpicker.dart';
import 'package:snowmanchallenge/marker_modal.dart';
import 'package:snowmanchallenge/markers_provider.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/pincolor_provider.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class NewSpotModal extends StatefulWidget {
  const NewSpotModal({@required this.modalContext});

  final BuildContext modalContext;

  @override
  _NewSpotModalState createState() => _NewSpotModalState();
}

class _NewSpotModalState extends State<NewSpotModal> {
  TextEditingController _categoriesController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _pinController;

  @override
  void didChangeDependencies() {
    _pinController = TextEditingController(
        text: '#' +
            Provider.of<PinColorProvider>(context)
                .currentColor
                .toString()
                .toUpperCase()
                .substring(9)
                .replaceAll(')', ''));
    super.didChangeDependencies();
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 24, left: 40),
                width: 40,
                height: 40,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: HexColor('#757685'),
                      size: 25,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
            Container(
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
                  child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: HexColor('#10159A'),
                          ),
                          onPressed: () {})),
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
                      _buildCustomTextBox(
                          controller: _nameController, label: 'Name'),
                      _buildCustomTextBox(
                          controller: _categoriesController, label: 'Category'),
                      _buildCustomTextBox(
                        controller: _locationController,
                        label: 'Location',
                        isLocationTextBox: true,
                      ),
                      _buildCustomTextBox(
                        controller: _pinController,
                        label: 'Pin Color',
                        isColorPicker: true,
                      ),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildCustomTextBox({
    String label,
    TextEditingController controller,
    bool isLocationTextBox = false,
    bool isColorPicker = false,
  }) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: HexColor('#757685').withOpacity(0.60),
                              width: 1.0)),
                      child: Consumer<PinColorProvider>(
                        builder: (context, provider, child) => TextField(
                          controller: controller,
                          cursorColor: Colors.black,
                          readOnly: isColorPicker,
                          onTap: isColorPicker ? () => _colorPicker() : null,
                          onSubmitted: isLocationTextBox
                              ? (location) =>
                                  _getLatLng(_locationController.text)
                              : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: isLocationTextBox
                                ? Icon(
                                    CupertinoIcons.location_solid,
                                    color: HexColor('#10159A'),
                                  )
                                : isColorPicker
                                    ? Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: provider.currentColor),
                                        width: 5,
                                        height: 5,
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                      )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -6.0,
          left: 20.0,
          child: Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12.0, color: HexColor('#757685').withOpacity(0.60)),
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _colorPicker() {
    print('TAP COLOR');
    return showDialog(
      context: context,
      child: CustomColorPicker(),
    );
  }

  _buildAddButton() {
    return InkWell(
      onTap: () => _addMarker(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: HexColor('#FFBE00'),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Add Spot',
              style: TextStyle(
                fontFamily: CustomFonts.nunitoExtraBold,
                color: HexColor('#10159A'),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
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

    LatLng latLng = LatLng(
        position.first.position.latitude, position.first.position.longitude);

    TouristSpot newSpot = TouristSpot(
      title: _nameController.text,
      location: _locationController.text,
      rating: 0,
      isFavorite: false,
      mainPicture: '',
      category: _categoriesController.text,
      pinColor:
          Provider.of<PinColorProvider>(context, listen: false).currentColor,
    );

    Marker marker = Marker(
      markerId: MarkerId(position.toString()),
      position: latLng,
      consumeTapEvents: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(HSVColor.fromColor(
              Provider.of<PinColorProvider>(context, listen: false)
                  .currentColor)
          .hue),
      onTap: () {
        print('BITMAP COLOR: ' + BitmapDescriptor.defaultMarkerWithHue(HSVColor.fromColor(
                    Provider.of<PinColorProvider>(context, listen: false)
                        .currentColor)
                .hue)
            .toString());
        return showModalBottomSheet(
          context: widget.modalContext,
          builder: (context) => MarkerModal(touristSpot: newSpot),
        );
      },
    );

    Provider.of<MarkersProvider>(context, listen: false).addNewMarker(marker);

    Navigator.pop(context);
  }
}
