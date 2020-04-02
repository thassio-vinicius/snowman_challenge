import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/authentication_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AnonymousDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        title: Text(
          "As an anonymous user, you can only see the tourist spots' info, but you don't have access to all the other features, such as rating, commenting and adding new spots.",
          textAlign: TextAlign.justify,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
                fontSize: 16,
                color: HexColor('#111236'),
                fontWeight: FontWeight.bold),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                AuthResult auth = await Provider.of<AuthenticationProvider>(
                        context,
                        listen: false)
                    .signInAnonymously();

                Provider.of<UserProvider>(context, listen: false)
                    .saveUserInfo(auth.user);

                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                "Got it!",
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: HexColor('#111236'),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Sign in instead',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: HexColor('#11159A'),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
