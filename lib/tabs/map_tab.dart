import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/custom_searchbox.dart';
import 'package:snowmanchallenge/features/add_marker/newspot_modal.dart';
import 'package:snowmanchallenge/marker_modal.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final Completer<GoogleMapController> _mapController = Completer();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //Set<Marker> markerSet = {};

  _populateMarkers() {
    Provider.of<FireStoreProvider>(context, listen: false)
        .database
        .collection('markers')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        Provider.of<FireStoreProvider>(context, listen: false).markers;
      } else {
        print('aconteceu algo no populateMarkers');
      }
      /*
        for (int i = 0; i < docs.documents.length; i++) {
          print('length:' + docs.documents.length.toString());
          print('markers:' + docs.documents[i].data.toString());

          //var spot = TouristSpot.fromJson(docs.documents[i].data);
          //initMarker(docs.documents[i].data, docs.documents[i].documentID);
          _initMarker(docs.documents[i].data, docs.documents[i].documentID);
          //Provider.of<MarkersProvider>(context, listen: false).addNewMarker(docs.documents[i].data);
          final MarkerId markerId = MarkerId(docs.documents[i].documentID);
          Marker retrievedMarker =
              Provider.of<FireStoreProvider>(context, listen: false)
                  .markers[markerId.value];

          Provider.of<FireStoreProvider>(context, listen: false).markers.values;
        }
      }

         */
    });
  }

  /*
  void _initMarker(newMarker, markerRef) {
    var markerIDVal = markerRef;
    final MarkerId markerId = MarkerId(markerIDVal);

    LatLng latLng =
        LatLng(newMarker['location'].latitude, newMarker['location'].longitude);

    Marker retrievedMarker =
        Provider.of<FireStoreProvider>(context, listen: false)
            .markers[markerId.value];

    final Marker marker = Marker(
      position: latLng,
      markerId: markerId,
      onTap: newMarker.onTap,
      icon: newMarker.icon,
    );

    Provider.of<MarkersProvider>(context).addNewMarker(marker);
  }

   */

  @override
  void didChangeDependencies() {
    _populateMarkers();
    super.didChangeDependencies();
  }

  Set<Marker> _conversion() {
    Map<String, dynamic> markersMap =
        Provider.of<FireStoreProvider>(context, listen: false).markers;

    Set<Marker> markerSet = {};

    markersMap.entries.map((e) => markerSet.add(e.value)).toSet();

    return markerSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Consumer<FireStoreProvider>(
              builder: (context, provider, child) => GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-10.686929, -37.422591),
                    zoom: 18,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                  markers: _conversion(),
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

    Marker marker;

    TouristSpot _spot = TouristSpot(
      title: location.first.subLocality,
      associatedMarker: marker,
      location: location.first.thoroughfare + location.first.subThoroughfare,
      rating: 1,
      isFavorite: false,
    );

    marker = Marker(
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
