import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_progress_indicator.dart';
import 'package:snowmanchallenge/custom_searchbox.dart';
import 'package:snowmanchallenge/features/add_marker/newspot_modal.dart';
import 'package:snowmanchallenge/marker_sheet.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';
import 'package:snowmanchallenge/providers/spots_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class MapTab extends StatefulWidget {
  const MapTab({this.anonymous = false});

  final bool anonymous;

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  TouristSpot _spot;
  Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
  }

  _getPosition(String address) async {
    var position = await Geolocator().placemarkFromAddress(address);

    return LatLng(
      position.first.position.latitude,
      position.first.position.longitude,
    );
  }

  _populateMarkers(Map<String, dynamic> spots) async {
    TouristSpot spot = TouristSpot.fromJson(spots);
    Marker marker = Marker(
      markerId: MarkerId(spot.id),
      position: await _getPosition(spot.location),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        HSVColor.fromColor(
          HexColor(spot.pinColor),
        ).hue,
      ),
      onTap: () async {
        setState(() {
          _spot = spot;
        });
        if (_animationController.isDismissed)
          _animationController.forward();
        else if (_animationController.isCompleted)
          _animationController.reverse();
      },
    );

    Provider.of<MarkersProvider>(context, listen: false).addNewMarker(marker);

    Provider.of<SpotsProvider>(context, listen: false).addSpot(spot);
  }

  @override
  void didChangeDependencies() {
    _stream = Provider.of<FireStoreProvider>(context, listen: false)
        .database
        .collection('spots')
        .snapshots();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _mapController = Completer();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CustomProgressIndicator());
                break;
              case ConnectionState.active:
                if (snapshot.data.documents.isNotEmpty) {
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    _populateMarkers(snapshot.data.documents[i].data);
                  }
                }

                return Stack(
                  children: <Widget>[
                    Consumer<MarkersProvider>(
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
                    ),
                    Positioned(
                      top: 15,
                      left: 0,
                      right: 0,
                      child: CustomSearchBox(
                        readOnly: widget.anonymous,
                        dialogPressed: NewSpotModal(),
                      ),
                    ),
                    SizedBox.expand(
                      child: SlideTransition(
                        position: _tween.animate(_animationController),
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.35,
                          minChildSize: 0.35,
                          maxChildSize: 0.95,
                          builder: (context, scrollController) => MarkerSheet(
                            touristSpot: _spot,
                            scrollController: scrollController,
                            onClose: () => _animationController.reverse(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                break;
              default:
                return Container();
                break;
            }
          },
        ),
      ),
    );
  }
}
