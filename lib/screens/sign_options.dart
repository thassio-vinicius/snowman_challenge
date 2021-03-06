import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snowmanchallenge/features/authentication/components/anonymous_button.dart';
import 'package:snowmanchallenge/features/authentication/components/login_button.dart';
import 'package:snowmanchallenge/features/authentication/signup.dart';
import 'package:snowmanchallenge/shared/components/custom_progress_indicator.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class SignOptions extends StatefulWidget {
  const SignOptions({@required this.isSignUpOption});

  final bool isSignUpOption;

  @override
  _SignOptionsState createState() => _SignOptionsState();
}

class _SignOptionsState extends State<SignOptions> {
  Stream _stream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Container(
                padding: EdgeInsets.all(70),
                child: CustomProgressIndicator(),
              ),
            );
            break;
          default:
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
                child: widget.isSignUpOption
                    ? SignUp()
                    : _buildOptionsContent(context),
              ),
            );
        }
      },
    );
  }

  Widget _buildOptionsContent(context) {
    return Stack(
      children: <Widget>[
        _buildButtonColumn(context),
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

  Positioned _buildButtonColumn(context) {
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
            LoginButton(isSignInButton: false),
            AnonymousButton(),
          ],
        ),
      ),
    );
  }

  Container _buildBackground(BuildContext context) {
    //CustomPaint()

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
