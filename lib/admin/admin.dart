import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/admin/assistance/assistance.dart';
import 'package:fyp_project/admin/form_validation/form_validation.dart';
import 'package:fyp_project/admin/identification_verifiy/identification_verify.dart';
import 'package:fyp_project/admin/information/information.dart';
import 'package:fyp_project/admin/report_notify/report_notify.dart';
import 'package:fyp_project/constant.dart';

class Admin extends StatefulWidget {
  const Admin(
      {super.key, required this.toggleTheme, required this.themeDefault});

  @override
  State<Admin> createState() => _AdminState();

  final VoidCallback toggleTheme;
  final bool themeDefault;
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
    _pages = [
      const Information(),
      const ReportNotify(),
      const Assistance(),
      const FormValidation(),
      const IdentificationVerification()
    ];

    _railPages = <NavigationRailDestination>[
      const NavigationRailDestination(
        icon: Icon(Icons.info),
        label: Text('Info'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.map),
        label: Text('Peta'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.chat),
        label: Text('Rumah'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.note),
        label: Text('Bantuan'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.face),
        label: Text('Kad Pengenalan'),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Expanded(
              child: Container(
                decoration: decorationDefinedShadow(
                  Theme.of(context).colorScheme.onPrimary,
                  25,
                ),
                child: Stack(
                  children: [
                    NavigationRail(
                      labelType: NavigationRailLabelType.selected,
                      useIndicator: true,
                      // extended: true,
                      backgroundColor: Colors.transparent,
                      destinations: _railPages,
                      selectedIndex: _selectedPageIndex,
                      onDestinationSelected: _selectPage,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.logout),
                          ),
                          IconButton(
                            onPressed: () => widget.toggleTheme(),
                            icon: widget.themeDefault
                                ? const Icon(Icons.toggle_on, size: 40)
                                : const Icon(Icons.toggle_off, size: 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: _pages[_selectedPageIndex])
        ],
      ),
    );
  }
}
