import 'package:flutter/material.dart';

import '../../../data/chips_data.dart';

class ChipChoices extends StatefulWidget {
   ChipChoices({super.key, required this.disaster, required this.incidentController, required this.changeIncidentExtra});

  @override
  State<ChipChoices> createState() => _ChipChoicesState();
  final List<String> disaster;
  final TextEditingController incidentController;
  Function changeIncidentExtra;
}

class _ChipChoicesState extends State<ChipChoices> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 3,
      spacing: 5,
      children: chipsData
          .map(
            (chipVal) => ChoiceChip(
          label: Text(chipVal.label),
          selected: chipVal.selected,
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          onSelected: (bool select) {
            setState(() {
              //change bool
              chipVal.selected = select;
              //add to list

              //show extra input
            });
            chipVal.selected == true && chipVal.label != "Lain-Lain"
                ? widget.disaster.add(chipVal.label)
                : widget.disaster.remove(chipVal.label);

            (chipVal.selected == true && chipVal.label == "Lain-Lain")
                ? widget.changeIncidentExtra(true)
                : null;

            if (chipVal.selected == false && chipVal.label == "Lain-Lain") {
              widget.changeIncidentExtra(false);
              widget.incidentController.text = "";
            }
          },
        ),
      )
          .toList(),
    );;
  }
}
