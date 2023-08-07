import 'package:flutter/material.dart';
import 'package:fyp_project/camera/camera.dart';
import 'package:fyp_project/disaster_guide/disaster_guide.dart';
import 'package:fyp_project/places/places.dart';
import 'package:fyp_project/profile/profile.dart';

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
        'page': const Home(),
        'title': 'Peta',
        'icon': const Icon(
          Icons.home,
          size: 30,
        ),
      },
      {
        'page': const Camera(),
        'title': 'Bantuan',
        'icon': const Icon(
          Icons.camera_alt_rounded,
          size: 30,
        ),
      },
      {
        'page': const DisasterGuide(),
        'title': 'Panduan',
        'icon': const Icon(
          Icons.menu_book_rounded,
          size: 30,
        ),
      },
      {
        'page': const Places(),
        'title': 'Tempat',
        'icon': const Icon(
          Icons.map,
          size: 30,
        ),
      },
      {
        'page': const Profile(),
        'title': 'Profil',
        'icon': const Icon(
          Icons.people_rounded,
          size: 30,
        ),
      },
    ].toList();
    super.initState();
  }

  Widget? _buildFloatingActionButton() {
    if (_pages[_selectedPageIndex]['title'].toString() == "Panduan") {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.support_agent,
        ),
      );
    } else {
      return null;
    }
  }

  List<Widget>? _buildAppBarWidget() {
    if (_pages[_selectedPageIndex]['title'].toString() == "Profil") {
      return [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: _buildAppBarWidget(),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPageIndex,
          // elevation: 10,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          onTap: _selectPage,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: List.generate(
            _pages.length,
            (index) {
              return BottomNavigationBarItem(
                icon: _pages[index]['icon'] as Widget,
                label: _pages[index]['title'] as String,
                activeIcon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: _pages[index]['icon'] as Widget),
              );
            },
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
