import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/models/tab.dart';
import 'package:snowmanchallenge/providers/user_provider.dart';
import 'package:snowmanchallenge/screens/tabs/favorites.dart';
import 'package:snowmanchallenge/screens/tabs/map.dart';
import 'package:snowmanchallenge/screens/tabs/user_account.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            bool anonymous = false;

            ///This is a workaround, because if i sign in with facebook and
            ///restart the app later, firebase keeps a non-anonymous access
            ///token and passes it to the new anonymous user somehow. Since
            ///i don't have time to deal with this, i ended up leaving this
            ///simple nullity-check solution for now.

            var user;

            if (provider.user == null) {
              user = provider.customUser;
            } else {
              user = provider.user;
            }

            if (user == null) anonymous = true;

            return IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                FavoritesTab(anonymous: anonymous),
                MapTab(anonymous: anonymous),
                AccountTab(anonymous: anonymous),
              ],
            );
          },
        ),
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
                  title: SizedBox(width: 0.0, height: 0.0),
                ))
            .toList(),
      ),
    );
  }
}
