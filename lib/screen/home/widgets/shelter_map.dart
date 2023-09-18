import 'package:flutter/material.dart';
import 'package:fyp_project/screen/help_centre/help_centre.dart';
import '../../help_centre/widgets/map_location.dart';

class ShelterMap extends StatelessWidget {
  const ShelterMap({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.heart_broken_rounded),
                SizedBox(width: 10),
                Flexible(
                  child: ListTile(
                    title: Text(
                      "Bantuan",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Marilah kita bersama-sama memberi bantuan kepada yang memerlukan",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(HelpCentre.routeName),
              child: Container(
                width: size.width * 1,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: const Center(
                  child: Text("Semak Pusat Bantuan"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
