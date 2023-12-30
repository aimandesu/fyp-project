import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import '../../help_form/widgets/textfield_decoration.dart';

class AllTextFields extends StatefulWidget {
  const AllTextFields({
    super.key,
    required this.nameController,
    required this.identificationNoController,
    required this.addressController,
    required this.postcodeController,
    required this.isHide,
    required this.subDistrict,
    required this.currentSubDistrict,
    required this.changeSubDistrict,
  });

  //the rest
  final TextEditingController nameController;
  final TextEditingController identificationNoController;

  //communityAt
  final TextEditingController addressController;
  final TextEditingController postcodeController;
  final List<String> subDistrict;
  final String currentSubDistrict;
  final Function changeSubDistrict;

  //bool determine
  final bool isHide;

  @override
  State<AllTextFields> createState() => _AllTextFieldsState();
}

class _AllTextFieldsState extends State<AllTextFields> {
  @override
  Widget build(BuildContext context) {
    const paddingField = EdgeInsets.symmetric(horizontal: 10, vertical: 23);
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.isHide == true
                ? fieldText(
                    paddingField, context, widget.nameController, "Nama", true, TextInputType.text)
                : Container(),
            widget.isHide == true
                ? fieldText(paddingField, context,
                    widget.identificationNoController, "No Kad Pengenalan", true, TextInputType.number)
                : Container(),
            fieldText(paddingField, context, widget.addressController,
                "Alamat", true, TextInputType.text),
            fieldText(paddingField, context, widget.postcodeController,
                "Poskod", true, TextInputType.number),
             Container(
               margin: marginDefined,
               padding: paddingDefined,
               height: 60,
               width: size.width * 1,
               decoration: inputDecorationDefined(context),
               child: DropdownButton(
                 underline: const SizedBox(),
                 isExpanded: true,
                  value: widget.currentSubDistrict,
                  items: widget.subDistrict.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    widget.changeSubDistrict(value);
                  },
                ),
             ),

          ],
        ),
      ),
    );
  }

  Container fieldText(
    EdgeInsets paddingField,
    BuildContext context,
    TextEditingController controller,
    String hintText,
      bool enable,
      TextInputType keyboard,
  ) {
    return Container(
      margin: marginDefined,
      padding: paddingField,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Center(
        child: TextFormField(
          keyboardType: keyboard,
          enabled: enable,
          controller: controller,
          decoration: InputDecoration.collapsed(hintText: hintText),
        ),
      ),
    );
  }
}
