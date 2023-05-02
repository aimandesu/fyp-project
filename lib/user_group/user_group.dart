import 'package:flutter/material.dart';

class UserGroup extends StatelessWidget {
  const UserGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("Residents"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Community Leader"),
            )
          ],
        ),
      ),
    );
  }
}
