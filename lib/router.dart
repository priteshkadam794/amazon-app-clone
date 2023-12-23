import 'package:e_commerce_app/commons/widgets/bottom_bar.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const BottomBar());

    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(child: Text("Page does not exist")),
        );
      });
  }
}
