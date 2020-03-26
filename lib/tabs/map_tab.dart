import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snowmanchallenge/custom_searchbox.dart';
import 'package:snowmanchallenge/marker_modal.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(-10.686929, -37.422591),
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              markers: _markers,
              onLongPress: (position) {
                TouristSpot _spot = TouristSpot(
                  title: 'CASINHA DE PAPAI',
                  location: position.toString(),
                  rating: 1,
                  isFavorite: false,
                  mainPicture: 'cu',
                );

                setState(() {
                  _markers.add(
                    Marker(
                      markerId: MarkerId(position.toString()),
                      position: position,
                      icon: BitmapDescriptor.defaultMarker,
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => MarkerModal(touristSpot: _spot),
                      ),
                    ),
                  );
                });
              },
            ),
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: CustomSearchBox(),
            ),
          ],
        ),
      ),
    );
  }
}
