import 'package:flutter/material.dart';
import 'package:fyp_project/disaster_guide/disaster_guide.dart';
import 'package:fyp_project/profile/profile.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/signup_login/signup_login.dart';
import 'package:fyp_project/widgets/mobile_bottom_bar.dart';

import 'home/home.dart';

class MainLayoutController extends StatefulWidget {
  const MainLayoutController({super.key});

  @override
  State<MainLayoutController> createState() => _MainLayoutControllerState();
}

class _MainLayoutControllerState extends State<MainLayoutController> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const ResponsiveLayoutController(
          mobile: Home(),
          tablet: Home(),
        ),
        'title': 'Utama',
      },
      {
        'page': const ResponsiveLayoutController(
          mobile: DisasterGuide(),
          tablet: Home(),
        ),
        'title': 'Panduan',
      },
      {
        'page': const ResponsiveLayoutController(
          mobile: Home(),
          tablet: Home(),
        ),
        'title': 'Gambar',
      },
      {
        'page': const ResponsiveLayoutController(
          mobile: Home(),
          tablet: Home(),
        ),
        'title': 'Data',
      },
      {
        'page': Profile(),
        'title': 'Profil',
      },
    ].toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActionWidget() {
      if (_pages[_selectedPageIndex]['title'].toString() == "Profil") {
        return [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ];
      } else {
        return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: appBarActionWidget(),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onTap: _selectPage,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Utama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Panduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Gambar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_array_rounded),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
