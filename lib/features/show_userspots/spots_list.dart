import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/features/favorites/spot_card.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class MySpotsList extends StatefulWidget {
  const MySpotsList({@required this.spots});

  final List<TouristSpot> spots;

  @override
  _MySpotsListState createState() => _MySpotsListState();
}

class _MySpotsListState extends State<MySpotsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.height * 0.80,
          child: Theme(
            data: ThemeData.light(),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              buttonPadding: EdgeInsets.zero,
              title: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.height * 0.80,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'My added spots',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: HexColor('#606062'),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -12,
                      top: -12,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: HexColor('#757685').withOpacity(0.60),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.72,
                width: MediaQuery.of(context).size.height * 0.80,
                child: ListView(
                  children: widget.spots
                      .map((e) => SpotCard(
                            address: e.location,
                            title: e.title,
                            imageUrl: e.mainPicture,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
