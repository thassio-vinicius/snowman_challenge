import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/authentication_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({@required this.isSignInButton, this.notifyLoginCard});

  final bool isSignInButton;
  final Function notifyLoginCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSignInButton ? Colors.white : HexColor('#11159A'),
          border: Border.all(
            color: HexColor('#10159A'),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () => isSignInButton ? _signIn(context) : _signUp(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  isSignInButton
                      ? 'assets/images/google_signin.png'
                      : 'assets/images/google_signup.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                isSignInButton ? 'Sign in with Google' : 'Sign up with Google',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color:
                          isSignInButton ? HexColor('#11159A') : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signIn(context) async {
    UserCredential user =
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .googleSignOption();

    Provider.of<UserProvider>(context, listen: false).saveUserInfo(user.user);

    Navigator.pushReplacementNamed(context, '/home');
  }

  _signUp(context) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    if (user == null) {
      UserCredential auth =
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .googleSignOption();

      Provider.of<UserProvider>(context, listen: false).saveUserInfo(auth.user);

      Navigator.pushReplacementNamed(context, '/signOptionsTrue');
    }
  }
}
