import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/star_rating.dart';
import 'package:snowmanchallenge/utils/custom_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class MarkerModal extends StatefulWidget {
  const MarkerModal({@required this.touristSpot});

  final TouristSpot touristSpot;

  @override
  _MarkerModalState createState() => _MarkerModalState();
}

class _MarkerModalState extends State<MarkerModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: <Widget>[
          Flexible(flex: 5, child: _buildHeader()),
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Placeholder(
      color: Colors.grey,
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 9,
              child: Column(
                children: <Widget>[
                  Text(
                    widget.touristSpot.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#111236'),
                      fontFamily: CustomFonts.nunitoBold,
                    ),
                  ),
                  Text(
                    widget.touristSpot.location,
                    style: TextStyle(
                      fontFamily: CustomFonts.nunitoSemiBold,
                      color: HexColor('#757685').withOpacity(0.60),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#FF7074')),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white),
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: HexColor('#FF7074'),
                        size: 24,
                      ),
                      onPressed: () {}),
                ),
              ),
            ),
          ],
        ),
        StarRating(
          color: HexColor('#10159A'),
          onRatingChanged: (rating) => setState(
            () => widget.touristSpot.copyWith(rating: rating),
          ),
        ),
      ],
    );
  }
}
