import 'package:flutter/material.dart';

import '../../../responsive_layout_controller.dart';

class NameAndTitle extends StatelessWidget {
  const NameAndTitle({
    required this.name,
    required this.communityAt,
    super.key,
  });

  final String name;
  final Map<String, dynamic> communityAt;

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            isTablet ? BorderRadius.circular(0) : BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                communityAt['place'],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
