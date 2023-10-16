import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.sendForm,
  });

  final VoidCallback sendForm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
