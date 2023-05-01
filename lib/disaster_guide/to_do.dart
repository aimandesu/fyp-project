import 'package:flutter/material.dart';

class ToDo extends StatelessWidget {
  const ToDo({
    super.key,
    required this.subTopic,
    required this.subTopicDescription,
  });

  final String subTopic;
  final String subTopicDescription;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subTopic),
      subtitle: Text(
        subTopicDescription,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
