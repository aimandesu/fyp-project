import 'package:flutter/material.dart';
import 'package:fyp_project/data/disaster_guide_data.dart';
import 'package:fyp_project/disaster_guide/to_do.dart';

class DisasterGuide extends StatefulWidget {
  const DisasterGuide({super.key});

  @override
  State<DisasterGuide> createState() => _DisasterGuideState();
}

class _DisasterGuideState extends State<DisasterGuide> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disasterGuidelines.toList().length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text(disasterGuidelines[index].mainTopic),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          disasterGuidelines[index].showSubTopic =
                              !disasterGuidelines[index].showSubTopic;
                        });
                      },
                      icon: Icon(Icons.open_in_browser))
                ],
              ),
            ),
            disasterGuidelines[index].showSubTopic == false
                ? Container()
                : Column(
                    children: disasterGuidelines[index]
                        .whatTodo
                        .map((oneStep) => ToDo(
                              subTopic: oneStep["subTopic"].toString(),
                              subTopicDescription:
                                  oneStep["subTopicDescription"].toString(),
                            ))
                        .toList(),
                  )
          ],
        );
      },
    );
  }
}
