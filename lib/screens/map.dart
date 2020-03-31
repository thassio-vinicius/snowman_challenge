import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_progress_indicator.dart';
import 'package:snowmanchallenge/custom_searchbox.dart';
import 'package:snowmanchallenge/features/add_marker/newspot_modal.dart';
import 'package:snowmanchallenge/marker_modal.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class MapTab extends StatefulWidget {
  const MapTab({this.anonymous = false});

  final bool anonymous;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  _populateSpots(Map<String, dynamic> markers) async {
    await Provider.of<FireStoreProvider>(context, listen: false)
        .database
        .collection('spots')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          if (markers['markerId'] ==
              docs.documents[i].data['associatedMarkerId']) {
            TouristSpot spot = TouristSpot.fromJson(docs.documents[i].data);

            Marker marker = Marker(
              markerId: MarkerId(markers['markerId']),
              position: LatLng(
                markers['position'][0],
                markers['position'][1],
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                HSVColor.fromColor(
                  HexColor(spot.pinColor),
                ).hue,
              ),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => MarkerModal(touristSpot: spot),
              ),
            );

            Provider.of<MarkersProvider>(context, listen: false)
                .addNewMarker(marker);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _mapController = Completer();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Provider.of<FireStoreProvider>(context, listen: false)
                  .database
                  .collection('markers')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CustomProgressIndicator());
                    break;
                  default:
                    for (int i = 0; i < snapshot.data.documents.length; i++)
                      _populateSpots(snapshot.data.documents[i].data);

                    return Consumer<MarkersProvider>(
                      builder: (context, provider, child) => GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-10.686929, -37.422591),
                          zoom: 18,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        markers: provider.markers,
                      ),
                    );
                    break;
                }
              },
            ),
            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: CustomSearchBox(
                readOnly: widget.anonymous,
                dialogPressed: NewSpotModal(modalContext: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
