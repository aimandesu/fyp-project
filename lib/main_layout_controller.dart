import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:fyp_project/providers/profile_provider.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/chat/chat.dart';
import 'package:fyp_project/screen/help_form/help_form.dart';
import 'package:fyp_project/screen/disaster_guide/disaster_guide.dart';
import 'package:fyp_project/screen/profile/profile.dart';
import 'package:fyp_project/screen/support_result/dart/support_result.dart';
import 'package:provider/provider.dart';

import 'screen/home/home.dart';
import 'screen/verification/verification.dart';
import 'services/auth_service.dart';

class MainLayoutController extends StatefulWidget {
  const MainLayoutController({
    required this.themeDefault,
    required this.toggleTheme,
    super.key,
  });

  @override
  State<MainLayoutController> createState() => _MainLayoutControllerState();
  final bool themeDefault;
  final VoidCallback toggleTheme;
}

class _MainLayoutControllerState extends State<MainLayoutController> {

  late List<Map<String, Object>> _pages;
  late List<NavigationRailDestination> _railPages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    AuthService().signUserInfo();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const Home(),
        'title': 'Rumah',
        'icon': const Icon(
          Icons.home,
          size: 30,
        ),
      },
      {
        'page': const HelpForm(),
        'title': 'Bantuan',
        'icon': const Icon(
          Icons.camera_alt_rounded,
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

    _railPages = const <NavigationRailDestination>[
      NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: Text('Rumah'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.camera_alt_outlined),
        selectedIcon: Icon(Icons.camera_alt_rounded),
        label: Text('Bantuan'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.people_outlined),
        selectedIcon: Icon(Icons.people_rounded),
        label: Text('Profil'),
      ),
    ];

    super.initState();
  }

  Widget? _buildFloatingActionButton() {
    if (_pages[_selectedPageIndex]['title'].toString() == "Rumah") {
      return FloatingActionButton(
        onPressed: () async {
          String args = await ChatProvider().askAssistance();
          if (context.mounted) {
            Navigator.pushNamed(context, Chat.routeName, arguments: args);
          }
        },
        shape: RoundedRectangleBorder(
          side:  BorderSide(width: 1, color: Theme.of(context).colorScheme.onPrimaryContainer,),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.support_agent,
        ),
      );
    } else {
      return null;
    }
  }

  List<Widget>? _buildAppBarWidget() {
    if (_pages[_selectedPageIndex]['title'].toString() == "Bantuan") {
      return [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SupportResult.routeName);
          },
          icon: const Icon(Icons.notification_add),
        ),
      ];
    } else {
      return null;
    }
  }

  profileUpdate(Map<String, dynamic> data) {
    Navigator.of(context).pushNamed(Verification.routeName, arguments: data);
  }

  Drawer? _buildDrawer() {
    if (_pages[_selectedPageIndex]['title'].toString() == "Profil") {
      return Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SwitchListTile(
              title: const Text("Togol Tema"),
              value: widget.themeDefault,
              onChanged: (bool value) {
                widget.toggleTheme();
              },
            ),
            ListTile(
              onTap: () async {
                Map<String, dynamic> data =
                    await Provider.of<ProfileProvider>(context, listen: false)
                        .fetchOwnProfile();
                profileUpdate(data);
              },
              title: const Text("Kemaskini Profil"),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              title: const Text("Log Keluar"),
            )
          ],
        ),
      );
      // .animate().shakeX(duration: 200.ms);
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
      endDrawer: _buildDrawer(),
      body: ResponsiveLayoutController(
        mobile: _pages[_selectedPageIndex]['page'] as Widget,
        tablet: Row(
          children: [
            NavigationRail(
              destinations: _railPages,
              selectedIndex: _selectedPageIndex,
              onDestinationSelected: _selectPage,
              groupAlignment: 0.0,
              labelType: NavigationRailLabelType.selected,
            ),
            Expanded(
              child: _pages[_selectedPageIndex]['page'] as Widget,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ResponsiveLayoutController.isMobile(context)
          ? Container(
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
                        child: _pages[index]['icon'] as Widget,
                      ),
                    );
                  },
                ),
              ),
            )
          : null,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
