import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/main.dart';
import 'package:snowmanchallenge/models/user.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
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
          onTap: () => isSignInButton
              ? _facebookSignIn(context)
              : _facebookSignUp(context),
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

  void _facebookSignIn(context) async {
    var facebookLogin = FacebookLogin();

    var result = await facebookLogin.logIn(['email', 'public_profile']);
    var credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var auth = await FirebaseAuth.instance.signInWithCredential(credential);

        Provider.of<FirestoreProvider>(context, listen: false).addUser(User(
          displayName: auth.user.displayName,
          email: auth.user.email,
          urlPhoto: auth.user.photoUrl,
        ).toJson());

        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));

        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  _facebookSignUp(context) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;

    print('USER ' + user.toString());
    //print(user.displayName);
    //print(user.email);

    if (user == null) {
      var facebookLogin = FacebookLogin();
      await facebookLogin
          .logIn(['email', 'public_profile']).then((value) async {
        var credential = FacebookAuthProvider.getCredential(
            accessToken: value.accessToken.token);

        var auth = await FirebaseAuth.instance.signInWithCredential(credential);

        Provider.of<UserProvider>(context, listen: false)
            .saveUserInfo(auth.user);

        print('saved email: ' +
            Provider.of<UserProvider>(context, listen: false).user.email);
        print('saved name: ' +
            Provider.of<UserProvider>(context, listen: false).user.displayName);
        print('saved id: ' +
            Provider.of<UserProvider>(context, listen: false).user.providerId);
      });
    }
    return notifyLoginCard;
  }
}
