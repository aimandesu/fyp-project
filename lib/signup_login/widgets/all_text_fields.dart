import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

import '../../responsive_layout_controller.dart';

class AllTextFields extends StatefulWidget {
  const AllTextFields({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
    required this.positionController,
    required this.nameController,
    required this.addressController,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;
  final TextEditingController positionController;
  final TextEditingController nameController;
  final TextEditingController addressController;

  @override
  State<AllTextFields> createState() => _AllTextFieldsState();
}

class _AllTextFieldsState extends State<AllTextFields> {
  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);
    final widthTablet = widget.mediaQuery.size.width * 0.4;
    const paddingField = EdgeInsets.symmetric(horizontal: 10, vertical: 23);

    return SizedBox(
      height: isTablet
          ? widget.mediaQuery.size.height - widget.paddingTop
          : (widget.mediaQuery.size.height - widget.paddingTop) * 0.5,
      width: isTablet ? widthTablet : null,
      child: SingleChildScrollView(
        child: Column(
          children: [
            fieldText(isTablet, widthTablet, paddingField, context,
                widget.positionController, "Your Position"),
            fieldText(isTablet, widthTablet, paddingField, context,
                widget.nameController, "Your Name"),

            fieldText(isTablet, widthTablet, paddingField, context,
                widget.addressController, "Your Address"),

            //   Container(
            //     width: isTablet ? widthTablet : null,
            //     // height: isTablet
            //     //     ? (mediaQuery.size.height - paddingTop) * 0.2
            //     //     : (mediaQuery.size.height - paddingTop) * 0.08,
            //     margin: marginDefined,
            //     padding: paddingField,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //       border: Border.all(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            //     ),
            //     child: Center(
            //       child: TextFormField(
            //         controller: widget.nameController,
            //         decoration:
            //             const InputDecoration.collapsed(hintText: "Your Name"),
            //       ),
            //     ),
            //   ),
            //   Container(
            //     width: isTablet ? widthTablet : null,
            //     margin: marginDefined,
            //   padding: paddingField,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //       border: Border.all(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            //     ),
            //     child: Center(
            //       child: TextFormField(
            //         controller: widget.emailController,
            //         decoration:
            //             const InputDecoration.collapsed(hintText: "Your Email"),
            //       ),
            //     ),
            //   ),
            //   Container(
            //     width: isTablet ? widthTablet : null,
            //     margin: marginDefined,
            //    padding: paddingField,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //       border: Border.all(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            //     ),
            //     child: Center(
            //       child: TextFormField(
            //         controller: widget.passwordController,
            //         decoration: const InputDecoration.collapsed(
            //             hintText: "Your Password"),
            //       ),
            //     ),
            //   ),
            //   Container(
            //     width: isTablet ? widthTablet : null,
            //     margin: marginDefined,
            //  padding: paddingField,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //       border: Border.all(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            //     ),
            //     child: Center(
            //       child: TextFormField(
            //         controller: widget.addressController,
            //         keyboardType: TextInputType.multiline,
            //         maxLines: null,
            //         decoration: const InputDecoration.collapsed(
            //           hintText: "Your Address",
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Container fieldText(
    bool isTablet,
    double widthTablet,
    EdgeInsets paddingField,
    BuildContext context,
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      width: isTablet ? widthTablet : null,
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
          controller: controller,
          decoration: InputDecoration.collapsed(hintText: hintText),
        ),
      ),
    );
  }
}
