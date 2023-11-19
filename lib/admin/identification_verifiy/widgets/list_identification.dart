import 'package:flutter/material.dart';

import '../../../constant.dart';

class ListIdentification extends StatelessWidget {
  const ListIdentification({
    super.key,
    required this.identificationList,
    required this.userUID,
    required this.setIdentificationOn,
  });

  final Future<List<Map<String, dynamic>>> identificationList;
  final String? userUID;
  final Function setIdentificationOn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: identificationList,
      builder: (context, snapshot) {
        if (snapshot.hasData  && snapshot.data!.isNotEmpty) {
          return Container(
            width: 250,
            height: size.height * 0.8,
            decoration:
            decorationDefinedShadow(Theme.of(context).colorScheme.onPrimary, 35),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            margin: marginDefined,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String user = snapshot.data![index]["userUID"];
                bool hasFilledIc =
                    snapshot.data![index]["identificationNo"] != "";
                if (hasFilledIc) {
                  return ListTile(
                    trailing: userUID == user
                        ? const Icon(Icons.select_all_rounded)
                        : null,
                    title: const Text("userUID"),
                    subtitle: Text(user),
                    onTap: () {
                      setIdentificationOn(user, snapshot.data![index]);
                    },
                  );
                }else{
                  return Container();
                }
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
