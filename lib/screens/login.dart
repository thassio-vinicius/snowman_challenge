import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_marker_textbox.dart';
import 'package:snowmanchallenge/models/user.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/screens/login_button.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  CurvedAnimation _curve;
  bool _signUpPressed = false;
  TextEditingController _nameController;
  TextEditingController _emailController;
  double _begin = 1.0;
  double _end = 0.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animation = Tween(
      begin: _begin,
      end: _end,
    ).animate(_curve);

    /*
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        _animationController.forward();
    });

     */

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _nameController = TextEditingController(
        text: _signUpPressed
            ? Provider.of<UserProvider>(context, listen: false).user.displayName
            : '');
    _emailController = TextEditingController(
        text: _signUpPressed
            ? Provider.of<UserProvider>(context, listen: false).user.email
            : '');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('status: ' + _animation.status.toString());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildBackground(context),
            _buildLoginCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2.0, 4.0),
              blurRadius: 24,
            ),
          ],
        ),
        child: FadeTransition(
          opacity: _animation,
          child: _signUpPressed ? _buildLoginContent() : _buildSignUpContent(),
        ),
      ),
    );
  }

  Widget _buildSignUpContent() {
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

  Widget _buildLoginContent() {
    return Stack(
      children: <Widget>[
        _buildButtonColumn(),
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 122,
                height: 170,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  spacing: -18,
                  children: <Widget>[
                    Text(
                      'SNOW',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            fontSize: 40,
                            color: HexColor('#10159A'),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      'MAN',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            fontSize: 52,
                            color: HexColor('#10159A'),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      'LABS',
                      style: GoogleFonts.rubik(
                        textStyle: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              fontSize: 43,
                              color: HexColor('#10159A'),
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Challenge',
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      fontSize: 23,
                      color: HexColor('#10159A'),
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Positioned _buildButtonColumn() {
    return Positioned(
      bottom: 25,
      left: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            LoginButton(isSignInButton: true),
            LoginButton(
              isSignInButton: false,
              notifyLoginCard: () => _fadeTransition(),
            )
          ],
        ),
      ),
    );
  }

  _fadeTransition() {
    setState(() {
      _signUpPressed = true;
      _end = 1.0;
      _begin = 0.0;
      _animationController.forward();
      print('sign up pressed:' + _signUpPressed.toString());
    });
    /*
    if (_signUpPressed) {
      setState(() {
        _animationController.reverse();
      });
    } else {
      setState(() {
        _animationController.forward();
      });
    }

     */
  }

  Container _buildBackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fill,
      ),
    );
  }

  _signUp() {
    User user = User(
      displayName: _nameController.text,
      email: _emailController.text,
      urlPhoto: Provider.of<UserProvider>(context, listen: false).user.photoUrl,
    );

    Provider.of<FirestoreProvider>(context, listen: false)
        .addUser(user.toJson());
  }
}
