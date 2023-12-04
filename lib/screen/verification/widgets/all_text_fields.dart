import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

class AllTextFields extends StatefulWidget {
  const AllTextFields({
    super.key,
    // required this.positionController,
    required this.nameController,
    required this.identificationNoController,
    required this.districtController,
    required this.addressController,
    required this.postcodeController,
    required this.subDistrictController,
    required this.isHide,
  });

  // final TextEditingController positionController;

  //the rest
  final TextEditingController nameController;
  final TextEditingController identificationNoController;

  //communityAt
  final TextEditingController districtController;
  final TextEditingController addressController;
  final TextEditingController postcodeController;
  final TextEditingController subDistrictController;

  //bool determine
  final bool isHide;

  @override
  State<AllTextFields> createState() => _AllTextFieldsState();
}

class _AllTextFieldsState extends State<AllTextFields> {
  @override
  Widget build(BuildContext context) {
    const paddingField = EdgeInsets.symmetric(horizontal: 10, vertical: 23);

    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // fieldText(isTablet, widthTablet, paddingField, context,
            //     widget.positionController, "Your Position"),
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
            fieldText(paddingField, context, widget.subDistrictController,
                "Bandar", false, TextInputType.text),
            fieldText(paddingField, context, widget.districtController,
                "Daerah", false, TextInputType.text),
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
