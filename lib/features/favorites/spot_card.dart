import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class SpotCard extends StatelessWidget {
  const SpotCard({@required this.address, @required this.title, this.imageUrl});

  final String address;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.25,
      //width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl)
                : AssetImage('assets/images/logo.png'),
          ),
          Flexible(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HexColor('#606062'),
                      fontSize: 18,
                    )),
                  ),
                  Text(
                    address,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: HexColor('#757685').withOpacity(0.60),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
