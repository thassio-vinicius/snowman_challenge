import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/models/firestore_user.dart';
import 'package:snowmanchallenge/providers/authentication_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_button.dart';
import 'package:snowmanchallenge/shared/components/custom_textbox.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  bool _emailTaken = false;

  @override
  void didChangeDependencies() {
    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      _nameController = TextEditingController(
          text: Provider.of<UserProvider>(context, listen: false)
              .user
              .displayName);
      _emailController = TextEditingController(
          text: Provider.of<UserProvider>(context, listen: false).user.email);
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width * 0.75,
      //height: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Text(
              'Confirm your personal info below: ',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    color: HexColor('#11159A'),
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          CustomTextBox(label: 'Name', controller: _nameController),
          CustomTextBox(label: 'E-mail', controller: _emailController),
          if (_emailTaken) _buildEmailTakenText(context),
          CustomButton(
              onTap: () => _signUp(), label: 'Sign Up', percentageWidth: 0.70),
        ],
      ),
    );
  }

  FittedBox _buildEmailTakenText(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                'E-mail already taken. ',
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      color: HexColor('#111236'),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, '/signOptionsFalse'),
                child: Text(
                  'Try signing in!',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      color: HexColor('#11159A'),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decorationThickness: 1,
                      decorationColor: HexColor('#11159A'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _signUp() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);

    var user = FirestoreUser(
      displayName: _nameController.value.text,
      email: _emailController.value.text,
      uid: userProvider.user.uid,
      photoUrl: userProvider.user.photoURL,
    );

    if (userProvider.user != null) {
      bool result =
          await authenticationProvider.checkAndAddUser(user: user.toJson());

      ///returns true if there's no match between the input e-mail and the database emails.

      if (result) {
        if (_emailController.value.text != userProvider.user.email) {
          await userProvider.deleteFirebaseUser();
          user.copyWith(
              uid: FieldPath.documentId.toString(),
              displayName: _nameController.value.text,
              email: _emailController.value.text,
              photoUrl: '');
          userProvider.saveFirestoreUser(user);
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        setState(() {
          _emailTaken = true;
        });
      }
    }
  }
}
