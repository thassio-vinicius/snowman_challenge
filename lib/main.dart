import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/authentication_provider.dart';
import 'package:snowmanchallenge/providers/firestore_provider.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/providers/markers_provider.dart';
import 'package:snowmanchallenge/providers/pincolor_provider.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/screens/home.dart';
import 'package:snowmanchallenge/screens/sign_options.dart';

void main() {
  final signOptionsFalse = SignOptions(isSignUpOption: false);
  final signOptionsTrue = SignOptions(isSignUpOption: true);
  final home = Home();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MarkersProvider()),
      ChangeNotifierProvider(create: (_) => PinColorProvider()),
      ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
      ChangeNotifierProvider(create: (_) => FireStoreProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProxyProvider<FireStoreProvider, AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
          update: (_, fireStore, authentication) =>
              AuthenticationProvider(firestoreProvider: fireStore)),
    ],
    child: MaterialApp(
      initialRoute: '/signOptionsFalse',
      routes: {
        '/signOptionsFalse': (context) => signOptionsFalse,
        '/signOptionsTrue': (context) => signOptionsTrue,
        '/home': (context) => home,
      },
      home: SignOptions(isSignUpOption: false),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          applyElevationOverlayColor: true,
          dialogBackgroundColor: Colors.white),
    ),
  ));
}
