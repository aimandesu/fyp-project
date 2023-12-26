import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../table_input.dart';

class ListHousehold extends StatelessWidget {
  const ListHousehold({super.key, required this.listFamilies, required this.addFamilyMember, required this.removeLast});

  final List<Map<String, TextEditingController>> listFamilies;
  final VoidCallback addFamilyMember;
  final VoidCallback removeLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: paddingDefined,
          child: Text(
            "Senarai isi rumah",
            style: textStyling30,
          ),
        ),
        TableInput(
          listFamilies: listFamilies,
        ),
        tableDecision(),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
  Row tableDecision() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: marginDefined,
            child: ElevatedButton(
              onPressed: addFamilyMember,
              child: const Text(
                  textAlign: TextAlign.center, "Tambah Ahli Keluarga"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            child: ElevatedButton(
                onPressed: removeLast, child: const Text("Padam ")),
          ),
        )
      ],
    );
  }
}
