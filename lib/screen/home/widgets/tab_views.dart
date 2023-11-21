import 'package:flutter/material.dart';
import 'package:fyp_project/screen/news/news.dart';
import 'package:fyp_project/screen/statistic/statistic.dart';

class TabViews extends StatefulWidget {
  const TabViews({super.key});

  @override
  State<TabViews> createState() => _TabViewsState();
}

class _TabViewsState extends State<TabViews>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(
      child: Text("Kejadian Harian"),
    ),
    Tab(
      child: Text("Data Harian"),
    ),
  ];
  late TabController _tabController;

  // int _tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    // _tabController.addListener(() {
    //   setState(() {
    //     _tabIndex = _tabController.index;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          DefaultTabController(
            length: myTabs.length,
            child: TabBar(
              onTap: (selectedTabIndex) {
                setState(() {
                  _tabController.index = selectedTabIndex;
                });
              },
              isScrollable: true,
              //this one if sets to true, it's gonna center it somehow
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              News(),
              Graph(),
            ]),
          )
        ],
      ),
    );
  }
}
