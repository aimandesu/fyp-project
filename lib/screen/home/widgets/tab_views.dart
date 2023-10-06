import 'package:flutter/material.dart';
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
      child: Text("Berita"),
    ),
    Tab(
      child: Text("Data Harian"),
    ),
    Tab(
      child: Text("Stuff"),
    )
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
    Size size = MediaQuery.of(context).size;

    return Column(
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
        SizedBox(
          width: size.width * 1,
          height: size.height * 0.5,
          child: TabBarView(controller: _tabController, children: const [
            Text("Berita"),
            Graph(),
            Text("Stuff"),
          ]),
        )
      ],
    );
  }
}
