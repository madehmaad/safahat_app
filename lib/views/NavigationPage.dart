import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pages_app/core/Config/colors.dart';
import 'package:pages_app/views/Home/HomePage.dart';
import 'package:pages_app/views/Notifications/noti_pages.dart';
import 'package:pages_app/views/Profile/profile.dart';
import 'package:pages_app/views/Settings/settingsPage.dart';

// ignore: must_be_immutable
class NavigationPage extends StatefulWidget {
  NavigationPage({super.key, required this.selectedIndex});
  int selectedIndex;
  @override
  State<NavigationPage> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: pages[widget.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            showSelectedLabels: false,
            selectedItemColor: Themecolor,
            unselectedFontSize: 13,
            selectedFontSize: 15,
            unselectedItemColor: Color.fromRGBO(143, 149, 158, 1),
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
            onTap: (value) {
              setState(() {
                widget.selectedIndex = value;
              });
            },
            currentIndex: widget.selectedIndex,
            items: [
              BottomNavigationBarItem(
                tooltip: '',
                activeIcon: Icon(
                  Icons.home_rounded,
                  size: 30,
                ),
                icon: Icon(
                  Icons.home_rounded,
                  size: 25,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  tooltip: '',
                  activeIcon: Icon(
                    Iconsax.user,
                    size: 30,
                  ),
                  icon: Icon(
                    Iconsax.user,
                    size: 25,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  tooltip: '',
                  activeIcon: Icon(
                    Iconsax.notification,
                    size: 30,
                  ),
                  icon: Icon(
                    Iconsax.notification,
                    size: 25,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                tooltip: '',
                activeIcon: Icon(
                  Iconsax.more,
                  size: 30,
                ),
                icon: Icon(
                  Iconsax.more,
                  size: 25,
                ),
                label: '',
              ),
            ],
          )),
    );
  }
}

List<Widget> pages = [
  HomePage(),
  profilePage(),
  yourPages(),
  SettingsPage(),
];
