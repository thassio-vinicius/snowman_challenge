import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snowmanchallenge/models/user.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({this.fireStoreProvider});

  FacebookLogin _facebookLogin = FacebookLogin();
  FireStoreProvider fireStoreProvider;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  checkNaddUser(
      {FirebaseUser firebaseUser,
      Map<String, dynamic> user,
      bool checkFromSignIn = false}) async {
    bool checkReturn = await fireStoreProvider.database
        .collection('users')
        .getDocuments()
        .then((docs) {
      for (int i = 0; i < docs.documents.length; i++) {
        if (checkFromSignIn) {
          if (docs.documents[i].data['email'] != firebaseUser.email) {
            fireStoreProvider.addUser(user);
            return true;
          }
        } else {
          if (docs.documents[i].data['email'] != user['email']) {
            fireStoreProvider.addUser(user);
            return true;
          }
        }
      }
      return false;
    });

    notifyListeners();

    return checkReturn;
  }

  facebookSignIn() async {
    var result = await _facebookLogin.logIn(['email', 'public_profile']);
    var credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);
    AuthResult auth;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        auth = await firebaseAuth.signInWithCredential(credential);

        var user = User(
          displayName: auth.user.displayName,
          email: auth.user.email,
          urlPhoto: auth.user.photoUrl,
          id: auth.user.uid,
        ).toJson();

        checkNaddUser(
            firebaseUser: auth.user, user: user, checkFromSignIn: true);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }

    notifyListeners();

    return auth;
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
