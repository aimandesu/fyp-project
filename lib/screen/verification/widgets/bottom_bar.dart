import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

import '../../../responsive_layout_controller.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
    required this.sendForm,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;
  final VoidCallback sendForm;

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);
    return SizedBox(
      width: mediaQuery.size.width * 1,
      height: isTablet ? 100 : (mediaQuery.size.height - paddingTop) * 0.1,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Spacer(),
          Container(
            margin: marginDefined,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: TextButton(
              onPressed: sendForm,
              child: const Text(
                "Hantar Informasi",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
