import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../textfield_decoration.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//ignore: must_be_immutable
class VictimCategory extends StatelessWidget {
   VictimCategory({super.key, required this.category, required this.changeCategory});

   String category;
   final Function(String value) changeCategory;


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Padding(
          padding: paddingDefined,
          child: Text(
            "Kategori Bencana",
            style: textStyling30,
          ),
        ),
        disasterCategory(size, context),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Container disasterCategory(Size size, BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      height: 60,
      width: size.width * 1,
      decoration: inputDecorationDefined(context),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        isExpanded: true,
        value: category,
        // hint: Text("gender"),
        onChanged: (String? value) {
          changeCategory(value.toString());
          // setState(() {
          //   widget.category = value!;
          // });
        },
        items: [
          "Banjir",
          "Tanah Runtuh",
          "Angin Taufan",
          "Lain-lain",
        ].map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
