import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({this.anonymous = false});

  final bool anonymous;

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  FirebaseUser _user;

  @override
  void didChangeDependencies() {
    _user = Provider.of<UserProvider>(context).user;
    print(_user);
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
        body: _buildUser());
  }

  Widget _buildUser() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
              radius: 35,
              backgroundImage: _user.photoUrl != null
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
          )
        ],
      ),
    );
  }
}
