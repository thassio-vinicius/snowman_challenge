import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/markers_provider.dart';
import 'package:snowmanchallenge/models/tab.dart';
import 'package:snowmanchallenge/pincolor_provider.dart';
import 'package:snowmanchallenge/tabs/account_tab.dart';
import 'package:snowmanchallenge/tabs/favorites_tab.dart';
import 'package:snowmanchallenge/tabs/map_tab.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MarkersProvider()),
      ChangeNotifierProvider(create: (_) => PinColorProvider()),
    ],
    child: MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(applyElevationOverlayColor: true),
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _tabs = [FavoritesTab(), MapTab(), AccountTab()];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(index: _currentIndex, children: _tabs),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        unselectedIconTheme: IconThemeData(color: HexColor('#AFB0B8')),
        selectedIconTheme: IconThemeData(color: HexColor('#10159A')),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allTabs
            .map((AppTab tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  title: Container(width: 0.0, height: 0.0),
                ))
            .toList(),
      ),
    );
  }
}
