import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const Center(
      child: Text('Cart Page'),
    ),
  ];

  void updateOnTap(int page) {
    setState(() {
      _page = page;
    });
  }

  final double bottomBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.secondaryColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updateOnTap,
        items: [
          // home screen page
          BottomNavigationBarItem(
            label: "",
            icon: Column(
              children: [
                Divider(
                  indent: 40,
                  endIndent: 40,
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  thickness: bottomBorderWidth,
                ),
                const SizedBox(
                  height: 2,
                ),
                const Icon(
                  Icons.home_outlined,
                )
              ],
            ),
          ),

          // accout screen page
          BottomNavigationBarItem(
            label: "",
            icon: Column(
              children: [
                Divider(
                  indent: 40,
                  endIndent: 40,
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  thickness: bottomBorderWidth,
                ),
                const SizedBox(
                  height: 2,
                ),
                const Icon(Icons.person_outline_outlined),
              ],
            ),
          ),

          // cart screen page,
          BottomNavigationBarItem(
            label: "",
            icon: Column(
              children: [
                Divider(
                  indent: 40,
                  endIndent: 40,
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  thickness: bottomBorderWidth,
                ),
                const SizedBox(
                  height: 2,
                ),
                badges.Badge(
                    position: badges.BadgePosition.topEnd(end: -8),
                    badgeStyle: const badges.BadgeStyle(
                        badgeColor: GlobalVariables.backgroundColor),
                    badgeContent: const Text('2'),
                    child: const Icon(Icons.shopping_cart_outlined))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
