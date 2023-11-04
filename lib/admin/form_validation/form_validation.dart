import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fyp_project/admin/form_validation/widgets/completed.dart';
import 'package:fyp_project/admin/form_validation/widgets/form_counts.dart';
import 'package:fyp_project/admin/form_validation/widgets/onwatch.dart';
import 'package:fyp_project/admin/form_validation/widgets/pending.dart';
import 'package:fyp_project/admin/providers/form_provider.dart';
import 'package:lottie/lottie.dart';
import '../../constant.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation>
    with SingleTickerProviderStateMixin {


  static const List<Tab> myTabs = <Tab>[
    Tab(
      child: Text("Pending"),
    ),
    Tab(
      child: Text("OnWatch"),
    ),
    Tab(
      child: Text("Completed"),
    )
  ];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormCounts(),
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
          child: TabBarView(
            controller: _tabController,
            children: const [
              Pending(),
              OnWatch(),
              Completed(),
            ],
          ),
        )
      ],
    );
  }
}
