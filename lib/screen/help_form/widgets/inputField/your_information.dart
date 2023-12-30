import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../textfield_decoration.dart';

//ignore: must_be_immutable
class YourInformation extends StatelessWidget {
  YourInformation({
    super.key,
    required this.nameController,
    required this.noICController,
    required this.addressController,
    required this.phoneController,
    required this.ageController,
    required this.gender,
    required this.changeGender,
    required this.postcodeController,
    required this.changeSubDistrict,
    required this.currentSubDistrict,
    required this.subDistrict,
  });

  final TextEditingController nameController;
  final TextEditingController noICController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final TextEditingController postcodeController;
  String gender;
  final Function(String value) changeGender;
  final Function changeSubDistrict;
  final String currentSubDistrict;
  final List<String> subDistrict;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: paddingDefined,
          child: Text(
            "Maklumat Anda",
            style: textStyling30,
          ),
        ),
        definedInput(context, "Name", nameController, TextInputType.text),
        definedInput(
            context, "No Kad Pengenalan", noICController, TextInputType.number),
        genderAgePhoneInput(size, context),
        definedInput(context, "Alamat", addressController, TextInputType.text),
        postcodeAndDistrict(size, context),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Container definedInput(
    BuildContext context,
    String hintText,
    TextEditingController textEditingController,
    TextInputType textInputType,
  ) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      height: 60,
      decoration: inputDecorationDefined(context),
      child: TextFieldDecoration(
        hintText: hintText,
        textInputType: textInputType,
        textEditingController: textEditingController,
      ),
    );
  }

  Row genderAgePhoneInput(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          margin: marginDefined,
          padding: paddingDefined,
          height: 60,
          width: size.width * 0.2,
          decoration: inputDecorationDefined(context),
          child: TextFieldDecoration(
            hintText: "Umur",
            textInputType: TextInputType.number,
            textEditingController: ageController,
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            // width: size.width * 0.3,
            decoration: inputDecorationDefined(context),
            child: TextFieldDecoration(
              hintText: "No Telefon",
              textInputType: TextInputType.phone,
              textEditingController: phoneController,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            // width: size.width * 0.3,
            decoration: inputDecorationDefined(context),
            child: DropdownButton<String>(
              underline: const SizedBox(),
              value: gender,
              isExpanded: true,
              // hint: Text("gender"),
              onChanged: (String? value) {
                changeGender(value.toString());
              },
              items: ["Lelaki", "Perempuan"].map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),

      ],
    );
  }

  Row postcodeAndDistrict(Size size, BuildContext context){
    return Row(
      children: [
        Container(
          margin: marginDefined,
          padding: paddingDefined,
          height: 60,
          width: size.width * 0.4,
          decoration: inputDecorationDefined(context),
          child: TextFieldDecoration(
            hintText: "Poskod",
            textInputType: TextInputType.number,
            textEditingController: postcodeController,
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            width: size.width * 1,
            decoration: inputDecorationDefined(context),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: currentSubDistrict,
              items: subDistrict.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                changeSubDistrict(value);
              },
            ),
          ),
        ),
      ],
    );
  }

}
