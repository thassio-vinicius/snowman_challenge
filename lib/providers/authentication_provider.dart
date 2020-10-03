import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({this.fireStoreProvider});

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FireStoreProvider fireStoreProvider;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInAnonymously() async {
    UserCredential auth = await firebaseAuth.signInAnonymously();

    return auth;
  }

  checkAndAddUser(
      {User firebaseUser,
      Map<String, dynamic> user,
      bool checkFromSignIn = false}) async {
    bool checkReturn =
        await fireStoreProvider.database.collection('users').get().then((docs) {
      if (docs.docs.isEmpty) {
        fireStoreProvider.addUser(user, user['email']);
        return true;
      }

      for (int i = 0; i < docs.docs.length; i++) {
        if (checkFromSignIn) {
          if (docs.docs[i].data()['email'] != firebaseUser.email) {
            fireStoreProvider.addUser(user, firebaseUser.email);
            return true;
          }
        } else {
          if (docs.docs[i].data()['email'] != user['email']) {
            fireStoreProvider.addUser(user, user['email']);
            return true;
          }
        }
      }
      return false;
    });

    notifyListeners();

    return checkReturn;
  }

  googleSignOption() async {
    var result = await _googleSignIn.signIn();
    var token = await result.authentication;
    var credential = GoogleAuthProvider.credential(
      idToken: token.idToken,
      accessToken: token.accessToken,
    );
    UserCredential auth;

    auth = await firebaseAuth.signInWithCredential(credential);

    notifyListeners();

    return auth;
  }
}
