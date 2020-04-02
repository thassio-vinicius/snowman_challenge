import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/newspot_modal.dart';
import 'package:snowmanchallenge/features/search/custom_searchbox.dart';
import 'package:snowmanchallenge/features/update_marker/marker_sheet.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_progress_indicator.dart';
import 'package:snowmanchallenge/utils/custom_scroll_behavior.dart';
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
  bool _showDraggableSheet = false;
  Stream<QuerySnapshot> _stream;
  bool _gotLocation = false;
  String _spotId;
  LatLng _position;

  Future<Position> _getUserPosition() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  }

  @override
  void initState() {
    super.initState();
    _getUserPosition().then((value) {
      setState(() {
        _position = LatLng(
          value.latitude,
          value.longitude,
        );
        _gotLocation = true;
      });
    });
    _animationController =
        AnimationController(vsync: this, duration: _duration);
  }

  _getMarkerPosition(String address) async {
    var position = await Geolocator().placemarkFromAddress(address);

    return LatLng(
      position.first.position.latitude,
      position.first.position.longitude,
    );
  }

  _populateSpots({List<DocumentSnapshot> documents}) async {
    for (int i = 0; i < documents.length; i++) {
      TouristSpot spot = TouristSpot.fromJson(documents[i].data);
      Marker marker = Marker(
        markerId: MarkerId(spot.id),
        position: await _getMarkerPosition(spot.location),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          HSVColor.fromColor(
            HexColor(spot.pinColor),
          ).hue,
        ),
        onTap: () {
          setState(() {
            _spotId = documents[i].documentID;
            _showDraggableSheet = !_showDraggableSheet;
          });
          Timer(Duration(milliseconds: 200), () => _animationHandler());
        },
      );
      Provider.of<MarkersProvider>(context, listen: false).addNewMarker(marker);
    }
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
    ///Since this project involves multiple tabs and modals, the controller gets
    ///disposed every time i switch from map tab to another screen. And the completer
    ///doesn't reset once it's completed. That's why the solution i found was to
    ///declarate the controller inside build method. It ensures the controller
    ///always rebuilds when i switch to map tab. Maybe there's a better solution,
    ///but this was the fastest one.

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
                  _populateSpots(documents: snapshot.data.documents);
                }
                return Stack(
                  children: <Widget>[
                    Consumer<MarkersProvider>(
                      builder: (context, provider, child) {
                        return _gotLocation
                            ? GoogleMap(
                                mapType: MapType.normal,
                                mapToolbarEnabled: false,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: _position,
                                  zoom: 15,
                                ),
                                onMapCreated:
                                    (GoogleMapController controller) async {
                                  _mapController.complete(controller);
                                  await _getUserPosition();
                                },
                                markers: provider.markers,
                              )
                            : Center(
                                child: CustomProgressIndicator(),
                              );
                      },
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
                    if (_showDraggableSheet)
                      SizedBox.expand(
                        child: ScrollConfiguration(
                          behavior: CustomScrollBehavior(),
                          child: SlideTransition(
                            position: _tween.animate(_animationController),
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.50,
                              minChildSize: 0.5,
                              maxChildSize: 0.95,
                              builder: (context, scrollController) =>
                                  MarkerSheet(
                                id: _spotId,
                                scrollController: scrollController,
                                anonymous: widget.anonymous,
                                onClose: () {
                                  if (_animationController.isCompleted) {
                                    _animationController.reverse();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
                break;
              default:
                return Text('error : ' + snapshot.error);
                break;
            }
          },
        ),
      ),
    );
  }

  _animationHandler() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    }
  }
}
