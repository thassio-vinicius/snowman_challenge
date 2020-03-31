import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_marker_textbox.dart';
import 'package:snowmanchallenge/models/user.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/screens/home.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController;
  TextEditingController _emailController;

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
          CustomMarkerTextBox(label: 'Name', controller: _nameController),
          CustomMarkerTextBox(label: 'E-mail', controller: _emailController),
          CustomButton(
              onTap: () => _signUp(), label: 'Sign Up', percentageWidth: 0.70),
        ],
      ),
    );
  }

  _signUp() {
    if (Provider.of<UserProvider>(context, listen: false).user != null) {
      User user = User(
        displayName: _nameController.text,
        email: _emailController.text,
        urlPhoto:
            Provider.of<UserProvider>(context, listen: false).user.photoUrl,
      );
      Provider.of<FireStoreProvider>(context, listen: false)
          .addUser(user.toJson());

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
            transitionsBuilder: (context, animation1, animation2, child) =>
                FadeTransition(opacity: animation1, child: child),
            transitionDuration: Duration(milliseconds: 500),
          ));
    } else {
      print('USER : ' +
          Provider.of<UserProvider>(context, listen: false).user.toString());
    }
  }
}
