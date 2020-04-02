import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/Usuario/AndroidStudioProjects/snowman_challenge/lib/features/authentication/anonymous_dialog.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class AnonymousButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6),
      child: GestureDetector(
        onTap: () => _anonymousSignIn(context),
        child: Text(
          'Sign in anonymously',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1,
                decorationColor: Colors.black,
                color: HexColor('#111236'),
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}

_anonymousSignIn(context) async {
  return showDialog(context: context, builder: (context) => AnonymousDialog());
}
