import 'package:flutter/material.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ICimage(mediaQuery: mediaQuery, paddingTop: paddingTop),
            AllTextFields(mediaQuery: mediaQuery, paddingTop: paddingTop),
            BottomBar(mediaQuery: mediaQuery, paddingTop: paddingTop),
          ],
        ),
      ),
    );
  }
}

class ICimage extends StatelessWidget {
  const ICimage({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.size.width * 1,
      height: (mediaQuery.size.height - paddingTop) * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.red,
              width: mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Front IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Icon(Icons.card_giftcard),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              width: mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Back IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Icon(Icons.card_giftcard),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllTextFields extends StatelessWidget {
  const AllTextFields({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (mediaQuery.size.height - paddingTop) * 0.55,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
                bottom: 8.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Your Position"),
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration:
                      const InputDecoration.collapsed(hintText: "Your Name"),
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration:
                      const InputDecoration.collapsed(hintText: "Your Email"),
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Your Password"),
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Your Address",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.size.width * 1,
      height: (mediaQuery.size.height - paddingTop) * 0.1,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          TextButton(
            onPressed: null,
            child: Text("Login Instead"),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
