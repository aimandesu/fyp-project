import 'package:flutter/material.dart';

class NameAndTitle extends StatelessWidget {
  const NameAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          Icon(Icons.add),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aiman Afiq bin Esam"),
              Text("Ketua Kampung Taman Botani"),
            ],
          ),
        ],
      ),
    );
  }
}
