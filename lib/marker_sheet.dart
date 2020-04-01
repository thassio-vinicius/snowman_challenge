import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_backbutton.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/star_rating.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class MarkerSheet extends StatefulWidget {
  const MarkerSheet({
    @required this.touristSpot,
    @required this.scrollController,
    @required this.onClose,
  });

  final TouristSpot touristSpot;
  final Function onClose;
  final ScrollController scrollController;

  @override
  _MarkerSheetState createState() => _MarkerSheetState();
}

class _MarkerSheetState extends State<MarkerSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              child: CustomBackButton(
                onTap: widget.onClose,
                icon: Icons.close,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.95,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: _buildHeader()),
                Container(
                  height: MediaQuery.of(context).size.width * 0.90,
                  padding: EdgeInsets.only(top: 24),
                  child: _buildBody(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader() {
    return Image(
      image: widget.touristSpot?.mainPicture != null &&
              widget.touristSpot?.mainPicture != ''
          ? NetworkImage(widget.touristSpot.mainPicture)
          : AssetImage('assets/images/logo.png'),
      fit: BoxFit.cover,
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.touristSpot.title,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: HexColor('#111236'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.touristSpot.location,
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: HexColor('#757685').withOpacity(0.60),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
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
        ),
        Flexible(
          child: StarRating(
            color: HexColor('#10159A'),
            rating: widget.touristSpot.rating,
            onRatingChanged: (rating) {
              setState(
                () => widget.touristSpot.copyWith(rating: rating),
              );
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.green,
            child: Center(child: Text('category')),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.red,
            child: Center(child: Text('about')),
          ),
        ),
        Flexible(
          flex: 4,
          child: Container(
            color: Colors.blue,
            child: Center(child: Text('comments')),
          ),
        ),
      ],
    );
  }
}
