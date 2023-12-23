import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 120,
                height: 45,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: const Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 28,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.search_outlined,
                        size: 28,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
