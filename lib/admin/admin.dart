import 'package:flutter/material.dart';
import 'package:fyp_project/admin/assistance/assistance.dart';
import 'package:fyp_project/admin/form_validation/form_validation.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  /* things to do:
  1. Form - ada boleh nampak orang punya form, gambar keadaan, and kelulusan
  2. Assistance - boleh chat org tnya soalan, boleh send gmbr, and send file
  3. Map - boleh tgok map, guna api untuk dptkn coordinate maybe mcm search bar, and dpt tgok all list kita punya map disaster  
  4. Graph - boleh tengok mana various stuff - idk what that is
  5. */

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
        icon: Icon(Icons.chat),
        label: Text('Rumah'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.note),
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
            // leading: const SizedBox(
            //   width: 180,
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: Icon(Icons.close),
            //   ),
            // ),
            elevation: 20,
            // minWidth: 200,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
