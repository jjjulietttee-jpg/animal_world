import 'package:flutter/material.dart';

class NavigationIcons {
  NavigationIcons._();

  static const IconData home = Icons.home;
  static const IconData game = Icons.games;
  static const IconData profile = Icons.person;
  
  static IconData getIconByRoute(String route) {
    switch (route) {
      case '/home':
        return home;
      case '/game':
        return game;
      case '/profile':
        return profile;
      default:
        return home;
    }
  }
}

