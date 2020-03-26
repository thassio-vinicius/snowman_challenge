import 'package:flutter/material.dart';

class AppTab {
  const AppTab(this.icon);
  final IconData icon;
}

const List<AppTab> allTabs = <AppTab>[
  AppTab(Icons.star),
  AppTab(Icons.pin_drop),
  AppTab(Icons.supervisor_account),
];
