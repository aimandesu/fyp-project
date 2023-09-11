import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/data/disaster_guide_data.dart';
import 'package:fyp_project/screen/disaster_guide/to_do.dart';

class DisasterGuide extends StatefulWidget {
  const DisasterGuide({super.key});

  @override
  State<DisasterGuide> createState() => _DisasterGuideState();
}

class _DisasterGuideState extends State<DisasterGuide> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: disasterGuidelines.toList().length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              // height: size.height * 0.1,

              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    disasterGuidelines[index].mainTopic,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        disasterGuidelines[index].showSubTopic =
                            !disasterGuidelines[index].showSubTopic;
                      });
                    },
                    icon: disasterGuidelines[index].showSubTopic
                        ? Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Theme.of(context).colorScheme.onSurface,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                  ),
                ],
              ),
            ),
            disasterGuidelines[index].showSubTopic == false
                ? Container()
                : Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Column(
                      children: disasterGuidelines[index]
                          .whatTodo
                          .map(
                            (oneStep) => ToDo(
                              subTopic: oneStep["subTopic"].toString(),
                              subTopicDescription:
                                  oneStep["subTopicDescription"].join("\n"),
                            ),
                          )
                          .toList(),
                    ),
                  ).animate().fade().slideX(curve: Curves.easeIn),
          ].animate(interval: 400.ms).fade(duration: 300.ms).slideY(),
        );
      },
    );
  }
}
