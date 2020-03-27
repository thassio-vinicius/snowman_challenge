import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_searchbox.dart';
import 'package:snowmanchallenge/marker_modal.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';

import 'package:snowmanchallenge/features/add_marker/newspot_modal.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final Completer<GoogleMapController> _mapController = Completer();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Consumer<MarkersProvider>(
              builder: (context, provider, child) => GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-10.686929, -37.422591),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  markers: provider.markers,
                  onLongPress: (position) => _placeMarker(position)),
            ),
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: CustomSearchBox(
                dialogPressed: NewSpotModal(modalContext: context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _placeMarker(LatLng position) async {
    var location = await Geolocator().placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'pt_BR');

    TouristSpot _spot = TouristSpot(
      title: location.first.subLocality,
      location: location.first.thoroughfare + location.first.subThoroughfare,
      rating: 1,
      isFavorite: false,
      mainPicture: 'cu',
    );

    Marker marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      icon: BitmapDescriptor.defaultMarker,
      consumeTapEvents: true,
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => MarkerModal(touristSpot: _spot),
      ),
    );

    Provider.of<MarkersProvider>(context, listen: false).addNewMarker(marker);
  }
}
