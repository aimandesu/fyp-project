import 'package:flutter/material.dart';
import 'package:fyp_project/admin/assistance/assistance.dart';
import 'package:fyp_project/admin/form_validation/form_validation.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late List<Widget> _pages;
  late List<NavigationRailDestination> _railPages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [const Assistance(), const FormValidation()];

    _railPages = <NavigationRailDestination>[
      const NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: Text('Rumah'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.camera_alt_outlined),
        selectedIcon: Icon(Icons.camera_alt_rounded),
        label: Text('Bantuan'),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: _railPages,
            selectedIndex: _selectedPageIndex,
            onDestinationSelected: _selectPage,
            labelType: NavigationRailLabelType.all,
          ),
          Expanded(child: _pages[_selectedPageIndex])
        ],
      ),
    );
  }
}
