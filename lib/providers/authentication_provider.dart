import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snowmanchallenge/models/user.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({this.firestoreProvider});

  FacebookLogin _facebookLogin = FacebookLogin();
  FireStoreProvider firestoreProvider;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /*
  anonymousSignIn() async {
    await firebaseAuth.signInAnonymously();

    notifyListeners();
  }

   */

  void facebookSignIn() async {
    var result = await _facebookLogin.logIn(['email', 'public_profile']);
    var credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var auth = await firebaseAuth.signInWithCredential(credential);

        firestoreProvider.addUser(User(
          displayName: auth.user.displayName,
          email: auth.user.email,
          urlPhoto: auth.user.photoUrl,
        ).toJson());
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }

    notifyListeners();
  }

  facebookSignUp() async {
    AuthResult auth;

    await _facebookLogin.logIn(['email', 'public_profile']).then((value) async {
      AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: value.accessToken.token);

      auth = await firebaseAuth.signInWithCredential(credential);
    });

    notifyListeners();

    return auth;
  }
}
