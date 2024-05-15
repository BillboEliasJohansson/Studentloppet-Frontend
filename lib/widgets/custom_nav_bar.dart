// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';

class CustomNavBar extends StatefulWidget {
  CustomNavBar({super.key, required this.PageIndex});

  int PageIndex;

  @override
  State<CustomNavBar> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<CustomNavBar> {
  late int CurrentPageIndex;

  @override
  void initState() {
    super.initState();
    CurrentPageIndex = widget.PageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70,
      onDestinationSelected: (int index) {
        setState(() {
          CurrentPageIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.leaderboard);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.homeScreen);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.runScreen);
            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.profileScreenTest);
            break;
          default:
        }
      },
      backgroundColor: appTheme.purple200,
      indicatorColor: appTheme.deepPurple500,
      selectedIndex: CurrentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.leaderboard, color: Colors.white),
          icon: Icon(Icons.leaderboard_outlined, color: Colors.white),
          label: 'Leaderboard',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white),
          icon: Icon(Icons.home_outlined, color: Colors.white),
          label: 'Hem',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.directions_run, color: Colors.white),
          icon: Icon(Icons.directions_run_outlined, color: Colors.white),
          label: 'Löprunda',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person, color: Colors.white),
          icon: Icon(Icons.person_outlined, color: Colors.white),
          label: 'Min sida',
        ),
      ],
    );
  }
}
