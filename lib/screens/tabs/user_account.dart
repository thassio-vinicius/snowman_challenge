import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/show_userspots/spots_list.dart';
import 'package:snowmanchallenge/models/tourist_spot.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_button.dart';
import 'package:snowmanchallenge/shared/components/custom_progress_indicator.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({this.anonymous = false});

  final bool anonymous;

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  var _user;
  Stream<QuerySnapshot> _stream;

  @override
  void didChangeDependencies() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    _user = userProvider.user ?? userProvider.firestoreUser;
    _stream =
        Provider.of<FireStoreProvider>(context, listen: false).getStreamSpots();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            color: Colors.transparent,
          ),
          backgroundColor: HexColor('#10159A'),
          title: Text('Account'),
          centerTitle: true,
        ),
        body: widget.anonymous
            ? Center(child: Image.asset('assets/images/logo.png'))
            : _buildUser());
  }

  Widget _buildUser() {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Container(
                  padding: EdgeInsets.all(70),
                  child: CustomProgressIndicator(),
                ),
              );
              break;
            default:
              List<DocumentSnapshot> list = snapshot.data.docs
                  .where((element) =>
                      element.data()['owner'] == _user?.email ?? _user?.email)
                  .toList();

              List<TouristSpot> mySpots = [];

              for (int i = 0; i < list.length; i++) {
                if (!mySpots.contains(list[i].data))
                  mySpots.add(TouristSpot.fromJson(list[i].data()));
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 35,
                        backgroundImage: _user is User
                            ? NetworkImage(_user.photoUrl)
                            : AssetImage('assets/images/logo.png')),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(_user.displayName,
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: HexColor('#606062'),
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        _user.email,
                        style: TextStyle(
                            fontSize: 16,
                            color: HexColor('#606062'),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: CustomButton(
                          onTap: () => _showMySpots(mySpots),
                          label: 'My custom markers',
                          percentageWidth: 0.60),
                    )
                  ],
                ),
              );
              break;
          }
        });
  }

  _showMySpots(List<TouristSpot> spots) {
    return showDialog(
        context: context, builder: (context) => MySpotsList(spots: spots));
  }
}
