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
                      ? 'assets/images/facebook_signin.png'
                      : 'assets/images/facebook_signup.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                isSignInButton
                    ? 'Sign in with Facebook'
                    : 'Sign up with Facebook',
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
    AuthResult user =
        await Provider.of<AuthenticationProvider>(context, listen: false)
            .facebookSignIn();

    Provider.of<UserProvider>(context, listen: false).saveUserInfo(user.user);

    Navigator.pushReplacementNamed(context, '/home');
    /*
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => Home(),
        transitionsBuilder: (context, animation1, animation2, child) =>
            FadeTransition(opacity: animation1, child: child),
        transitionDuration: Duration(milliseconds: 500),
      ),
    );

     */
  }

  _signUp(context) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    print('USER ' + user.toString());

    if (user == null) {
      AuthResult auth =
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .facebookSignUp();

      Provider.of<UserProvider>(context, listen: false).saveUserInfo(auth.user);

      Navigator.pushReplacementNamed(context, '/signOptionsTrue');
    }
  }
}
