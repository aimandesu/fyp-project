import 'package:flutter/material.dart';

class Statistic extends StatelessWidget {
  const Statistic({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      width: size.width * 1,
      height: 50,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(Graph.routeName);
        },
        child: const Center(
          child: Text("Lihat Kemaskini Data"),
        ),
      ),
    );
  }
}
